# AGENTS.md

本仓库的 Agent 协作约定。**当前只约定 Dart 代码风格**（`gi_demo_admin` 是前端 Vue 项目，另有自己的
`AGENTS.md`，不在本文件范围内）。

## Dart 代码风格

**行宽 120，紧凑优先。**

- 行宽由各包 `analysis_options.yaml` 的 `formatter.page_width: 120` 强制。仓库根执行 `dart format .` 和编辑器
  保存格式化都会读到它，**不要**在命令行另传宽度，也不要用 80 列的默认行为去判断"格式是否正确"。
- 能一行写完就别拆：长签名、长调用、带 `where` 闭包的查询优先保持单行。
- 只有超过 120 列、或可读性明显下降时才换行；拆行按语义块拆，不要"一行一个参数"。
- 反面样板就是 `dart format` 默认 80 列的产物（每个参数独占一行 + 尾随逗号）—— 见到这种形态说明
  某处用错了行宽，顺着 `analysis_options.yaml` 查，不要手工重排。

完整规则见 `.cursor/rules/dart-style.mdc`（Cursor 会自动加载；其他 agent 以本文件为准）。

## 环境

- Flutter/Dart SDK 由 FVM 管理，版本见 `.fvmrc`；项目内入口是 `.fvm/flutter_sdk`。
- 各包的 `analysis_options.yaml` 是格式化与 lint 的唯一事实来源。
