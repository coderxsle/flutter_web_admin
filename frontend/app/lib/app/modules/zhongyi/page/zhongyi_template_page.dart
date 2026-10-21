import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/app/utils/result_code.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_ui.dart';

/// 处方模板列表：搜索 + 新增，卡片列表支持分页加载、启停与删除。
///
/// 本人模板可编辑；公共 / 协定模板后端禁止修改，点击进只读详情。
class ZhongyiTemplatePage extends StatefulWidget {
  const ZhongyiTemplatePage({super.key});

  @override
  State<ZhongyiTemplatePage> createState() => _ZhongyiTemplatePageState();
}

class _ZhongyiTemplatePageState extends State<ZhongyiTemplatePage> {
  static const int _pageSize = 20;

  final ScrollController _scrollController = ScrollController();
  List<ZhongyiTemplate> _templates = const [];
  String _keyword = '';
  int _page = 1;
  bool _hasNext = false;
  bool _loading = true;
  bool _loadingMore = false;
  int _busyId = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 120) _loadMore();
  }

  Future<void> _load({bool reset = true}) async {
    if (!reset && (!_hasNext || _loadingMore)) return;
    final nextPage = reset ? 1 : _page + 1;
    setState(() {
      if (reset) {
        _loading = _templates.isEmpty;
      } else {
        _loadingMore = true;
      }
    });

    final response = await ZhongyiRequest.templateList(page: nextPage, pageSize: _pageSize, name: _keyword);
    if (!mounted) return;
    if (!response.success) {
      setState(() {
        _loading = false;
        _loadingMore = false;
      });
      showMessage(response.message ?? '');
      return;
    }

    final page = ZhongyiPage.from<ZhongyiTemplate>(zyMap(response.data), ZhongyiTemplate.fromJson);
    setState(() {
      _templates = reset ? page.items : [..._templates, ...page.items];
      _page = page.page;
      _hasNext = page.hasNext;
      _loading = false;
      _loadingMore = false;
    });
  }

  Future<void> _loadMore() => _load(reset: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: TdColors.white), onPressed: () => Get.back()),
        title: const NavigatorTitle('药方模板'),
      ),
      body: Column(
        children: [
          _toolbar(),
          const SizedBox(height: 8),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return ZhongyiSearchToolbar(
      search: ZhongyiSearchBar(
        hintText: '搜索模板名称',
        onSubmitted: (value) {
          _keyword = value.trim();
          _load();
        },
        onClearPressed: () {
          _keyword = '';
          _load();
        },
      ),
      action: SizedBox(
        width: 76.w,
        child: ZhongyiPrimaryButton(text: '新增', height: 40, onPressed: () => _openEdit()),
      ),
    );
  }

  Widget _body() {
    if (_loading) return const ZhongyiLoading();
    if (_templates.isEmpty) {
      return ZhongyiEmpty(
        text: _keyword.isEmpty ? '暂无模板' : '没有匹配的模板',
        operation: ZhongyiPrimaryButton(text: '新增模板', height: 36, onPressed: () => _openEdit()),
      );
    }
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
      itemCount: _templates.length + 1,
      itemBuilder: (context, index) {
        if (index == _templates.length) return _footer();
        return Padding(padding: EdgeInsets.only(bottom: 5.h), child: _card(_templates[index]));
      },
    );
  }

  Widget _footer() {
    final text = _loadingMore ? '加载中...' : (_hasNext ? '上拉加载更多' : '没有更多了');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Center(child: Text(text, style: greyStyle())),
    );
  }

  Widget _card(ZhongyiTemplate template) {
    final editable = template.canEdit;
    return TSwipeCell(
      end: TSwipeCellPanel(
        children: [
          // 只有本人模板可改；共享模板进去是只读详情，按钮不能写「编辑」。
          TSwipeCellAction(
            label: editable ? '编辑' : '查看',
            backgroundColor: TdColors.blue,
            onPressed: (_) => _openTemplate(template),
          ),
          TSwipeCellAction(
            label: _busyId == template.id ? '...' : (template.isActive ? '停用' : '启用'),
            backgroundColor: TdColors.orange,
            onPressed: (_) => _toggleStatus(template),
          ),
          TSwipeCellAction(
            label: '删除',
            backgroundColor: TdColors.red,
            onPressed: (_) => _delete(template),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _openTemplate(template),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
          decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(12.w)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(template.name,
                        style: blackBoldStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(width: 6.w),
                  ZhongyiStatusTag(zhongyiScopeText(template.scope)),
                  SizedBox(width: 6.w),
                  ZhongyiStatusTag(
                    template.isActive ? '启用' : '停用',
                    colorPreset: template.isActive ? TTagColorPreset.success : TTagColorPreset.warning,
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Expanded(
                    child: Text('默认 ${template.doses} 剂 · ${template.items.length} 味药',
                        style: greyStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  if (!editable) ...[
                    SizedBox(width: 8.w),
                    Text('只读', style: greyStyle(font: 12.sp)),
                  ],
                ],
              ),
              if (zyText(template.notes) != null) ...[
                SizedBox(height: 2.h),
                Text(template.notes!, style: greyStyle(font: 12.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
              if (zyText(template.syndrome) != null) ...[
                SizedBox(height: 2.h),
                Text('主治：${template.syndrome}',
                    style: greyStyle(font: 12.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleStatus(ZhongyiTemplate template) async {
    if (_busyId != 0) return;
    setState(() => _busyId = template.id);
    final response = await ZhongyiRequest.setTemplateStatus(template.id, isActive: !template.isActive);
    if (!mounted) return;
    setState(() => _busyId = 0);
    showMessage(zyTextOr(response.message, response.success ? '操作成功' : '操作失败'));
    if (response.success) await _load();
  }

  Future<void> _delete(ZhongyiTemplate template) async {
    if (_busyId != 0) return;
    showAlertDialog(
      title: '删除药方模板',
      message: '确定删除「${template.name}」吗？',
      confirmText: '删除',
      confirm: () async {
        dismissAlertDialog();
        setState(() => _busyId = template.id);
        final response = await ZhongyiRequest.deleteTemplates([template.id]);
        if (!mounted) return;
        setState(() => _busyId = 0);
        showMessage(zyTextOr(response.message, response.success ? '删除成功' : '删除失败'));
        if (response.success) await _load();
      },
    );
  }

  /// 可编辑权限由后端算好（can_edit）：本人模板与本人创建的公共模板可改，
  /// 协定模板与他人模板只读。
  void _openTemplate(ZhongyiTemplate template) {
    final route = template.canEdit ? Routes.ZHONGYITEMPLATEEDITPAGE : Routes.ZHONGYITEMPLATEDETAILPAGE;
    Get.toNamed(route, arguments: template.id)?.then((_) => _load());
  }

  void _openEdit() {
    Get.toNamed(Routes.ZHONGYITEMPLATEEDITPAGE)?.then((_) => _load());
  }
}
