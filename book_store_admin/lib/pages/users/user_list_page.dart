import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserListController extends GetxController {
  final users = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;
    try {
      // TODO: 实现获取用户列表的逻辑
      await Future.delayed(const Duration(seconds: 1));
      users.value = [
        {
          'id': 1,
          'username': 'zhangsan',
          'truename': '张三',
          'phone': '13800138000',
          'email': 'zhangsan@example.com',
          'status': 0,
          'memberLevel': 1,
          'createTime': '2024-01-27 10:00:00',
        },
        {
          'id': 2,
          'username': 'lisi',
          'truename': '李四',
          'phone': '13800138001',
          'email': 'lisi@example.com',
          'status': 1,
          'memberLevel': 2,
          'createTime': '2024-01-27 11:00:00',
        },
      ];
    } finally {
      isLoading.value = false;
    }
  }

  String getStatusText(int status) {
    return status == 0 ? '正常' : '禁用';
  }

  String getMemberLevelText(int level) {
    switch (level) {
      case 0:
        return '普通会员';
      case 1:
        return '银卡会员';
      case 2:
        return '金卡会员';
      default:
        return '未知';
    }
  }

  void addUser() {
    // TODO: 实现添加用户的逻辑
  }

  void editUser(Map<String, dynamic> user) {
    // TODO: 实现编辑用户的逻辑
  }

  void toggleUserStatus(int id, int currentStatus) {
    // TODO: 实现切换用户状态的逻辑
  }
}

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserListController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('用户管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.addUser,
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(user['truename']),
                          SizedBox(width: 8.w),
                          Text(
                            '(${user['username']})',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Chip(
                            label: Text(
                              controller.getMemberLevelText(user['memberLevel']),
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            backgroundColor: Colors.blue[100],
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('手机：${user['phone']}'),
                          Text('邮箱：${user['email']}'),
                          Text('注册时间：${user['createTime']}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: user['status'] == 0,
                            onChanged: (value) => controller.toggleUserStatus(
                              user['id'],
                              user['status'],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => controller.editUser(user),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
} 