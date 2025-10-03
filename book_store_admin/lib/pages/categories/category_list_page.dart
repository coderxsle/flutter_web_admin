import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryListController extends GetxController {
  final categories = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      // TODO: 实现获取分类列表的逻辑
      await Future.delayed(const Duration(seconds: 1));
      categories.value = [
        {
          'id': 1,
          'name': '文学',
          'description': '文学类书籍',
        },
        {
          'id': 2,
          'name': '科技',
          'description': '科技类书籍',
        },
      ];
    } finally {
      isLoading.value = false;
    }
  }

  void addCategory() {
    // TODO: 实现添加分类的逻辑
  }

  void editCategory(Map<String, dynamic> category) {
    // TODO: 实现编辑分类的逻辑
  }

  void deleteCategory(int id) {
    // TODO: 实现删除分类的逻辑
  }
}

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryListController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('分类管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.addCategory,
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: ListTile(
                      title: Text(category['name']),
                      subtitle: Text(category['description']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => controller.editCategory(category),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => controller.deleteCategory(category['id']),
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