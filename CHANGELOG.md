# CHANGELOG

> `/ingest` 보고서(intake)는 저장소에 두지 않는다. 결론만 여기 남기고 보고서 원문은 비공개로 보관한다.

## 미출시

RPG 기준선 재분류(설계 8-11). `metrics/baseline-rpg.csv`에 리뷰 지적 46건을 기록하고, 두 번 이상 나온 UNMAPPED를 규칙으로 올림. 규칙 38개 → 43개.

- 추가: B-001 bool 방향 확인, B-002 거리 비교 기준 하나로 (새 파일 `rules/bugs.md`, 엔진과 무관하게 주입)
- 추가: C-021 동작을 바꾸면 주석도 같이, C-022 초기화가 실패해도 정리 경로는 안전하게, C-023 쓰지 않는 코드 제거
- hook: `bugs.md` 주입, 규칙 ID 안내에 `B-` 추가. 테스트에 B-001 · C-021 주입 확인 추가
- 기준선 CSV는 규칙 추가 전 기준으로 둔다 (UNMAPPED 그대로)

## 0.3.0 — 2026-11-18

모험가 RPG `Assets/Code/CLAUDE.md`(코드 컨벤션·최적화·커밋·디버깅)와 `.claude/skills/cs-review` 검토 항목을 전역 규칙으로 이식. 규칙 31개 → 38개.

- 채움: C-001 이름, C-002 서식, C-011 Assert·로그 메시지 형식 (`[RPG 이식]` 빈칸 해소)
- 구체화: C-004(구독 함수 쌍), C-005(`[field: FormerlySerializedAs]`, 윗줄에 따로), C-006(summary 문구·위치), C-007(Unity 메시지 포함), C-008("-다" 한 문장), C-013(구체 타입 의존 시 이유)
- 추가: C-014 주석 언어·필드 주석, C-015 로그 수준·디버깅 로그 금지, C-016 직렬화 노출 방식, C-017 이벤트 통지·폴링 금지, C-018 프레임 함수 조회 금지, C-019 매 프레임 할당 금지, C-020 프레임 함수 위치·애니메이터 해시
- 커밋: G-001 type 목록을 RPG에 맞춤(`asset` 제거, 제목 대문자), G-002 `.meta` 동반·생성물 제외, G-003 never일 때 파일 묶음·`git add` 명령 안내
- guides/debugging.md: RPG 절차(인스펙터 값 먼저 의심, learn 모드의 임시 로그 방식)와 유니티 함정 목록
- RPG에만 해당해서 옮기지 않은 것: 네임스페이스 루트 `Code.*`, `ModuleOwner`·`IndexedAsset` 이름 예외, BT 그래프 타입 문자열, 에디터 백킹 필드 접근, 모듈·FSM 설계 관례
- 기존 프로젝트: `/zoe-pipeline:init`으로 0.3.0으로 올리면 적용

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
