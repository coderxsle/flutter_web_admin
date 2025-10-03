import 'package:get/get.dart';
import 'package:book_store_admin/services/api_service.dart';
import 'system_resource_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SystemResourceController extends GetxController {
  final ApiService _apiService = ApiService();
  
  // 资源列表（树形结构）
  final resources = <SystemResourceModel>[].obs;
  
  // 加载状态
  final isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchResources();
  }
  
  // 加载资源数据
  Future<void> fetchResources() async {
    isLoading.value = true;
    try {
      // TODO: 实现 API 调用获取资源树
      // 暂时使用模拟数据
      await Future.delayed(const Duration(seconds: 1));
      resources.value = _getMockResources();
    } catch (e) {
      EasyLoading.showError('获取资源数据失败: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // 添加资源
  Future<bool> addResource(SystemResourceModel resource) async {
    try {
      EasyLoading.show(status: '正在添加资源...');
      // TODO: 实现 API 调用添加资源
      await Future.delayed(const Duration(seconds: 1));
      
      if (resource.parentId == 0) {
        // 顶级资源
        resources.add(resource);
      } else {
        // 子资源，需要找到父资源并添加
        _addChildResource(resources, resource);
      }
      
      EasyLoading.showSuccess('添加资源成功');
      return true;
    } catch (e) {
      EasyLoading.showError('添加资源失败: $e');
      return false;
    }
  }
  
  // 递归添加子资源
  void _addChildResource(List<SystemResourceModel> list, SystemResourceModel resource) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == resource.parentId) {
        // 找到父资源
        list[i].children ??= [];
        list[i].children!.add(resource);
        return;
      }
      
      // 递归查找
      if (list[i].children != null && list[i].children!.isNotEmpty) {
        _addChildResource(list[i].children!, resource);
      }
    }
  }
  
  // 更新资源
  Future<bool> updateResource(SystemResourceModel resource) async {
    try {
      EasyLoading.show(status: '正在更新资源...');
      // TODO: 实现 API 调用更新资源
      await Future.delayed(const Duration(seconds: 1));
      
      // 递归更新资源树
      final updated = _updateResourceInTree(resources, resource);
      
      if (updated) {
        EasyLoading.showSuccess('更新资源成功');
        return true;
      } else {
        EasyLoading.showError('资源不存在');
        return false;
      }
    } catch (e) {
      EasyLoading.showError('更新资源失败: $e');
      return false;
    }
  }
  
  // 递归更新资源
  bool _updateResourceInTree(List<SystemResourceModel> list, SystemResourceModel resource) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == resource.id) {
        // 找到资源
        list[i] = resource;
        return true;
      }
      
      // 递归查找
      if (list[i].children != null && list[i].children!.isNotEmpty) {
        if (_updateResourceInTree(list[i].children!, resource)) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  // 删除资源
  Future<bool> deleteResource(int resourceId) async {
    try {
      EasyLoading.show(status: '正在删除资源...');
      // TODO: 实现 API 调用删除资源
      await Future.delayed(const Duration(seconds: 1));
      
      // 递归删除资源树
      final deleted = _deleteResourceFromTree(resources, resourceId);
      
      if (deleted) {
        EasyLoading.showSuccess('删除资源成功');
        return true;
      } else {
        EasyLoading.showError('资源不存在');
        return false;
      }
    } catch (e) {
      EasyLoading.showError('删除资源失败: $e');
      return false;
    }
  }
  
  // 递归删除资源
  bool _deleteResourceFromTree(List<SystemResourceModel> list, int resourceId) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == resourceId) {
        // 找到资源
        list.removeAt(i);
        return true;
      }
      
      // 递归查找
      if (list[i].children != null && list[i].children!.isNotEmpty) {
        if (_deleteResourceFromTree(list[i].children!, resourceId)) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  // 获取所有资源（扁平结构，用于选择父资源）
  List<SystemResourceModel> getAllResources() {
    final result = <SystemResourceModel>[];
    _flattenResources(resources, result);
    return result;
  }
  
  // 递归平铺资源树
  void _flattenResources(List<SystemResourceModel> tree, List<SystemResourceModel> result) {
    for (var resource in tree) {
      result.add(resource);
      if (resource.children != null && resource.children!.isNotEmpty) {
        _flattenResources(resource.children!, result);
      }
    }
  }
  
  // 模拟数据
  List<SystemResourceModel> _getMockResources() {
    return [
      SystemResourceModel(
        id: 1,
        name: '系统管理',
        uri: '/system',
        permission: 'system',
        type: 0, // 目录
        icon: 'settings',
        sn: 1,
        parentId: 0,
        children: [
          SystemResourceModel(
            id: 2,
            name: '用户管理',
            uri: '/system/users',
            permission: 'system:users',
            type: 1, // 菜单
            icon: 'person',
            sn: 1,
            parentId: 1,
            children: [
              SystemResourceModel(
                id: 5,
                name: '添加用户',
                uri: '',
                permission: 'system:users:add',
                type: 2, // 按钮
                icon: '',
                sn: 1,
                parentId: 2,
              ),
              SystemResourceModel(
                id: 6,
                name: '编辑用户',
                uri: '',
                permission: 'system:users:edit',
                type: 2, // 按钮
                icon: '',
                sn: 2,
                parentId: 2,
              ),
              SystemResourceModel(
                id: 7,
                name: '删除用户',
                uri: '',
                permission: 'system:users:delete',
                type: 2, // 按钮
                icon: '',
                sn: 3,
                parentId: 2,
              ),
            ],
          ),
          SystemResourceModel(
            id: 3,
            name: '角色管理',
            uri: '/system/roles',
            permission: 'system:roles',
            type: 1, // 菜单
            icon: 'group',
            sn: 2,
            parentId: 1,
          ),
          SystemResourceModel(
            id: 4,
            name: '资源管理',
            uri: '/system/resources',
            permission: 'system:resources',
            type: 1, // 菜单
            icon: 'list',
            sn: 3,
            parentId: 1,
          ),
        ],
      ),
      SystemResourceModel(
        id: 8,
        name: '图书管理',
        uri: '/books',
        permission: 'books',
        type: 0, // 目录
        icon: 'book',
        sn: 2,
        parentId: 0,
      ),
    ];
  }
} 