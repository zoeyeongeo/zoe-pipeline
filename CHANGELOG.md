# CHANGELOG

## 0.2.1 — 2026-11-18

- 수정: Windows에서 SessionStart hook이 실패해 규칙이 주입되지 않던 문제. `run-hook.cmd`의 한글 REM 주석 때문에 cmd가 LF 줄을 잘못 잘라 `exit /b 1`(또는 255)로 끝났다. 주석을 ASCII로 바꾸고, 테스트에 "run-hook.cmd ASCII 전용" 검사 추가
- 발견: RPG 첫 적용 때 세션 안 Claude가 hook을 직접 실행해 진단
- 0.1.0, 0.2.0을 Windows에서 쓰면 규칙이 주입되지 않는다 → `/zoe-pipeline:init`으로 0.2.1로 올릴 것

## 0.2.0 — 2026-11-18

- `/zoe-pipeline:init` 추가 (P-007): 현재 프로젝트에 `.claude/pipeline.json`을 만든다. 인자로 mode·commit 지정, 이미 있으면 덮어쓰지 않고 버전 올리기만 제안
- 출처: 사용자 요청 ("적용도 딸깍으로")
- 적용된 프로젝트는 `/zoe-pipeline:init`을 다시 실행하면 0.2.0으로 올릴 수 있다. 규칙 변경 없음

## 0.1.0 — 2026-11-18 (초안)

구축 1단계 뼈대.

- 플러그인 매니페스트 + 로컬 마켓플레이스
- SessionStart hook: `.claude/pipeline.json`이 있는 프로젝트에만 규칙·모드·커밋 권한 주입, 버전 불일치 경고 (P-001, P-003, P-004, P-013)
- rules: common(W-001~011), unity-style(C-001~013), unity-assets(A-001~004), commit(G-001~003)
  - C-001, C-002, C-011은 RPG 컨벤션 이식 전 빈칸
  - A-004(.meta 직접 편집 금지)는 초안 제안, 승인 필요
- templates: spec, design(수정 파일 목록 포함), review, defaults, pipeline.json, CLAUDE.md 뼈대, 규정 체크리스트
- 반영한 intake: 2026-11-18 외부 영상 검토 — A 규정 체크리스트, B 범위 이탈 검사(지금은 W-006 문서, 검사는 2단계)

### 설계 문서와 다른 점 (확인 필요)
- 규칙 ID 접두사를 파일별로 나눔: W(작업) · C(코드) · A(에셋) · G(커밋). 설계 문서는 C-ID만 언급
- pipeline.json에 `commit` 칸 추가 (`never` | `on-request`) — 설계의 "커밋 권한은 프로젝트 설정"을 구체화
