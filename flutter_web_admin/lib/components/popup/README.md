# GiArrowPopupWrapper 通用弹出组件

一个基于 Flutter Overlay 的通用弹出组件，支持四个方向弹出、带箭头指向、自定义内容等功能。

## 功能特性

- ✅ **四个方向弹出**：支持 top / bottom / left / right 四个方向
- ✅ **箭头指向**：弹出框带一个小尖尖，指向目标按钮
- ✅ **自定义内容**：支持传入任意 Widget
- ✅ **自动关闭**：点击外部区域时，自动关闭弹框
- ✅ **多实例支持**：支持多个地方独立使用，不相互影响
- ✅ **动画效果**：弹出时有淡入/缩放动画效果
- ✅ **自定义样式**：支持自定义背景色、圆角、阴影等

## 基本用法

```dart
import 'package:flutter/material.dart';
import 'path/to/gi_arrow_popup_wrapper.dart';

GiArrowPopupWrapper(
  direction: PopupDirection.bottom,
  size: const Size(200, 100),
  popupBuilder: (context) => Container(
    padding: const EdgeInsets.all(16),
    child: const Text('这是弹出内容'),
  ),
  child: ElevatedButton(
    onPressed: () {},
    child: const Text("点击弹出"),
  ),
)
```

## 参数说明

| 参数 | 类型 | 默认值 | 说明 |
|-----|------|--------|------|
| `direction` | `PopupDirection` | 必需 | 弹出方向：top/bottom/left/right |
| `size` | `Size` | 必需 | 弹框尺寸 |
| `popupBuilder` | `Widget Function(BuildContext)` | 必需 | 弹框内容构建器 |
| `child` | `Widget` | 必需 | 被包裹的触发组件 |
| `arrowSize` | `double` | 8.0 | 箭头大小 |
| `borderRadius` | `double` | 8.0 | 弹框圆角 |
| `elevation` | `double` | 8.0 | 弹框阴影 |
| `backgroundColor` | `Color` | Colors.white | 弹框背景色 |
| `enableAnimation` | `bool` | true | 是否启用动画 |
| `animationDuration` | `Duration` | 200ms | 动画时长 |
| `offset` | `Offset` | Offset.zero | 弹框偏移量 |

## 使用示例

### 1. 基本弹出

```dart
GiArrowPopupWrapper(
  direction: PopupDirection.bottom,
  size: const Size(160, 100),
  popupBuilder: (context) => Container(
    padding: const EdgeInsets.all(12),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info, size: 24),
        SizedBox(height: 8),
        Text('提示信息'),
      ],
    ),
  ),
  child: const Icon(Icons.help_outline),
)
```

### 2. 下拉选择器

```dart
String selectedValue = '请选择';

GiArrowPopupWrapper(
  direction: PopupDirection.bottom,
  size: const Size(140, 160),
  popupBuilder: (context) => ListView(
    padding: const EdgeInsets.symmetric(vertical: 8),
    children: ['选项1', '选项2', '选项3'].map((option) => 
      InkWell(
        onTap: () {
          setState(() {
            selectedValue = option;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(option),
        ),
      ),
    ).toList(),
  ),
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(selectedValue),
        const Icon(Icons.arrow_drop_down),
      ],
    ),
  ),
)
```

### 3. 操作菜单

```dart
GiArrowPopupWrapper(
  direction: PopupDirection.bottom,
  size: const Size(120, 140),
  popupBuilder: (context) => Column(
    children: [
      _buildMenuItem(Icons.edit, '编辑'),
      _buildMenuItem(Icons.copy, '复制'),
      _buildMenuItem(Icons.share, '分享'),
      _buildMenuItem(Icons.delete, '删除'),
    ],
  ),
  child: const Icon(Icons.more_vert),
)

Widget _buildMenuItem(IconData icon, String label) {
  return InkWell(
    onTap: () {
      // 处理点击事件
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    ),
  );
}
```

### 4. 自定义样式

```dart
GiArrowPopupWrapper(
  direction: PopupDirection.top,
  size: const Size(200, 80),
  backgroundColor: Colors.blue[50]!,
  borderRadius: 12,
  elevation: 4,
  popupBuilder: (context) => Container(
    padding: const EdgeInsets.all(16),
    child: const Text('自定义样式弹框'),
  ),
  child: const Text('自定义样式'),
)
```

## 注意事项

1. **智能边界检测**：组件会自动检测屏幕边界，当弹窗超出边界时会自动调整位置和箭头指向，确保弹窗完整显示
2. **动画性能**：如果不需要动画效果，可以设置 `enableAnimation: false` 提升性能
3. **内存管理**：组件会自动处理 Overlay 的创建和销毁，无需手动管理
4. **触发方式**：目前仅支持点击触发，如需其他触发方式可以扩展
5. **多实例**：支持同时存在多个弹框实例，它们不会相互影响
6. **按钮兼容性**：不要在 child 中使用 `IconButton` 等有自己点击事件的组件，使用 `Container` + `Icon` 代替

## 完整示例

查看 `gi_arrow_popup_demo_page.dart` 文件，其中包含了所有使用场景的完整示例代码。
