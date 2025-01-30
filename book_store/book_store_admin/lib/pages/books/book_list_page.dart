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
        await _apiService.createBook(result);
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
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookListController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('图书管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.addBook,
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.books.length,
                itemBuilder: (context, index) {
                  final book = controller.books[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: ListTile(
                      leading: book.image.isNotEmpty
                          ? Image.network(
                              book.image,
                              width: 50.w,
                              height: 50.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.book,
                                  size: 50.w,
                                  color: Colors.grey,
                                );
                              },
                            )
                          : Icon(
                              Icons.book,
                              size: 50.w,
                              color: Colors.grey,
                            ),
                      title: Text(book.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('作者：${book.author}'),
                          Text('分类：${book.category ?? '未分类'}'),
                          Text(
                            '价格：¥${book.salePrice ?? book.originalPrice}',
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
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => controller.editBook(book),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => controller.deleteBook(book),
                          ),
                        ],
                      ),
                      onTap: () => controller.editBook(book),
                    ),
                  );
                },
              ),
      ),
    );
  }
} 