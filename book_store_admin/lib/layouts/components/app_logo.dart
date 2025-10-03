///
/// @file Logo 组件
/// @description 系统 Logo 组件，支持折叠状态和首页导航功能
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/routes.dart';

/// 系统 Logo 组件
/// 
/// 功能特性：
/// - 显示系统 Logo 和名称
/// - 支持折叠状态（隐藏名称）
/// - 点击跳转到首页
/// - 响应式设计
class AppLogo extends StatelessWidget {
  /// 是否折叠状态
  final bool collapsed;

  const AppLogo({
    super.key,
    this.collapsed = false,
  });

  /// 处理首页导航
  void _handleHomeNavigation() {
    Get.toNamed(Routes.books);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleHomeNavigation,
      child: Container(
        height: 56,
        padding: EdgeInsets.symmetric(
          horizontal: collapsed ? 0 : 12,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: collapsed 
              ? MainAxisAlignment.center 
              : MainAxisAlignment.start,
          children: [
            // Logo 图片
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).primaryColor,
              ),
              child: const Icon(
                Icons.book,
                color: Colors.white,
                size: 20,
              ),
            ),
            
            // 系统名称（非折叠状态显示）
            if (!collapsed) ...[
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Admin Pro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
