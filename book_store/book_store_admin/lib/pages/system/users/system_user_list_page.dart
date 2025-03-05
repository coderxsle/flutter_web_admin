import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'system_user_controller.dart';
import 'system_user_model.dart';

class SystemUserListPage extends StatelessWidget {
  const SystemUserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SystemUserController());

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
                          '用户名、真实姓名、昵称、邮箱',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
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
                    SizedBox(width: 12.w),
                    ElevatedButton.icon(
                      onPressed: () => controller.fetchUsers(),
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
                onPressed: () => _showAddUserDialog(context, controller),
                icon: const Icon(Icons.add),
                label: const Text('添加'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              OutlinedButton.icon(
                onPressed: () => controller.fetchUsers(),
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
          
          // 用户列表区域
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
                : _buildUserTable(controller)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTable(SystemUserController controller) {
    if (controller.users.isEmpty) {
      return const Center(
        child: Text('暂无用户数据'),
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
              Expanded(flex: 2, child: Text('用户名', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 2, child: Text('真实姓名', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 2, child: Text('昵称', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 2, child: Text('手机号', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 2, child: Text('邮箱', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 1, child: Text('状态', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 2, child: Text('创建时间', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 2, child: Text('最后登录', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              SizedBox(width: 160.w, child: Text('操作', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
            ],
          ),
        ),
        
        // 表格内容
        Expanded(
          child: ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40.w, 
                      child: Checkbox(value: false, onChanged: (_) {}),
                    ),
                    Expanded(flex: 1, child: Text('${user.id}')),
                    Expanded(flex: 2, child: Text(user.username)),
                    Expanded(flex: 2, child: Text(user.truename)),
                    Expanded(flex: 2, child: Text(user.nickname)),
                    Expanded(flex: 2, child: Text(user.phone)),
                    Expanded(flex: 2, child: Text(user.email)),
                    Expanded(
                      flex: 1, 
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        decoration: BoxDecoration(
                          color: (user.status == 0 ? Colors.green : Colors.red).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(2.r),
                          border: Border.all(color: user.status == 0 ? Colors.green : Colors.red),
                        ),
                        child: Text(
                          user.status == 0 ? '正常' : '锁定',
                          style: TextStyle(
                            color: user.status == 0 ? Colors.green : Colors.red,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2, 
                      child: Text(
                        '${user.createTime.year}-${user.createTime.month.toString().padLeft(2, '0')}-${user.createTime.day.toString().padLeft(2, '0')}'
                      ),
                    ),
                    Expanded(
                      flex: 2, 
                      child: Text(
                        '${user.loginTime.year}-${user.loginTime.month.toString().padLeft(2, '0')}-${user.loginTime.day.toString().padLeft(2, '0')} ${user.loginTime.hour.toString().padLeft(2, '0')}:${user.loginTime.minute.toString().padLeft(2, '0')}'
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                            onPressed: () {
                              // 编辑用户
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            tooltip: '编辑',
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            icon: Icon(
                              user.status == 0 ? Icons.lock : Icons.lock_open,
                              color: user.status == 0 ? Colors.orange : Colors.green,
                              size: 20,
                            ),
                            onPressed: () {
                              // 锁定/解锁用户
                              controller.updateUserStatus(user.id, user.status == 0 ? 1 : 0);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            tooltip: user.status == 0 ? '锁定' : '解锁',
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            icon: const Icon(Icons.key, color: Colors.purple, size: 20),
                            onPressed: () {
                              // 重置密码
                              controller.resetPassword(user.id);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            tooltip: '重置密码',
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                            onPressed: () {
                              // 删除用户
                              _showDeleteUserDialog(context, controller, user);
                            },
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

  void _showAddUserDialog(BuildContext context, SystemUserController controller) {
    final usernameController = TextEditingController();
    final truenameController = TextEditingController();
    final nicknameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('添加用户'),
          content: SizedBox(
            width: 500.w,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: '用户名',
                      hintText: '请输入用户名',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: '密码',
                      hintText: '请输入密码',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: truenameController,
                    decoration: const InputDecoration(
                      labelText: '真实姓名',
                      hintText: '请输入真实姓名',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: nicknameController,
                    decoration: const InputDecoration(
                      labelText: '昵称',
                      hintText: '请输入昵称',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: '手机号',
                      hintText: '请输入手机号',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: '邮箱',
                      hintText: '请输入邮箱',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
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
                if (usernameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请输入用户名')),
                  );
                  return;
                }
                
                if (passwordController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请输入密码')),
                  );
                  return;
                }
                
                final newUser = SystemUserModel(
                  id: DateTime.now().millisecondsSinceEpoch, // 临时ID
                  username: usernameController.text.trim(),
                  truename: truenameController.text.trim(),
                  nickname: nicknameController.text.trim(),
                  phone: phoneController.text.trim(),
                  email: emailController.text.trim(),
                  status: 0,
                  createTime: DateTime.now(),
                  loginTime: DateTime.now(),
                );
                
                controller.addUser(newUser).then((success) {
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

  void _showDeleteUserDialog(BuildContext context, SystemUserController controller, SystemUserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除用户'),
          content: Text('确定要删除用户 "${user.username}" 吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                controller.deleteUser(user.id).then((success) {
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
} 