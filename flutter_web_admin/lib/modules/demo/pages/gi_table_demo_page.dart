import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:flutter_web_admin/components/table/index.dart';
import 'package:flutter_web_admin/components/cell/gi_cell_avatar.dart';
import 'package:flutter_web_admin/components/cell/gi_cell_status.dart';
import 'package:flutter_web_admin/components/cell/gi_cell_gender.dart';
import 'package:flutter_web_admin/components/cell/gi_cell_tags.dart';
import 'package:flutter_web_admin/components/button/gi_arco_button.dart';

/// GiTable (基于 trina_grid) 演示页面
class GiTableDemoPage extends StatefulWidget {
  final String title;
  const GiTableDemoPage({super.key, required this.title});

  @override
  State<GiTableDemoPage> createState() => _GiTableDemoPageState();
}

class _GiTableDemoPageState extends State<GiTableDemoPage> {
  bool _loading = false;
  List<Map<String, dynamic>> _tableData = [];
  late GiTablePaginationController _paginationController;
  final int _totalRecords = 500; // 测试：恢复到 500 条数据
  
  @override
  void initState() {
    super.initState();
    _paginationController = GiTablePaginationController(pageSize: 20);
    _paginationController.setTotal(_totalRecords);
    // ✅ 使用自定义分页时，需要监听分页变化来加载对应页的数据
    _paginationController.addListener(_onPaginationChanged);
    _loadData();
  }
  
  @override
  void dispose() {
    _paginationController.removeListener(_onPaginationChanged);
    _paginationController.dispose();
    super.dispose();
  }
  
  /// 分页状态变化回调
  void _onPaginationChanged() {
    _loadData();
  }
  
  /// 加载数据
  Future<void> _loadData() async {
    // 生成当前页数据并更新状态
    final newData = _generateMockData();
    
    setState(() {
      _tableData = newData;
    });
  }
  
  /// 生成模拟数据（服务端分页模式：只生成当前页数据）
  List<Map<String, dynamic>> _generateMockData() {
    final names = ['张三', '李四', '王五', '赵六', '钱七', '孙八', '周九', '吴十'];
    final avatars = [
      'https://api.dicebear.com/7.x/avataaars/svg?seed=1',
      'https://api.dicebear.com/7.x/avataaars/svg?seed=2',
      'https://api.dicebear.com/7.x/avataaars/svg?seed=3',
      'https://api.dicebear.com/7.x/avataaars/svg?seed=4',
    ];
    final hobbies = ['编程', '阅读', '旅游', '音乐', '运动', '摄影', '绘画', '烹饪'];
    final addresses = [
      '北京市朝阳区某某街道某某小区',
      '上海市浦东新区某某路某某号',
      '广州市天河区某某大道某某楼',
      '深圳市南山区某某科技园',
    ];
    
    // ✅ 服务端分页：只生成当前页的数据
    final start = (_paginationController.current - 1) * _paginationController.pageSize;
    final end = (start + _paginationController.pageSize).clamp(0, _totalRecords);
    final count = end - start;
    
    return List.generate(count, (i) {
      final index = start + i;
      final now = DateTime.now();
      return {
        'id': 'ID-${1000 + index}',
        'name': names[index % names.length],
        'avatar': avatars[index % avatars.length],
        'account': 'user${index + 1}',
        'status': index % 3 == 0 ? 0 : 1,
        'phone': '138${(10000000 + index).toString().substring(0, 8)}',
        'gender': (index % 3) + 1,
        'age': 20 + (index % 30),
        'hobbys': [
          hobbies[index % hobbies.length],
          hobbies[(index + 1) % hobbies.length],
          hobbies[(index + 2) % hobbies.length],
        ],
        'createTime': DateTime(
          now.year,
          now.month,
          now.day - (index % 30),
          now.hour,
          now.minute,
        ).toString().substring(0, 19),
        'address': addresses[index % addresses.length],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GiTable 演示 (基于 trina_grid)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GiTable<Map<String, dynamic>>(
          title: '用户列表',
          columns: _buildColumns(),
          data: _tableData,
          loading: _loading,
          showPagination: true,
          currentPage: _paginationController.current,
          pageSize: 20, // 测试：每页显示 20 条
          totalCount: _paginationController.total,
          onPageChange: _paginationController.onPageChange,
          onPageSizeChange: _paginationController.onPageSizeChange,
          enableRowSelection: true,
          multipleSelection: true,
          onRefresh: _loadData,
          customExtra: (context) => Row(
            children: [
              GiArcoButton(
                type: GiArcoButtonType.primary,
                text: '新增',
                icon: Icons.add,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('点击了新增')),
                  );
                },
              ),
              const SizedBox(width: 8),
              GiArcoButton(
                type: GiArcoButtonType.primary,
                status: GiArcoButtonStatus.danger,
                text: '删除',
                icon: Icons.delete,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('点击了删除')),
                  );
                },
              ),
              const SizedBox(width: 8),
              GiArcoButton(
                type: GiArcoButtonType.secondary,
                text: '导出',
                icon: Icons.download,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('点击了导出')),
                  );
                },
              ),
            ],
          ),
          onRowSelectionChanged: (rows) {
            debugPrint('选中了 ${rows.length} 行');
          },
          onRowDoubleTap: (event) {
            final row = event.row;
            final name = row.cells['name']?.value;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('双击了: $name')),
            );
          },
          disabledColumnKeys: const ['id', 'name'],
          noRowsWidget: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  '暂无数据',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  /// 构建列配置
  List<GiTableColumn<Map<String, dynamic>>> _buildColumns() {
    return [
      // 序号列
      GiTableColumn<Map<String, dynamic>>(
        title: '序号',
        field: 'id',  // 使用 id 字段，但显示序号
        type: GiColumnType.number,
        width: 60,
        frozen: true,
        textAlign: TextAlign.center,
        sortable: false,
        cellRenderer: (context, cell, rowIndex) {
          return Center(
            child: Text(
              '${rowIndex + 1}',
              style: const TextStyle(fontSize: 14),
            ),
          );
        },
      ),
      
      // 姓名列 (带头像)
      GiTableColumn<Map<String, dynamic>>(
        title: '姓名',
        field: 'name',
        type: GiColumnType.text,
        width: 150,
        cellRenderer: (context, cell, rowIndex) {
          final row = _tableData[rowIndex];
          return GiCellAvatar(
            avatar: row['avatar'],
            name: row['name'],
            size: 28,
          );
        },
      ),
      
      // 账户列
      const GiTableColumn<Map<String, dynamic>>(
        title: '账户',
        field: 'account',
        type: GiColumnType.text,
        width: 120,
      ),
      
      // 状态列
      GiTableColumn<Map<String, dynamic>>(
        title: '状态',
        field: 'status',
        type: GiColumnType.number,
        width: 100,
        textAlign: TextAlign.center,
        cellRenderer: (context, cell, rowIndex) {
          final row = _tableData[rowIndex];
          return Center(
            child: GiCellStatus(
              status: row['status'],
              size: GiStatusSize.small,
            ),
          );
        },
      ),
      
      // 手机号列
      const GiTableColumn<Map<String, dynamic>>(
        title: '手机号',
        field: 'phone',
        type: GiColumnType.text,
        width: 150,
      ),
      
      // 性别列
      GiTableColumn<Map<String, dynamic>>(
        title: '性别',
        field: 'gender',
        type: GiColumnType.number,
        width: 100,
        textAlign: TextAlign.center,
        cellRenderer: (context, cell, rowIndex) {
          final row = _tableData[rowIndex];
          return Center(
            child: GiCellGender(
              gender: row['gender'],
              size: GiGenderSize.small,
            ),
          );
        },
      ),
      
      // 年龄列
      const GiTableColumn<Map<String, dynamic>>(
        title: '年龄',
        field: 'age',
        type: GiColumnType.number,
        width: 80,
        textAlign: TextAlign.center,
      ),
      
      // 爱好列
      GiTableColumn<Map<String, dynamic>>(
        title: '爱好',
        field: 'hobbys',
        type: GiColumnType.text,
        width: 200,
        cellRenderer: (context, cell, rowIndex) {
          final row = _tableData[rowIndex];
          final hobbys = row['hobbys'] as List<dynamic>?;
          if (hobbys == null || hobbys.isEmpty) {
            return const SizedBox.shrink();
          }
          return GiCellTags(
            data: hobbys.map((e) => e.toString()).toList(),
            size: GiTagSize.small,
            maxVisible: 2,
          );
        },
      ),
      
      // 创建时间列
      const GiTableColumn<Map<String, dynamic>>(
        title: '创建时间',
        field: 'createTime',
        type: GiColumnType.datetime,
        width: 180,
      ),
      
      // 地址列
      const GiTableColumn<Map<String, dynamic>>(
        title: '地址',
        field: 'address',
        type: GiColumnType.text,
        width: 250,
      ),
      
      // 操作列
      GiTableColumn<Map<String, dynamic>>(
        title: '操作',
        field: 'id',  // 使用 id 字段，但显示操作按钮
        type: GiColumnType.text,
        width: 260,
        frozen: true,
        frozenPosition: TrinaColumnFrozen.end,
        textAlign: TextAlign.center,
        sortable: false,
        cellRenderer: (context, cell, rowIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GiArcoButton(
                type: GiArcoButtonType.primary,
                size: GiArcoButtonSize.mini,
                text: '编辑',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('编辑第 ${rowIndex + 1} 行')),
                  );
                },
              ),
              const SizedBox(width: 8),
              GiArcoButton(
                type: GiArcoButtonType.secondary,
                size: GiArcoButtonSize.mini,
                text: '详情',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('查看第 ${rowIndex + 1} 行详情')),
                  );
                },
              ),
              const SizedBox(width: 8),
              GiArcoButton(
                type: GiArcoButtonType.primary,
                status: GiArcoButtonStatus.danger,
                size: GiArcoButtonSize.mini,
                text: '删除',
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('确认删除'),
                      content: const Text('您确定要删除该项吗?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('取消'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('删除'),
                        ),
                      ],
                    ),
                  );
                  
                  if (confirmed == true && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('删除第 ${rowIndex + 1} 行')),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    ];
  }
}

