# CAPABILITIES — zoe-pipeline이 가진 것

`/ingest`의 대조 기준. 메커니즘만 적는다 (규칙은 rules/의 W·C·A·G-ID). 플러그인 파일이 바뀌면 같이 갱신한다.
상태: ✅ 동작 / 📝 문서·템플릿만 / ⏳ 예정(구축 단계)

| ID | 층 | 무엇 | 어디 | 상태 | 근거 |
|---|---|---|---|---|---|
| P-001 | 1 | SessionStart 규칙 주입 (pipeline.json 있는 프로젝트만) | hooks/session-start | ✅ | superpowers |
| P-002 | 1 | 규칙 ID + 심각도 + 강제 방식 형식 | rules/*.md | 📝 | 설계 8-2 |
| P-003 | 2 | 프로젝트별 설정·버전 고정 (mode, engine, commit) | templates/pipeline.json | ✅ | 설계 8-1 |
| P-004 | 2 | 버전 불일치 경고 | hooks/session-start | ✅ | 설계 8-12 적용 규칙 |
| P-005 | 2 | 프로젝트 규정 체크리스트 K1~K11 | templates/project-rules-checklist.md | 📝 실험 | intake 2026-11-18 |
| P-006 | 2 | 새 프로젝트 CLAUDE.md 뼈대 | templates/CLAUDE.md | 📝 | 설계 8-8 |
| P-007 | 2 | 프로젝트 적용 명령 (pipeline.json 생성·버전 갱신) | skills/init | ✅ | 사용자 요청 0.2.0 |
| P-010 | 3 | Intake 명세 (요구사항 ID, 게임 감각, 가정 목록, 질문 3개 상한) | templates/spec.md | 📝 | Spec Kit, unity-ai-workflow |
| P-011 | 3 | 질문 vs 가정 기본값 표 | templates/defaults.md | 📝 | 설계 8-3 |
| P-012 | 3 | 설계 대안 + 구현 단계 담당자 + 수정 파일 목록 | templates/design.md | 📝 | 설계 6-3 |
| P-013 | 3 | learn / build 모드 주입 | hooks/session-start | ✅ | 설계 7장 |
| P-014 | 3 | /fix → /feature 승격 기준 E1~E5 | (설계 6-1) | ⏳ 3단계 | 설계 6-1 |
| P-015 | 3 | /fix, /feature, /bootstrap, /ingest 스킬 | skills/ | ⏳ 3단계 | — |
| P-020 | 4 | 독립 리뷰 에이전트 (심각도·규칙 ID·확인 필요) | agents/reviewer.md | ⏳ 3단계, 형식만 templates/review.md | superpowers, cs-review |
| P-021 | 4 | 컴파일 hook (Unity CLI) | hooks/ | ⏳ 2단계 | 설계 8-4 |
| P-022 | 4 | 커스텀 Roslyn 분석기 | analyzers/ | ⏳ 2단계 | 설계 8-4 |
| P-023 | 4 | 범위 이탈 검사 | hooks/ | ⏳ 2단계 (지금은 W-006 문서) | intake 2026-11-18 |
| P-030 | — | 지표: 기준선 CSV 형식 | metrics/ | 📝 | 설계 8-11 |
| P-031 | — | 외부 자료 반영 보고서 (비공개) | 저장소 밖 — Claude 프로젝트 문서 `claude/intake/` | 📝 손으로 실행 | 설계 8-12 |
| P-032 | — | 디버깅 절차 | guides/debugging.md | 📝 | 기존 두 프로젝트 |
