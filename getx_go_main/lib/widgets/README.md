# 通用按钮组件库

基于 `InkWell` 封装的常用按钮组件，提供统一的 Material Design 风格和良好的用户体验。

## 组件列表

### 1. PrimaryButton - 主要按钮
用于重要操作，如保存、提交等。

```dart
PrimaryButton(
  text: '保存',
  icon: Icons.save,
  onPressed: () => print('保存'),
  width: 120,
  backgroundColor: Colors.blue,
)
```

### 2. SecondaryButton - 次要按钮
用于次要操作，如取消、重置等。

```dart
SecondaryButton(
  text: '取消',
  icon: Icons.cancel,
  onPressed: () => print('取消'),
  borderColor: Colors.grey,
)
```

### 3. CustomTextButton - 文本按钮
用于链接样式的操作。

```dart
CustomTextButton(
  text: '查看详情',
  icon: Icons.visibility,
  onPressed: () => print('查看详情'),
  textColor: Colors.blue,
)
```

### 4. CustomIconButton - 图标按钮
用于工具栏或操作栏。

```dart
CustomIconButton(
  icon: Icons.favorite,
  tooltip: '收藏',
  onPressed: () => print('收藏'),
  backgroundColor: Colors.red[50],
  iconColor: Colors.red,
)
```

### 5. DangerButton - 危险按钮
用于删除等危险操作。

```dart
DangerButton(
  text: '删除',
  icon: Icons.delete,
  onPressed: () => _showConfirmDialog(),
)
```

### 6. CustomFloatingActionButton - 浮动操作按钮
用于主要操作。

```dart
CustomFloatingActionButton(
  icon: Icons.add,
  tooltip: '添加新项目',
  onPressed: () => print('添加'),
  backgroundColor: Colors.green,
)
```

## 通用属性

所有按钮都支持以下通用属性：

- `onPressed`: 点击回调函数
- `isLoading`: 加载状态（显示加载动画）
- `width`: 按钮宽度
- `height`: 按钮高度
- `borderRadius`: 圆角大小

## 使用示例

### 表单按钮组
```dart
Row(
  children: [
    Expanded(
      child: SecondaryButton(
        text: '取消',
        onPressed: () => Navigator.pop(),
      ),
    ),
    const SizedBox(width: 12),
    Expanded(
      child: PrimaryButton(
        text: '保存',
        icon: Icons.save,
        onPressed: _saveData,
        isLoading: _isSaving,
      ),
    ),
  ],
)
```

### 工具栏按钮组
```dart
Row(
  children: [
    CustomIconButton(
      icon: Icons.edit,
      tooltip: '编辑',
      onPressed: () => _editItem(),
    ),
    CustomIconButton(
      icon: Icons.delete,
      tooltip: '删除',
      onPressed: () => _deleteItem(),
      backgroundColor: Colors.red[50],
      iconColor: Colors.red,
    ),
    CustomIconButton(
      icon: Icons.share,
      tooltip: '分享',
      onPressed: () => _shareItem(),
    ),
  ],
)
```

## 优势

1. **统一的视觉效果**: 所有按钮都使用 `InkWell` 提供一致的 Material Design 水波纹效果
2. **良好的用户体验**: 支持加载状态、禁用状态、工具提示等
3. **高度可定制**: 支持自定义颜色、大小、图标等
4. **易于维护**: 集中管理按钮样式，便于统一修改
5. **类型安全**: 使用 Dart 的强类型系统，减少运行时错误

## 注意事项

1. 所有按钮都需要在 `Material` 组件内部使用（通常 `Scaffold` 已经提供了）
2. 使用 `isLoading` 时，按钮会自动禁用点击
3. 图标按钮支持 `tooltip`，会在长按时显示提示
4. 危险按钮使用红色主题，适合删除等危险操作
