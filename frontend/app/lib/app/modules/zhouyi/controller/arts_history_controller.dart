import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:http_manager/http_manager.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/common_widget/base_controller.dart';
import '../../../utils/common_widget/my_dialog.dart';
import '../../../utils/result_code.dart';
import '../../ba_zi/model/bazi_record.dart';
import '../../ba_zi/service/bazi_record_opener.dart';
import '../../qi_men/controller/qimen_controller.dart';
import '../algorithm/qimen_calculator.dart';
import '../algorithm/zy_datetime_model.dart';
import '../http/arts_record_item.dart';
import '../http/arts_record_request.dart';

/// 排盘历史：奇门与八字共用，[artsType] 决定标题、行内摘要与点击后的去向。
///
/// 数据只来自 `GET /api/lxs_arts/record/list`，不落本地；页面只管渲染，
/// 状态走 [recode]，下拉/上拉走 [refreshCtrl] + [onRefresh]/[onLoad]。
class ArtsHistoryController extends BaseController {
  ArtsHistoryController(this.artsType);

  /// [ArtsRecordType.qimen] / [ArtsRecordType.bazi]
  final String artsType;

  /// 列表数据，页面用 Obx 直接吃
  final items = <ArtsRecordItem>[].obs;

  /// 搜索框；keywordText 只用来控制清除按钮的显隐
  final keyword = TextEditingController();
  final keywordText = ''.obs;

  /// 正在删除的记录 id，避免连点重复提交
  final deletingId = 0.obs;

  static const int _pageSize = 20;

  String _query = '';

  /// 请求序号：搜索、刷新交错时丢弃过期响应
  int _seq = 0;

  Timer? _debounce;

  bool get isBazi => artsType == ArtsRecordType.bazi;

  String get title => isBazi ? '八字排盘历史' : '奇门排盘历史';

  String get emptyTip => _query.isEmpty ? '还没有排盘记录' : '没有匹配的记录';

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

  /// 上拉下一页：页码和「还有没有下一页」都交给 [pageModel]，收尾交回父类
  @override
  Future<void> onLoad() async {
    if (!pageModel.hasMore) {
      super.onLoad(); // hasMore=false → finishLoad(noMore)
      return;
    }
    final result = await _fetch(pageModel.page + 1);
    if (isClosed) return;
    if (!result.success) {
      showMessage(_message(result));
      refreshCtrl.finishLoad(IndicatorResult.fail);
      return;
    }
    modelListAnalyzing(result, items, ArtsRecordItem.fromJson);
    await super.onLoad();
  }

  /// 重拉第一页；[showLoading] 为假时不整屏切回加载态（下拉刷新、回页刷新）
  Future<void> requestDataList({bool showLoading = false}) async {
    if (showLoading) recode.value = ResultCode.loading;
    final seq = ++_seq;
    final result = await _fetch(1);
    if (isClosed || seq != _seq) return;
    if (!result.success) {
      // 已有内容就保留列表只提示，首屏空白才切错误态
      if (items.isEmpty) recode.value = ResultCode.error;
      showMessage(_message(result));
      return;
    }
    // 解析交回 BaseController：分页元信息进 pageModel，recode 也在里面落
    modelListAnalyzing(result, items, ArtsRecordItem.fromJson);
  }

  Future<ResponseAnalyzed> _fetch(int page) => ArtsRecordRequest.fetch(
    artsType: artsType,
    page: page,
    pageSize: _pageSize,
    keyword: _query,
  );

  String _message(ResponseAnalyzed result) {
    final text = result.message?.trim() ?? '';
    return text.isEmpty ? '请求失败，请检查网络后重试' : text;
  }

  // ---------------------------------------------------------------- 交互
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
    keyword.clear();
    keywordText.value = '';
    _debounce?.cancel();
    search('');
  }

  /// 按落库的入参重算盘面后进结果页，回来重拉一次（卦解/标签可能已改）
  Future<void> open(ArtsRecordItem item) async {
    final opened = isBazi ? await BaziRecordOpener.open(BaziRecord.fromArtsRecord(item)) : await _openQimen(item);
    if (!opened || isClosed) return;
    await requestDataList();
  }

  /// 奇门按落库的起局时间与局式重算；算法不认这条记录时留在列表页
  Future<bool> _openQimen(ArtsRecordItem item) async {
    final params = item.queryParams;
    final time = item.chartTime ?? DateTime.now();
    final method = params['method'] == QimenMethod.chaibu.name ? QimenMethod.chaibu : QimenMethod.zhirun;
    try {
      final model = QimenCalculator().calculate(ZYDatetimeModel.fromDateTime(time), method: method);
      await Get.toNamed(
        Routes.QIMENRESULTPAGE,
        arguments: QiMenResultArgs(
          model: model,
          method: method,
          showAnGan: params['show_an_gan'] != false,
          showDiBaShen: params['show_di_ba_shen'] != false,
          clientKey: item.clientKey,
          chartTime: time,
          question: item.question,
          interpretation: item.interpretation,
          feedback: item.feedback,
        ),
      );
      return true;
    } on QimenException catch (e) {
      showMessage(e.message);
      return false;
    }
  }

  Future<void> remove(ArtsRecordItem item) async {
    if (deletingId.value != 0) return;
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("删除记录"),
        content: Text("确定删除「${item.displayTitle}」这条排盘记录？"),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("取消")),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("删除", style: TextStyle(color: TdColors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true || isClosed) return;

    deletingId.value = item.id;
    final response = await ArtsRecordRequest.remove([item.id]);
    if (isClosed) return;
    deletingId.value = 0;
    if (!response.success) {
      showMessage(response.message?.trim().isNotEmpty == true ? response.message! : '删除失败，请稍后重试');
      return;
    }
    items.removeWhere((e) => e.id == item.id);
    if (items.isEmpty) recode.value = ResultCode.empty_data;
    showMessage("已删除");
  }
}
