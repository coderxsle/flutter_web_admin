import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/app/utils/result_code.dart';

import '../../../utils/app_manager.dart';
import '../../../utils/global.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_catalog.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_sheet.dart';
import '../widget/zhongyi_ui.dart';

/// 一条可编辑的药味：药品 ID + 单剂用量。
class _TemplateLine {
  _TemplateLine({required this.medicineId, this.dosageGrams = 0});

  final int medicineId;
  double dosageGrams;
}

/// 处方模板编辑：模板信息 + 药味组成，提交一次 create / update。
class ZhongyiTemplateEditPage extends StatefulWidget {
  const ZhongyiTemplateEditPage({super.key});

  @override
  State<ZhongyiTemplateEditPage> createState() => _ZhongyiTemplateEditPageState();
}

class _ZhongyiTemplateEditPageState extends State<ZhongyiTemplateEditPage> {
  final _name = TextEditingController();
  final _notes = TextEditingController();
  final _syndrome = TextEditingController();
  final _efficacy = TextEditingController();
  final _decoction = TextEditingController();

  int _templateId = 0;
  String _scope = 'personal';
  int _doses = 7;
  bool _isActive = true;
  bool _loading = false;
  bool _saving = false;
  List<_TemplateLine> _lines = [];

  /// 协定模板后端禁止修改，编辑态只读。
  bool get _locked => _scope == 'agreed';

  bool get _isSuperuser => AppManager.user?.isSuperuser ?? false;

  /// 适用范围只有管理员能选；非管理员要么是个人模板，要么保持原有共享类型。
  List<({String value, String label})> get _scopeOptions {
    if (_isSuperuser) return zhongyiTemplateScopes;
    if (_scope == 'personal') return [zhongyiTemplateScopes.first];
    return [
      zhongyiTemplateScopes.firstWhere((option) => option.value == _scope, orElse: () => zhongyiTemplateScopes.first)
    ];
  }

  @override
  void initState() {
    super.initState();
    _templateId = zyInt(Get.arguments) ?? 0;
    if (_templateId > 0) _load();
  }

  @override
  void dispose() {
    for (final controller in [_name, _notes, _syndrome, _efficacy, _decoction]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final response = await ZhongyiRequest.templateDetail(_templateId);
    if (!mounted) return;
    if (!response.success) {
      setState(() => _loading = false);
      showMessage(response.message ?? '');
      return;
    }
    final template = ZhongyiTemplate.fromJson(zyMap(response.data));
    await ZhongyiMedicineCatalog.instance.ensure(template.items.map((item) => item.medicineId));
    if (!mounted) return;
    _name.text = template.name;
    _notes.text = template.notes ?? '';
    _syndrome.text = template.syndrome ?? '';
    _efficacy.text = template.efficacy ?? '';
    _decoction.text = template.decoctionInstruction ?? '';
    setState(() {
      _scope = template.scope;
      _doses = template.doses.clamp(1, 60);
      _isActive = template.isActive;
      _lines = [
        for (final item in template.items) _TemplateLine(medicineId: item.medicineId, dosageGrams: item.dosageGrams)
      ];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: TdColors.white), onPressed: () => Get.back()),
        title: NavigatorTitle(_templateId > 0 ? '模板编辑' : '新增模板'),
      ),
      body: _loading
          ? const ZhongyiLoading()
          : SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_locked) ...[ZhongyiNotice('协定模板不可修改。'), SizedBox(height: 2.h)],
                  _infoCard(),
                  _itemsCard(),
                  SizedBox(height: 8.h),
                  ZhongyiPrimaryButton(text: '保存模板', loading: _saving, onPressed: _locked ? null : _submit),
                ],
              ),
            ),
    );
  }

  /// 本页标签最长 4 字，比默认 76 窄一档，标签才贴得住输入框。
  static const double _labelWidth = 60;

  Widget _formRow(String label, Widget child) =>
      ZhongyiFormRow(label: label, labelWidth: _labelWidth, child: child);

  Widget _infoCard() {
    return ZhongyiCard(
      title: '模板信息',
      padding: EdgeInsets.only(bottom: 12.h),
      children: [
        _formRow(
          '模板类型',
          Row(
            children: [
              Expanded(
                child: ZhongyiChipGroup(
                  options: [for (final option in _scopeOptions) option.label],
                  selected: {zhongyiScopeText(_scope)},
                  onTap: (label) {
                    if (!_isSuperuser) return;
                    setState(() {
                      for (final option in zhongyiTemplateScopes) {
                        if (option.label == label) _scope = option.value;
                      }
                    });
                  },
                ),
              ),
              // 自己能改内容、但改不了适用范围，用一句说明比挂锁清楚。
              if (!_isSuperuser && _scope != 'personal')
                Text('仅管理员可改', style: greyStyle()),
            ],
          ),
        ),
        _formRow(
          '模板名称',
          Row(
            children: [
              Expanded(child: ZhongyiFormInput(controller: _name, hint: '请输入模板名称')),
              SizedBox(width: 8.w),
              Text('是否启用', style: greyStyle()),
              SizedBox(width: 4.w),
              TSwitch(value: _isActive, onChanged: (value) => setState(() => _isActive = value)),
            ],
          ),
        ),
        _formRow(
          '默认剂数',
          Row(
            children: [
              Expanded(child: Text('开方时默认带出的剂数', style: greyStyle())),
              TStepper(
                value: _doses,
                min: 1,
                max: 60,
                onChanged: (value) => setState(() => _doses = value.toInt()),
              ),
            ],
          ),
        ),
        _formRow('主治', ZhongyiFormInput(controller: _syndrome, hint: '如：风寒感冒')),
        _formRow('功效', ZhongyiFormInput(controller: _efficacy, hint: '选填')),
        _formRow('煎服说明', ZhongyiFormInput(controller: _decoction, hint: '选填')),
        _formRow('备注', ZhongyiFormInput(controller: _notes, hint: '适用场景或备注', maxLines: 2)),
      ],
    );
  }

  Widget _itemsCard() {
    return ZhongyiCard(
      padding: EdgeInsets.only(bottom: 6.h),
      title: '药品明细',
      trailing: SizedBox(
        width: 70.w,
        child: ZhongyiPrimaryButton(text: '添加', height: 30, onPressed: _pickMedicines),
      ),
      children: [
        if (_lines.isEmpty)
          const ZhongyiEmpty(text: '暂无药品')
        else
          for (var index = 0; index < _lines.length; index++)
            _TemplateLineRow(
              key: ValueKey(_lines[index].medicineId),
              line: _lines[index],
              onDosageChanged: (value) => _lines[index].dosageGrams = value,
              onDelete: () => setState(() => _lines.removeAt(index)),
            ),
      ],
    );
  }

  Future<void> _pickMedicines() async {
    final medicines = await pickZhongyiMedicines(context, selectedIds: _lines.map((line) => line.medicineId).toList());
    if (medicines.isEmpty) return;
    setState(() {
      for (final medicine in medicines) {
        _lines.add(_TemplateLine(medicineId: medicine.id));
      }
    });
    showMessage('已添加 ${medicines.length} 味药');
  }

  String? _validate() {
    if (_name.text.trim().isEmpty) return '请填写模板名称';
    if (_doses <= 0) return '默认剂数必须大于 0';
    if (_lines.isEmpty) return '请至少添加一味药';
    if (_lines.any((line) => line.dosageGrams <= 0)) return '单剂用量必须大于 0';
    final ids = <int>{};
    for (final line in _lines) {
      if (!ids.add(line.medicineId)) return '同一模板不允许重复药品';
      if (ZhongyiMedicineCatalog.instance.isDisabled(line.medicineId)) {
        return '${ZhongyiMedicineCatalog.instance.nameOf(line.medicineId)} 已停用，请替换后再保存';
      }
    }
    return null;
  }

  Future<void> _submit() async {
    final invalid = _validate();
    if (invalid != null) {
      showMessage(invalid);
      return;
    }
    setState(() => _saving = true);
    try {
      final body = <String, dynamic>{
        'name': _name.text.trim(),
        'category': 'herb_decoction',
        'doses': _doses,
        'notes': _notes.text.trim(),
        'syndrome': _syndrome.text.trim(),
        'efficacy': _efficacy.text.trim(),
        'decoction_instruction': _decoction.text.trim(),
        'is_active': _isActive,
        'items': [
          for (var index = 0; index < _lines.length; index++)
            {
              'medicine_id': _lines[index].medicineId,
              'sort_order': index,
              'dosage_grams': _lines[index].dosageGrams,
              'dosage_unit': 'g'
            },
        ],
      };
      // 只有管理员能改适用范围。非管理员编辑共享模板时不能回传 scope，
      // 否则会被当成"把公共模板改成个人模板"。
      if (_isSuperuser) body['scope'] = _scope;
      final response = _templateId > 0
          ? await ZhongyiRequest.updateTemplate(_templateId, body)
          : await ZhongyiRequest.createTemplate(body);
      showMessage(zyTextOr(response.message, response.success ? '保存成功' : '保存失败'));
      if (response.success) Get.back();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

/// 一味药的编辑行：药名 + 单剂用量 + 删除。
class _TemplateLineRow extends StatefulWidget {
  const _TemplateLineRow({super.key, required this.line, required this.onDosageChanged, required this.onDelete});

  final _TemplateLine line;
  final ValueChanged<double> onDosageChanged;
  final VoidCallback onDelete;

  @override
  State<_TemplateLineRow> createState() => _TemplateLineRowState();
}

class _TemplateLineRowState extends State<_TemplateLineRow> {
  late final TextEditingController _dosage = TextEditingController(
    text: widget.line.dosageGrams > 0 ? zhongyiNumberText(widget.line.dosageGrams) : '',
  );

  @override
  void dispose() {
    _dosage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = ZhongyiMedicineCatalog.instance;
    final name = catalog.nameOf(widget.line.medicineId);
    final unit = catalog[widget.line.medicineId]?.unit ?? 'g';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      child: Row(
        children: [
          Expanded(child: Text(name, style: blackBoldStyle(), maxLines: 1, overflow: TextOverflow.ellipsis)),
          SizedBox(width: 6.w),
          Text('单剂', style: greyStyle(font: 12.sp)),
          SizedBox(width: 5.w),
          SizedBox(
            width: 82.w,
            child: ZhongyiFormInput(
              controller: _dosage,
              hint: '0',
              number: true,
              dense: true,
              suffix: unit,
              onChanged: (value) => widget.onDosageChanged(double.tryParse(value.trim()) ?? 0),
            ),
          ),
          SizedBox(width: 8.w),
          _LineRemoveButton(onTap: widget.onDelete),
        ],
      ),
    );
  }
}

/// 明细行的移除钮：浅底小方块，比默认 IconButton 少一半占位。
class _LineRemoveButton extends StatelessWidget {
  const _LineRemoveButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 26.w,
        height: 26.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: TdColors.redBg,
          borderRadius: BorderRadius.circular(7.w),
        ),
        child: Icon(Icons.close_rounded, size: 15.w, color: TdColors.brand),
      ),
    );
  }
}
