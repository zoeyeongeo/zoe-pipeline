---
name: update
description: 이미 zoe-pipeline이 적용된 프로젝트의 .claude/pipeline.json을 설치된 플러그인 버전으로 올리거나 mode·commit 값을 바꾼다. 사용자가 /zoe-pipeline:update 를 실행했을 때만 사용.
disable-model-invocation: true
argument-hint: "[learn|build] [never|on-request]"
---

# zoe-pipeline 갱신

현재 프로젝트의 `.claude/pipeline.json`을 고친다. 처음 적용은 `/zoe-pipeline:init`이 한다. 코드나 다른 설정은 건드리지 않는다.

인자: `$ARGUMENTS`

## 순서

1. **파일 확인** — `.claude/pipeline.json`이 없으면 아무것도 만들지 않고 "아직 적용되지 않았습니다. `/zoe-pipeline:init`을 먼저 실행하세요"로 끝낸다.

2. **설치된 버전 확인** — 이 스킬의 기본 디렉터리에서 `../../.claude-plugin/plugin.json`을 읽어 `version` 값을 얻는다.

3. **인자 검사** — `learn`/`build`는 mode, `never`/`on-request`는 commit. 허용되지 않은 값이 있으면 아무것도 바꾸지 않고 허용 값을 알려 준다.

4. **바뀔 것 정리** — 현재 값과 비교해 바뀌는 칸만 모은다.
   - `pipeline`이 설치 버전과 다르면 → 버전 변경. `../../CHANGELOG.md`에서 현재 버전 초과 ~ 설치 버전 이하 항목을 읽고, 버전마다 한두 줄로 요약한다 (추가·바뀐 규칙 ID, 템플릿 변경). 설치 버전이 더 낮으면 "설치본이 프로젝트보다 오래됐습니다. 플러그인을 먼저 업데이트하세요"로 알리고 버전은 바꾸지 않는다
   - 인자로 준 mode/commit이 현재 값과 다르면 → 그 값 변경
   - 바뀔 것이 없으면 → "이미 최신입니다 (<버전>, <mode>, <commit>)"로 끝낸다

5. **승인 후 쓰기** — 바뀌는 칸을 `기존 → 새 값` 표로 보여 주고 승인을 받는다. 승인되면 그 칸만 바꾸고 나머지 키·순서·들여쓰기는 그대로 둔다.

6. **보고** — 짧게:
   - 바꾼 값
   - "규칙은 세션 시작 시 주입됩니다. `/clear`를 실행하거나 새 세션을 여세요."
   - 버전을 올렸으면: 새 템플릿은 앞으로 만드는 기능 기록부터 적용되고, 기존 `Docs/features/` 기록은 바꾸지 않는다는 한 줄
   - 이 파일의 커밋 여부는 사용자 판단 (G-003)
