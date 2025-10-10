# 字体配置架构方案总结

## 📊 架构概览

本字体配置系统采用**三层架构设计**，实现了字体的统一管理和灵活配置。

```
┌─────────────────────────────────────────────────┐
│             应用层 (Application)                  │
│          使用 theme.textTheme.xxx                │
└────────────────────┬────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────┐
│           配置层 (Typography Config)              │
│     定义完整的文本样式和排版规范                    │
│   - displayLarge, headlineLarge, bodyMedium...   │
│   - 特殊样式: code, numeric, emphasis            │
└────────────────────┬────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────┐
│             基础层 (Font Config)                  │
│          定义字体家族和字体栈                       │
│   - primaryFont: Roboto                         │
│   - chineseFont: NotoSansSC                     │
│   - monoFont: Roboto Mono                       │
└─────────────────────────────────────────────────┘
```

## 🎯 核心特性

### 1. 统一字体管理
- ✅ 所有字体定义集中在 `FontConfig` 中
- ✅ 支持主字体、中文字体、等宽字体等多种字体类型
- ✅ 提供字体栈配置，支持回退机制

### 2. 完整排版系统
- ✅ 遵循 Material Design 3 排版规范
- ✅ 提供 15+ 预定义文本样式
- ✅ 支持特殊场景样式（代码、数字、强调）

### 3. 灵活扩展性
- ✅ 易于添加新字体
- ✅ 易于自定义文本样式
- ✅ 支持多语言字体配置

### 4. 主题集成
- ✅ 与颜色主题无缝集成
- ✅ 支持明暗模式自动适配
- ✅ 响应式文本样式

## 📁 文件结构

```
lib/theme/
├── config/
│   ├── font_config.dart           # 字体基础配置
│   ├── typography_config.dart     # 排版样式配置
│   └── theme_tokens.dart          # 设计令牌（字号、字重等）
├── themes/
│   ├── light_theme.dart           # 已集成字体配置
│   └── dark_theme.dart            # 已集成字体配置
├── examples/
│   └── font_usage_example.dart    # 使用示例
├── FONT_CONFIGURATION.md          # 详细文档
├── QUICK_REFERENCE.md             # 快速参考
└── README.md                      # 主文档（已更新）
```

## 🔧 主要组件

### 1. FontConfig (字体配置)

**位置**: `lib/theme/config/font_config.dart`

**功能**:
- 定义字体家族名称
- 配置字体栈和回退方案
- 提供字体权重映射

**核心代码**:
```dart
class FontConfig {
  // 字体家族
  static const String primaryFont = 'Roboto';
  static const String chineseFont = 'NotoSansSC';
  static const String monoFont = 'Roboto Mono';
  
  // 字体栈
  static const List<String> standardFontFamily = [
    primaryFont,
    chineseFont,
  ];
  
  // 辅助方法
  static String get defaultFontFamily => primaryFont;
  static List<String> get defaultFontFallback => [chineseFont];
}
```

### 2. TypographyConfig (排版配置)

**位置**: `lib/theme/config/typography_config.dart`

**功能**:
- 提供完整的文本样式定义
- 支持自定义颜色
- 构建 TextTheme

**文本样式层级**:
- **Display**: displayLarge (36px), displayMedium (32px), displaySmall (28px)
- **Headline**: headlineLarge (24px), headlineMedium (20px), headlineSmall (18px)
- **Title**: titleLarge (18px), titleMedium (16px), titleSmall (14px)
- **Body**: bodyLarge (16px), bodyMedium (14px), bodySmall (12px)
- **Label**: labelLarge (14px), labelMedium (12px), labelSmall (12px)
- **特殊**: code, numeric, emphasis

**核心方法**:
```dart
class TypographyConfig {
  // 构建完整的 TextTheme
  static TextTheme buildTextTheme({
    required Color primaryColor,
    required Color secondaryColor,
    required Color tertiaryColor,
  });
  
  // 单个样式
  static TextStyle headlineLarge({Color? color});
  static TextStyle bodyMedium({Color? color});
  // ...
}
```

### 3. 主题集成

**明亮模式** (`lib/theme/themes/light_theme.dart`):
```dart
ThemeData(
  fontFamily: FontConfig.defaultFontFamily,
  textTheme: TypographyConfig.buildTextTheme(
    primaryColor: appColors.textPrimary,
    secondaryColor: appColors.textSecondary,
    tertiaryColor: appColors.textTertiary,
  ),
)
```

**黑暗模式** (`lib/theme/themes/dark_theme.dart`):
```dart
ThemeData(
  fontFamily: FontConfig.defaultFontFamily,
  textTheme: TypographyConfig.buildTextTheme(
    primaryColor: appColors.textPrimary,
    secondaryColor: appColors.textSecondary,
    tertiaryColor: appColors.textTertiary,
  ),
)
```

## 📖 使用指南

### 基本使用

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  
  return Column(
    children: [
      // 使用预定义样式
      Text('页面标题', style: theme.textTheme.headlineLarge),
      Text('正文内容', style: theme.textTheme.bodyMedium),
      Text('辅助信息', style: theme.textTheme.bodySmall),
      
      // 自定义颜色
      Text(
        '自定义文本',
        style: theme.textTheme.titleMedium?.copyWith(
          color: Colors.blue,
        ),
      ),
      
      // 使用特殊样式
      Text('code', style: TypographyConfig.code(color: Colors.green)),
      Text('123.45', style: TypographyConfig.numeric(color: Colors.blue)),
    ],
  );
}
```

### 添加新字体

1. **添加字体文件** (pubspec.yaml):
```yaml
flutter:
  fonts:
    - family: CustomFont
      fonts:
        - asset: assets/fonts/CustomFont-Regular.ttf
        - asset: assets/fonts/CustomFont-Bold.ttf
          weight: 700
```

2. **更新 FontConfig**:
```dart
class FontConfig {
  static const String primaryFont = 'CustomFont';
  // ...
}
```

### 自定义文本样式

```dart
// 在 TypographyConfig 中添加
static TextStyle customStyle({Color? color}) {
  return TextStyle(
    fontFamily: FontConfig.primaryFont,
    fontFamilyFallback: FontConfig.defaultFontFallback,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: color,
  );
}
```

## 🌍 多语言支持

### 当前配置
```dart
static const List<String> standardFontFamily = [
  'Roboto',       // 英文优先
  'NotoSansSC',   // 中文回退
];
```

### 扩展多语言
```dart
static const List<String> cjkFontFamily = [
  'Roboto',
  'NotoSansSC',   // 简体中文
  'NotoSansTC',   // 繁体中文
  'NotoSansJP',   // 日文
  'NotoSansKR',   // 韩文
];
```

## ✅ 优势与特点

### 1. 集中管理
- 所有字体配置集中在两个文件中
- 易于维护和修改
- 避免代码重复

### 2. 类型安全
- 使用 Dart 常量和枚举
- 编译时错误检查
- IDE 自动补全支持

### 3. 设计一致性
- 遵循 Material Design 3 规范
- 统一的排版层级
- 语义化的样式命名

### 4. 灵活性
- 支持自定义字体
- 支持特殊样式
- 支持多语言

### 5. 易用性
- 简单的 API
- 完整的文档
- 丰富的示例

## 🔄 迁移建议

### Before (旧代码)
```dart
Text(
  '标题',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontFamily: 'Roboto',
  ),
)
```

### After (新代码)
```dart
Text(
  '标题',
  style: theme.textTheme.headlineLarge,
)
```

## 📊 文本样式一览表

| 样式名称 | 字号 | 字重 | 行高 | 用途 |
|---------|------|------|------|------|
| displayLarge | 36px | 700 | 1.2 | 超大标题 |
| displayMedium | 32px | 700 | 1.2 | 大标题 |
| displaySmall | 28px | 700 | 1.2 | 标题 |
| headlineLarge | 24px | 600 | 1.5 | 页面主标题 |
| headlineMedium | 20px | 600 | 1.5 | 区域标题 |
| headlineSmall | 18px | 600 | 1.5 | 小标题 |
| titleLarge | 18px | 500 | 1.5 | 卡片标题 |
| titleMedium | 16px | 500 | 1.5 | 列表标题 |
| titleSmall | 14px | 500 | 1.5 | 小标题 |
| bodyLarge | 16px | 400 | 1.75 | 长文本、段落 |
| bodyMedium | 14px | 400 | 1.75 | 正文内容 |
| bodySmall | 12px | 400 | 1.5 | 辅助文本 |
| labelLarge | 14px | 500 | 1.5 | 按钮文本 |
| labelMedium | 12px | 500 | 1.5 | 小按钮、芯片 |
| labelSmall | 12px | 500 | 1.5 | 标签、提示 |

## 🎨 与颜色系统集成

字体系统与颜色系统完美集成：

```dart
// 自动使用主题颜色
textTheme: TypographyConfig.buildTextTheme(
  primaryColor: appColors.textPrimary,    // 自动适配明暗模式
  secondaryColor: appColors.textSecondary,
  tertiaryColor: appColors.textTertiary,
)
```

## 📚 相关文档

- [字体配置详细文档](FONT_CONFIGURATION.md)
- [主题系统文档](README.md)
- [快速参考](QUICK_REFERENCE.md)
- [使用示例](examples/font_usage_example.dart)

## 🐛 常见问题

### Q: 如何修改默认字体？
A: 修改 `FontConfig.defaultFontFamily`

### Q: 如何添加新的文本样式？
A: 在 `TypographyConfig` 中添加新的静态方法

### Q: 中文显示问题？
A: 确保 NotoSansSC 字体已正确配置，并在 `FontConfig.defaultFontFallback` 中设置

### Q: 如何支持更多语言？
A: 在 `FontConfig` 中添加对应语言的字体，并更新字体栈配置

## ✨ 总结

这个字体配置架构方案提供了：

1. **统一的字体管理系统** - 集中配置，易于维护
2. **完整的排版规范** - 基于 Material Design 3
3. **灵活的扩展机制** - 易于添加新字体和样式
4. **无缝的主题集成** - 与颜色系统完美配合
5. **优秀的开发体验** - 类型安全、自动补全、丰富文档

通过这个系统，您可以：
- ✅ 快速应用统一的字体样式
- ✅ 轻松支持多语言文本
- ✅ 保持设计一致性
- ✅ 提高开发效率

