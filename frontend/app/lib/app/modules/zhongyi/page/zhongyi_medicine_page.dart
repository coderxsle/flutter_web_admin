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

/// 药品库存列表：搜索 + 新增，列表按拼音首字母分组并带右侧索引条。
///
/// 与参考实现一致，取的是 medicine/options（后端一次最多 500 条，已附售价与余量），
/// 分组、索引跳转都在本地完成，不再逐页拼装。
class ZhongyiMedicinePage extends StatefulWidget {
  const ZhongyiMedicinePage({super.key});

  @override
  State<ZhongyiMedicinePage> createState() => _ZhongyiMedicinePageState();
}

class _ZhongyiMedicinePageState extends State<ZhongyiMedicinePage> {
  List<({String index, List<ZhongyiMedicine> items})> _groups = const [];
  List<String> _letters = const [];
  List<ZhongyiMedicine> _medicines = const [];
  String _keyword = '';
  bool _loading = true;
  int _deletingId = 0;

  /// 索引条字母格边长与距容器右侧的间距；列表右侧留白按这两个值算，别只改一处。
  static const double _indexItemSize = 17;
  static const double _indexSidebarRight = 4;

  /// 索引条主题依赖屏宽，缓存在这里而不是每次 build 新建，免得平白触发下游重建。
  late ThemeData _indexThemeData;

  /// 列表内容右侧让开的宽度：索引条浮在列表上层，不让开的话售价尾数会被字母压住。
  late double _tileRightPadding;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _indexThemeData = _buildIndexTheme(Theme.of(context));
    // 索引条覆盖范围 = 距右间距 + 字母格 + 组件内层 spacer，末尾再留 4 做呼吸位。
    _tileRightPadding = (_indexSidebarRight + _indexItemSize).w + themeOf(context).spacer + 4.w;
  }

  /// 索引条对齐参考实现（Vue 版）：字母小一号、用次要灰，激活项品牌色圆底白字。
  ThemeData _buildIndexTheme(ThemeData base) {
    return base.copyWith(
      // extensions 是整体替换语义，先摘掉可能存在的旧索引主题再补一份。
      extensions: [
        ...base.extensions.values.where((item) => item is! TIndexesThemeData),
        TIndexesThemeData(
          indexItemSize: _indexItemSize.w,
          indexItemSpacing: 5.w,
          sidebarRight: _indexSidebarRight.w,
          indexColor: TdColors.grey85,
          activeIndexColor: TdColors.white,
          activeIndexBackgroundColor: TdColors.brand,
          indexFont: Font(size: 11.w.round(), lineHeight: 14.w.round(), fontWeight: FontWeight.w600),
          activeIndexFont: Font(size: 11.w.round(), lineHeight: 14.w.round(), fontWeight: FontWeight.w600),
          tipSize: 48.w,
          tipMaxWidth: 56.w,
          tipColor: TdColors.white,
          tipBackgroundColor: const Color(0xB81D2129),
        ),
      ],
    );
  }

  Future<void> _load({String keyword = ''}) async {
    setState(() => _loading = true);
    final response = await ZhongyiRequest.medicineOptions(keyword: keyword);
    if (!mounted) return;
    final items =
        response.success ? zyMapList(response.data).map(ZhongyiMedicine.fromJson).toList() : <ZhongyiMedicine>[];
    final groups = groupMedicinesByIndex(items);
    setState(() {
      _loading = false;
      _medicines = items;
      _groups = groups;
      _letters = groups.map((group) => group.index).toList();
    });
    if (!response.success) showMessage(response.message ?? '');
  }

  /// 列表被编辑页改动过，返回时无条件重拉，避免余量与售价过期。
  Future<void> _reload() => _load(keyword: _keyword);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: TdColors.white), onPressed: () => Get.back()),
        title: const NavigatorTitle('药品库存'),
      ),
      body: Column(
        children: [
          _toolbar(),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return ZhongyiSearchToolbar(
      search: ZhongyiSearchBar(
        hintText: '搜索药品名称 / 拼音',
        onSubmitted: (value) {
          _keyword = value.trim();
          _load(keyword: _keyword);
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
    if (_medicines.isEmpty) {
      return ZhongyiEmpty(
        text: _keyword.isEmpty ? '暂无药品，点右上角新增' : '没有匹配的药品',
        operation: ZhongyiPrimaryButton(text: '新增药品', height: 36, onPressed: () => _openEdit()),
      );
    }
    return Theme(
      data: _indexThemeData,
      child: TIndexes(
        indexList: _letters,
        builderContent: (context, index) {
          final group = _groups.firstWhere((item) => item.index == index);
          return Column(children: [for (final medicine in group.items) _medicineTile(medicine)]);
        },
      ),
    );
  }

  Widget _medicineTile(ZhongyiMedicine medicine) {
    return TSwipeCell(
      end: TSwipeCellPanel(
        children: [
          TSwipeCellAction(
            label: '编辑',
            backgroundColor: TdColors.blue,
            onPressed: (_) => _openEdit(medicine.id),
          ),
          TSwipeCellAction(
            label: _deletingId == medicine.id ? '删除中' : '删除',
            backgroundColor: TdColors.red,
            onPressed: (_) => _delete(medicine),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _openDetail(medicine.id),
        child: Container(
          padding: EdgeInsets.fromLTRB(12.w, 11.h, _tileRightPadding, 11.h),
          decoration: const BoxDecoration(
            color: TdColors.white,
            border: Border(bottom: BorderSide(color: TdColors.grey225, width: 0.5)),
          ),
          child: Row(
            children: [
              Expanded(child: _medicineTitle(medicine)),
              SizedBox(width: 8.w),
              _stockCell(medicine),
              SizedBox(width: 10.w),
              _priceText('进¥${zhongyiNumberText(medicine.purchasePrice)}', blackStyle().copyWith(color: const Color(0xFF16A34A))),
              SizedBox(width: 8.w),
              _priceText('售¥${zhongyiNumberText(medicine.salePrice)}', redThemeStyle()),
            ],
          ),
        ),
      ),
    );
  }

  /// 药名用富文本拼：炮制前缀单独上红色，基名沿用主文字色，字号字重两边共用一个 style。
  Widget _medicineTitle(ZhongyiMedicine medicine) {
    final prefix = zyText(medicine.prefix);
    final originPlace = zyText(medicine.originPlace);
    return Row(
      children: [
        if (!medicine.enabled) ...[
          const ZhongyiStatusTag('停用', colorPreset: TTagColorPreset.warning),
        ],
        SizedBox(width: 10.w),
        Flexible(
          child: Text.rich(
            TextSpan(
              children: [
                if (prefix != null) TextSpan(text: prefix, style: const TextStyle(color: TdColors.brand)),
                TextSpan(text: medicine.name),
              ],
            ),
            style: blackBoldStyle(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (originPlace != null) ...[
          SizedBox(width: 10.w),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 80.w),
            child: Text(originPlace, style: greyStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
        
      ],
    );
  }

  /// 余量：有货走品牌色，无货走红色，与参考实现的 stock-cell 一致。
  Widget _stockCell(ZhongyiMedicine medicine) {
    final stock = zhongyiStockDisplay(medicine.stockQuantityG, medicine.unit);
    final out = medicine.stockQuantityG <= 0;
    final color = out ? TdColors.brand : TdColors.blue;
    return Row(
      children: [
        Text('余', style: blackStyle(font: 12.sp).copyWith(color: color, fontWeight: FontWeight.w600)),
        Text(
          zhongyiNumberText(stock.value.toDouble()),
          style: blackStyle().copyWith(color: color, fontWeight: FontWeight.w800),
        ),
        Text(stock.unit, style: blackStyle(font: 12.sp).copyWith(color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _priceText(String text, TextStyle style) => Text(text, style: style);

  void _openDetail(int id) {
    Get.toNamed(Routes.ZHONGYIMEDICINEDETAILPAGE, arguments: id)?.then((_) => _reload());
  }

  void _openEdit([int id = 0]) {
    Get.toNamed(Routes.ZHONGYIMEDICINEEDITPAGE, arguments: id)?.then((_) => _reload());
  }

  Future<void> _delete(ZhongyiMedicine medicine) async {
    if (_deletingId != 0) return;
    showAlertDialog(
      title: '删除药品',
      message: '确定删除「${medicine.fullName}」吗？',
      confirmText: '删除',
      confirm: () async {
        dismissAlertDialog();
        setState(() => _deletingId = medicine.id);
        final response = await ZhongyiRequest.deleteMedicines([medicine.id]);
        if (!mounted) return;
        setState(() => _deletingId = 0);
        showMessage(zyTextOr(response.message, response.success ? '删除成功' : '删除失败'));
        if (response.success) await _reload();
      },
    );
  }
}
