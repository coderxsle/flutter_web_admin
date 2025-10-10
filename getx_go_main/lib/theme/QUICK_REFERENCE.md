# 主题系统快速参考

## 🎨 颜色使用

```dart
// 获取主题颜色
final colors = context.themeColors;

// 使用语义化颜色
Container(
  color: colors.bgContainer,      // 容器背景
  child: Text(
    'Hello',
    style: TextStyle(color: colors.textPrimary),  // 主要文本
  ),
)
```

### 常用颜色

| 颜色 | 说明 |
|------|------|
| `colors.primary` | 主色 |
| `colors.success` | 成功色 |
| `colors.warning` | 警告色 |
| `colors.danger` | 危险色 |
| `colors.bgContainer` | 容器背景 |
| `colors.bgLayout` | 布局背景 |
| `colors.textPrimary` | 主要文本 |
| `colors.textSecondary` | 次要文本 |
| `colors.borderDefault` | 默认边框 |

## 🔤 字体使用

```dart
// 获取主题文本样式
final theme = Theme.of(context);

// 使用预定义样式
Text('标题', style: theme.textTheme.headlineLarge);
Text('正文', style: theme.textTheme.bodyMedium);
```

### 常用文本样式

| 样式 | 字号 | 用途 |
|------|------|------|
| `displayLarge` | 36px | 超大标题 |
| `headlineLarge` | 24px | 页面主标题 |
| `headlineMedium` | 20px | 区域标题 |
| `titleLarge` | 18px | 卡片标题 |
| `titleMedium` | 16px | 列表标题 |
| `bodyLarge` | 16px | 长文本 |
| `bodyMedium` | 14px | 正文 |
| `bodySmall` | 12px | 辅助文本 |
| `labelLarge` | 14px | 按钮文本 |

## 📐 设计令牌

```dart
import 'package:your_app/theme/config/theme_tokens.dart';

// 间距
ThemeTokens.spacingXs    // 4px
ThemeTokens.spacingSm    // 8px
ThemeTokens.spacingMd    // 12px
ThemeTokens.spacingLg    // 16px

// 圆角
ThemeTokens.radiusSm     // 4px
ThemeTokens.radiusMd     // 8px
ThemeTokens.radiusLg     // 12px

// 阴影
ThemeTokens.elevationXs  // 1
ThemeTokens.elevationSm  // 2
ThemeTokens.elevationMd  // 4
```

## 🌓 主题切换

```dart
// 切换明暗模式
await AppTheme.toggleThemeMode();

// 设置颜色方案
await AppTheme.setColorScheme(ColorSchemeType.purple);

// 检查当前模式
bool isDark = AppTheme.isDarkMode;
```

## 🎯 常用组件样式

### 按钮

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: colors.primary,
    padding: const EdgeInsets.symmetric(
      horizontal: ThemeTokens.spacingLg,
      vertical: ThemeTokens.spacingMd,
    ),
  ),
  child: Text('按钮', style: theme.textTheme.labelLarge),
)
```

### 卡片

```dart
Card(
  child: Padding(
    padding: const EdgeInsets.all(ThemeTokens.spacingLg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('标题', style: theme.textTheme.titleLarge),
        SizedBox(height: ThemeTokens.spacingSm),
        Text('内容', style: theme.textTheme.bodyMedium),
      ],
    ),
  ),
)
```

### 输入框

```dart
TextField(
  decoration: InputDecoration(
    labelText: '标签',
    hintText: '提示文本',
    // 主题已自动配置样式
  ),
)
```

## 💡 最佳实践

✅ **推荐做法**
```dart
// 使用主题颜色
color: colors.primary

// 使用设计令牌
padding: EdgeInsets.all(ThemeTokens.spacingLg)

// 使用文本样式
style: theme.textTheme.bodyMedium
```

❌ **避免做法**
```dart
// 硬编码颜色
color: Color(0xFF165DFF)

// 硬编码数值
padding: EdgeInsets.all(16)

// 硬编码文本样式
style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)
```

## 📚 完整文档

- [主题系统文档](README.md)
- [字体配置文档](FONT_CONFIGURATION.md)

