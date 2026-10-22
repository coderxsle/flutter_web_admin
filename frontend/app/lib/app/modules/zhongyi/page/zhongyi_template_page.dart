import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../controller/zhongyi_template_controller.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_ui.dart';

/// 处方模板列表：分页与刷新在 [ZhongyiTemplateController]，这里只管渲染。
class ZhongyiTemplatePage extends GetView<ZhongyiTemplateController> {
  const ZhongyiTemplatePage({super.key});

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
          _body(context),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return ZhongyiSearchToolbar(
      search: ZhongyiSearchBar(
        hintText: '搜索模板名称',
        controller: controller.keyword,
        onChanged: controller.onKeywordChanged,
        onSubmitted: controller.search,
        onClearPressed: controller.clearKeyword,
      ),
      action: SizedBox(
        width: 76.w,
        child: ZhongyiPrimaryButton(text: '新增', height: 40, onPressed: controller.create),
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
        emptyActionText: '新增模板',
        emptyRetry: controller.create,
        errorTip: '网络不太顺畅，稍后重试一次',
        onRetry: () => controller.requestDataList(showLoading: true),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
          itemCount: controller.items.length,
          separatorBuilder: (_, __) => SizedBox(height: 5.h),
          itemBuilder: (_, index) => _card(controller.items[index]),
        ),
      ),
    );
  }

  Widget _card(ZhongyiTemplate template) {
    final editable = template.canEdit;
    // 每行单独订阅 busyId：itemBuilder 在布局期执行，外层 Obx 收不到
    return Obx(() {
      final busy = controller.busyId.value == template.id;
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.w),
        child: TSwipeCell(
          end: TSwipeCellPanel(
            children: [
              // 共享模板进去是只读详情，按钮不能写「编辑」
              TSwipeCellAction(
                label: editable ? '编辑' : '查看',
                backgroundColor: TdColors.blue,
                onPressed: (_) => controller.open(template),
              ),
              TSwipeCellAction(
                label: busy ? '...' : (template.isActive ? '停用' : '启用'),
                backgroundColor: TdColors.orange,
                onPressed: (_) => controller.toggleStatus(template),
              ),
              TSwipeCellAction(
                label: busy ? '...' : '删除',
                backgroundColor: TdColors.red,
                onPressed: (_) => controller.remove(template),
              ),
            ],
          ),
          child: Material(
            color: TdColors.white,
            child: InkWell(
              onTap: () => controller.open(template),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
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
          ),
        ),
      );
    });
  }
}
