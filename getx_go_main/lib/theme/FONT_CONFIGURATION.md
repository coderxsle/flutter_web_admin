# 字体配置系统文档

本文档描述了应用中统一的字体配置架构。

## 📐 架构设计

字体配置系统采用分层设计，包含三个核心层次：

```
┌─────────────────────────────────────┐
│      业务层 (UI Components)          │
│   使用 Theme.of(context).textTheme   │
└────────────────┬────────────────────┘
                 │
┌────────────────▼────────────────────┐
│     配置层 (Typography Config)       │
│  定义完整的排版规范和文本样式         │
└────────────────┬────────────────────┘
                 │
┌────────────────▼────────────────────┐
│      基础层 (Font Config)            │
│    定义字体家族和字体栈配置           │
└─────────────────────────────────────┘
```

## 📁 文件结构

```
lib/theme/config/
├── font_config.dart          # 基础字体配置
├── typography_config.dart    # 排版配置
└── theme_tokens.dart         # 设计令牌(字号、字重等)
```

## 🎯 核心配置文件

### 1. FontConfig (基础字体配置)

**位置**: `lib/theme/config/font_config.dart`

**功能**:
- 定义字体家族名称
- 配置字体栈和回退方案
- 提供字体权重映射

**主要属性**:
```dart
class FontConfig {
  // 字体家族
  static const String primaryFont = 'Roboto';        // 主字体
  static const String chineseFont = 'NotoSansSC';    // 中文字体
  static const String monoFont = 'Roboto Mono';      // 等宽字体
  
  // 字体栈
  static const List<String> standardFontFamily = [
    primaryFont,
    chineseFont,
  ];
  
  // 字体权重
  static const int light = 300;
  static const int regular = 400;
  static const int medium = 500;
  static const int semiBold = 600;
  static const int bold = 700;
}
```

### 2. TypographyConfig (排版配置)

**位置**: `lib/theme/config/typography_config.dart`

**功能**:
- 定义完整的文本样式
- 遵循 Material Design 3 排版规范
- 统一管理字体、字号、字重、行高、字间距

**文本样式层级**:

#### Display (显示级别)
- `displayLarge`: 36px/bold - 超大标题
- `displayMedium`: 32px/bold - 大标题
- `displaySmall`: 28px/bold - 标题

#### Headline (标题级别)
- `headlineLarge`: 24px/w600 - 页面主标题
- `headlineMedium`: 20px/w600 - 区域标题
- `headlineSmall`: 18px/w600 - 小标题

#### Title (标题)
- `titleLarge`: 18px/w500 - 卡片标题、对话框标题
- `titleMedium`: 16px/w500 - 列表标题
- `titleSmall`: 14px/w500 - 小标题

#### Body (正文)
- `bodyLarge`: 16px/w400 - 长文本、段落
- `bodyMedium`: 14px/w400 - 正文
- `bodySmall`: 12px/w400 - 辅助文本

#### Label (标签)
- `labelLarge`: 14px/w500 - 按钮文本、Tab 标签
- `labelMedium`: 12px/w500 - 小按钮、芯片
- `labelSmall`: 12px/w500 - 标签、提示文本

#### 特殊样式
- `code`: 等宽字体 - 代码显示
- `numeric`: 表格数字 - 数据展示
- `emphasis`: 强调文本

## 📖 使用指南

### 1. 在主题中使用

主题配置已自动集成字体系统，无需额外配置：

```dart
// lib/theme/themes/light_theme.dart
ThemeData(
  fontFamily: FontConfig.defaultFontFamily,
  textTheme: TypographyConfig.buildTextTheme(
    primaryColor: appColors.textPrimary,
    secondaryColor: appColors.textSecondary,
    tertiaryColor: appColors.textTertiary,
  ),
)
```

### 2. 在组件中使用

#### 方式一: 使用 Theme.of(context) (推荐)

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  
  return Column(
    children: [
      Text(
        '页面标题',
        style: theme.textTheme.headlineLarge,
      ),
      Text(
        '正文内容',
        style: theme.textTheme.bodyMedium,
      ),
      Text(
        '辅助信息',
        style: theme.textTheme.bodySmall,
      ),
    ],
  );
}
```

#### 方式二: 直接使用 TypographyConfig

```dart
Text(
  '自定义文本',
  style: TypographyConfig.headlineMedium(
    color: Colors.blue,
  ),
)
```

### 3. 自定义文本样式

```dart
// 基于现有样式修改
Text(
  '强调文本',
  style: theme.textTheme.bodyMedium?.copyWith(
    fontWeight: FontWeight.w600,
    color: Colors.red,
  ),
)

// 使用特殊样式
Text(
  'const code = "hello";',
  style: TypographyConfig.code(color: Colors.green),
)

// 数字样式
Text(
  '123,456.78',
  style: TypographyConfig.numeric(color: Colors.blue),
)
```

## 🔧 修改字体配置

### 添加新字体

1. **添加字体文件**
   ```yaml
   # pubspec.yaml
   flutter:
     fonts:
       - family: CustomFont
         fonts:
           - asset: assets/fonts/CustomFont-Regular.ttf
           - asset: assets/fonts/CustomFont-Bold.ttf
             weight: 700
   ```

2. **更新 FontConfig**
   ```dart
   // lib/theme/config/font_config.dart
   class FontConfig {
     static const String primaryFont = 'CustomFont';
     // ... 其他配置
   }
   ```

### 修改字体栈

```dart
// lib/theme/config/font_config.dart
static const List<String> standardFontFamily = [
  'YourPrimaryFont',
  'YourFallbackFont',
  chineseFont,
];
```

### 自定义排版样式

```dart
// lib/theme/config/typography_config.dart
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

## 📐 设计令牌

字号、字重等设计令牌定义在 `ThemeTokens` 中：

```dart
// lib/theme/config/theme_tokens.dart
class ThemeTokens {
  // 字号
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;
  
  // 字重
  static const int fontWeightLight = 300;
  static const int fontWeightRegular = 400;
  static const int fontWeightMedium = 500;
  static const int fontWeightSemiBold = 600;
  static const int fontWeightBold = 700;
  
  // 行高
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;
}
```

## 🌍 多语言字体支持

### 当前配置

```dart
// 英文和中文混合显示
static const List<String> standardFontFamily = [
  'Roboto',        // 英文优先
  'NotoSansSC',    // 中文回退
];
```

### 添加其他语言字体

```dart
// 支持日文、韩文等
static const List<String> cjkFontFamily = [
  'Roboto',
  'NotoSansSC',     // 简体中文
  'NotoSansTC',     // 繁体中文
  'NotoSansJP',     // 日文
  'NotoSansKR',     // 韩文
];
```

## ✅ 最佳实践

1. **统一使用主题文本样式**
   - ✅ 使用 `theme.textTheme.bodyMedium`
   - ❌ 避免硬编码 `TextStyle(fontSize: 14)`

2. **保持一致性**
   - ✅ 在整个应用中使用相同的文本样式层级
   - ❌ 不要随意创建自定义样式

3. **响应式字体**
   - 如需根据屏幕尺寸调整，使用 `MediaQuery.textScaleFactor`

4. **可访问性**
   - 确保最小字号不小于 12px
   - 保持适当的行高和字间距
   - 支持系统字体缩放

## 🔄 与现有系统集成

字体配置系统已完全集成到主题系统中：

```dart
// 导入主题系统时，字体配置自动可用
import 'package:your_app/theme/theme.dart';

// 包含：
// - FontConfig
// - TypographyConfig
// - ThemeTokens
// - 其他主题配置
```

## 📝 迁移指南

如果要将现有代码迁移到新的字体系统：

### Before (旧方式)
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

### After (新方式)
```dart
Text(
  '标题',
  style: theme.textTheme.headlineLarge,
)
```

## 🎨 样式预览

| 样式名称 | 字号 | 字重 | 用途 |
|---------|------|------|------|
| displayLarge | 36px | 700 | 超大标题 |
| displayMedium | 32px | 700 | 大标题 |
| displaySmall | 28px | 700 | 标题 |
| headlineLarge | 24px | 600 | 页面主标题 |
| headlineMedium | 20px | 600 | 区域标题 |
| headlineSmall | 18px | 600 | 小标题 |
| titleLarge | 18px | 500 | 卡片标题 |
| titleMedium | 16px | 500 | 列表标题 |
| titleSmall | 14px | 500 | 小标题 |
| bodyLarge | 16px | 400 | 长文本 |
| bodyMedium | 14px | 400 | 正文 |
| bodySmall | 12px | 400 | 辅助文本 |
| labelLarge | 14px | 500 | 按钮文本 |
| labelMedium | 12px | 500 | 小按钮 |
| labelSmall | 12px | 500 | 标签 |

## 🐛 常见问题

### Q: 如何修改全局默认字体？
A: 在 `FontConfig.defaultFontFamily` 中修改：
```dart
static String get defaultFontFamily => 'YourFont';
```

### Q: 如何添加字体变体（粗体、斜体）？
A: 在 `pubspec.yaml` 中添加对应的字体文件，并指定 weight 和 style。

### Q: 为什么中文显示不正确？
A: 确保 `NotoSansSC` 字体文件已正确添加到项目中，并在 `FontConfig.defaultFontFallback` 中配置。

### Q: 如何支持动态字体大小？
A: 使用 `MediaQuery.textScaleFactorOf(context)` 结合主题样式。

## 📚 相关文档

- [主题系统使用文档](README.md)
- [Material Design 3 Typography](https://m3.material.io/styles/typography)
- [Flutter Typography](https://api.flutter.dev/flutter/material/Typography-class.html)

