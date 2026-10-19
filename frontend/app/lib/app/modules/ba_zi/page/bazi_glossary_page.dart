import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../service/term_glossary.dart';

/// 术语百科：按分类浏览或按关键字检索命盘里出现的名词。
///
/// 配色与结果页一致，从结果页点进来不会跳色。
class BaziGlossaryPage extends StatefulWidget {
  const BaziGlossaryPage({super.key});

  @override
  State<BaziGlossaryPage> createState() => _BaziGlossaryPageState();
}

class _BaziGlossaryPageState extends State<BaziGlossaryPage> {
  final TextEditingController _keyword = TextEditingController();

  /// 当前分类，空串表示全部
  String _section = '';

  @override
  void dispose() {
    _keyword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counts = TermGlossary.counts();
    final total = counts.values.fold(0, (sum, v) => sum + v);

    final hits = TermGlossary.search(_keyword.text);
    final shown =
        _section.isEmpty ? hits : hits.where((e) => e.section == _section);
    final grouped = TermGlossary.groupBySection(shown.toList());

    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
                onPressed: () => Get.back(),
              )
            : null,
        title: const NavigatorTitle("术语百科"),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _searchBar(),
            _chips(counts, total),
            Expanded(
              child: grouped.isEmpty
                  ? _empty()
                  : ListView(
                      padding: EdgeInsets.fromLTRB(
                          10.w,
                          0,
                          10.w,
                          20.h + MediaQuery.paddingOf(context).bottom),
                      children: [
                        for (final entry in grouped.entries)
                          _sectionCard(entry.key, entry.value),
                      ],
                    ),
            ),
          ],
        ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 4.h),
      child: Container(
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
                controller: _keyword,
                onChanged: (_) => setState(() {}),
                style: blackStyle(),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "搜索术语或释义，如「华盖」「三合」",
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
    );
  }

  Widget _chips(Map<String, int> counts, int total) {
    return SizedBox(
      height: 38.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: [
          _chip('全部', total, ''),
          for (final section in TermGlossary.sectionOrder)
            _chip(section, counts[section] ?? 0, section),
        ],
      ),
    );
  }

  Widget _chip(String label, int count, String value) {
    final on = _section == value;
    return Padding(
      padding: EdgeInsets.only(right: 6.w, top: 6.h, bottom: 6.h),
      child: GestureDetector(
        onTap: () => setState(() => _section = value),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: on ? TdColors.brand : Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Text(
            '$label $count',
            style: blackStyle(font: 12.sp)
                .copyWith(color: on ? TdColors.white : TdColors.textPrimary),
          ),
        ),
      ),
    );
  }

  Widget _sectionCard(String section, List<TermEntry> entries) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(4.w, 10.h, 4.w, 6.h),
          child: Text(
            '$section（${entries.length}）',
            style: greyBoldStyle(),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < entries.length; i++) ...[
                if (i > 0) Container(height: 0.5, color: const Color(0xFFEDEDED)),
                _termRow(entries[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _termRow(TermEntry entry) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            entry.term,
            style: redThemeBoldStyle(),
          ),
          SizedBox(height: 3.h),
          Text(entry.meaning, style: blackStyle()),
        ],
      ),
    );
  }

  Widget _empty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Text(
          "没有匹配的术语，换个词试试。",
          textAlign: TextAlign.center,
          style: greyStyle(),
        ),
      ),
    );
  }
}
