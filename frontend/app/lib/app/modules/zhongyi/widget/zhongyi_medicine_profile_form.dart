import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_domain.dart';
import 'zhongyi_sheet.dart';
import 'zhongyi_ui.dart';

/// 药品资料表单：必填项常显，次要属性折叠。
///
/// 字段与后端 `_parseMedicineFields` 一一对应。后端按 containsKey 取值，不传 key
/// 才保留原值，所以 [toBody] 必须带上全部字段，留空即清空。
class ZhongyiMedicineProfileForm extends StatefulWidget {
  const ZhongyiMedicineProfileForm({super.key, this.medicine, this.onChanged});

  /// 为 null 表示新增。
  final ZhongyiMedicine? medicine;

  /// 任一字段变化时回调，用于离开页面时的未保存提示。
  final VoidCallback? onChanged;

  @override
  State<ZhongyiMedicineProfileForm> createState() => ZhongyiMedicineProfileFormState();
}

class ZhongyiMedicineProfileFormState extends State<ZhongyiMedicineProfileForm> {
  final _name = TextEditingController();
  final _subcategory = TextEditingController();
  final _originPlace = TextEditingController();
  final _pinyin = TextEditingController();
  final _indications = TextEditingController();
  final _functions = TextEditingController();
  final _dosageMin = TextEditingController();
  final _dosageMax = TextEditingController();
  final _dosageWarning = TextEditingController();
  final _toxicity = TextEditingController();
  final _pregnancy = TextEditingController();
  final _storage = TextEditingController();
  final _shelfLife = TextEditingController();
  final _description = TextEditingController();

  String _prefix = '';
  String _category = 'herb';
  bool _enabled = true;
  bool _special = false;
  String? _nature;
  final Set<String> _flavors = {};
  final Set<String> _meridians = {};
  bool _expanded = false;

  /// 用户手动改过拼音后，就不再跟随基名自动重算。
  bool _pinyinTouched = false;

  @override
  void initState() {
    super.initState();
    final medicine = widget.medicine;
    if (medicine == null) return;
    _applyMedicine(medicine);
  }

  /// 详情是异步拿的：表单先以 null 建出来时，数据到了要能补填一次。
  @override
  void didUpdateWidget(covariant ZhongyiMedicineProfileForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    final medicine = widget.medicine;
    if (oldWidget.medicine != null || medicine == null) return;
    _applyMedicine(medicine);
  }

  void _applyMedicine(ZhongyiMedicine medicine) {
    _prefix = medicine.prefix;
    _category = _normalizeCategory(medicine.category);
    _enabled = medicine.enabled;
    _special = medicine.isSpecialManagement;
    _nature = medicine.propertyNature;
    _flavors.addAll(medicine.propertyFlavors);
    _meridians.addAll(medicine.propertyMeridians);
    _name.text = medicine.name;
    _subcategory.text = medicine.subcategory ?? '';
    _originPlace.text = medicine.originPlace ?? '';
    _pinyin.text = medicine.pinyin;
    _indications.text = medicine.indications ?? '';
    _functions.text = medicine.functions ?? '';
    _dosageMin.text = _numberText(medicine.commonDosageMin);
    _dosageMax.text = _numberText(medicine.commonDosageMax);
    _dosageWarning.text = _numberText(medicine.dosageWarning);
    _toxicity.text = medicine.toxicity ?? '';
    _pregnancy.text = medicine.pregnancyCategory ?? '';
    _storage.text = medicine.storageRequirements ?? '';
    _shelfLife.text = medicine.shelfLifeMonths?.toString() ?? '';
    _description.text = medicine.description ?? '';
    _pinyinTouched = medicine.pinyin.trim().isNotEmpty;
    // 已有的次要属性直接展开，免得用户以为数据丢了。
    _expanded = _hasSecondary(medicine);
  }

  @override
  void dispose() {
    for (final controller in [
      _name,
      _subcategory,
      _originPlace,
      _pinyin,
      _indications,
      _functions,
      _dosageMin,
      _dosageMax,
      _dosageWarning,
      _toxicity,
      _pregnancy,
      _storage,
      _shelfLife,
      _description,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  /// 校验规则对齐后端：基名非空且不超 20 字、前缀不超 5 字、剂量区间有序。
  String? validate() {
    if (_name.text.trim().isEmpty) return '请填写药品基名';
    if (_name.text.trim().length > 20) return '药品基名不能超过 20 个字符';
    if (_prefix.length > zhongyiPrefixMaxLength) return '炮制前缀不能超过 $zhongyiPrefixMaxLength 个字符';
    final min = _read(_dosageMin);
    final max = _read(_dosageMax);
    if (min != null && max != null && min > max) return '常用剂量下限不能大于上限';
    return null;
  }

  /// 提交体：全部字段都带上，空文本交给后端清空。
  Map<String, dynamic> toBody() {
    final nature = zyText(_nature);
    final properties = <String, dynamic>{
      if (nature != null) 'nature': nature,
      if (_flavors.isNotEmpty) 'flavor': zhongyiFlavorOptions.where(_flavors.contains).toList(),
      if (_meridians.isNotEmpty) 'meridians': zhongyiMeridianOptions.where(_meridians.contains).toList(),
    };
    return <String, dynamic>{
      'prefix': _prefix,
      'name': _name.text.trim(),
      'pinyin': _pinyin.text.trim(),
      'category': _category,
      'subcategory': _subcategory.text.trim(),
      'originPlace': _originPlace.text.trim(),
      'properties': properties.isEmpty ? null : properties,
      'functions': _functions.text.trim(),
      'indications': _indications.text.trim(),
      'commonDosageMin': _read(_dosageMin),
      'commonDosageMax': _read(_dosageMax),
      'dosageWarning': _read(_dosageWarning),
      'toxicity': _toxicity.text.trim(),
      'pregnancyCategory': _pregnancy.text.trim(),
      'isSpecialManagement': _special,
      'storageRequirements': _storage.text.trim(),
      'shelfLifeMonths': _readInt(_shelfLife),
      'description': _description.text.trim(),
      'status': _enabled ? 1 : 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _baseCard(),
        ZhongyiMoreToggle(
          expanded: _expanded,
          label: '次要属性',
          onTap: () => setState(() => _expanded = !_expanded),
        ),
        if (_expanded) ...[
          _sourceCard(),
          _propertyCard(),
          _usageCard(),
          _textCard(),
        ],
      ],
    );
  }

  // ===================== 卡片 =====================

  Widget _baseCard() {
    return ZhongyiCard(
      title: '基础资料',
      padding: EdgeInsets.only(bottom: 10.h),
      children: [
        // 前缀与基名共用一行、不挂行标签，把 76.w 的标签列让给两个控件。
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 5.h, 12.w, 5.h),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: ZhongyiFormPicker(
                  value: _prefix,
                  hint: '选择前缀',
                  leading: _prefix.isEmpty ? null : ZhongyiPrefixChip(_prefix),
                  trailing: _prefix.isEmpty
                      ? null
                      : ZhongyiClearButton(
                          onTap: () => setState(() => _prefix = ''),
                        ),
                  onTap: _pickPrefix,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: 5,
                child: ZhongyiFormInput(
                  controller: _name,
                  hint: '基名，如 甘草',
                  maxLength: 20,
                  onChanged: (_) {
                    _syncPinyin();
                    _touch();
                  },
                ),
              ),
            ],
          ),
        ),
        ZhongyiChipField(
          label: '分类',
          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
          child: ZhongyiChipGroup(
            options: [for (final option in zhongyiCategoryOptions) option.label],
            selected: {zhongyiCategoryText(_category)},
            onTap: (label) => setState(() {
              for (final option in zhongyiCategoryOptions) {
                if (option.label == label) _category = option.value;
              }
              _touch();
            }),
          ),
        ),
        ZhongyiFormRow(
          label: '状态',
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _enabled ? '可用，开方与模板可选' : '停用，开方与模板不可选',
                  style: greyStyle(),
                ),
              ),
              TSwitch(
                value: _enabled,
                onChanged: (value) => setState(() {
                  _enabled = value;
                  _touch();
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sourceCard() {
    return ZhongyiCard(
      title: '来源与检索',
      padding: EdgeInsets.only(bottom: 10.h),
      children: [
        ZhongyiFormRow(
          label: '子分类',
          child: ZhongyiFormInput(
            controller: _subcategory,
            hint: '选填',
            onChanged: (_) => _touch(),
          ),
        ),
        ZhongyiFormRow(
          label: '产地',
          child: ZhongyiFormInput(
            controller: _originPlace,
            hint: '如 内蒙古',
            onChanged: (_) => _touch(),
          ),
        ),
        ZhongyiFormRow(
          label: '拼音',
          child: Row(
            children: [
              Expanded(
                child: ZhongyiFormInput(
                  controller: _pinyin,
                  hint: '改基名自动生成，可手动覆盖',
                  onChanged: (_) {
                    _pinyinTouched = true;
                    _touch();
                  },
                ),
              ),
              SizedBox(width: 8.w),
              // 历史数据里的拼音可能是旧算法写的，给个一键按基名重算的入口。
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() {
                  _pinyinTouched = false;
                  _syncPinyin();
                }),
                child: Text('重算', style: redThemeStyle()),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _propertyCard() {
    return ZhongyiCard(
      title: '性味归经',
      padding: EdgeInsets.only(bottom: 10.h),
      children: [
        ZhongyiChipField(
          label: '四气',
          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 6.h),
          child: ZhongyiChipGroup(
            options: zhongyiNatureOptions,
            selected: {if (_nature != null) _nature!},
            onTap: (value) => setState(() {
              _nature = _nature == value ? null : value;
              _touch();
            }),
          ),
        ),
        ZhongyiChipField(
          label: '五味',
          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 6.h),
          child: ZhongyiChipGroup(
            options: zhongyiFlavorOptions,
            selected: _flavors,
            onTap: (value) => setState(() {
              if (_flavors.contains(value)) {
                _flavors.remove(value);
              } else {
                _flavors.add(value);
              }
              _touch();
            }),
          ),
        ),
        ZhongyiChipField(
          label: '归经',
          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
          child: ZhongyiChipGroup(
            options: zhongyiMeridianOptions,
            selected: _meridians,
            onTap: (value) => setState(() {
              if (_meridians.contains(value)) {
                _meridians.remove(value);
              } else {
                _meridians.add(value);
              }
              _touch();
            }),
          ),
        ),
      ],
    );
  }

  Widget _usageCard() {
    return ZhongyiCard(
      title: '用药信息',
      padding: EdgeInsets.only(bottom: 10.h),
      children: [
        ZhongyiFormRow(
          label: '常用剂量',
          child: Row(
            children: [
              Expanded(
                child: ZhongyiFormInput(
                  controller: _dosageMin,
                  hint: '下限',
                  number: true,
                  onChanged: (_) => _touch(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text('~', style: greyStyle()),
              ),
              Expanded(
                child: ZhongyiFormInput(
                  controller: _dosageMax,
                  hint: '上限',
                  number: true,
                  onChanged: (_) => _touch(),
                ),
              ),
              SizedBox(width: 4.w),
              Text('g', style: greyStyle()),
            ],
          ),
        ),
        ZhongyiFormRow(
          label: '剂量警戒值',
          child: ZhongyiFormInput(
            controller: _dosageWarning,
            hint: '超过则提示',
            number: true,
            suffix: 'g',
            onChanged: (_) => _touch(),
          ),
        ),
        ZhongyiFormRow(
          label: '毒性',
          child: ZhongyiFormInput(
            controller: _toxicity,
            hint: '如 无毒 / 小毒 / 有毒',
            onChanged: (_) => _touch(),
          ),
        ),
        ZhongyiFormRow(
          label: '孕妇用药',
          child: ZhongyiFormInput(
            controller: _pregnancy,
            hint: '如 慎用 / 禁用',
            onChanged: (_) => _touch(),
          ),
        ),
        ZhongyiFormRow(
          label: '特殊管理',
          child: Row(
            children: [
              Expanded(
                child: Text(_special ? '按特殊管理药品登记' : '普通药品', style: greyStyle()),
              ),
              TSwitch(
                value: _special,
                onChanged: (value) => setState(() {
                  _special = value;
                  _touch();
                }),
              ),
            ],
          ),
        ),
        ZhongyiFormRow(
          label: '储存要求',
          child: ZhongyiFormInput(
            controller: _storage,
            hint: '如 阴凉干燥处',
            onChanged: (_) => _touch(),
          ),
        ),
        ZhongyiFormRow(
          label: '保质期',
          child: ZhongyiFormInput(
            controller: _shelfLife,
            hint: '按月填写',
            number: true,
            decimals: 0,
            suffix: '个月',
            onChanged: (_) => _touch(),
          ),
        ),
      ],
    );
  }

  Widget _textCard() {
    return ZhongyiCard(
      title: '主治与功效',
      padding: EdgeInsets.only(bottom: 10.h),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('主治', style: greyStyle()),
              SizedBox(height: 5.h),
              ZhongyiFormInput(
                controller: _indications,
                hint: '如 脾胃虚弱、心悸气短',
                maxLines: 3,
                onChanged: (_) => _touch(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('功效', style: greyStyle()),
              SizedBox(height: 5.h),
              ZhongyiFormInput(
                controller: _functions,
                hint: '如 补脾益气、缓急止痛',
                maxLines: 3,
                onChanged: (_) => _touch(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('备注', style: greyStyle()),
              SizedBox(height: 5.h),
              ZhongyiFormInput(
                controller: _description,
                hint: '选填',
                maxLines: 3,
                onChanged: (_) => _touch(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===================== 交互 =====================

  Future<void> _pickPrefix() async {
    final result = await pickZhongyiPrefix(context, prefix: _prefix);
    if (result == null) return;
    setState(() => _prefix = result);
    _touch();
  }

  /// 只按基名生成拼音；炮制前缀单列，不参与。
  void _syncPinyin() {
    if (_pinyinTouched) return;
    _pinyin.text = zhongyiPinyinOf(_name.text);
  }

  void _touch() => widget.onChanged?.call();

  String _numberText(double? value) => value == null ? '' : zhongyiNumberText(value);

  /// 分类兜底：空值、历史中文标签、未知值都归到选项值上，新增默认植物药。
  String _normalizeCategory(String? value) {
    final text = (value ?? '').trim();
    for (final option in zhongyiCategoryOptions) {
      if (option.value == text || option.label == text) return option.value;
    }
    return 'herb';
  }

  double? _read(TextEditingController controller) {
    final text = controller.text.trim();
    return text.isEmpty ? null : double.tryParse(text);
  }

  int? _readInt(TextEditingController controller) {
    final text = controller.text.trim();
    return text.isEmpty ? null : int.tryParse(text);
  }

  bool _hasSecondary(ZhongyiMedicine medicine) {
    return [
      medicine.subcategory,
      medicine.originPlace,
      medicine.indications,
      medicine.functions,
      medicine.toxicity,
      medicine.pregnancyCategory,
      medicine.storageRequirements,
      medicine.description,
    ].any((value) => zyText(value) != null) ||
        medicine.propertyNature != null ||
        medicine.propertyFlavors.isNotEmpty ||
        medicine.propertyMeridians.isNotEmpty ||
        medicine.commonDosageMin != null ||
        medicine.commonDosageMax != null ||
        medicine.dosageWarning != null ||
        medicine.shelfLifeMonths != null ||
        medicine.isSpecialManagement;
  }
}
