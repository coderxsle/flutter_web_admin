# Serverpod 版本统一管理指南

## 概述
本项目使用 `dependency_overrides` 机制实现 Serverpod 版本的统一管理，确保所有模块使用相同的 Serverpod 版本。

## 版本控制架构

### 1. 中央版本控制文件
**文件位置**: `/pubspec.yaml` (根目录)

```yaml
# 统一管理 Serverpod 版本号 - 只需在这里修改一次，所有模块同步
dependency_overrides:
  sdk: ">=3.9.0 <4.0.0"  # 统一 SDK 版本范围
  serverpod: 3.0.0-alpha.1
  serverpod_client: 3.0.0-alpha.1
  serverpod_serialization: 3.0.0-alpha.1
  serverpod_shared: 3.0.0-alpha.1
  serverpod_flutter: 3.0.0-alpha.1
  serverpod_test: 3.0.0-alpha.1
```

### 2. 各模块配置

#### book_store_server
```yaml
dependencies:
  serverpod: any  # 使用根级别 override 的版本
dev_dependencies:
  serverpod_test: any  # 使用根级别 override 的版本
```

#### book_store_client
```yaml
dependencies:
  serverpod_client: any  # 使用根级别 override 的版本
```

#### book_store_flutter
```yaml
dependencies:
  serverpod_flutter: any  # 使用根级别 override 的版本
```

#### book_store_shared
```yaml
dependencies:
  serverpod_serialization: any  # 使用根级别 override 的版本
```

## 如何更新 Serverpod 版本

### 步骤 1: 修改根配置
只需要修改根目录的 `pubspec.yaml` 文件中的版本号：

```yaml
dependency_overrides:
  serverpod: 新版本号
  serverpod_client: 新版本号
  serverpod_serialization: 新版本号
  serverpod_shared: 新版本号
  serverpod_flutter: 新版本号
  serverpod_test: 新版本号
```

### 步骤 2: 更新依赖
在根目录运行：
```bash
melos get  # 或者 melos exec -- "flutter pub get"
```

### 步骤 3: 验证版本一致性
检查所有模块是否使用了正确的版本：
```bash
# 检查各模块的 pubspec.lock 文件
find . -name "pubspec.lock" -exec grep -l "serverpod" {} \;
```

## 优势

1. **集中管理**: 只需在一个地方修改版本号
2. **版本一致性**: 确保所有模块使用相同的 Serverpod 版本
3. **简化维护**: 避免在多个文件中分别更新版本号
4. **减少错误**: 防止版本不一致导致的兼容性问题

## 注意事项

1. **dependency_overrides 优先级**: `dependency_overrides` 中的版本会覆盖各模块 `pubspec.yaml` 中指定的版本
2. **Melos 工作区**: 配合 Melos 使用可以更方便地管理多模块依赖
3. **版本兼容性**: 更新版本前请确认新版本的兼容性
4. **测试验证**: 版本更新后务必进行充分测试

## 当前版本状态
- **Serverpod 版本**: `3.0.0-alpha.1`
- **管理方式**: 根级别 `dependency_overrides`
- **模块依赖**: 全部使用 `any` 版本，依赖 override 机制

## Serverpod 版本升级注意事项

### 重要提醒
在升级 Serverpod 版本时，请注意以下破坏性更改：

#### Serverpod 3.0 主要 API 变更
1. **认证 API 变更**:
   - `AuthenticationInfo.userId` → `AuthenticationInfo.userIdentifier`
   - `userIdentifier` 现在是 `String` 类型，如果需要 `int` 类型需要转换：
     ```dart
     // 旧版本
     final userId = authData.userId;
     
     // 新版本
     final userId = int.parse(authData.userIdentifier);
     ```

2. **其他可能的变更**:
   - 检查官方迁移指南
   - 运行 `serverpod generate` 查看编译错误
   - 逐一修复 API 变更

## 故障排除

### CLI 警告处理
`serverpod generate` 会显示版本警告，但这是正常的：
```
Warning: The package is defined with a version range (for example "^3.0.0-alpha.1").
```
- **原因**: CLI 更喜欢精确版本号而不是 `any`
- **影响**: 仅仅是警告，不影响功能
- **解决**: 可以忽略，或使用精确版本号（但失去统一管理优势）

### 版本冲突
如果遇到版本冲突，请检查：
1. 根目录 `pubspec.yaml` 中的 `dependency_overrides` 是否正确
2. 各模块是否使用 `any` 版本
3. 是否有直接指定版本的依赖需要改为 `any`

### API 变更错误
升级版本后出现编译错误：
1. 运行 `serverpod generate` 查看具体错误
2. 查阅 Serverpod 官方迁移指南
3. 根据错误信息修改代码
4. 常见变更：属性名、方法签名、类型变更

### 依赖解析失败
```bash
# 清理所有依赖缓存
melos clean
melos get

# 或者逐个模块更新
cd book_store_server && dart pub get
cd ../book_store_client && dart pub get
cd ../book_store_flutter && flutter pub get
cd ../book_store_shared && dart pub get
```
