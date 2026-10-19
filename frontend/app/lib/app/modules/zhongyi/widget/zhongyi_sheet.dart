import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_catalog.dart';
import '../service/zhongyi_domain.dart';
import 'zhongyi_ui.dart';

/// 底部弹窗统一外壳：拖动手柄 + 标题栏 + 内容区 + 可选底栏。
Future<T?> showZhongyiSheet<T>({
  required BuildContext context,
  required String title,
  required Widget Function(BuildContext context) builder,
  double heightFactor = 0.76,
  Widget? footer,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) => Container(
      height: MediaQuery.of(sheetContext).size.height * heightFactor,
      decoration:
          BoxDecoration(color: TdColors.pageBg, borderRadius: BorderRadius.vertical(top: Radius.circular(16.w))),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(color: TdColors.grey225, borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 8.h, 4.w, 4.h),
            child: Row(
              children: [
                Expanded(child: Text(title, style: blackBoldStyle(font: 16.sp))),
                IconButton(
                    onPressed: () => Navigator.of(sheetContext).pop(),
                    icon: Icon(Icons.close, size: 20.w, color: TdColors.grey153)),
              ],
            ),
          ),
          Expanded(child: builder(sheetContext)),
          if (footer != null) footer,
          SizedBox(height: MediaQuery.paddingOf(sheetContext).bottom),
        ],
      ),
    ),
  );
}

/// 弹窗顶部搜索框，回车即触发查询。
class ZhongyiSheetSearch extends StatelessWidget {
  const ZhongyiSheetSearch({super.key, required this.hintText, required this.onSubmitted});

  final String hintText;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.w, 0, 12.w, 8.h),
      child: ZhongyiSearchBar(
        hintText: hintText,
        onSubmitted: onSubmitted,
        onClearPressed: () => onSubmitted(''),
      ),
    );
  }
}

/// 药品选择弹窗：多选，已入方的药品会被禁用。
Future<List<ZhongyiMedicine>> pickZhongyiMedicines(
  BuildContext context, {
  List<int> selectedIds = const [],
}) async {
  final result = await showZhongyiSheet<List<ZhongyiMedicine>>(
    context: context,
    title: '选择药品',
    builder: (context) => _MedicinePicker(selectedIds: selectedIds),
  );
  return result ?? const [];
}

class _MedicinePicker extends StatefulWidget {
  const _MedicinePicker({required this.selectedIds});

  final List<int> selectedIds;

  @override
  State<_MedicinePicker> createState() => _MedicinePickerState();
}

class _MedicinePickerState extends State<_MedicinePicker> {
  List<ZhongyiMedicine> _medicines = const [];
  final List<ZhongyiMedicine> _selected = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({String keyword = ''}) async {
    setState(() => _loading = true);
    final response = await ZhongyiRequest.medicineOptions(keyword: keyword);
    if (!mounted) return;
    final medicines = response.success ? response.listData.map(ZhongyiMedicine.fromJson).toList() : <ZhongyiMedicine>[];
    // 顺手喂给目录缓存：调用方拿到的只是选中项，缓存后模板明细才能反查到药名。
    ZhongyiMedicineCatalog.instance.putAll(medicines);
    setState(() {
      _loading = false;
      _medicines = medicines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZhongyiSheetSearch(hintText: '搜索药品名称 / 拼音 / 编码', onSubmitted: (value) => _load(keyword: value)),
        Expanded(child: _buildList()),
        _buildFooter(),
      ],
    );
  }

  Widget _buildList() {
    if (_loading) return const ZhongyiLoading();
    if (_medicines.isEmpty) return const ZhongyiEmpty(text: '没有匹配的药品');
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
      itemCount: _medicines.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) => _buildItem(_medicines[index]),
    );
  }

  Widget _buildItem(ZhongyiMedicine medicine) {
    final used = widget.selectedIds.contains(medicine.id);
    final checked = _selected.any((item) => item.id == medicine.id);
    final stock = zhongyiStockDisplay(medicine.stockQuantityG, medicine.unit);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: used ? null : () => setState(() => checked ? _remove(medicine) : _selected.add(medicine)),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: TdColors.white,
          borderRadius: BorderRadius.circular(10.w),
          border: checked ? Border.all(color: TdColors.brand, width: 1.w) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(medicine.fullName, style: blackBoldStyle()),
                      SizedBox(width: 6.w),
                      if (used) const ZhongyiStatusTag('已在方中', colorPreset: TTagColorPreset.warning),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${medicine.category} · 余${stock.value}${stock.unit} · ¥${zhongyiNumberText(medicine.salePrice)}/${medicine.unit}',
                    style: greyStyle(font: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              checked ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 20.w,
              color: checked ? TdColors.brand : TdColors.grey195,
            ),
          ],
        ),
      ),
    );
  }

  void _remove(ZhongyiMedicine medicine) => _selected.removeWhere((item) => item.id == medicine.id);

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
      color: TdColors.white,
      child: Row(
        children: [
          Expanded(child: Text('已选 ${_selected.length} 味', style: greyStyle())),
          SizedBox(width: 12.w),
          SizedBox(
            width: 140.w,
            child: ZhongyiPrimaryButton(
              text: '确定',
              height: 38,
              onPressed: _selected.isEmpty ? null : () => Navigator.of(context).pop(_selected),
            ),
          ),
        ],
      ),
    );
  }
}

/// 患者选择弹窗：单选，支持按姓名 / 电话搜索。
Future<ZhongyiPatient?> pickZhongyiPatient(BuildContext context, {int selectedId = 0}) async {
  return showZhongyiSheet<ZhongyiPatient>(
    context: context,
    title: '选择患者',
    heightFactor: 0.7,
    builder: (context) => _PatientPicker(selectedId: selectedId),
  );
}

class _PatientPicker extends StatefulWidget {
  const _PatientPicker({required this.selectedId});

  final int selectedId;

  @override
  State<_PatientPicker> createState() => _PatientPickerState();
}

class _PatientPickerState extends State<_PatientPicker> {
  List<ZhongyiPatient> _patients = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({String keyword = ''}) async {
    setState(() => _loading = true);
    final response = await ZhongyiRequest.patientList(pageSize: 50, keyword: keyword);
    if (!mounted) return;
    setState(() {
      _loading = false;
      _patients = response.success
          ? ZhongyiPage.from<ZhongyiPatient>(response.mapData, ZhongyiPatient.fromJson).items
          : const [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZhongyiSheetSearch(hintText: '搜索患者姓名 / 电话', onSubmitted: (value) => _load(keyword: value)),
        Expanded(child: _buildList()),
      ],
    );
  }

  Widget _buildList() {
    if (_loading) return const ZhongyiLoading();
    if (_patients.isEmpty) return const ZhongyiEmpty(text: '暂无患者档案，可直接在页面里新建');
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
      itemCount: _patients.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final patient = _patients[index];
        final selected = patient.id == widget.selectedId;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(patient),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: TdColors.white,
              borderRadius: BorderRadius.circular(10.w),
              border: selected ? Border.all(color: TdColors.brand, width: 1.w) : null,
            ),
            child: Row(
              children: [
                Expanded(child: Text(patient.name, style: blackBoldStyle())),
                Text(zyText(patient.phone) ?? '未留电话', style: greyStyle(font: 12.sp)),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 处方模板选择弹窗：单选，返回模板 ID。
Future<ZhongyiTemplate?> pickZhongyiTemplate(BuildContext context, {int selectedId = 0}) async {
  return showZhongyiSheet<ZhongyiTemplate>(
    context: context,
    title: '套用处方模板',
    heightFactor: 0.7,
    builder: (context) => _TemplatePicker(selectedId: selectedId),
  );
}

class _TemplatePicker extends StatefulWidget {
  const _TemplatePicker({required this.selectedId});

  final int selectedId;

  @override
  State<_TemplatePicker> createState() => _TemplatePickerState();
}

class _TemplatePickerState extends State<_TemplatePicker> {
  List<ZhongyiTemplate> _templates = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({String keyword = ''}) async {
    setState(() => _loading = true);
    final response = await ZhongyiRequest.templateList(pageSize: 100, name: keyword);
    if (!mounted) return;
    setState(() {
      _loading = false;
      final page =
          response.success ? ZhongyiPage.from<ZhongyiTemplate>(response.mapData, ZhongyiTemplate.fromJson) : null;
      _templates = page?.items.where((item) => item.isActive).toList() ?? const [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZhongyiSheetSearch(hintText: '搜索模板名称', onSubmitted: (value) => _load(keyword: value)),
        Expanded(child: _buildList()),
      ],
    );
  }

  Widget _buildList() {
    if (_loading) return const ZhongyiLoading();
    if (_templates.isEmpty) return const ZhongyiEmpty(text: '没有启用的处方模板');
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
      itemCount: _templates.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) {
        final template = _templates[index];
        final selected = template.id == widget.selectedId;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(template),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: TdColors.white,
              borderRadius: BorderRadius.circular(10.w),
              border: selected ? Border.all(color: TdColors.brand, width: 1.w) : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(template.name, style: blackBoldStyle())),
                    ZhongyiStatusTag(zhongyiScopeText(template.scope)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text('默认 ${template.doses} 剂 · ${template.items.length} 味药', style: greyStyle(font: 12.sp)),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 炮制前缀选择：候选由接口下发，新增走接口落盘。返回空串表示清除前缀，null 表示未操作。
Future<String?> pickZhongyiPrefix(BuildContext context, {String prefix = ''}) async {
  final response = await ZhongyiRequest.medicinePrefixes();
  if (!response.success) {
    showMessage(response.message.isEmpty ? '获取炮制前缀失败' : response.message);
    return null;
  }
  final groups = [
    for (final group in response.listData)
      (
        title: '${group['title'] ?? ''}'.trim(),
        items: [for (final item in (group['items'] as List? ?? const [])) '$item'],
      ),
  ].where((group) => group.title.isNotEmpty && group.items.isNotEmpty).toList();
  if (groups.isEmpty) {
    showMessage('暂无可选前缀');
    return null;
  }
  if (!context.mounted) return null;
  return showZhongyiSheet<String>(
    context: context,
    title: '选择炮制前缀',
    heightFactor: 0.75,
    builder: (context) => ZhongyiPrefixPicker(prefix: prefix, groups: groups),
  );
}

/// 分组可由外部注入，便于 UI 测试或复用；正式入口是 [pickZhongyiPrefix]。
class ZhongyiPrefixPicker extends StatefulWidget {
  const ZhongyiPrefixPicker({super.key, required this.prefix, required this.groups});

  final String prefix;
  final List<({String title, List<String> items})> groups;

  @override
  State<ZhongyiPrefixPicker> createState() => _ZhongyiPrefixPickerState();
}

class _ZhongyiPrefixPickerState extends State<ZhongyiPrefixPicker> {
  late final List<({String title, List<String> items})> _groups = [
    for (final group in widget.groups) (title: group.title, items: [...group.items]),
  ];
  final TextEditingController _custom = TextEditingController();
  String _editingGroup = '';
  bool _adding = false;

  @override
  void dispose() {
    _custom.dispose();
    super.dispose();
  }

  void _toggleCustom(String title) {
    setState(() {
      _custom.clear();
      _editingGroup = _editingGroup == title ? '' : title;
    });
  }

  Future<void> _addCustom(String title) async {
    final value = _custom.text.trim();
    if (value.isEmpty) {
      showMessage('请输入自定义前缀');
      return;
    }
    if (value.length > zhongyiPrefixMaxLength) {
      showMessage('前缀不能超过 $zhongyiPrefixMaxLength 个字符');
      return;
    }
    if (_adding) return;
    setState(() => _adding = true);
    final response = await ZhongyiRequest.createMedicinePrefix(value, groupTitle: title);
    if (!mounted) return;
    setState(() => _adding = false);
    if (!response.success) {
      showMessage(response.message.isEmpty ? '新增炮制前缀失败' : response.message);
      return;
    }
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
      children: [
        for (final group in _groups) ...[
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 6.h),
            child: Row(
              children: [
                Text(group.title, style: greyStyle()),
                SizedBox(width: 5.w),
                GestureDetector(
                  onTap: () => _toggleCustom(group.title),
                  child: Container(
                    width: 20.w,
                    height: 20.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: TdColors.brand, borderRadius: BorderRadius.circular(6.w)),
                    child: const Icon(Icons.add, size: 14, color: TdColors.white),
                  ),
                ),
              ],
            ),
          ),
          if (_editingGroup == group.title) ...[
            Row(
              children: [
                Expanded(
                  child: Container(
                    // 只给下限：有界高度会让 TInput 的 Column 填满、文字贴顶。
                    constraints: BoxConstraints(minHeight: 34.h),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(8.w)),
                    child: Center(
                      child: Theme(
                        data: zhongyiBareInputTheme(context),
                        child: TInput(
                          controller: _custom,
                          hintText: '添加前缀',
                          borderless: true,
                          maxLength: zhongyiPrefixMaxLength,
                          style: blackStyle(),
                          onSubmitted: (_) => _addCustom(group.title),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                SizedBox(
                  width: 64.w,
                  child: ZhongyiPrimaryButton(
                    text: '添加',
                    height: 34,
                    onPressed: () => _addCustom(group.title),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
          ],
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [for (final item in group.items) _prefixTag(item)],
          ),
        ],
      ],
    );
  }

  Widget _prefixTag(String item) {
    return ZhongyiPrefixChip(
      item,
      height: 26,
      horizontalPadding: 9,
      selected: item == widget.prefix,
      onTap: () => Navigator.of(context).pop(item),
    );
  }
}

/// 收款：填金额 + 选渠道，确认后返回 (渠道, 金额)，取消返回 null。
Future<({String channel, double amount})?> showZhongyiPaySheet(BuildContext context, {required double amount}) {
  return showZhongyiSheet<({String channel, double amount})>(
    context: context,
    title: '收款',
    heightFactor: 0.5,
    builder: (context) => _PaySheet(amount: amount),
  );
}

class _PaySheet extends StatefulWidget {
  const _PaySheet({required this.amount});

  final double amount;

  @override
  State<_PaySheet> createState() => _PaySheetState();
}

class _PaySheetState extends State<_PaySheet> {
  late final TextEditingController _amount = TextEditingController(text: zhongyiAmountText(widget.amount));
  String _channel = zhongyiPayChannels.first.value;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  void _confirm() {
    final value = double.tryParse(_amount.text.trim());
    if (value == null || value <= 0) {
      showMessage('请输入收款金额');
      return;
    }
    if (value > widget.amount + 0.001) {
      showMessage('收款金额不能超过待收 ¥${zhongyiAmountText(widget.amount)}');
      return;
    }
    Navigator.of(context).pop((channel: _channel, amount: value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text('待收 ¥${zhongyiAmountText(widget.amount)}', style: greyStyle()),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(8.w)),
                child: TInput(
                  controller: _amount,
                  hintText: '收款金额',
                  borderless: true,
                  inputType: TextInputType.number,
                  style: blackStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
                child: Text('支付方式', style: greyStyle()),
              ),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final channel in zhongyiPayChannels)
                    GestureDetector(
                      onTap: () => setState(() => _channel = channel.value),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                        decoration: BoxDecoration(
                          color: _channel == channel.value ? TdColors.brand : TdColors.brandLight,
                          borderRadius: BorderRadius.circular(14.w),
                        ),
                        child: Text(
                          channel.label,
                          style: blackStyle().copyWith(
                            color: _channel == channel.value ? TdColors.white : TdColors.brand,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h),
          color: TdColors.white,
          child: ZhongyiPrimaryButton(text: '确认收款', height: 42, onPressed: _confirm),
        ),
      ],
    );
  }
}

/// 库存批次选择：返回选中的批次，取消返回 null。
Future<ZhongyiInventoryBatch?> pickZhongyiBatch(
  BuildContext context,
  List<ZhongyiInventoryBatch> batches, {
  int selectedId = 0,
}) {
  return showZhongyiSheet<ZhongyiInventoryBatch>(
    context: context,
    title: '选择库存批次',
    heightFactor: 0.6,
    builder: (context) {
      if (batches.isEmpty) return const ZhongyiEmpty(text: '暂无库存批次');
      return ListView.separated(
        padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.h),
        itemCount: batches.length,
        separatorBuilder: (_, __) => SizedBox(height: 8.h),
        itemBuilder: (context, index) {
          final batch = batches[index];
          final stock = zhongyiStockDisplay(batch.quantityG, batch.unit);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(batch),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: TdColors.white,
                borderRadius: BorderRadius.circular(10.w),
                border: batch.id == selectedId ? Border.all(color: TdColors.brand, width: 1.w) : null,
              ),
              child: Row(
                children: [
                  Expanded(child: Text(batch.batchNumber, style: blackBoldStyle())),
                  Text('余${stock.value}${stock.unit}', style: greyStyle()),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
