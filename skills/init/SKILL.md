---
name: init
description: 현재 프로젝트에 zoe-pipeline을 적용한다 (.claude/pipeline.json 생성 또는 버전 갱신). 사용자가 /zoe-pipeline:init 을 실행했을 때만 사용.
disable-model-invocation: true
argument-hint: "[learn|build] [never|on-request]"
---

# zoe-pipeline 적용

현재 프로젝트 루트(작업 디렉터리)에 `.claude/pipeline.json`을 만들어 파이프라인을 켠다. 코드나 다른 설정은 건드리지 않는다.

인자: `$ARGUMENTS`

## 순서

1. **설치된 버전 확인** — 이 스킬의 기본 디렉터리에서 `../../.claude-plugin/plugin.json`을 읽어 `version` 값을 얻는다.

2. **값 정하기** — 인자에 있으면 그 값, 없으면 기본값. 질문하지 않는다.
   | 키 | 허용 값 | 기본값 |
   |---|---|---|
   | `mode` | `learn`, `build` | `learn` |
   | `commit` | `never`, `on-request` | `never` |
   | `engine` | `unity` | 프로젝트에 `ProjectSettings/ProjectVersion.txt`가 있으면 `unity`. 없으면 `unity`로 두고 "엔진 감지 못 함"을 알린다 |
   인자에 허용되지 않은 값이 있으면 만들지 말고 허용 값을 알려 준다.

3. **이미 있으면** — `.claude/pipeline.json`이 있으면 덮어쓰지 않는다. 현재 내용을 보여 주고:
   - `pipeline` 버전만 설치 버전과 다르면 → "버전을 <기존> → <설치>로 올릴까요? 바뀐 점은 CHANGELOG에 있습니다" 하고 승인 시 `pipeline` 값만 바꾼다
   - 인자로 mode/commit을 줬으면 → 바뀌는 값을 보여 주고 승인 시 그 값만 바꾼다
   - 둘 다 아니면 → "이미 적용되어 있습니다"로 끝낸다

4. **없으면 만든다** — `.claude/` 폴더가 없으면 만들고, 아래 형식 그대로 쓴다 (키 순서 유지, 2칸 들여쓰기).
   ```json
   {
     "pipeline": "<설치 버전>",
     "mode": "<mode>",
     "engine": "<engine>",
     "commit": "<commit>"
   }
   ```

5. **보고** — 짧게:
   - 만든(또는 바꾼) 파일 경로와 값
   - "규칙은 세션 시작 시 주입됩니다. `/clear`를 실행하거나 새 세션을 여세요."
   - 모드·커밋 권한을 바꾸려면 `/zoe-pipeline:init build on-request`처럼 다시 실행하면 된다는 한 줄
   - 이 파일을 git에 포함할지는 사용자 판단 (커밋 권한 규칙 G-003을 따른다)
