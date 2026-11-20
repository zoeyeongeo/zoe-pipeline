# zoe-pipeline

질문 수준·컨디션과 무관하게 일정 수준 이상의 결과가 나오게 하는 개인 게임 개발용 Claude Code 플러그인.

> **현재 0.4.0 — 구축 1단계 초안**
> 규칙 주입, 템플릿, 프로젝트 적용 명령(`/zoe-pipeline:init`)이 있습니다. 개발 흐름 스킬(`/fix`, `/feature` 등)·검증 hook·분석기는 아직 없습니다 (`CAPABILITIES.md`의 ⏳ 항목).

## 설치

Claude Code 안에서 아래 두 줄을 차례로 실행합니다.

```
/plugin marketplace add zoeyeongeo/zoe-pipeline
```

```
/plugin install zoe-pipeline@zoe-local
```

Windows에서는 Git for Windows(bash)가 필요합니다. 없으면 hook이 조용히 건너뛰고 세션은 정상으로 시작합니다.

## 프로젝트에 적용

프로젝트 폴더에서 Claude Code를 열고 실행합니다.

```
/zoe-pipeline:init
```

`.claude/pipeline.json`이 만들어집니다. 그다음 `/clear`를 실행하거나 새 세션을 열면 규칙이 주입됩니다. `pipeline.json`이 없는 프로젝트는 영향을 받지 않습니다.

기본값은 learn 모드, 커밋 금지입니다. 바꾸려면 인자를 붙여 다시 실행합니다. 이미 적용된 프로젝트에서 실행하면 플러그인 버전 올리기를 제안합니다.

```
/zoe-pipeline:init build on-request
```

| 키 | 값 | 뜻 |
|---|---|---|
| `pipeline` | `0.4.0` | 이 프로젝트가 맞춘 플러그인 버전. 설치본과 다르면 세션 시작 시 경고 |
| `mode` | `learn` / `build` | 게임플레이 코드를 누가 쓰는가의 기본값 |
| `engine` | `unity` | `rules/<engine>-style.md`, `rules/<engine>-assets.md`를 주입 |
| `commit` | `never` / `on-request` | 커밋 권한 |

## 구조

| 경로 | 내용 |
|---|---|
| `.claude-plugin/` | 플러그인 매니페스트, 마켓플레이스 정의 |
| `hooks/` | 세션 시작 시 규칙 주입. `run-hook.cmd`는 Windows·Unix 겸용 실행기 |
| `rules/` | 1층 규칙. 작업(W) · 버그 패턴(B) · 코드(C) · 에셋(A) · 커밋(G) |
| `skills/` | 명령. 지금은 `init`(프로젝트 적용)만 |
| `templates/` | 기능 기록(spec · design · review), 기본값 표, `pipeline.json`, 새 프로젝트용 CLAUDE.md 뼈대, 규정 체크리스트 |
| `guides/` | 디버깅 절차. FORMAL_VERIFY는 RPG에서 옮겨올 예정 |
| `metrics/` | 기준선 CSV 형식 |
| `tests/` | hook 테스트 |
| `CAPABILITIES.md` | 파이프라인이 가진 기능 목록 (P-ID). `/ingest`의 대조 기준 |
| `CHANGELOG.md` | 버전별 변경 내역 |

## 규칙 형식

모든 규칙은 ID와 아래 다섯 칸을 가집니다.

- **심각도** — `MUST` · `SHOULD` · `NIT`. 리뷰어가 아니라 규칙이 정합니다
- **규칙** — 지켜야 할 것
- **이유** — 어기면 무엇이 깨지는가
- **강제** — 문서 / 템플릿 / hook / 분석기. "문서"인 규칙 목록이 곧 분석기 로드맵
- **예외** — 적용하지 않는 경우

예시 — `rules/unity-style.md`

```markdown
### C-003 유니티 클래스는 파일당 하나
- 심각도: MUST
- 규칙: MonoBehaviour/ScriptableObject 파일에는 해당 클래스와 그 중첩 클래스만 둔다
- 이유: 유니티는 파일명으로 스크립트를 연결한다
- 강제: 문서 → (2단계) Analyzer ZOE003
- 예외: 없음
```

🔴 MUST 위반만 리뷰 게이트를 막습니다.

## 테스트

```
bash tests/test-session-start.sh
```
