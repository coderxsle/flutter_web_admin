import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageListController extends GetxController {
  final packages = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPackages();
  }

  Future<void> fetchPackages() async {
    isLoading.value = true;
    try {
      // TODO: 实现获取套餐列表的逻辑
      await Future.delayed(const Duration(seconds: 1));
      packages.value = [
        {
          'id': 1,
          'name': '文学套装',
          'originalPrice': 199.9,
          'bundlePrice': 149.9,
          'description': '包含3本经典文学作品',
          'status': 1,
        },
        {
          'id': 2,
          'name': '科技套装',
          'originalPrice': 299.9,
          'bundlePrice': 249.9,
          'description': '包含4本科技类书籍',
          'status': 0,
        },
      ];
    } finally {
      isLoading.value = false;
    }
  }

  String getStatusText(int status) {
    switch (status) {
      case 0:
        return '下架';
      case 1:
        return '上架';
      case 2:
        return '预售';
      default:
        return '未知';
    }
  }

  void addPackage() {
    // TODO: 实现添加套餐的逻辑
  }

  void editPackage(Map<String, dynamic> package) {
    // TODO: 实现编辑套餐的逻辑
  }

  void deletePackage(int id) {
    // TODO: 实现删除套餐的逻辑
  }
}

class PackageListPage extends StatelessWidget {
  const PackageListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PackageListController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('套餐管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.addPackage,
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.packages.length,
                itemBuilder: (context, index) {
                  final package = controller.packages[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: ListTile(
                      title: Text(package['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(package['description']),
                          Text(
                            '原价：¥${package['originalPrice']} 套餐价：¥${package['bundlePrice']}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Chip(
                            label: Text(
                              controller.getStatusText(package['status']),
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => controller.editPackage(package),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => controller.deletePackage(package['id']),
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