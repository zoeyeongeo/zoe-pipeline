# zoe-pipeline

질문 수준·컨디션과 무관하게 일정 수준 이상의 결과가 나오게 하는 개인 게임 개발용 Claude Code 플러그인.
설계: 프로젝트 문서 "AI 개발 파이프라인 설계 v3.3"

현재 **0.1.0 — 구축 1단계 초안**: 규칙 주입 + 템플릿. 스킬(/fix, /feature 등)·검증 hook·분석기는 아직 없다 → `CAPABILITIES.md`의 ⏳ 항목.

## 설치 (로컬)

```
# Claude Code 안에서
/plugin marketplace add C:/path/to/zoe-pipeline
/plugin install zoe-pipeline@zoe-local
```

Windows는 Git for Windows(bash)가 필요하다. 없으면 hook이 조용히 건너뛴다(세션은 정상).

## 프로젝트에 적용

1. `templates/pipeline.json`을 프로젝트의 `.claude/pipeline.json`으로 복사
2. 값 조정
   | 키 | 값 | 뜻 |
   |---|---|---|
   | `pipeline` | `0.1.0` | 이 프로젝트가 맞춘 플러그인 버전. 설치본과 다르면 세션 시작 시 경고 |
   | `mode` | `learn` / `build` | 게임플레이 코드를 누가 쓰는가의 기본값 |
   | `engine` | `unity` | `rules/<engine>-style.md`, `rules/<engine>-assets.md`를 주입 |
   | `commit` | `never` / `on-request` | 커밋 권한 |
3. 새 세션을 열면 규칙이 주입된다. `pipeline.json`이 없는 프로젝트는 영향 없음

## 구조

```
.claude-plugin/   plugin.json, marketplace.json
hooks/            SessionStart 규칙 주입 (run-hook.cmd = Windows/Unix 겸용 실행기)
rules/            1층 규칙 — W(작업) C(코드) A(에셋) G(커밋), ID·심각도·강제·예외
templates/        spec · design · review · defaults · pipeline.json · CLAUDE.md 뼈대 · 규정 체크리스트
guides/           디버깅 절차 (FORMAL_VERIFY.md는 RPG에서 옮겨올 예정)
metrics/          기준선 CSV 형식
intake/           /ingest 보고서
tests/            hook 테스트 (bash tests/test-session-start.sh)
CAPABILITIES.md   파이프라인이 가진 것 (P-ID) — /ingest 대조 기준
CHANGELOG.md
```

## 규칙 형식

```markdown
### C-003 유니티 클래스는 파일당 하나
- 심각도: MUST | SHOULD | NIT
- 규칙: …
- 이유: …
- 강제: 문서 → (2단계) Analyzer ZOE003
- 예외: …
```

심각도는 규칙이 정한다. 🔴 MUST만 리뷰 게이트를 막는다. 강제가 "문서"인 규칙 목록 = 분석기 로드맵.
