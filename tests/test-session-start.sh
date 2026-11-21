#!/usr/bin/env bash
# SessionStart hook 테스트. 실행: bash tests/test-session-start.sh
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HOOK="$ROOT/hooks/run-hook.cmd"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
VER="$(python3 -c 'import json,sys;print(json.load(open(sys.argv[1], encoding="utf-8"))["version"])' "$ROOT/.claude-plugin/plugin.json")"
pass=0; fail=0

check() { # 이름, 조건 결과(0=성공)
  if [ "$2" -eq 0 ]; then echo "PASS $1"; pass=$((pass+1)); else echo "FAIL $1"; fail=$((fail+1)); fi
}
run_hook() { # 프로젝트 폴더 → stdout
  CLAUDE_PLUGIN_ROOT="$ROOT" CLAUDE_PROJECT_DIR="$1" bash "$HOOK" session-start
}
# Windows python은 print가 줄바꿈을 CRLF로 바꾸고 stdin을 cp949로 읽는다 → UTF-8 바이트로 직접 읽고 쓴다
ctx_of() { python3 -c 'import json,sys; d=json.loads(sys.stdin.buffer.read().decode("utf-8")); sys.stdout.buffer.write(d["hookSpecificOutput"]["additionalContext"].encode("utf-8"))'; }

# 0. run-hook.cmd는 ASCII만 (cmd가 LF 줄바꿈 + 멀티바이트 문자에서 줄을 잘못 자름, 0.2.1 버그)
! LC_ALL=C grep -qP '[^\x00-\x7F]' "$HOOK"; check "run-hook.cmd ASCII 전용" $?
! grep -q $'\r' "$HOOK"; check "run-hook.cmd CR 없음 (bash 쪽이 깨지지 않게)" $?

# 1. pipeline.json 없음 → 출력 없음
mkdir -p "$TMP/none"
out="$(run_hook "$TMP/none")"
[ -z "$out" ]; check "pipeline.json 없으면 출력 없음" $?

# 2. 정상 설정 → 유효한 JSON, 규칙 4개 파일 모두 포함, 경고 없음
mkdir -p "$TMP/ok/.claude"
printf '{\r\n  "pipeline": "%s",\r\n  "mode": "build",\r\n  "engine": "unity",\r\n  "commit": "on-request"\r\n}\r\n' "$VER" > "$TMP/ok/.claude/pipeline.json"
out="$(run_hook "$TMP/ok")"
ctx="$(printf '%s' "$out" | ctx_of)"; check "정상 설정: 유효한 JSON" $?
for id in "W-001" "W-012" "B-001" "C-003" "C-021" "A-003" "G-003"; do
  [[ $ctx == *"### $id"* ]]; check "정상 설정: $id 주입" $?
done
[[ $ctx == *"build — "* ]]; check "정상 설정: build 모드 문구" $?
[[ $ctx == *"요청할 때만 커밋"* ]]; check "정상 설정: on-request 커밋 문구" $?
[[ $ctx != *"## 경고"* ]]; check "정상 설정: 경고 없음" $?
[[ $ctx != *$'\r'* ]]; check "정상 설정: CR 제거됨" $?

# 3. 버전 불일치 + 모르는 mode → 경고, learn으로 대체
mkdir -p "$TMP/old/.claude"
printf '{ "pipeline": "0.0.9", "mode": "turbo", "engine": "unity" }' > "$TMP/old/.claude/pipeline.json"
ctx="$(run_hook "$TMP/old" | ctx_of)"
[[ $ctx == *"버전 불일치"*"0.0.9"* ]]; check "버전 불일치 경고" $?
[[ $ctx == *"/zoe-pipeline:update"* ]]; check "버전 불일치: update 안내" $?
[[ $ctx == *"turbo"* && $ctx == *"learn — "* ]]; check "모르는 mode → learn" $?

# 4. 모르는 엔진 → common/commit만, 엔진 규칙 없음
mkdir -p "$TMP/unreal/.claude"
printf '{ "pipeline": "%s", "engine": "unreal", "commit": "never" }' "$VER" > "$TMP/unreal/.claude/pipeline.json"
ctx="$(run_hook "$TMP/unreal" | ctx_of)"
[[ $ctx == *"### W-001"* && $ctx == *"### B-001"* && $ctx == *"### G-001"* && $ctx != *"### C-003"* ]]; check "unreal: 공통 규칙만" $?
[[ $ctx == *"커밋 금지"* ]]; check "unreal: never 커밋 문구" $?

# 5. 경로에 공백
mkdir -p "$TMP/my project/.claude"
cp "$TMP/ok/.claude/pipeline.json" "$TMP/my project/.claude/"
run_hook "$TMP/my project" | ctx_of >/dev/null; check "경로 공백" $?

echo "---- $pass passed, $fail failed"
[ "$fail" -eq 0 ]
