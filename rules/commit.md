# 커밋 규칙 (G)

> 커밋 **권한**은 프로젝트 설정(`.claude/pipeline.json`의 `commit`)이 정한다. 아래는 형식 규칙.
> 출처: 모험가 RPG `Assets/Code/CLAUDE.md` 커밋 절 (0.3.0 이식).

### G-001 Conventional Commits, 영어
- 심각도: SHOULD
- 규칙: `type: Summary` 형식. 제목·본문 모두 영어, 제목은 대문자로 시작. type은 `feat` · `fix` · `refactor` · `chore` · `docs` (테스트를 쓰는 프로젝트는 `test` 추가). 예: `feat: Add Character FSM (Idle/Move/Attack states)`
- 이유: 로그만 보고 변경 종류를 거를 수 있다
- 강제: 문서
- 예외: 없음

### G-002 기능별로 나누고, 에셋은 .meta와 함께
- 심각도: SHOULD
- 규칙: 서로 다른 기능·수정을 한 커밋에 섞지 않는다. 코드와 그 코드가 쓰는 에셋은 같은 커밋. 에셋은 `.meta`를 **반드시 같이** 묶는다. 생성물(`Library/`, `Temp/`, `Logs/`, `obj/`, `*.csproj`, `*.sln`)은 넣지 않는다
- 이유: 되돌리기 쉽게. `.meta`가 빠지면 다른 PC에서 GUID가 새로 생겨 참조가 끊긴다
- 강제: 문서
- 예외: 없음

### G-003 커밋 권한을 지킨다
- 심각도: MUST
- 규칙: `commit: never`면 `git add`·`commit`·`push`를 실행하지 않는다. 커밋 순서를 제안할 때는 파일 묶음, `git add` 명령, 메시지 초안을 같이 적는다. `on-request`면 요청받았을 때만 커밋한다. push는 항상 별도 요청이 있을 때만
- 이유: 커밋·push는 되돌리기 어렵고 이력·원격에 바로 남는다. 언제 남길지는 프로젝트마다 사용자가 정한다
- 강제: 문서 (SessionStart 주입)
- 예외: 없음
