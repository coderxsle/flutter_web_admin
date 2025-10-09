import 'package:flutter/material.dart';

/// GiArcoMessage - 参照 ArcoDesign Message 的轻量提示
/// 支持 success / info / warning / error，右上角堆叠、自动消失
class GiArcoMessage {
  GiArcoMessage._();

  static final List<_MessageEntry> _entries = <_MessageEntry>[];
  static const EdgeInsets _margin = EdgeInsets.only(top: 16, right: 16);
  static const double _itemGap = 8;
  static const Duration _duration = Duration(milliseconds: 2400);
  static const Duration _fadeDuration = Duration(milliseconds: 200);

  static void success(String text, {BuildContext? context}) {
    _show(text, _GiMessageType.success, context: context);
  }

  static void info(String text, {BuildContext? context}) {
    _show(text, _GiMessageType.info, context: context);
  }

  static void warning(String text, {BuildContext? context}) {
    _show(text, _GiMessageType.warning, context: context);
  }

  static void error(String text, {BuildContext? context}) {
    _show(text, _GiMessageType.error, context: context);
  }

  static void _show(String text, _GiMessageType type, {BuildContext? context}) {
    final overlay = _obtainOverlay(context);
    if (overlay == null) return;

    final controller = ValueNotifier<double>(0);
    final entry = OverlayEntry(
      builder: (ctx) {
        final topOffset = _computeTopOffset(ctx, controller);
        final theme = Theme.of(ctx);
        final cfg = _typeStyle(theme, type);
        return Positioned.fill(
          child: Padding(
            padding: EdgeInsets.only(top: topOffset),
            child: Align(
              alignment: Alignment.topCenter,
              child: _MessageCard(
                text: text,
                icon: cfg.icon,
                color: cfg.color,
                onClose: () => _removeEntry(controller),
                fadeDuration: _fadeDuration,
                controller: controller,
              ),
            ),
          ),
        );
      },
    );

    final messageEntry = _MessageEntry(entry: entry, controller: controller);
    _entries.add(messageEntry);
    overlay.insert(entry);

    // 入场动画
    Future<void>.delayed(const Duration(milliseconds: 10), () {
      controller.value = 1;
    });

    // 自动移除
    Future<void>.delayed(_duration, () => _removeEntry(controller));
  }

  static OverlayState? _obtainOverlay(BuildContext? context) {
    // 优先使用传入 context 的 Overlay
    if (context != null) {
      final overlay = Overlay.maybeOf(context);
      if (overlay != null) return overlay;
    }
    // 退化到全局 navigatorKey 的 overlay
    return _navigatorKey.currentState?.overlay;
  }

  static void _removeEntry(ValueNotifier<double> controller) {
    // 先触发淡出
    controller.value = 0;
    Future<void>.delayed(_fadeDuration, () {
      final current = _entries.firstWhere(
        (e) => e.controller == controller,
        orElse: () => _MessageEntry(entry: OverlayEntry(builder: (_) => const SizedBox.shrink()), controller: controller),
      );
      final existed = _entries.contains(current);
      if (existed) {
        current.entry.remove();
        _entries.remove(current);
      }

      // 更新其后的位置
      for (int i = 0; i < _entries.length; i++) {
        _nudge(_entries[i].controller);
      }
    });
  }

  static void _nudge(ValueNotifier<double> controller) {
    final v = controller.value;
    // 在 [0,1] 内轻微调整触发重建
    final next = (v >= 1.0) ? v - 1e-6 : v + 1e-6;
    controller.value = next;
  }

  static double _computeTopOffset(BuildContext context, ValueNotifier<double> controller) {
    final index = _entries.indexWhere((e) => e.controller == controller);
    final safeTop = MediaQuery.of(context).padding.top;
    final base = safeTop + _margin.top;
    double offset = base;
    for (int i = 0; i < index; i++) {
      offset += _entries[i].lastHeight + _itemGap;
    }
    return offset;
  }

  // 全局 NavigatorKey，提供给 GoRouter 使用
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  // 提供给 GoRouter 的 navigatorKey
  static GlobalKey<NavigatorState> navigatorKey() => _navigatorKey;
}

class _MessageEntry {
  _MessageEntry({required this.entry, required this.controller});
  final OverlayEntry entry;
  final ValueNotifier<double> controller;
  double lastHeight = 0;
}

enum _GiMessageType { success, info, warning, error }

class _TypeStyle {
  _TypeStyle({required this.color, required this.icon});
  final Color color;
  final IconData icon;
}

_TypeStyle _typeStyle(ThemeData theme, _GiMessageType type) {
  switch (type) {
    case _GiMessageType.success:
      return _TypeStyle(color: const Color(0xFF00B42A), icon: Icons.check_circle);
    case _GiMessageType.info:
      return _TypeStyle(color: const Color(0xFF165DFF), icon: Icons.info);
    case _GiMessageType.warning:
      return _TypeStyle(color: const Color(0xFFFF7D00), icon: Icons.warning_amber);
    case _GiMessageType.error:
      return _TypeStyle(color: const Color(0xFFF53F3F), icon: Icons.error);
  }
}

class _MessageCard extends StatefulWidget {
  const _MessageCard({
    required this.text,
    required this.icon,
    required this.color,
    required this.onClose,
    required this.fadeDuration,
    required this.controller,
  });

  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onClose;
  final Duration fadeDuration;
  final ValueNotifier<double> controller;

  @override
  State<_MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<_MessageCard> {
  final GlobalKey _measureKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _saveSize());
  }

  void _saveSize() {
    final render = _measureKey.currentContext?.findRenderObject() as RenderBox?;
    if (render == null) return;
    final list = GiArcoMessage._entries;
    final idx = list.indexWhere((e) => e.controller == widget.controller);
    if (idx >= 0 && idx < list.length) {
      list[idx].lastHeight = render.size.height;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: widget.controller,
      builder: (ctx, t, child) {
        return AnimatedOpacity(
          opacity: t.clamp(0.0, 1.0),
          duration: widget.fadeDuration,
          child: AnimatedSlide(
            duration: widget.fadeDuration,
            offset: Offset(0.1 * (1 - t), 0),
            child: child!,
          ),
        );
      },
      child: Material(
        key: _measureKey,
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 360),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18, color: widget.color),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
