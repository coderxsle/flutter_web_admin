import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:book_store_admin/services/api_service.dart';
import 'role_controller.dart';
import 'role_model.dart';

class RoleListPage extends StatelessWidget {
  const RoleListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoleController());

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
                  '角色管理',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddRoleDialog(context, controller),
                  icon: const Icon(Icons.add),
                  label: const Text('添加角色'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
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
                    TextField(
                      decoration: const InputDecoration(
                        hintText: '搜索角色...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // 实现搜索逻辑
                      },
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: Obx(() => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : _buildRoleTable(controller, context)),
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

  Widget _buildRoleTable(RoleController controller, BuildContext context) {
    if (controller.roles.isEmpty) {
      return const Center(
        child: Text('暂无角色数据'),
      );
    }

    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('角色名称')),
            DataColumn(label: Text('用户数量')),
            DataColumn(label: Text('资源数量')),
            DataColumn(label: Text('操作')),
          ],
          rows: controller.roles.map((role) {
            return DataRow(
              cells: [
                DataCell(Text('${role.id}')),
                DataCell(Text(role.name)),
                DataCell(Text('${role.userCount ?? 0}')),
                DataCell(Text('${role.resourceCount ?? 0}')),
                DataCell(
                  Row(
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.people, color: Colors.blue),
                        label: const Text('用户'),
                        onPressed: () => _showRoleUsersDialog(context, controller, role),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.security, color: Colors.green),
                        label: const Text('权限'),
                        onPressed: () => _showRoleResourcesDialog(context, controller, role),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => _showEditRoleDialog(context, controller, role),
                        tooltip: '编辑',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteRoleDialog(context, controller, role),
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

  void _showAddRoleDialog(BuildContext context, RoleController controller) {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('添加角色'),
          content: SizedBox(
            width: 400.w,
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '角色名称',
                hintText: '请输入角色名称',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请输入角色名称')),
                  );
                  return;
                }
                
                final newRole = RoleModel(
                  id: DateTime.now().millisecondsSinceEpoch, // 临时ID
                  name: nameController.text.trim(),
                  userCount: 0,
                  resourceCount: 0,
                );
                
                controller.addRole(newRole).then((success) {
                  if (success) {
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  void _showEditRoleDialog(BuildContext context, RoleController controller, RoleModel role) {
    final nameController = TextEditingController(text: role.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('编辑角色'),
          content: SizedBox(
            width: 400.w,
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: '角色名称',
                hintText: '请输入角色名称',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请输入角色名称')),
                  );
                  return;
                }
                
                final updatedRole = RoleModel(
                  id: role.id,
                  name: nameController.text.trim(),
                  userCount: role.userCount,
                  resourceCount: role.resourceCount,
                );
                
                controller.updateRole(updatedRole).then((success) {
                  if (success) {
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteRoleDialog(BuildContext context, RoleController controller, RoleModel role) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除角色'),
          content: Text('确定要删除角色 "${role.name}" 吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                controller.deleteRole(role.id).then((success) {
                  if (success) {
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text('确定删除', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showRoleUsersDialog(BuildContext context, RoleController controller, RoleModel role) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${role.name} - 用户列表'),
          content: const SizedBox(
            width: 500,
            height: 400,
            child: Center(
              child: Text('用户分配功能正在开发中...'),
            ),
          ),
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

  void _showRoleResourcesDialog(BuildContext context, RoleController controller, RoleModel role) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${role.name} - 权限分配'),
          content: const SizedBox(
            width: 500,
            height: 400,
            child: Center(
              child: Text('权限分配功能正在开发中...'),
            ),
          ),
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