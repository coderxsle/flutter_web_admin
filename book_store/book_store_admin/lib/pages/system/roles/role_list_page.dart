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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 顶部搜索区域
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.r),
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
                // 搜索条件区域
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: const Text(
                          '角色名称',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    ElevatedButton.icon(
                      onPressed: () => controller.fetchRoles(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('刷新'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton.icon(
                      onPressed: () {
                        // 搜索逻辑
                      },
                      icon: const Icon(Icons.search),
                      label: const Text('搜索'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // 操作按钮区域
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => _showAddRoleDialog(context, controller),
                icon: const Icon(Icons.add),
                label: const Text('添加'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              OutlinedButton.icon(
                onPressed: () => controller.fetchRoles(),
                icon: const Icon(Icons.refresh),
                label: const Text('刷新'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // 显示列设置
                },
                icon: const Icon(Icons.view_column, color: Colors.grey),
                tooltip: '列设置',
              ),
              IconButton(
                onPressed: () {
                  // 导出数据
                },
                icon: const Icon(Icons.download, color: Colors.grey),
                tooltip: '导出',
              ),
              IconButton(
                onPressed: () {
                  // 打印数据
                },
                icon: const Icon(Icons.print, color: Colors.grey),
                tooltip: '打印',
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // 角色列表区域
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : _buildRoleTable(controller, context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleTable(RoleController controller, BuildContext context) {
    if (controller.roles.isEmpty) {
      return const Center(
        child: Text('暂无角色数据'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 表头
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              SizedBox(width: 40.w, child: Checkbox(value: false, onChanged: (_) {})),
              Expanded(flex: 1, child: Text('ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 3, child: Text('角色名称', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 1, child: Text('用户数量', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 1, child: Text('资源数量', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              SizedBox(width: 280.w, child: Text('操作', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
            ],
          ),
        ),
        
        // 表格内容
        Expanded(
          child: ListView.builder(
            itemCount: controller.roles.length,
            itemBuilder: (context, index) {
              final role = controller.roles[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40.w, 
                      child: Checkbox(value: false, onChanged: (_) {}),
                    ),
                    Expanded(flex: 1, child: Text('${role.id}')),
                    Expanded(flex: 3, child: Text(role.name)),
                    Expanded(flex: 1, child: Text('${role.userCount ?? 0}')),
                    Expanded(flex: 1, child: Text('${role.resourceCount ?? 0}')),
                    SizedBox(
                      width: 280.w,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OutlinedButton.icon(
                            icon: const Icon(Icons.people, color: Colors.blue, size: 16),
                            label: const Text('用户'),
                            onPressed: () => _showRoleUsersDialog(context, controller, role),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
                              minimumSize: Size(0, 30.h),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.security, color: Colors.green, size: 16),
                            label: const Text('权限'),
                            onPressed: () => _showRoleResourcesDialog(context, controller, role),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
                              minimumSize: Size(0, 30.h),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange, size: 20),
                            onPressed: () => _showEditRoleDialog(context, controller, role),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            tooltip: '编辑',
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                            onPressed: () => _showDeleteRoleDialog(context, controller, role),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            tooltip: '删除',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
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
          content: SizedBox(
            width: 700.w,
            height: 500.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // 分配用户
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('分配用户'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: FutureBuilder(
                    future: controller.getRoleUsers(role.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      
                      if (snapshot.hasError) {
                        return Center(child: Text('加载失败: ${snapshot.error}'));
                      }
                      
                      final users = snapshot.data as List<dynamic>;
                      
                      if (users.isEmpty) {
                        return const Center(child: Text('该角色暂未分配用户'));
                      }
                      
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: const Center(
                          child: Text('用户分配功能正在开发中...'),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
          content: SizedBox(
            width: 700.w,
            height: 500.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // 分配权限
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('保存权限设置'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: FutureBuilder(
                    future: controller.getRoleResources(role.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      
                      if (snapshot.hasError) {
                        return Center(child: Text('加载失败: ${snapshot.error}'));
                      }
                      
                      final resources = snapshot.data as List<dynamic>;
                      
                      if (resources.isEmpty) {
                        return const Center(child: Text('该角色暂未分配资源权限'));
                      }
                      
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: const Center(
                          child: Text('权限分配功能正在开发中...'),
                        ),
                      );
                    },
                  ),
                ),
              ],
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