import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:book_store_admin/widgets/resizable_table.dart';
import 'package:book_store_admin/models/table_column_config.dart';
import 'package:book_store_admin/services/api_service.dart';
import 'user_controller.dart';
import 'user_model.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '用户管理',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddUserDialog(context),
                  icon: const Icon(Icons.add),
                  label: const Text('添加用户'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: '搜索用户...',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              // 实现搜索逻辑
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        DropdownButton<String>(
                          value: '所有状态',
                          items: const [
                            DropdownMenuItem(value: '所有状态', child: Text('所有状态')),
                            DropdownMenuItem(value: '正常', child: Text('正常')),
                            DropdownMenuItem(value: '锁定', child: Text('锁定')),
                          ],
                          onChanged: (value) {
                            // 实现状态筛选
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: Obx(() => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : _buildUserTable(controller)),
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

  Widget _buildUserTable(UserController controller) {
    if (controller.users.isEmpty) {
      return const Center(
        child: Text('暂无用户数据'),
      );
    }

    // 由于TableColumnConfig是为Book对象设计的，我们需要调整实现
    // 这里暂时使用简单的DataTable作为替代
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('用户名')),
            DataColumn(label: Text('真实姓名')),
            DataColumn(label: Text('昵称')),
            DataColumn(label: Text('手机号')),
            DataColumn(label: Text('邮箱')),
            DataColumn(label: Text('状态')),
            DataColumn(label: Text('创建时间')),
            DataColumn(label: Text('最后登录时间')),
            DataColumn(label: Text('操作')),
          ],
          rows: controller.users.map((user) {
            return DataRow(
              cells: [
                DataCell(Text('${user.id}')),
                DataCell(Text(user.username)),
                DataCell(Text(user.truename)),
                DataCell(Text(user.nickname)),
                DataCell(Text(user.phone)),
                DataCell(Text(user.email)),
                DataCell(
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: (user.status == 0 ? Colors.green : Colors.red).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: user.status == 0 ? Colors.green : Colors.red),
                    ),
                    child: Text(
                      user.status == 0 ? '正常' : '锁定',
                      style: TextStyle(color: user.status == 0 ? Colors.green : Colors.red),
                    ),
                  ),
                ),
                DataCell(Text(user.createTime.toString())),
                DataCell(Text(user.loginTime.toString())),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // 编辑用户
                        },
                        tooltip: '编辑',
                      ),
                      IconButton(
                        icon: Icon(
                          user.status == 0 ? Icons.lock : Icons.lock_open,
                          color: user.status == 0 ? Colors.orange : Colors.green,
                        ),
                        onPressed: () {
                          // 锁定/解锁用户
                        },
                        tooltip: user.status == 0 ? '锁定' : '解锁',
                      ),
                      IconButton(
                        icon: const Icon(Icons.key, color: Colors.purple),
                        onPressed: () {
                          // 重置密码
                        },
                        tooltip: '重置密码',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // 删除用户
                        },
                        tooltip: '删除',
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showAddUserDialog(BuildContext context) {
    // 添加用户对话框
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('添加用户'),
          content: const Text('用户添加功能正在开发中...'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('关闭'),
            ),
          ],
        );
      },
    );
  }
} 