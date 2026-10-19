import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../../zhouyi/widget/t_section_title.dart';
import '../service/bazi_record_store.dart';

/// 输入页的历史排盘区块：可按关键字与标签检索，默认只列最近若干条，更多时走弹窗。
class BaziHistorySection extends StatefulWidget {
  const BaziHistorySection({
    super.key,
    required this.records,
    required this.onOpen,
    required this.onRemove,
  });

  final List<BaziRecord> records;
  final void Function(BaziRecord record) onOpen;
  final void Function(BaziRecord record) onRemove;

  /// 卡片内最多直接列出几条
  static const int maxInline = 5;

  @override
  State<BaziHistorySection> createState() => _BaziHistorySectionState();
}

class _BaziHistorySectionState extends State<BaziHistorySection> {
  final TextEditingController _keyword = TextEditingController();
  final Set<String> _selected = {};

  /// 有检索条件时不截断，直接把命中的都列出来
  bool get _filtering => _keyword.text.trim().isNotEmpty || _selected.isNotEmpty;

  List<BaziRecord> get _hits =>
      BaziRecordStore.filter(keyword: _keyword.text, tags: _selected.toList());

  @override
  void dispose() {
    _keyword.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BaziHistorySection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 记录被删掉后，选中标签可能已不存在
    if (oldWidget.records.length != widget.records.length) {
      final alive = BaziRecordStore.allTags();
      _selected.removeWhere((t) => !alive.contains(t));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.records.isEmpty) return const SizedBox.shrink();

    final hits = _hits;
    final tags = BaziRecordStore.allTags();
    final shown = _filtering ? hits : hits.take(BaziHistorySection.maxInline).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TSectionTitle("历史排盘"),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _searchRow(tags),
              if (tags.isNotEmpty) _tagRow(tags),
              const TDivider(),
              if (hits.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Text(
                    "没有符合条件的命例",
                    textAlign: TextAlign.center,
                    style: greyStyle(),
                  ),
                )
              else ...[
                for (var i = 0; i < shown.length; i++) ...[
                  if (i > 0) const TDivider(),
                  _row(shown[i]),
                ],
                if (!_filtering && hits.length > BaziHistorySection.maxInline) ...[
                  const TDivider(),
                  _moreRow(context, hits.length),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchRow(List<String> tags) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 4.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 34.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: TdColors.pageBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 16.w, color: TdColors.grey153),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: TextField(
                      controller: _keyword,
                      onChanged: (_) => setState(() {}),
                      style: blackStyle(),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: tags.isEmpty ? "搜索姓名 / 备注" : "搜索姓名 / 备注 / 标签",
                        hintStyle: greyStyle(),
                      ),
                    ),
                  ),
                  if (_keyword.text.isNotEmpty)
                    GestureDetector(
                      onTap: () => setState(() => _keyword.clear()),
                      child: Icon(Icons.close, size: 14.w, color: TdColors.grey153),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagRow(List<String> tags) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
      child: Wrap(
        spacing: 6.w,
        runSpacing: 4.h,
        children: [
          for (final tag in tags) _tagChip(tag),
        ],
      ),
    );
  }

  Widget _tagChip(String tag) {
    final on = _selected.contains(tag);
    return GestureDetector(
      onTap: () => setState(() {
        if (on) {
          _selected.remove(tag);
        } else {
          _selected.add(tag);
        }
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: on ? TdColors.brandLight : TdColors.pageBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: on ? TdColors.brand : Colors.transparent,
            width: 0.5,
          ),
        ),
        child: Text(
          tag,
          style: greyStyle(font: 12.sp)
              .copyWith(color: on ? TdColors.brand : TdColors.grey85),
        ),
      ),
    );
  }

  Widget _row(BaziRecord record) {
    // 这一行也会出现在「查看全部」的 TPopup 面板里，那儿没有 Material 祖先
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => widget.onOpen(record),
        onLongPress: () => _confirmRemove(record),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          record.name.isEmpty ? "未命名" : record.name,
                          style: blackStyle(),
                        ),
                        SizedBox(width: 6.w),
                        Text(record.sex == 1 ? "男" : "女",
                            style: greyStyle(font: 12.sp)),
                        if (record.yeZiShi) ...[
                          SizedBox(width: 6.w),
                          Text("夜子时", style: greyStyle(font: 12.sp)),
                        ],
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(record.birthLabel, style: greyStyle(font: 12.sp)),
                    if (record.tags.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Wrap(
                        spacing: 4.w,
                        runSpacing: 2.h,
                        children: [
                          for (final tag in record.tags)
                            Text(
                              '#$tag',
                              style: redThemeStyle(font: 12.sp),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _confirmRemove(record),
                child: Icon(Icons.close, size: 16.w, color: TdColors.grey195),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _moreRow(BuildContext context, int total) {
    return InkWell(
      onTap: () => _showAll(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Text("查看全部 $total 条", style: greyStyle()),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 12, color: TdColors.grey195),
          ],
        ),
      ),
    );
  }

  void _showAll(BuildContext context) {
    final hits = _hits;
    TPopup.show(
      context,
      options: TPopupOptions.bottom(
        headerBuilder: (ctx, close) => TPopupHeader(
          title: const Text("历史排盘"),
          confirmButton: TButton(
            size: TButtonSize.small,
            variant: TButtonVariant.text,
            onPressed: close,
            child: const Text("关闭"),
          ),
        ),
        child: SizedBox(
          height: 380.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: hits.length,
            separatorBuilder: (_, __) => const TDivider(),
            itemBuilder: (_, i) => _row(hits[i]),
          ),
        ),
      ),
    );
  }

  void _confirmRemove(BaziRecord record) {
    Get.dialog(
      AlertDialog(
        title: const Text("删除记录"),
        content: Text("确定删除「${record.name.isEmpty ? '未命名' : record.name}」这条排盘记录？"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("取消"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              widget.onRemove(record);
            },
            child: const Text("删除", style: TextStyle(color: TdColors.red)),
          ),
        ],
      ),
    );
  }
}
