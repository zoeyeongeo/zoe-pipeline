# metrics

## 기준선 (설계 8-11)
- `baseline-<프로젝트>.csv` — 지적 하나당 한 줄. 열: `date, feature, rule_id, severity, author, summary`
- `rule_id`: 규칙에 안 맞으면 `UNMAPPED`. 두 번 이상 나온 UNMAPPED는 새 규칙 후보
- `severity`: `MUST` / `SHOULD` / `NIT` (이모지 없이, grep용)
- `author`: `AI` / `사용자`
- 첫 예시 행은 `baseline-template.csv`

## 기능당 한 줄 기록 (0단계)
도입 후에는 각 `Docs/features/<기능>/review.md`에서 집계한다 (4단계 스크립트).
