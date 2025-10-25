
import 'package:flutter/material.dart';
import 'package:flutter_web_admin/modules/layout/layout.dart';

import 'fold_button.dart';

/// 头部组件
/// @file Header 组件
/// @description 头部组件，包含折叠按钮、面包屑导航和右侧工具栏
class LayoutContentHeader extends StatelessWidget {
  const LayoutContentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border(bottom: BorderSide(width: 1, color:  Theme.of(context).dividerColor)),
      ),
      child: Row(
        children: [
          // 折叠按钮区域
          const LayoutMenuFoldBtn(),
          
          // 中间内容区域
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // 响应式布局
                  if (constraints.maxWidth > 768) {
                    // 桌面端布局
                    return const Row(
                      children: [
                        // // 面包屑导航（左侧）
                        // Expanded(
                        //   flex: 5,
                        //   child: AppBreadcrumb(),
                        // ),
                        
                        // 右侧工具栏
                        Expanded(
                          flex: 7,
                          child: HeaderRightBar(),
                        ),
                      ],
                    );
                  } else {
                    // 移动端布局（只显示右侧工具栏）
                    return const Row(
                      children: [
                        // Expanded(child: SizedBox.shrink()),
                        // HeaderRightBar(),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// IconButton(
//   onPressed: onToggleExpansion,
//   icon: Icon(isExpanded ? Icons.chevron_left : Icons.chevron_right, color: Colors.white),
//   tooltip: isExpanded ? '收起菜单' : '展开菜单',
// ),


// const Spacer(),
// IconButton(
//   onPressed: onToggleExpansion,
//   icon: Icon(
//     Icons.chevron_right,
//     color: Colors.white,
//   ),
//   tooltip: '展开菜单',
//   padding: EdgeInsets.zero,
//   constraints: const BoxConstraints(),
//   iconSize: 20,
// ),