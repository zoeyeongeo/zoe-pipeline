# 커밋 규칙 (G)

> 커밋 **권한**은 프로젝트 설정(`.claude/pipeline.json`의 `commit`)이 정한다. 아래는 형식 규칙.

### G-001 Conventional Commits, 영어
- 심각도: SHOULD
- 규칙: `type(scope): summary` 형식, 영어, 명령형. type은 feat · fix · refactor · test · docs · chore · asset
- 이유: 로그만 보고 변경 종류를 거를 수 있다
- 강제: 문서
- 예외: 없음

### G-002 기능별로 나눈다
- 심각도: SHOULD
- 규칙: 서로 다른 기능·수정을 한 커밋에 섞지 않는다. 코드와 그 코드가 쓰는 에셋은 같은 커밋
- 이유: 되돌리기 쉽게
- 강제: 문서
- 예외: 없음

### G-003 커밋 권한을 지킨다
- 심각도: MUST
- 규칙: `commit: never`면 커밋하지 않고 메시지 초안만 준다. `on-request`면 요청받았을 때만 커밋한다. push는 항상 별도 요청이 있을 때만
- 이유: 출시 준비 중인 프로젝트 보호
- 강제: 문서 (SessionStart 주입)
- 예외: 없음
