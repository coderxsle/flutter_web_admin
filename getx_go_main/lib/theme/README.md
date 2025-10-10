# 主题系统使用文档

基于 Arco Design 设计语言的 Flutter 主题系统，支持明暗模式和多种颜色方案。

## 📚 参考资源
- [Arco Design 色板](https://arco.design/palette/list)
- [Material Design 3](https://m3.material.io/)
- [Flutter ThemeExtension](https://api.flutter.dev/flutter/material/ThemeExtension-class.html)


## 📁 目录结构

```
lib/theme/
├── config/                      # 配置文件
│   ├── theme_colors.dart       # Arco Design 颜色定义
│   ├── theme_tokens.dart       # 设计令牌(间距、字号等)
│   ├── color_schemes.dart      # 颜色方案定义
│   ├── font_config.dart        # 字体配置 ✨
│   └── typography_config.dart  # 排版配置 ✨
├── themes/                      # 主题生成器
│   ├── light_theme.dart        # 明亮模式主题
│   └── dark_theme.dart         # 黑暗模式主题
├── extensions/                  # 扩展
│   └── theme_extension.dart    # BuildContext 扩展
├── examples/                    # 使用示例 ✨
│   └── font_usage_example.dart # 字体使用示例
├── theme_controller.dart        # 主题控制器
├── theme_service.dart          # 主题持久化服务
├── app_theme.dart              # 对外 API
├── theme.dart                  # 统一导出文件
├── README.md                   # 主题系统文档
└── FONT_CONFIGURATION.md       # 字体配置文档 ✨
```

## 🎨 支持的颜色方案

1. **Arco Blue** (默认) - 蓝色主题 `#165DFF`
2. **Purple** - 紫色主题 `#722ED1`
3. **Green** - 绿色主题 `#00B42A`

## 🚀 快速开始

### 1. 导入主题

```dart
import 'package:your_app/theme/theme.dart';
```

### 2. 基础用法

#### 切换明暗模式

```dart
// 切换模式
await AppTheme.toggleThemeMode();

// 设置为暗色模式
await AppTheme.setThemeMode(true);

// 设置为明亮模式
await AppTheme.setThemeMode(false);

// 检查当前是否为暗色模式
bool isDark = AppTheme.isDarkMode;
```

#### 切换颜色方案

```dart
// 设置为紫色主题
await AppTheme.setColorScheme(ColorSchemeType.purple);

// 设置为绿色主题
await AppTheme.setColorScheme(ColorSchemeType.green);

// 获取当前颜色方案
ColorSchemeType current = AppTheme.currentColorScheme;

// 获取所有可用方案
List<ColorSchemeType> schemes = AppTheme.availableColorSchemes;
```

### 3. 在组件中使用主题颜色

#### 方式一: 使用 BuildContext 扩展 (推荐)

```dart
@override
Widget build(BuildContext context) {
  final colors = context.themeColors;

  return Container(
    color: colors.bgContainer,
    child: Text(
      'Hello',
      style: TextStyle(color: colors.textPrimary),
    ),
  );
}
```

#### 方式二: 使用 AppTheme.of()

```dart
@override
Widget build(BuildContext context) {
  final colors = AppTheme.of(context);

  return Container(
    color: colors.primary,
  );
}
```

#### 方式三: 使用标准 Theme.of()

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);

  return Container(
    color: theme.scaffoldBackgroundColor,
    child: Text(
      'Hello',
      style: theme.textTheme.bodyMedium,
    ),
  );
}
```

## 🎯 可用的语义化颜色

### 主要颜色
- `primary` - 主色
- `primaryHover` - 主色悬停
- `primaryActive` - 主色激活
- `primaryDisabled` - 主色禁用

### 功能色
- `success` - 成功色
- `warning` - 警告色
- `danger` - 危险色
- `info` - 信息色
- `link` - 链接色

### 背景色
- `bgContainer` - 容器背景
- `bgLayout` - 布局背景
- `bgElevated` - 悬浮容器背景
- `bgMask` - 遮罩背景
- `bgSpotlight` - 聚光灯背景

### 文本色
- `textPrimary` - 主要文本
- `textSecondary` - 次要文本
- `textTertiary` - 第三级文本
- `textDisabled` - 禁用文本

### 边框色
- `borderDefault` - 默认边框
- `borderLight` - 浅色边框
- `borderDark` - 深色边框

### 填充色
- `fillDefault` - 默认填充
- `fillHover` - 悬停填充
- `fillActive` - 激活填充
- `fillDisabled` - 禁用填充

## 📐 设计令牌

可通过 `ThemeTokens` 访问所有设计令牌:

```dart
import 'package:your_app/theme/config/theme_tokens.dart';

// 间距
ThemeTokens.spacingXs   // 4px
ThemeTokens.spacingSm   // 8px
ThemeTokens.spacingMd   // 12px
ThemeTokens.spacingLg   // 16px

// 字号
ThemeTokens.fontSizeXs  // 12px
ThemeTokens.fontSizeSm  // 14px
ThemeTokens.fontSizeMd  // 16px
ThemeTokens.fontSizeLg  // 18px

// 圆角
ThemeTokens.radiusXs    // 2px
ThemeTokens.radiusSm    // 4px
ThemeTokens.radiusMd    // 8px
ThemeTokens.radiusLg    // 12px

// 阴影
ThemeTokens.elevationXs  // 1
ThemeTokens.elevationSm  // 2
ThemeTokens.elevationMd  // 4
ThemeTokens.elevationLg  // 8
```

## 🔧 组件示例

### 使用主题切换器

```dart
import 'package:your_app/theme/widgets/theme_switcher.dart';

// 在你的设置页面中
Scaffold(
  body: Center(
    child: ThemeSwitcher(),
  ),
)
```

### 自定义按钮

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: context.themeColors.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: ThemeTokens.spacingLg,
      vertical: ThemeTokens.spacingMd,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
    ),
  ),
  child: const Text('提交'),
)
```

### 自定义卡片

```dart
Container(
  padding: const EdgeInsets.all(ThemeTokens.spacingLg),
  decoration: BoxDecoration(
    color: context.themeColors.bgContainer,
    borderRadius: BorderRadius.circular(ThemeTokens.radiusMd),
    border: Border.all(
      color: context.themeColors.borderLight,
      width: ThemeTokens.borderWidthThin,
    ),
    boxShadow: [
      BoxShadow(
        color: context.themeColors.textPrimary.withOpacity(0.05),
        blurRadius: ThemeTokens.elevationSm,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: Text(
    '卡片内容',
    style: TextStyle(color: context.themeColors.textPrimary),
  ),
)
```

## 💡 最佳实践

1. **优先使用语义化颜色** - 使用 `colors.textPrimary` 而不是硬编码颜色
2. **使用设计令牌** - 使用 `ThemeTokens.spacingLg` 而不是硬编码数值
3. **使用 BuildContext 扩展** - `context.themeColors` 最简洁
4. **保持一致性** - 在整个应用中使用相同的主题系统
5. **避免硬编码** - 不要直接使用 `Colors.blue` 等固定颜色

## 🔄 主题持久化

主题设置会自动保存到本地存储(使用 GetStorage)，应用重启后会自动恢复上次的主题设置。

## 🎨 扩展新颜色方案

如需添加新的颜色方案，按以下步骤操作:

1. 在 `ColorSchemeType` 枚举中添加新类型
2. 在 `AppColorScheme` 中添加对应的工厂方法
3. 在 `ThemeController` 中添加名称映射

示例:

```dart
// 1. color_schemes.dart
enum ColorSchemeType {
  blue,
  purple,
  green,
  orange, // 新增
}

// 2. 添加工厂方法
static AppColorScheme lightOrange() {
  return const AppColorScheme(
    primary: Color(0xFFFF7D00),
    // ... 其他颜色
  );
}

// 3. theme_controller.dart
String getColorSchemeName(ColorSchemeType type) {
  switch (type) {
    // ...
    case ColorSchemeType.orange:
      return 'Orange';
  }
}
```

## 🔤 字体配置系统

主题系统现已集成统一的字体配置架构，支持：
- ✅ 统一的字体家族管理
- ✅ 完整的排版规范（基于 Material Design 3）
- ✅ 中英文混排支持
- ✅ 特殊文本样式（代码、数字、强调等）

### 使用字体样式

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  
  return Column(
    children: [
      Text('页面标题', style: theme.textTheme.headlineLarge),
      Text('正文内容', style: theme.textTheme.bodyMedium),
      Text('辅助信息', style: theme.textTheme.bodySmall),
    ],
  );
}
```

### 可用的文本样式

| 样式 | 字号 | 字重 | 用途 |
|------|------|------|------|
| `displayLarge` | 36px | 700 | 超大标题 |
| `headlineLarge` | 24px | 600 | 页面主标题 |
| `titleLarge` | 18px | 500 | 卡片标题 |
| `bodyMedium` | 14px | 400 | 正文内容 |
| `labelLarge` | 14px | 500 | 按钮文本 |

**查看完整文档**: [字体配置系统文档](FONT_CONFIGURATION.md)

## 📚 相关文档

- [字体配置系统文档](FONT_CONFIGURATION.md) ✨
- [Arco Design 色板](https://arco.design/palette/list)
- [Material Design 3](https://m3.material.io/)
- [Material Design 3 Typography](https://m3.material.io/styles/typography)
- [Flutter ThemeExtension](https://api.flutter.dev/flutter/material/ThemeExtension-class.html)
- [Flutter Typography](https://api.flutter.dev/flutter/material/Typography-class.html)
