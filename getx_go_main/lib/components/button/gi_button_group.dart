import 'package:flutter/material.dart';

/// 按钮组组件 - 仿照 ArcoDesign 的 ButtonGroup
class GiButtonGroup extends StatelessWidget {
  /// 按钮列表
  final List<Widget> children;
  
  /// 是否垂直布局
  final bool vertical;

  const GiButtonGroup({
    super.key,
    required this.children,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return vertical ? _buildVerticalGroup() : _buildHorizontalGroup();
  }

  /// 构建水平按钮组
  Widget _buildHorizontalGroup() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _buildGroupedButtons(),
    );
  }

  /// 构建垂直按钮组
  Widget _buildVerticalGroup() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _buildGroupedButtons(),
    );
  }

  /// 构建分组按钮
  List<Widget> _buildGroupedButtons() {
    final groupedButtons = <Widget>[];
    
    for (int i = 0; i < children.length; i++) {
      final isFirst = i == 0;
      final isLast = i == children.length - 1;
      final isSingle = children.length == 1;
      
      Widget button = children[i];
      
      // 如果是 ElevatedButton，需要修改其样式以适应按钮组
      if (button is ElevatedButton) {
        button = _wrapButtonForGroup(button, isFirst, isLast, isSingle);
      }
      
      groupedButtons.add(button);
    }
    
    return groupedButtons;
  }

  /// 为按钮组包装按钮样式
  Widget _wrapButtonForGroup(ElevatedButton button, bool isFirst, bool isLast, bool isSingle) {
    final originalStyle = button.style ?? ElevatedButton.styleFrom();
    
    BorderRadius borderRadius;
    if (isSingle) {
      borderRadius = BorderRadius.circular(6);
    } else if (vertical) {
      if (isFirst) {
        borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        );
      } else if (isLast) {
        borderRadius = const BorderRadius.only(
          bottomLeft: Radius.circular(6),
          bottomRight: Radius.circular(6),
        );
      } else {
        borderRadius = BorderRadius.zero;
      }
    } else {
      if (isFirst) {
        borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(6),
          bottomLeft: Radius.circular(6),
        );
      } else if (isLast) {
        borderRadius = const BorderRadius.only(
          topRight: Radius.circular(6),
          bottomRight: Radius.circular(6),
        );
      } else {
        borderRadius = BorderRadius.zero;
      }
    }

    return ElevatedButton(
      onPressed: button.onPressed,
      style: originalStyle.copyWith(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: button.child,
    );
  }
}
