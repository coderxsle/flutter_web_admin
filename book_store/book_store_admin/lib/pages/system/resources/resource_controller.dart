import 'package:get/get.dart';
import 'package:book_store_admin/services/api_service.dart';
import 'resource_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ResourceController extends GetxController {
  final ApiService _apiService = ApiService();
  
  // 资源列表（树形结构）
  final resources = <ResourceModel>[].obs;
  
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
  Future<bool> addResource(ResourceModel resource) async {
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
  void _addChildResource(List<ResourceModel> list, ResourceModel resource) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == resource.parentId) {
        // 找到父资源
        list[i].children ??= [];
        list[i].children!.add(resource);
        resources.refresh(); // 刷新列表
        return;
      }
      
      if (list[i].children != null && list[i].children!.isNotEmpty) {
        _addChildResource(list[i].children!, resource);
      }
    }
  }
  
  // 更新资源
  Future<bool> updateResource(ResourceModel resource) async {
    try {
      EasyLoading.show(status: '正在更新资源...');
      // TODO: 实现 API 调用更新资源
      await Future.delayed(const Duration(seconds: 1));
      
      _updateResourceInTree(resources, resource);
      
      EasyLoading.showSuccess('更新资源成功');
      return true;
    } catch (e) {
      EasyLoading.showError('更新资源失败: $e');
      return false;
    }
  }
  
  // 递归更新资源
  bool _updateResourceInTree(List<ResourceModel> list, ResourceModel resource) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == resource.id) {
        // 保持原有的children
        resource.children = list[i].children;
        list[i] = resource;
        resources.refresh(); // 刷新列表
        return true;
      }
      
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
      
      _deleteResourceFromTree(resources, resourceId);
      
      EasyLoading.showSuccess('删除资源成功');
      return true;
    } catch (e) {
      EasyLoading.showError('删除资源失败: $e');
      return false;
    }
  }
  
  // 递归删除资源
  bool _deleteResourceFromTree(List<ResourceModel> list, int resourceId) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == resourceId) {
        list.removeAt(i);
        resources.refresh(); // 刷新列表
        return true;
      }
      
      if (list[i].children != null && list[i].children!.isNotEmpty) {
        if (_deleteResourceFromTree(list[i].children!, resourceId)) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  // 获取所有资源（扁平结构，用于选择父资源）
  List<ResourceModel> getAllResources() {
    final result = <ResourceModel>[];
    _flattenResources(resources, result);
    return result;
  }
  
  // 递归平铺资源树
  void _flattenResources(List<ResourceModel> tree, List<ResourceModel> result) {
    for (var resource in tree) {
      result.add(resource);
      if (resource.children != null && resource.children!.isNotEmpty) {
        _flattenResources(resource.children!, result);
      }
    }
  }
  
  // 模拟数据
  List<ResourceModel> _getMockResources() {
    return [
      ResourceModel(
        id: 1,
        name: '系统管理',
        uri: '/system',
        permission: 'system:view',
        type: 0,
        icon: 'settings',
        sn: 1,
        parentId: 0,
        children: [
          ResourceModel(
            id: 2,
            name: '用户管理',
            uri: '/system/users',
            permission: 'system:user:view',
            type: 1,
            icon: 'people',
            sn: 1,
            parentId: 1,
            children: [
              ResourceModel(
                id: 5,
                name: '添加用户',
                uri: '',
                permission: 'system:user:add',
                type: 2,
                icon: '',
                sn: 1,
                parentId: 2,
              ),
              ResourceModel(
                id: 6,
                name: '编辑用户',
                uri: '',
                permission: 'system:user:edit',
                type: 2,
                icon: '',
                sn: 2,
                parentId: 2,
              ),
              ResourceModel(
                id: 7,
                name: '删除用户',
                uri: '',
                permission: 'system:user:delete',
                type: 2,
                icon: '',
                sn: 3,
                parentId: 2,
              ),
            ],
          ),
          ResourceModel(
            id: 3,
            name: '角色管理',
            uri: '/system/roles',
            permission: 'system:role:view',
            type: 1,
            icon: 'security',
            sn: 2,
            parentId: 1,
          ),
          ResourceModel(
            id: 4,
            name: '资源管理',
            uri: '/system/resources',
            permission: 'system:resource:view',
            type: 1,
            icon: 'list',
            sn: 3,
            parentId: 1,
          ),
        ],
      ),
      ResourceModel(
        id: 8,
        name: '图书管理',
        uri: '/books',
        permission: 'book:view',
        type: 0,
        icon: 'book',
        sn: 2,
        parentId: 0,
      ),
    ];
  }
} 