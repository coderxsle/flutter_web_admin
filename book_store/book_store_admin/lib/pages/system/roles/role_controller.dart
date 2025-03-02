import 'package:get/get.dart';
import 'package:book_store_admin/services/api_service.dart';
import 'role_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RoleController extends GetxController {
  final ApiService _apiService = ApiService();
  
  // 角色列表
  final roles = <RoleModel>[].obs;
  
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
    fetchRoles();
  }
  
  // 加载角色数据
  Future<void> fetchRoles() async {
    isLoading.value = true;
    try {
      // TODO: 实现 API 调用获取角色列表
      // 暂时使用模拟数据
      await Future.delayed(const Duration(seconds: 1));
      roles.value = _getMockRoles();
      totalPages.value = 1; // 模拟总页数
    } catch (e) {
      EasyLoading.showError('获取角色数据失败: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // 添加角色
  Future<bool> addRole(RoleModel role) async {
    try {
      EasyLoading.show(status: '正在添加角色...');
      // TODO: 实现 API 调用添加角色
      await Future.delayed(const Duration(seconds: 1));
      roles.add(role);
      EasyLoading.showSuccess('添加角色成功');
      return true;
    } catch (e) {
      EasyLoading.showError('添加角色失败: $e');
      return false;
    }
  }
  
  // 更新角色
  Future<bool> updateRole(RoleModel role) async {
    try {
      EasyLoading.show(status: '正在更新角色...');
      // TODO: 实现 API 调用更新角色
      await Future.delayed(const Duration(seconds: 1));
      final index = roles.indexWhere((element) => element.id == role.id);
      if (index != -1) {
        roles[index] = role;
        roles.refresh();
      }
      EasyLoading.showSuccess('更新角色成功');
      return true;
    } catch (e) {
      EasyLoading.showError('更新角色失败: $e');
      return false;
    }
  }
  
  // 删除角色
  Future<bool> deleteRole(int roleId) async {
    try {
      EasyLoading.show(status: '正在删除角色...');
      // TODO: 实现 API 调用删除角色
      await Future.delayed(const Duration(seconds: 1));
      roles.removeWhere((element) => element.id == roleId);
      EasyLoading.showSuccess('删除角色成功');
      return true;
    } catch (e) {
      EasyLoading.showError('删除角色失败: $e');
      return false;
    }
  }
  
  // 获取角色用户
  Future<List<dynamic>> getRoleUsers(int roleId) async {
    try {
      // TODO: 实现 API 调用获取角色用户
      await Future.delayed(const Duration(seconds: 1));
      return []; // 暂时返回空列表
    } catch (e) {
      EasyLoading.showError('获取角色用户失败: $e');
      return [];
    }
  }
  
  // 获取角色资源
  Future<List<dynamic>> getRoleResources(int roleId) async {
    try {
      // TODO: 实现 API 调用获取角色资源
      await Future.delayed(const Duration(seconds: 1));
      return []; // 暂时返回空列表
    } catch (e) {
      EasyLoading.showError('获取角色资源失败: $e');
      return [];
    }
  }
  
  // 分配角色资源
  Future<bool> assignRoleResources(int roleId, List<int> resourceIds) async {
    try {
      EasyLoading.show(status: '正在分配角色资源...');
      // TODO: 实现 API 调用分配角色资源
      await Future.delayed(const Duration(seconds: 1));
      EasyLoading.showSuccess('分配角色资源成功');
      return true;
    } catch (e) {
      EasyLoading.showError('分配角色资源失败: $e');
      return false;
    }
  }
  
  // 模拟数据
  List<RoleModel> _getMockRoles() {
    return [
      RoleModel(
        id: 1,
        name: '超级管理员',
        userCount: 1,
        resourceCount: 20,
      ),
      RoleModel(
        id: 2,
        name: '内容管理员',
        userCount: 2,
        resourceCount: 10,
      ),
      RoleModel(
        id: 3,
        name: '运营人员',
        userCount: 3,
        resourceCount: 8,
      ),
    ];
  }
} 