import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:book_store_client/book_store_client.dart';
import '../../services/api_service.dart';
import 'book_edit_form.dart';

class BookListController extends GetxController {
  final books = <Book>[].obs;
  final isLoading = false.obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    isLoading.value = true;
    try {
      books.value = await _apiService.getBooks();
    } catch (e) {
      Get.snackbar(
        '错误',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[100],
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addBook() async {
    final result = await Get.dialog<Book>(
      Dialog(
        child: Container(
          width: 500.w,
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '添加图书',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                const BookEditForm(),
              ],
            ),
          ),
        ),
      ),
    );

    if (result != null) {
      try {
        EasyLoading.show(status: '添加中...');
        final response = await _apiService.createBook(result);
        if (response.isSuccess) {
          EasyLoading.dismiss();
          Get.back();
          Get.snackbar(
            '添加成功', result.name,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green[100],
          );
          fetchBooks();
        } else {
          EasyLoading.dismiss();
          Get.snackbar(
            '错误',
            response.message ?? '未知错误',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[100],
          );
        }
      } catch (e) {
        EasyLoading.dismiss();
        Get.snackbar(
          '错误',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[100],
        );
      }
    }
  }

  Future<void> editBook(Book book) async {
    final result = await Get.dialog<Book>(
      Dialog(
        child: Container(
          width: 500.w,
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '编辑图书',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                BookEditForm(book: book),
              ],
            ),
          ),
        ),
      ),
    );

    if (result != null) {
      try {
        EasyLoading.show(status: '更新中...');
        await _apiService.updateBook(result);
        EasyLoading.dismiss();
        Get.back();
        fetchBooks();
      } catch (e) {
        EasyLoading.dismiss();
        Get.snackbar(
          '错误',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[100],
        );
      }
    }
  } 

  Future<void> deleteBook(Book book) async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这本图书吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        EasyLoading.show(status: '删除中...');
        await _apiService.deleteBook(book);
        EasyLoading.dismiss();
        fetchBooks();
      } catch (e) {
        EasyLoading.dismiss();
        Get.snackbar(
          '错误',
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[100],
        );
      }
    }
  }
}

class BookListPage extends StatelessWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 添加控制器
    final controller = Get.put(BookListController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 顶部操作栏
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              // 搜索框
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '请输入书名或作者进行搜索',
                      prefixIcon: Icon(Icons.search, color: Colors.black45),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: (value) {
                      // TODO: 实现搜索功能
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // 更新添加图书按钮
              ElevatedButton.icon(
                onPressed: controller.addBook,  // 连接到控制器方法
                icon: const Icon(Icons.add),
                label: const Text('添加图书'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
        // 图书列表区域
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                ),
              ],
            ),
            // 添加加载状态显示
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : const Center(child: Text('图书列表区域 - 待实现')),
            ),
          ),
        ),
      ],
    );
  }
} 