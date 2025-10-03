///
/// @file LayoutDefault 组件
/// @description 默认布局组件，包含左侧菜单和右侧内容区域
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global/global.dart';
import 'components/app_asider.dart';
import 'components/app_header.dart';
import 'components/app_main.dart';
import 'components/app_tabs.dart';

/// 默认布局组件
/// 
/// 采用经典的左右分栏布局：
/// - 左侧：侧边栏菜单（可折叠）
/// - 右侧：头部导航 + 标签页 + 主内容区
class LayoutDefault extends StatefulWidget {
  /// 子组件内容
  final Widget child;

  const LayoutDefault({
    super.key,
    required this.child,
  });

  @override
  State<LayoutDefault> createState() => _LayoutDefaultState();
}

class _LayoutDefaultState extends State<LayoutDefault> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GlobalController>(
        builder: (controller) {
          return Row(
            children: [
              // 左侧菜单区域
              const AppAsider(),
              
              // 右侧内容区域
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                  ),
                  child: Column(
                    children: [
                      // 顶部导航
                      const AppHeader(),
                      
                      // 标签页（根据配置显示）
                      if (controller.tabVisible) const AppTabs(),
                      
                      // 主内容区域
                      Expanded(
                        child: AppMain(child: widget.child),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
