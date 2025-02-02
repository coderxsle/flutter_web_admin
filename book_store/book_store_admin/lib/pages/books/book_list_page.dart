import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:book_store_client/book_store_client.dart';
import '../../services/api_service.dart';
import 'book_edit_form.dart';
import '../../widgets/resizable_table.dart';

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
      books.value = [];
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

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final Map<int, double> columnWidths = {
    0: 80,  // 序号
    1: 100, // 封面
    2: 200, // 书名
    3: 150, // 作者
    4: 150, // ISBN
    5: 200, // 出版社
    6: 120, // 原价
    7: 120, // 售价
    8: 100, // 库存
    9: 150, // 操作
  };

  // 添加列标题
  final List<String> columnTitles = [
    '序号',
    '封面',
    '书名',
    '作者',
    'ISBN',
    '出版社',
    '原价',
    '售价',
    '库存',
    '操作'
  ];

  @override
  Widget build(BuildContext context) {
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
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: DataTable(
                          columnSpacing: 40.0,  // 增加列间距
                          horizontalMargin: 24.0,
                          columns: [
                            for (var i = 0; i < columnTitles.length; i++)
                              DataColumn(
                                label: ResizableTableColumn(
                                  initialWidth: columnWidths[i]!,
                                  onWidthChanged: (width) {
                                    setState(() {
                                      columnWidths[i] = width;
                                    });
                                  },
                                  label: Text(columnTitles[i]),
                                ),
                              ),
                          ],
                          rows: controller.books.asMap().entries.map((entry) {
                            final index = entry.key;
                            final book = entry.value;
                            
                            // 定义单元格内容
                            final cells = [
                              Text('${index + 1}'),
                              book.image.isNotEmpty == true
                                  ? Image.network(
                                      book.image,
                                      width: 40,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.image_not_supported),
                                    )
                                  : const Icon(Icons.image_not_supported),
                              Text(book.name),
                              Text(book.author),
                              Text(book.isbn ?? '-'),
                              Text(book.publisher),
                              Text('¥${book.originalPrice.toStringAsFixed(2)}'),
                              Text(book.salePrice != null ? '¥${book.salePrice!.toStringAsFixed(2)}' : '-'),
                              Text('${book.inventory}'),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => controller.editBook(book),
                                    tooltip: '编辑',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => controller.deleteBook(book),
                                    tooltip: '删除',
                                  ),
                                ],
                              ),
                            ];

                            return DataRow(
                              cells: [
                                for (var i = 0; i < cells.length; i++)
                                  DataCell(
                                    SizedBox(
                                      width: columnWidths[i],
                                      child: cells[i],
                                    ),
                                  ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
} 