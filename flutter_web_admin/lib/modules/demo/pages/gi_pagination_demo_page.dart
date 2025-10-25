import 'package:flutter/material.dart';
import 'package:flutter_web_admin/components/pagination/gi_responsive_pagination.dart';

/// GiPagination 组件演示页面
/// 完整复刻 gi-demo 项目中 table/base 页面的分页组件效果
class GiPaginationDemoPage extends StatefulWidget {
  final String title;
  const GiPaginationDemoPage({super.key, required this.title});

  @override
  State<GiPaginationDemoPage> createState() => _GiPaginationDemoPageState();
}

class _GiPaginationDemoPageState extends State<GiPaginationDemoPage> {
  late TablePaginationController _paginationController;
  final int _total = 500; // 模拟总数据量

  @override
  void initState() {
    super.initState();
    _paginationController = TablePaginationController(
      pageSize: 10,
      onPageChange: () {
        setState(() {});
      },
    );
    _paginationController.setTotal(_total);
  }

  // 模拟表格数据
  List<Map<String, dynamic>> get _tableData {
    final start = (_paginationController.current - 1) * _paginationController.pageSize;
    final end = (start + _paginationController.pageSize).clamp(0, _total);
    
    return List.generate(end - start, (index) {
      final id = start + index + 1;
      return {
        'id': id,
        'name': '用户$id',
        'account': 'user$id',
        'status': id % 3 == 0 ? '禁用' : '启用',
        'phone': '138${id.toString().padLeft(8, '0')}',
        'gender': id % 2 == 0 ? '男' : '女',
        'hobbys': ['阅读', '音乐', '运动'][id % 3],
        'createTime': '2023-09-${(id % 30 + 1).toString().padLeft(2, '0')} 10:00:00',
        'address': '北京市朝阳区某某街道$id号',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 页面标题
          Row(
            children: [
              Icon(
                Icons.smart_button,
                size: 26,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
              // 顶部说明
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '分页组件演示',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '这是一个复刻 gi-demo 项目中 /table/base 页面底部分页组件的 Flutter 实现',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '功能特性：',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '• 显示总数据量和当前页范围\n'
                      '• 支持每页条数选择器\n'
                      '• 智能页码显示（超过7页使用省略号）\n'
                      '• 支持跳转到指定页码\n'
                      '• 响应式设计（移动端简单模式）\n'
                      '• Arco Design 风格样式',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),
              
              // 模拟表格
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // 表格头部
                      Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 60, child: Text('序号', style: TextStyle(fontWeight: FontWeight.w600))),
                            const SizedBox(width: 120, child: Text('姓名', style: TextStyle(fontWeight: FontWeight.w600))),
                            const SizedBox(width: 120, child: Text('账户', style: TextStyle(fontWeight: FontWeight.w600))),
                            const SizedBox(width: 100, child: Text('状态', style: TextStyle(fontWeight: FontWeight.w600))),
                            const SizedBox(width: 150, child: Text('手机号', style: TextStyle(fontWeight: FontWeight.w600))),
                            const SizedBox(width: 100, child: Text('性别', style: TextStyle(fontWeight: FontWeight.w600))),
                            const SizedBox(width: 120, child: Text('爱好', style: TextStyle(fontWeight: FontWeight.w600))),
                            const Expanded(child: Text('地址', style: TextStyle(fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ),
                      
                      // 表格内容
                      Expanded(
                        child: ListView.builder(
                          itemCount: _tableData.length,
                          itemBuilder: (context, index) {
                            final item = _tableData[index];
                            final isEven = index % 2 == 0;
                            
                            return Container(
                              height: 56,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: isEven ? Colors.white : Colors.grey[50],
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]!),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 60, child: Text('${item['id']}')),
                                  SizedBox(width: 120, child: Text(item['name'])),
                                  SizedBox(width: 120, child: Text(item['account'])),
                                  SizedBox(
                                    width: 100,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: item['status'] == '启用' ? Colors.green[100] : Colors.red[100],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        item['status'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: item['status'] == '启用' ? Colors.green[700] : Colors.red[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 150, child: Text(item['phone'])),
                                  SizedBox(width: 100, child: Text(item['gender'])),
                                  SizedBox(width: 120, child: Text(item['hobbys'])),
                                  Expanded(child: Text(item['address'], overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      
                      // 分页组件（响应式）
                      _paginationController.buildPagination(
                        showPageSize: true,
                        showTotal: true,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ],
            ),
          ),  
        ],
      ),
    );
  }
}
