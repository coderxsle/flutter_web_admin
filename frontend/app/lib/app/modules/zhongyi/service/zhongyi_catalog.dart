import 'package:yun_men_yi_pan/app/utils/result_code.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';

/// 药品目录缓存。
///
/// 处方模板明细、开方套模板都只拿到 medicine_id，需要反查药名、单位、售价与余量。
/// 这里统一缓存，一次拉全量选项，未命中的再按 ID 补详情，避免逐条重复请求。
class ZhongyiMedicineCatalog {
  ZhongyiMedicineCatalog._();

  static final ZhongyiMedicineCatalog instance = ZhongyiMedicineCatalog._();

  final Map<int, ZhongyiMedicine> _items = {};
  bool _optionsLoaded = false;

  ZhongyiMedicine? operator [](int medicineId) => _items[medicineId];

  /// 取显示名，未加载到时回落到「药品#ID」，不阻塞渲染。
  String nameOf(int medicineId) => _items[medicineId]?.fullName ?? '药品#$medicineId';

  void putAll(Iterable<ZhongyiMedicine> medicines) {
    for (final medicine in medicines) {
      _items[medicine.id] = medicine;
    }
  }

  Future<void> ensure(Iterable<int> medicineIds) async {
    final missing = medicineIds.where((id) => id > 0 && !_items.containsKey(id)).toSet();
    if (missing.isEmpty) return;

    if (!_optionsLoaded) {
      final response = await ZhongyiRequest.medicineOptions();
      if (response.success) {
        putAll(zyMapList(response.data).map(ZhongyiMedicine.fromJson));
      }
      _optionsLoaded = true;
    }

    final stillMissing = missing.where((id) => !_items.containsKey(id)).toList();
    await Future.wait(stillMissing.map(_fetchDetail));
  }

  Future<void> _fetchDetail(int medicineId) async {
    final response = await ZhongyiRequest.medicineDetail(medicineId);
    if (response.success) _items[medicineId] = ZhongyiMedicine.fromJson(zyMap(response.data));
  }

  /// 药品被停用或删除后，模板里可能引用到不可用的药，这里用于提示。
  bool isDisabled(int medicineId) {
    final medicine = _items[medicineId];
    return medicine != null && !medicine.enabled;
  }
}
