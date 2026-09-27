/// 生成器输出目标包的 barrel。
///
/// ⚠️ 本包不再提供 typed 客户端（Endpoint 客户端已全部删除，接口走 REST）。
/// 这里 export 的 `src/protocol/` 是 `serverpod generate` 的产物，**不入库**，
/// 只在本地跑过生成器之后才存在。存在原因见 `pubspec.yaml` 顶部注释。
library;

export 'src/protocol/protocol.dart';
