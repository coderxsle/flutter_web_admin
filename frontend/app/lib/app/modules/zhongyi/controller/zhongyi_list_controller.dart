import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http_manager/http_manager.dart';

import '../../../utils/common_widget/base_controller.dart';
import '../../../utils/global.dart';
import '../../../utils/result_code.dart';

/// 中医列表页的公共骨架：分页、关键字防抖、下拉/上拉收尾都在这里。
///
/// 子类只给接口、行解析与空态文案；页面用 Obx + LayoutSubviews 直接吃 [items]。
abstract class ZhongyiListController<T> extends BaseController {
  static const int pageSize = 20;

  /// 列表数据
  final items = <T>[].obs;

  /// 搜索框；[keywordText] 给页面判断当前是否带关键字
  final keyword = TextEditingController();
  final keywordText = ''.obs;

  String _query = '';
  int _seq = 0;
  Timer? _debounce;

  bool get hasQuery => _query.isNotEmpty;

  /// 空态文案，子类按 [hasQuery] 区分「没有数据」与「没有匹配」
  String get emptyTip;

  /// 拉第 [page] 页；[query] 已 trim，空串表示不带关键字
  Future<ResponseAnalyzed> fetchPage(int page, String query);

  T fromJson(Map<String, dynamic> json);

  @override
  void onInit() {
    super.onInit();
    requestDataList(showLoading: true);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    keyword.dispose();
    super.onClose();
  }

  @override
  Future<void> onRefresh() async {
    await requestDataList();
    super.onRefresh(); // 收尾：finishRefresh + resetFooter
  }

  /// 上拉下一页：页码与「还有没有下一页」都交给 [pageModel]
  @override
  Future<void> onLoad() async {
    if (!pageModel.hasMore) {
      super.onLoad(); // hasMore=false → finishLoad(noMore)
      return;
    }
    final result = await fetchPage(pageModel.page + 1, _query);
    if (isClosed) return;
    if (!result.success) {
      showMessage(messageOf(result));
      refreshCtrl.finishLoad(IndicatorResult.fail);
      return;
    }
    modelListAnalyzing(result, items, fromJson);
    await super.onLoad();
  }

  /// 重拉第一页；[showLoading] 为假时不整屏切回加载态（下拉刷新、返回列表）
  Future<void> requestDataList({bool showLoading = false}) async {
    if (showLoading) recode.value = ResultCode.loading;
    final seq = ++_seq;
    final result = await fetchPage(1, _query);
    if (isClosed || seq != _seq) return;
    if (!result.success) {
      // 已有内容就保留列表只提示，首屏空白才切错误态
      if (items.isEmpty) recode.value = ResultCode.error;
      showMessage(messageOf(result));
      return;
    }
    modelListAnalyzing(result, items, fromJson);
  }

  void onKeywordChanged(String value) {
    keywordText.value = value;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () => search(value));
  }

  void search(String value) {
    final query = value.trim();
    if (query == _query) return;
    _query = query;
    requestDataList(showLoading: true);
  }

  void clearKeyword() {
    _debounce?.cancel();
    keywordText.value = '';
    keyword.clear();
    search('');
  }

  String messageOf(ResponseAnalyzed result) {
    final text = result.message?.trim() ?? '';
    return text.isEmpty ? '请求失败，请检查网络后重试' : text;
  }
}
