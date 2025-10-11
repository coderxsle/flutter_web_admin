/// @file LayoutDemoPage 布局演示页面
/// @description 专门用于展示布局系统的独立页面
import 'package:flutter/material.dart';

/// 布局演示页面
class LayoutDemoPage extends StatelessWidget {
  final String title;
  
  const LayoutDemoPage({
    super.key,
    this.title = '布局系统演示',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 页面说明
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '关于布局系统',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      '这是一个完全基于 Flutter 实现的管理后台布局系统，'
                      '100% 对应原 Vue 组件的功能和交互逻辑。'
                      '支持三种布局模式、响应式设计、主题切换等特性。',
                      style: TextStyle(height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // 布局演示组件
            // LayoutDemoWidget(showFullLayout: true),
            
            SizedBox(height: 24),
            
            // 功能特性说明
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✨ 主要特性',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    _FeatureItem(
                      icon: Icons.dashboard,
                      title: '三种布局模式',
                      description: '默认布局、混合布局、顶部布局',
                    ),
                    _FeatureItem(
                      icon: Icons.image_search,
                      title: '响应式设计',
                      description: '桌面端和移动端自动适配',
                    ),
                    _FeatureItem(
                      icon: Icons.menu,
                      title: '智能菜单系统',
                      description: '多层级菜单、手风琴模式、图标支持',
                    ),
                    _FeatureItem(
                      icon: Icons.tab,
                      title: '强大的标签页',
                      description: '多种样式、拖拽排序、右键菜单',
                    ),
                    _FeatureItem(
                      icon: Icons.palette,
                      title: '主题系统',
                      description: '明暗主题切换、菜单主题配置',
                    ),
                    _FeatureItem(
                      icon: Icons.settings,
                      title: '丰富的配置',
                      description: '实时配置、设置持久化',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 功能特性项
class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              icon,
              size: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
