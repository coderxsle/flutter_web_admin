import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/app/utils/result_code.dart';

import '../../../utils/global.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_catalog.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_ui.dart';

/// 处方模板详情（只读）。
///
/// 公共 / 协定模板后端不允许本账号修改，列表点击后进这里看组成与剂量。
class ZhongyiTemplateDetailPage extends StatefulWidget {
  const ZhongyiTemplateDetailPage({super.key});

  @override
  State<ZhongyiTemplateDetailPage> createState() => _ZhongyiTemplateDetailPageState();
}

class _ZhongyiTemplateDetailPageState extends State<ZhongyiTemplateDetailPage> {
  int _templateId = 0;
  ZhongyiTemplate? _template;
  double _totalDosage = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _templateId = zyInt(Get.arguments) ?? 0;
    _load();
  }

  Future<void> _load() async {
    if (_templateId <= 0) {
      setState(() => _loading = false);
      return;
    }
    setState(() => _loading = true);
    final response = await ZhongyiRequest.templateDetail(_templateId);
    if (!response.success) {
      if (!mounted) return;
      setState(() => _loading = false);
      showMessage(response.message ?? '');
      return;
    }
    final template = ZhongyiTemplate.fromJson(zyMap(response.data));
    await ZhongyiMedicineCatalog.instance.ensure(template.items.map((item) => item.medicineId));
    if (!mounted) return;
    setState(() {
      _template = template;
      _totalDosage = zhongyiQuantity(template.items.fold<double>(0, (sum, item) => sum + item.dosageGrams));
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: TdColors.white), onPressed: () => Get.back()),
        title: const NavigatorTitle('模板详情'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (_loading) return const ZhongyiLoading();
    final template = _template;
    if (template == null) return const ZhongyiEmpty(text: '未找到模板');

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!template.canEdit) ZhongyiNotice('${zhongyiScopeText(template.scope)}不可修改，仅可查看。'),
          ZhongyiCard(
            padding: EdgeInsets.all(16.w),
            divided: false,
            children: [
              Row(
                children: [
                  Expanded(child: Text(template.name, style: blackBoldStyle(font: 19.sp))),
                  ZhongyiStatusTag(zhongyiScopeText(template.scope)),
                  SizedBox(width: 6.w),
                  ZhongyiStatusTag(
                    template.isActive ? '启用' : '停用',
                    colorPreset: template.isActive ? TTagColorPreset.success : TTagColorPreset.warning,
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text('默认 ${template.doses} 剂 · ${template.items.length} 味药 · 单剂合计 ${zhongyiNumberText(_totalDosage)}g',
                  style: greyStyle()),
            ],
          ),
          ZhongyiCard(
            title: '模板信息',
            children: [
              ZhongyiKeyValueRow(label: '主治', value: zyText(template.syndrome) ?? '-'),
              ZhongyiKeyValueRow(label: '功效', value: zyText(template.efficacy) ?? '-'),
              ZhongyiKeyValueRow(label: '煎服说明', value: zyText(template.decoctionInstruction) ?? '-'),
              ZhongyiKeyValueRow(label: '备注', value: zyText(template.notes) ?? '-'),
              ZhongyiKeyValueRow(label: '更新时间', value: zyTimeText(template.updateTime)),
            ],
          ),
          ZhongyiCard(
            title: '药品明细',
            children: [
              if (template.items.isEmpty)
                const ZhongyiEmpty(text: '模板里还没有药味')
              else
                for (var index = 0; index < template.items.length; index++)
                  ZhongyiKeyValueRow(
                    label: '${index + 1}. ${ZhongyiMedicineCatalog.instance.nameOf(template.items[index].medicineId)}',
                    value: '${zhongyiNumberText(template.items[index].dosageGrams)}${template.items[index].dosageUnit}',
                    dense: true,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
