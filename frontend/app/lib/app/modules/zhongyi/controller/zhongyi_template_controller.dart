import 'package:get/get.dart';
import 'package:http_manager/http_manager.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../../../utils/result_code.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import 'zhongyi_list_controller.dart';

/// 处方模板列表：本人模板可编辑，公共 / 协定模板只读。
class ZhongyiTemplateController extends ZhongyiListController<ZhongyiTemplate> {
  /// 正在启停或删除的模板 id，避免连点重复提交
  final busyId = 0.obs;

  @override
  String get emptyTip => hasQuery ? '没有匹配的模板' : '暂无模板';

  @override
  Future<ResponseAnalyzed> fetchPage(int page, String query) => ZhongyiRequest.templateList(
        page: page,
        pageSize: ZhongyiListController.pageSize,
        name: query.isEmpty ? null : query,
      );

  @override
  ZhongyiTemplate fromJson(Map<String, dynamic> json) => ZhongyiTemplate.fromJson(json);

  /// 可编辑权限由后端算好（can_edit），只读模板进详情页
  void open(ZhongyiTemplate template) {
    final route = template.canEdit ? Routes.ZHONGYITEMPLATEEDITPAGE : Routes.ZHONGYITEMPLATEDETAILPAGE;
    Get.toNamed(route, arguments: template.id)?.then((_) => requestDataList());
  }

  void create() => Get.toNamed(Routes.ZHONGYITEMPLATEEDITPAGE)?.then((_) => requestDataList());

  Future<void> toggleStatus(ZhongyiTemplate template) async {
    if (busyId.value != 0) return;
    busyId.value = template.id;
    final response = await ZhongyiRequest.setTemplateStatus(template.id, isActive: !template.isActive);
    if (isClosed) return;
    busyId.value = 0;
    showMessage(zyTextOr(response.message, response.success ? '操作成功' : '操作失败'));
    if (response.success) await requestDataList();
  }

  Future<void> remove(ZhongyiTemplate template) async {
    if (busyId.value != 0) return;
    showAlertDialog(
      title: '删除药方模板',
      message: '确定删除「${template.name}」吗？',
      confirmText: '删除',
      confirm: () => _submitRemove(template),
    );
  }

  Future<void> _submitRemove(ZhongyiTemplate template) async {
    dismissAlertDialog();
    busyId.value = template.id;
    final response = await ZhongyiRequest.deleteTemplates([template.id]);
    if (isClosed) return;
    busyId.value = 0;
    showMessage(zyTextOr(response.message, response.success ? '删除成功' : '删除失败'));
    if (!response.success) return;
    // 本地摘掉即可，不重拉整页
    items.removeWhere((item) => item.id == template.id);
    if (items.isEmpty) recode.value = ResultCode.empty_data;
  }
}
