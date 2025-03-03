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
                          '名称、URL、权限',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    ElevatedButton.icon(
                      onPressed: () => controller.fetchResources(),
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
                onPressed: () => _showAddResourceDialog(context, controller),
                icon: const Icon(Icons.add),
                label: const Text('添加'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              OutlinedButton.icon(
                onPressed: () => controller.fetchResources(),
                icon: const Icon(Icons.refresh),
                label: const Text('刷新'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
              SizedBox(width: 8.w),
              OutlinedButton.icon(
                onPressed: () {
                  // 折叠全部逻辑
                  _collapseAllResources(controller.resources);
                },
                icon: const Icon(Icons.unfold_less),
                label: const Text('折叠全部'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
              SizedBox(width: 8.w),
              OutlinedButton.icon(
                onPressed: () {
                  // 展开全部逻辑
                  _expandAllResources(controller.resources);
                },
                icon: const Icon(Icons.unfold_more),
                label: const Text('展开全部'),
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
          
          // 资源列表区域
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
                : _buildResourceTable(controller, context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceTable(ResourceController controller, BuildContext context) {
    if (controller.resources.isEmpty) {
      return const Center(
        child: Text('暂无资源数据'),
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
              Expanded(flex: 3, child: Text('名称', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 2, child: Text('权限', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              Expanded(flex: 2, child: Text('URI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              SizedBox(width: 60.w, child: Text('序号', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              SizedBox(width: 60.w, child: Text('图标', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              SizedBox(width: 80.w, child: Text('类型', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
              SizedBox(width: 120.w, child: Text('操作', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp))),
            ],
          ),
        ),
        
        // 表格内容
        Expanded(
          child: ListView(
            children: [
              ...controller.resources.map((resource) => _buildResourceTableItem(
                resource, 
                controller, 
                context,
                0, // 初始缩进级别
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResourceTableItem(
    ResourceModel resource, 
    ResourceController controller, 
    BuildContext context,
    int indentLevel,
  ) {
    final hasChildren = resource.children != null && resource.children!.isNotEmpty;
    
    // 根据资源类型设置图标和颜色
    IconData typeIcon;
    Color typeColor;
    String typeText;
    
    switch (resource.type) {
      case 0: // 目录
        typeIcon = Icons.folder;
        typeColor = Colors.blue;
        typeText = '目录';
        break;
      case 1: // 菜单
        typeIcon = Icons.menu;
        typeColor = Colors.green;
        typeText = '菜单';
        break;
      case 2: // 按钮
        typeIcon = Icons.touch_app;
        typeColor = Colors.orange;
        typeText = '按钮';
        break;
      default:
        typeIcon = Icons.help_outline;
        typeColor = Colors.grey;
        typeText = '未知';
    }

    final rowWidget = Obx(() => Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          // 选择框
          SizedBox(
            width: 40.w,
            child: Checkbox(
              value: false,
              onChanged: (_) {},
            ),
          ),
          
          // 名称列
          Expanded(
            flex: 3,
            child: Row(
              children: [
                SizedBox(width: indentLevel * 20.0), // 缩进
                if (hasChildren)
                  IconButton(
                    icon: Icon(
                      resource.isExpanded.value ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                      size: 16,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      resource.isExpanded.toggle();
                    },
                  )
                else
                  SizedBox(width: 16),
                Icon(typeIcon, color: typeColor, size: 16),
                SizedBox(width: 8),
                Text(resource.name),
              ],
            ),
          ),
          
          // 权限列
          Expanded(
            flex: 2,
            child: Text(resource.permission),
          ),
          
          // URI列
          Expanded(
            flex: 2,
            child: Text(resource.uri),
          ),
          
          // 序号列
          SizedBox(
            width: 60.w,
            child: Text('${resource.sn}'),
          ),
          
          // 图标列
          SizedBox(
            width: 60.w,
            child: resource.icon.isNotEmpty
                ? Icon(Icons.image, size: 16, color: Colors.grey)
                : const SizedBox(),
          ),
          
          // 类型列
          SizedBox(
            width: 80.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: typeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: Text(
                typeText,
                style: TextStyle(color: typeColor, fontSize: 12.sp),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          // 操作列
          SizedBox(
            width: 120.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                  onPressed: () => _showEditResourceDialog(context, controller, resource),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: '编辑',
                ),
                SizedBox(width: 12.w),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: () => _showDeleteResourceDialog(context, controller, resource),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: '删除',
                ),
              ],
            ),
          ),
        ],
      ),
    ));

    // 构建这个资源项及其所有子项
    final List<Widget> rowWithChildren = [rowWidget];
    
    if (hasChildren) {
      rowWithChildren.add(
        Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: resource.isExpanded.value ? null : 0,
          child: resource.isExpanded.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: resource.children!.map((child) => 
                    _buildResourceTableItem(child, controller, context, indentLevel + 1)
                  ).toList(),
                )
              : const SizedBox.shrink(),
        ))
      );
    }
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: rowWithChildren,
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

  // 递归折叠所有资源
  void _collapseAllResources(List<ResourceModel> resources) {
    for (var resource in resources) {
      resource.isExpanded.value = false;
      if (resource.children != null && resource.children!.isNotEmpty) {
        _collapseAllResources(resource.children!);
      }
    }
  }

  // 递归展开所有资源
  void _expandAllResources(List<ResourceModel> resources) {
    for (var resource in resources) {
      resource.isExpanded.value = true;
      if (resource.children != null && resource.children!.isNotEmpty) {
        _expandAllResources(resource.children!);
      }
    }
  }
} 