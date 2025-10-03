/// @file NoticeWidget 组件
/// @description 通知组件，显示系统通知和消息
import 'package:flutter/material.dart';

/// 通知项数据模型
class NoticeItem {
  final String id;
  final String title;
  final String content;
  final String time;
  final NoticeType type;
  final bool isRead;

  const NoticeItem({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

/// 通知类型枚举
enum NoticeType {
  info,
  warning,
  error,
  success,
}

/// 通知组件
class NoticeWidget extends StatefulWidget {
  const NoticeWidget({super.key});

  @override
  State<NoticeWidget> createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  /// 模拟通知数据
  final List<NoticeItem> _notifications = [
    NoticeItem(
      id: '1',
      title: '系统更新',
      content: '系统将在今晚进行更新维护，预计持续2小时',
      time: '2小时前',
      type: NoticeType.info,
    ),
    NoticeItem(
      id: '2',
      title: '安全警告',
      content: '检测到异常登录，请及时修改密码',
      time: '1天前',
      type: NoticeType.warning,
    ),
    NoticeItem(
      id: '3',
      title: '操作成功',
      content: '数据备份已完成',
      time: '3天前',
      type: NoticeType.success,
      isRead: true,
    ),
  ];

  final List<NoticeItem> _messages = [
    NoticeItem(
      id: '4',
      title: '新用户注册',
      content: '用户 John Doe 已注册账号',
      time: '1小时前',
      type: NoticeType.info,
    ),
    NoticeItem(
      id: '5',
      title: '订单提醒',
      content: '您有3个待处理的订单',
      time: '5小时前',
      type: NoticeType.warning,
    ),
  ];

  final List<NoticeItem> _todos = [
    NoticeItem(
      id: '6',
      title: '审核任务',
      content: '5个用户申请待审核',
      time: '今天',
      type: NoticeType.info,
    ),
    NoticeItem(
      id: '7',
      title: '报表生成',
      content: '月度报表需要生成',
      time: '明天',
      type: NoticeType.warning,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 获取通知类型图标
  IconData _getNoticeIcon(NoticeType type) {
    switch (type) {
      case NoticeType.info:
        return Icons.info;
      case NoticeType.warning:
        return Icons.warning;
      case NoticeType.error:
        return Icons.error;
      case NoticeType.success:
        return Icons.check_circle;
    }
  }

  /// 获取通知类型颜色
  Color _getNoticeColor(NoticeType type) {
    switch (type) {
      case NoticeType.info:
        return Colors.blue;
      case NoticeType.warning:
        return Colors.orange;
      case NoticeType.error:
        return Colors.red;
      case NoticeType.success:
        return Colors.green;
    }
  }

  /// 构建通知项
  Widget _buildNoticeItem(NoticeItem item) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: item.isRead 
            ? theme.cardColor 
            : theme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 通知图标
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _getNoticeColor(item.type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              _getNoticeIcon(item.type),
              size: 16,
              color: _getNoticeColor(item.type),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // 通知内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题和时间
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: theme.textTheme.titleMedium?.color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      item.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 4),
                
                // 内容
                Text(
                  item.content,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // 未读标识
          if (!item.isRead) ...[
            const SizedBox(width: 8),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 构建通知列表
  Widget _buildNoticeList(List<NoticeItem> items) {
    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 48,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '暂无消息',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      itemBuilder: (context, index) => _buildNoticeItem(items[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: 320,
      height: 400,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // 头部标签
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: theme.primaryColor,
              unselectedLabelColor: theme.textTheme.bodyMedium?.color,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('通知'),
                      if (_notifications.where((n) => !n.isRead).isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${_notifications.where((n) => !n.isRead).length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('消息'),
                      if (_messages.where((m) => !m.isRead).isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${_messages.where((m) => !m.isRead).length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Tab(text: '待办'),
              ],
            ),
          ),
          
          // 内容区域
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNoticeList(_notifications),
                _buildNoticeList(_messages),
                _buildNoticeList(_todos),
              ],
            ),
          ),
          
          // 底部操作
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: theme.dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    // 标记全部已读
                  },
                  child: const Text('全部已读'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // 查看更多
                  },
                  child: const Text('查看更多'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
