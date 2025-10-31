import 'package:flutter_web_admin/components/base_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_web_client/client.dart';
import 'package:flutter_web_admin/api/client.dart';
import 'package:flutter_web_admin/components/feedback/gi_acro_message.dart';

/// 表格列表控制器
class TableListController extends BaseController {
  /// 表格列表
  final tables = <AirTables>[].obs;

  /// 加载状态
  final loading = false.obs;

  /// 搜索关键词
  final keyword = ''.obs;

  /// 当前页码
  final currentPage = 1.obs;

  /// 每页数量
  final pageSize = 20.obs;

  /// 总数据量
  final total = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadTables();
  }

  /// 加载表格列表
  Future<void> loadTables() async {
    try {
      loading.value = true;
      final result = await client.tables.getTables(
        Pagination(
          page: currentPage.value,
          pageSize: pageSize.value,
          keyword: keyword.value.isEmpty ? null : keyword.value,
        ),
      );
      tables.value = (result.data as List).map((i) => AirTables.fromJson(i)).toList();
      total.value = result.data['total'] as int;
    } catch (e) {
      // GiArcoMessage.error('加载表格列表失败: $e');
    } finally {
      loading.value = false;
    }
  }

  /// 搜索表格
  void searchTables(String value) {
    keyword.value = value;
    currentPage.value = 1;
    loadTables();
  }

  /// 翻页
  void onPageChange(int page) {
    currentPage.value = page;
    loadTables();
  }

  /// 每页数量变化
  void onPageSizeChange(int size) {
    pageSize.value = size;
    currentPage.value = 1;
    loadTables();
  }

  /// 创建表格
  Future<void> createTable(String name) async {
    if (name.isEmpty) {
      GiArcoMessage.warning('请输入表格名称');
      return;
    }

    try {
      loading.value = true;
      final table = await client.tables.createTable(name);
      if (table.isSuccess) {
        GiArcoMessage.success('创建成功');
        loadTables();
      } else {
        GiArcoMessage.error('创建失败: ${table.message}');
      }
    } catch (e) {
      GiArcoMessage.error('创建失败: $e');
    }
  }

  /// 删除表格
  Future<void> deleteTable(int tableId) async {
    try {
      loading.value = true;
      final reslut = await client.tables.deleteTable(tableId);
      if (reslut.isSuccess) {
        GiArcoMessage.success('删除成功');
        loadTables();
      }
    } catch (e) {
      GiArcoMessage.error('删除失败: $e');
    } finally {
      loading.value = false;
    }
  }

  /// 刷新列表
  void refresh() {
    loadTables();
  }
}

