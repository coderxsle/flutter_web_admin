import 'package:get/get.dart';
import 'package:book_store_admin/services/api_service.dart';
import 'system_user_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SystemUserController extends GetxController {
  final ApiService _apiService = ApiService();
  
  // 用户列表
  final users = <SystemUserModel>[].obs;
  
  // 加载状态
  final isLoading = false.obs;
  
  // 当前页
  final currentPage = 1.obs;
  
  // 总页数
  final totalPages = 0.obs;
  
  // 每页条数
  final pageSize = 10.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }
  
  // 加载用户数据
  Future<void> fetchUsers() async {
    isLoading.value = true;
    try {
      // TODO: 实现 API 调用获取用户列表
      // 暂时使用模拟数据
      await Future.delayed(const Duration(seconds: 1));
      users.value = _getMockUsers();
      totalPages.value = 3; // 模拟总页数
    } catch (e) {
      EasyLoading.showError('获取用户数据失败: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // 添加用户
  Future<bool> addUser(SystemUserModel user) async {
    try {
      EasyLoading.show(status: '正在添加用户...');
      // TODO: 实现 API 调用添加用户
      await Future.delayed(const Duration(seconds: 1));
      users.add(user);
      EasyLoading.showSuccess('添加用户成功');
      return true;
    } catch (e) {
      EasyLoading.showError('添加用户失败: $e');
      return false;
    }
  }
  
  // 更新用户
  Future<bool> updateUser(SystemUserModel user) async {
    try {
      EasyLoading.show(status: '正在更新用户...');
      // TODO: 实现 API 调用更新用户
      await Future.delayed(const Duration(seconds: 1));
      final index = users.indexWhere((element) => element.id == user.id);
      if (index != -1) {
        users[index] = user;
        users.refresh();
      }
      EasyLoading.showSuccess('更新用户成功');
      return true;
    } catch (e) {
      EasyLoading.showError('更新用户失败: $e');
      return false;
    }
  }
  
  // 删除用户
  Future<bool> deleteUser(int userId) async {
    try {
      EasyLoading.show(status: '正在删除用户...');
      // TODO: 实现 API 调用删除用户
      await Future.delayed(const Duration(seconds: 1));
      users.removeWhere((element) => element.id == userId);
      EasyLoading.showSuccess('删除用户成功');
      return true;
    } catch (e) {
      EasyLoading.showError('删除用户失败: $e');
      return false;
    }
  }
  
  // 更新用户状态
  Future<bool> updateUserStatus(int userId, int status) async {
    try {
      EasyLoading.show(status: '正在更新用户状态...');
      // TODO: 实现 API 调用更新用户状态
      await Future.delayed(const Duration(seconds: 1));
      final index = users.indexWhere((element) => element.id == userId);
      if (index != -1) {
        users[index].status = status;
        users.refresh();
      }
      EasyLoading.showSuccess('更新用户状态成功');
      return true;
    } catch (e) {
      EasyLoading.showError('更新用户状态失败: $e');
      return false;
    }
  }
  
  // 重置密码
  Future<bool> resetPassword(int userId) async {
    try {
      EasyLoading.show(status: '正在重置密码...');
      // TODO: 实现 API 调用重置密码
      await Future.delayed(const Duration(seconds: 1));
      EasyLoading.showSuccess('重置密码成功');
      return true;
    } catch (e) {
      EasyLoading.showError('重置密码失败: $e');
      return false;
    }
  }
  
  // 模拟数据
  List<SystemUserModel> _getMockUsers() {
    return [
      SystemUserModel(
        id: 1,
        username: 'admin',
        truename: '系统管理员',
        nickname: '管理员',
        phone: '13800138000',
        email: 'admin@example.com',
        status: 0,
        createTime: DateTime(2023, 1, 1),
        loginTime: DateTime(2023, 2, 1, 10, 0),
      ),
      SystemUserModel(
        id: 2,
        username: 'editor',
        truename: '内容编辑',
        nickname: '编辑',
        phone: '13800138001',
        email: 'editor@example.com',
        status: 0,
        createTime: DateTime(2023, 1, 5),
        loginTime: DateTime(2023, 2, 2, 11, 0),
      ),
      SystemUserModel(
        id: 3,
        username: 'operator',
        truename: '运营人员',
        nickname: '运营',
        phone: '13800138002',
        email: 'operator@example.com',
        status: 1,
        createTime: DateTime(2023, 1, 10),
        loginTime: DateTime(2023, 1, 15, 9, 0),
      ),
    ];
  }
} 