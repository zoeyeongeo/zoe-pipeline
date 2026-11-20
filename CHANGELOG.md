# CHANGELOG

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
