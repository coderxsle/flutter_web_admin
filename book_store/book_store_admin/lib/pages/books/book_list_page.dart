import 'package:book_store_admin/widgets/proxy_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:book_store_client/book_store_client.dart';
import '../../services/api_service.dart';
import 'book_edit_form.dart';
import '../../widgets/resizable_table.dart';
import '../../models/table_column_config.dart';
import '../../utils/message_util.dart';

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
      final response = await _apiService.getBooks(1);
      // print('获取到的响应:');
      // print('- 数据: ${response.data}');
      // print('- 总数: ${response.total}');
      // print('- 每页数量: ${response.pageSize}');
      // print('- 页码: ${response.pageNum}');
      
      if (response.data == null) {
        books.value = [];
        return;
      }
      
      if (response.data is! List) {
        throw Exception('数据格式错误：期望列表类型，实际是 ${response.data.runtimeType}');
      }
      
      final bookList = (response.data as List).map((item) {
        if (item is! Map<String, dynamic>) {
          throw Exception('数据项格式错误：期望Map类型，实际是 ${item.runtimeType}');
        }
        return Book.fromJson(item);
      }).toList();
      
      books.value = bookList;
      
    } catch (e, stackTrace) {
      books.value = [];
      print('获取图书列表失败:');
      print('错误类型: ${e.runtimeType}');
      print('错误信息: $e');
      print('堆栈跟踪: $stackTrace');
      
      showError(Get.context!, '获取图书列表失败：${e.toString()}');
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
          showSuccess(Get.context!, '添加成功：${result.name}');
          fetchBooks();
        } else {
          EasyLoading.dismiss();
          showError(Get.context!, response.message ?? '未知错误');
        }
      } catch (e) {
        EasyLoading.dismiss();
        showError(Get.context!, '错误：${e.toString()}');
      }
    }
  }

  Future<void> editBook(Book book) async {
    final result = await Get.dialog<Book>(
      Dialog(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '修改图书',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              SingleChildScrollView(
                child: BookEditForm(book: book),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
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
        showError(Get.context!, '错误：${e.toString()}');
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
        showError(Get.context!, '错误：${e.toString()}');
      }
    }
  }
}

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  // 定义列配置
  final List<TableColumnConfig> columns = [
    TableColumnConfig(
      id: 'index',
      title: '序号',
      width: 20,
      builder: (book, index) => Text('${index + 1}'),
    ),
    TableColumnConfig(
      id: 'image',
      title: '封面',
      width: 90,
      builder: (book, _) {
        if (book.image.isEmpty) {
          return const Icon(Icons.image_not_supported);
        }
        return Container(
          margin: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: ProxyImage(
              url: book.image,
              fit: BoxFit.contain,
            ),
          ),
        );
      }
    ),
    TableColumnConfig(
      id: 'name',
      title: '书名',
      width: 200,
      builder: (book, _) => Text(book.name),
    ),
    TableColumnConfig(
      id: 'author',
      title: '作者',
      width: 150,
      builder: (book, _) => Text(book.author),
    ),
    TableColumnConfig(
      id: 'publisher',
      title: '出版社',
      width: 200,
      builder: (book, _) => Text(book.publisher),
    ),
    TableColumnConfig(
      id: 'originalPrice',
      title: '原价',
      width: 120,
      builder: (book, _) => Text('¥${book.originalPrice.toStringAsFixed(2)}'),
    ),
    TableColumnConfig(
      id: 'salePrice',
      title: '售价',
      width: 120,
      builder: (book, _) => Text(
        // book.salePrice != null ? '¥${book.salePrice!.toStringAsFixed(2)}' : '-'
        '0' // 临时
      ),
    ),
    TableColumnConfig(
      id: 'inventory',
      title: '库存',
      width: 100,
      // builder: (book, _) => Text('${book.inventory}'),
      builder: (book, _) => Text('0'), // 临时
    ),
    TableColumnConfig(
      id: 'actions',
      title: '操作',
      width: 150,
      builder: (book, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () => Get.find<BookListController>().editBook(book),
            tooltip: '编辑',
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => Get.find<BookListController>().deleteBook(book),
            tooltip: '删除',
          ),
        ],
      ),
    ),
  ];
  
  // 添加滚动控制器
  final ScrollController _horizontalScrollController = ScrollController();
  
  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

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
                  backgroundColor: Colors.blue,                  foregroundColor: Colors.white,
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
                  : Scrollbar(
                      thumbVisibility: true,
                      controller: _horizontalScrollController,
                      child: SingleChildScrollView(
                        controller: _horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: columns.fold<double>(0.0, (sum, column) => sum + column.width + 20),
                          child: DataTable(
                            columnSpacing: 20,
                            headingRowHeight: 50,
                            horizontalMargin: 20,
                            dataRowMinHeight: 100,
                            dataRowMaxHeight: 100,
                            columns: [
                              for (var column in columns)
                                DataColumn(
                                  label: ResizableTableColumn(
                                    initialWidth: column.width,
                                    onWidthChanged: (width) {
                                      setState(() {
                                        column.width = width;
                                      });
                                    },
                                    label: Text(column.title),
                                  ),
                                ),
                            ],
                            rows: controller.books.asMap().entries.map((entry) {
                              final index = entry.key;
                              final book = entry.value;
                              return DataRow(
                                cells: [
                                  for (var column in columns)
                                    DataCell(
                                      SizedBox(
                                        width: column.width,
                                        child: column.builder(book, index),
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
        ),
      ],
    );
  }
} 