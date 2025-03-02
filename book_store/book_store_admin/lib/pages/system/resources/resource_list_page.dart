import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:book_store_admin/services/api_service.dart';
import 'resource_controller.dart';
import 'resource_model.dart';

class ResourceListPage extends StatelessWidget {
  const ResourceListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResourceController());

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
                  '资源管理',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showAddResourceDialog(context, controller),
                  icon: const Icon(Icons.add),
                  label: const Text('添加资源'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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
                        hintText: '搜索资源...',
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
                          : _buildResourceTree(controller, context)),
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

  Widget _buildResourceTree(ResourceController controller, BuildContext context) {
    if (controller.resources.isEmpty) {
      return const Center(
        child: Text('暂无资源数据'),
      );
    }

    return SingleChildScrollView(
      child: _buildTreeView(controller.resources, controller, context),
    );
  }

  Widget _buildTreeView(List<ResourceModel> resources, ResourceController controller, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        final resource = resources[index];
        return _buildResourceItem(resource, controller, context);
      },
    );
  }

  Widget _buildResourceItem(ResourceModel resource, ResourceController controller, BuildContext context) {
    final hasChildren = resource.children != null && resource.children!.isNotEmpty;
    
    // 根据资源类型设置不同颜色
    Color typeColor;
    switch (resource.type) {
      case 0: // 目录
        typeColor = Colors.blue;
        break;
      case 1: // 菜单
        typeColor = Colors.green;
        break;
      case 2: // 按钮
        typeColor = Colors.orange;
        break;
      default:
        typeColor = Colors.grey;
    }
    
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: hasChildren ? 0 : 4.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: ExpansionTile(
            leading: Icon(Icons.circle, color: typeColor, size: 12.r),
            title: Text(resource.name),
            subtitle: Text(
              '${resource.typeName} | 权限标识: ${resource.permission}',
              style: TextStyle(fontSize: 12.sp),
            ),
            childrenPadding: EdgeInsets.only(left: 20.w),
            initiallyExpanded: resource.type == 0, // 默认展开目录
            children: hasChildren
                ? [_buildTreeView(resource.children!, controller, context)]
                : [],
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: () => _showAddChildResourceDialog(context, controller, resource),
                  tooltip: '添加子资源',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _showEditResourceDialog(context, controller, resource),
                  tooltip: '编辑',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteResourceDialog(context, controller, resource),
                  tooltip: '删除',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAddResourceDialog(BuildContext context, ResourceController controller) {
    final nameController = TextEditingController();
    final uriController = TextEditingController();
    final permissionController = TextEditingController();
    final iconController = TextEditingController();
    final snController = TextEditingController(text: '0');
    int selectedType = 0;
    int selectedParentId = 0;
    String selectedParentName = '无';
    
    final allResources = [
      {'id': 0, 'name': '无', 'type': -1}, // 表示顶级资源
      ...controller.getAllResources()
          .where((r) => r.type < 2) // 只有目录和菜单可以作为父资源
          .map((r) => {'id': r.id, 'name': r.name, 'type': r.type})
          .toList()
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('添加资源'),
              content: SizedBox(
                width: 600.w,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          labelText: '资源类型',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedType,
                        items: const [
                          DropdownMenuItem(value: 0, child: Text('目录')),
                          DropdownMenuItem(value: 1, child: Text('菜单')),
                          DropdownMenuItem(value: 2, child: Text('按钮')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          labelText: '父资源',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedParentId,
                        items: allResources.map((resource) {
                          return DropdownMenuItem<int>(
                            value: resource['id'] as int,
                            child: Text(resource['name'] as String),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedParentId = value!;
                            selectedParentName = allResources
                                .firstWhere((r) => r['id'] == value)['name'] as String;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: '资源名称',
                          hintText: '请输入资源名称',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: uriController,
                        decoration: const InputDecoration(
                          labelText: '路径',
                          hintText: '请输入路径，按钮类型可为空',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: permissionController,
                        decoration: const InputDecoration(
                          labelText: '权限标识',
                          hintText: '请输入权限标识',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: iconController,
                        decoration: const InputDecoration(
                          labelText: '图标',
                          hintText: '请输入图标名称，按钮类型可为空',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: snController,
                        decoration: const InputDecoration(
                          labelText: '排序号',
                          hintText: '请输入排序号',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
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
                    if (nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('请输入资源名称')),
                      );
                      return;
                    }
                    
                    if (permissionController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('请输入权限标识')),
                      );
                      return;
                    }
                    
                    final newResource = ResourceModel(
                      id: DateTime.now().millisecondsSinceEpoch, // 临时ID
                      name: nameController.text.trim(),
                      uri: uriController.text.trim(),
                      permission: permissionController.text.trim(),
                      type: selectedType,
                      icon: iconController.text.trim(),
                      sn: int.tryParse(snController.text.trim()) ?? 0,
                      parentId: selectedParentId,
                    );
                    
                    controller.addResource(newResource).then((success) {
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
      },
    );
  }

  void _showAddChildResourceDialog(BuildContext context, ResourceController controller, ResourceModel parent) {
    final nameController = TextEditingController();
    final uriController = TextEditingController();
    final permissionController = TextEditingController();
    final iconController = TextEditingController();
    final snController = TextEditingController(text: '0');
    
    // 根据父资源类型设置子资源类型
    int selectedType = parent.type < 2 ? parent.type + 1 : 2;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('添加 ${parent.name} 的子资源'),
              content: SizedBox(
                width: 600.w,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          labelText: '资源类型',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedType,
                        items: [
                          if (parent.type == 0) const DropdownMenuItem(value: 1, child: Text('菜单')),
                          const DropdownMenuItem(value: 2, child: Text('按钮')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: '资源名称',
                          hintText: '请输入资源名称',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: uriController,
                        decoration: const InputDecoration(
                          labelText: '路径',
                          hintText: '请输入路径，按钮类型可为空',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: permissionController,
                        decoration: InputDecoration(
                          labelText: '权限标识',
                          hintText: '请输入权限标识',
                          prefixText: '${parent.permission}:',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: iconController,
                        decoration: const InputDecoration(
                          labelText: '图标',
                          hintText: '请输入图标名称，按钮类型可为空',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: snController,
                        decoration: const InputDecoration(
                          labelText: '排序号',
                          hintText: '请输入排序号',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
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
                    if (nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('请输入资源名称')),
                      );
                      return;
                    }
                    
                    if (permissionController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('请输入权限标识')),
                      );
                      return;
                    }
                    
                    final newResource = ResourceModel(
                      id: DateTime.now().millisecondsSinceEpoch, // 临时ID
                      name: nameController.text.trim(),
                      uri: uriController.text.trim(),
                      permission: '${parent.permission}:${permissionController.text.trim()}',
                      type: selectedType,
                      icon: iconController.text.trim(),
                      sn: int.tryParse(snController.text.trim()) ?? 0,
                      parentId: parent.id,
                    );
                    
                    controller.addResource(newResource).then((success) {
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
      },
    );
  }

  void _showEditResourceDialog(BuildContext context, ResourceController controller, ResourceModel resource) {
    final nameController = TextEditingController(text: resource.name);
    final uriController = TextEditingController(text: resource.uri);
    final permissionController = TextEditingController(text: resource.permission);
    final iconController = TextEditingController(text: resource.icon);
    final snController = TextEditingController(text: resource.sn.toString());
    int selectedType = resource.type;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('编辑资源 - ${resource.name}'),
              content: SizedBox(
                width: 600.w,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          labelText: '资源类型',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedType,
                        items: const [
                          DropdownMenuItem(value: 0, child: Text('目录')),
                          DropdownMenuItem(value: 1, child: Text('菜单')),
                          DropdownMenuItem(value: 2, child: Text('按钮')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: '资源名称',
                          hintText: '请输入资源名称',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: uriController,
                        decoration: const InputDecoration(
                          labelText: '路径',
                          hintText: '请输入路径，按钮类型可为空',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: permissionController,
                        decoration: const InputDecoration(
                          labelText: '权限标识',
                          hintText: '请输入权限标识',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: iconController,
                        decoration: const InputDecoration(
                          labelText: '图标',
                          hintText: '请输入图标名称，按钮类型可为空',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextField(
                        controller: snController,
                        decoration: const InputDecoration(
                          labelText: '排序号',
                          hintText: '请输入排序号',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
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
                    if (nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('请输入资源名称')),
                      );
                      return;
                    }
                    
                    if (permissionController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('请输入权限标识')),
                      );
                      return;
                    }
                    
                    final updatedResource = ResourceModel(
                      id: resource.id,
                      name: nameController.text.trim(),
                      uri: uriController.text.trim(),
                      permission: permissionController.text.trim(),
                      type: selectedType,
                      icon: iconController.text.trim(),
                      sn: int.tryParse(snController.text.trim()) ?? 0,
                      parentId: resource.parentId,
                    );
                    
                    controller.updateResource(updatedResource).then((success) {
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
      },
    );
  }

  void _showDeleteResourceDialog(BuildContext context, ResourceController controller, ResourceModel resource) {
    // 检查是否有子资源
    final hasChildren = resource.children != null && resource.children!.isNotEmpty;
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除资源'),
          content: Text(hasChildren
              ? '资源 "${resource.name}" 包含子资源，删除将连同子资源一起删除，确定要删除吗？'
              : '确定要删除资源 "${resource.name}" 吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                controller.deleteResource(resource.id).then((success) {
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