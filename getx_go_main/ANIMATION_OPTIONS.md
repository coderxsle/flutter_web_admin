# 🎨 页面切换动画方案

## 使用说明
替换 `lib/modules/layout/pages/layout_admin_page.dart` 文件中第 36-47 行的 `transitionBuilder` 内容即可。

---

## 方案1：淡入 + 轻微向右滑动 ⭐⭐⭐ 最推荐
**特点**：现代、优雅、专业，适合后台管理系统
**效果**：页面从右侧轻微滑入并淡入

```dart
transitionBuilder: (child, animation) {
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.03, 0.0),  // 轻微偏移，不会太夸张
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: child,
    ),
  );
},
```

---

## 方案2：从右向左滑动 ⭐⭐ （你当前使用的）
**特点**：类似移动端APP的效果
**效果**：页面从屏幕右侧完整滑入

```dart
transitionBuilder: (child, animation) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0.0),  // 从右边完全滑入
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,  // 建议改为 easeOutCubic，更流畅
    )),
    child: child,
  );
},
```

---

## 方案3：淡入 + 缩放 ⭐⭐
**特点**：Material Design 风格，动感十足
**效果**：页面从 92% 缩放到 100% 并淡入

```dart
transitionBuilder: (child, animation) {
  return FadeTransition(
    opacity: animation,
    child: ScaleTransition(
      scale: Tween<double>(begin: 0.92, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
      ),
      child: child,
    ),
  );
},
```

---

## 方案4：淡入 + 向上滑动 ⭐⭐
**特点**：类似 iOS 风格
**效果**：页面从下方轻微上滑并淡入

```dart
transitionBuilder: (child, animation) {
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0.05),  // 从下方轻微偏移
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: child,
    ),
  );
},
```

---

## 方案5：纯淡入 ⭐
**特点**：最简洁，性能最好
**效果**：纯粹的淡入淡出

```dart
transitionBuilder: (child, animation) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
},
```

---

## 方案6：旋转 + 淡入
**特点**：有趣但可能不适合严肃的后台系统
**效果**：轻微旋转并淡入

```dart
transitionBuilder: (child, animation) {
  return FadeTransition(
    opacity: animation,
    child: RotationTransition(
      turns: Tween<double>(begin: 0.02, end: 0.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
      ),
      child: child,
    ),
  );
},
```

---

## 方案7：3D 翻转效果（高级）
**特点**：炫酷的 3D 效果
**效果**：卡片翻转效果

```dart
transitionBuilder: (child, animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      final angle = (1 - animation.value) * 0.3;  // 旋转角度
      return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)  // 透视效果
          ..rotateY(angle),
        alignment: Alignment.center,
        child: Opacity(
          opacity: animation.value,
          child: child,
        ),
      );
    },
    child: child,
  );
},
```

---

## 🎯 推荐搭配

### 后台管理系统：方案1（淡入 + 轻微滑动）
- 专业、不夸张
- 用户体验流畅
- 不会分散注意力

### 移动端风格：方案2（完整滑动）
- 符合移动端习惯
- 方向感明确
- 适合单页应用

### Material Design：方案3（淡入 + 缩放）
- 符合 Material 设计规范
- 动感十足
- 适合年轻化产品

---

## ⚙️ 调整参数

### 调整动画时长
```dart
duration: const Duration(milliseconds: 300),  // 标准速度
// duration: const Duration(milliseconds: 200),  // 快速
// duration: const Duration(milliseconds: 400),  // 缓慢
```

### 调整缓动曲线
```dart
Curves.easeOutCubic     // 推荐：平滑自然
Curves.fastOutSlowIn    // Material Design 标准
Curves.easeInOut        // 经典曲线
Curves.easeOut          // 快速开始，缓慢结束
Curves.elasticOut       // 弹性效果
```

### 调整偏移量
```dart
Offset(0.03, 0.0)   // 轻微偏移（推荐）
Offset(0.1, 0.0)    // 中等偏移
Offset(1.0, 0.0)    // 完整滑动
```

---

## 📝 使用示例

将选择的方案代码替换到 `layout_admin_page.dart` 的以下位置：

```dart
Expanded(
  child: Obx(() => AnimatedSwitcher(
    duration: const Duration(milliseconds: 300),
    transitionBuilder: (child, animation) {
      // ===== 在这里粘贴你选择的方案代码 =====
      
    },
    child: KeyedSubtree(
      key: ValueKey(controller.currentPage.value),
      child: controller.getCurrentPageContent(),
    ),
  )),
),
```

