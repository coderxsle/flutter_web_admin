import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/common/widgets/navigator_title.dart';

import '../../../theme/app_text_theme.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/common_widget/load_state.dart';
import '../../ba_zi/model/bazi_record.dart';
import '../algorithm/zhouyi_constants.dart';
import '../controller/arts_history_controller.dart';
import '../http/arts_record_item.dart';

/// 排盘历史列表：奇门与八字共用，数据和刷新逻辑都在 [ArtsHistoryController]。
class ArtsHistoryPage extends GetView<ArtsHistoryController> {
  const ArtsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
        title: NavigatorTitle(controller.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 0),
            child: _searchBar(),
          ),
          _body(context),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 36.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 16.w, color: TdColors.grey153),
          SizedBox(width: 6.w),
          Expanded(
            child: TextField(
              controller: controller.keyword,
              onChanged: controller.onKeywordChanged,
              onSubmitted: controller.search,
              style: blackStyle(font: 13.sp),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: controller.isBazi ? "搜索姓名 / 卦解 / 反馈" : "搜索占事 / 卦解 / 反馈",
                hintStyle: greyStyle(font: 13.sp),
              ),
            ),
          ),
          Obx(
            () => controller.keywordText.value.isEmpty
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: controller.clearKeyword,
                    child: Icon(Icons.close, size: 14.w, color: TdColors.grey153),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Obx(
      () => LayoutSubviews(
        state: controller.recode.value,
        controller: controller.refreshCtrl,
        onRefresh: controller.onRefresh,
        onLoad: controller.onLoad,
        emptyTip: controller.emptyTip,
        emptyActionText: "重新加载",
        emptyRetry: () => controller.requestDataList(showLoading: true),
        errorTip: "网络不太顺畅，稍后重试一次",
        onRetry: () => controller.requestDataList(showLoading: true),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 20.h + MediaQuery.paddingOf(context).bottom),
          itemCount: controller.items.length,
          separatorBuilder: (_, __) => SizedBox(height: 8.h),
          itemBuilder: (_, index) => _row(controller.items[index]),
        ),
      ),
    );
  }

  /// 左滑露出「删除」，与药品库存列表同一套 TSwipeCell
  Widget _row(ArtsRecordItem item) {
    final record = controller.isBazi ? BaziRecord.fromArtsRecord(item) : null;
    final note = item.interpretation.trim();

    // 每行单独订阅 deletingId：itemBuilder 在布局期执行，外层 Obx 收不到
    return Obx(() {
      final deleting = controller.deletingId.value == item.id;
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TSwipeCell(
          end: TSwipeCellPanel(
            children: [
              TSwipeCellAction(
                label: deleting ? "删除中" : "删除",
                backgroundColor: TdColors.red,
                onPressed: (_) => controller.remove(item),
              ),
            ],
          ),
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () => controller.open(item),
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.displayTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: blackStyle(font: 15.sp),
                          ),
                        ),
                        if (record != null) ...[
                          SizedBox(width: 6.w),
                          Text(record.sex == BaziSex.man ? "男" : "女", style: greyStyle(font: 12.sp)),
                        ],
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      _summary(item, record),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: greyStyle(font: 12.sp),
                    ),
                    if (note.isNotEmpty) ...[
                      SizedBox(height: 3.h),
                      Text(
                        "卦解：$note",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: greyStyle(font: 12.sp),
                      ),
                    ],
                    if (item.tags.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Wrap(
                        spacing: 6.w,
                        runSpacing: 3.h,
                        children: [
                          for (final tag in item.tags) Text("#$tag", style: redThemeStyle(font: 12.sp)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  /// 奇门看起局时刻，八字看生辰或甲子历四柱
  String _summary(ArtsRecordItem item, BaziRecord? record) {
    if (record != null) return record.birthLabel;
    final time = _formatTime(item.chartTime);
    return time.isEmpty ? "" : "起局 $time";
  }

  static String _formatTime(DateTime? time) {
    if (time == null) return "";
    String p2(int v) => v.toString().padLeft(2, '0');
    return "${time.year}-${p2(time.month)}-${p2(time.day)} ${p2(time.hour)}:${p2(time.minute)}";
  }
}
