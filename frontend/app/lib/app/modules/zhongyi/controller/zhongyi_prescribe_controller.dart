import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_catalog.dart';
import '../service/zhongyi_domain.dart';

/// 开方结算页控制器。
///
/// 流程与参考实现一致：先确定患者（手填或选档案，没有就建档），再选药 / 套模板，
/// 填单剂用量，校验剂量与库存后调 billing/create 生成账单。
class ZhongyiPrescribeController extends GetxController {
  static const int defaultDoses = 7;

  /// 患者姓名与电话手填（UI 不依赖它们做响应式渲染，只提交时用）；
  /// [selectedPatientId] 非 0 表示已绑定档案。
  String patientName = '';
  String patientPhone = '';
  final selectedPatientId = 0.obs;

  final doses = defaultDoses.obs;
  String notes = '';
  final lines = <ZhongyiPrescriptionLine>[].obs;
  final patients = <ZhongyiPatient>[].obs;
  final submitting = false.obs;

  /// 当前套用的模板，用于在备注里记录模板名与加减情况。
  final selectedTemplate = Rxn<ZhongyiTemplate>();
  final templateOriginalIds = <int>[].obs;

  ZhongyiPrescriptionSummary get summary => calculatePrescription(lines, doses.value);

  @override
  void onInit() {
    super.onInit();
    loadPatients();
  }

  Future<void> loadPatients() async {
    final response = await ZhongyiRequest.patientList(pageSize: 50);
    if (!response.success) return;
    patients.assignAll(ZhongyiPage.from<ZhongyiPatient>(response.mapData, ZhongyiPatient.fromJson).items);
  }

  void setName(String value) {
    patientName = value;
    selectedPatientId.value = 0;
  }

  void setPhone(String value) {
    patientPhone = value;
    selectedPatientId.value = 0;
  }

  void setDoses(int value) => doses.value = value;

  void setNotes(String value) => notes = value;

  void selectPatient(ZhongyiPatient patient) {
    selectedPatientId.value = patient.id;
    patientName = patient.name;
    patientPhone = zyText(patient.phone) ?? '';
    if (!patients.any((item) => item.id == patient.id)) patients.insert(0, patient);
  }

  /// 追加药品，已在方中的自动跳过。
  void addMedicines(List<ZhongyiMedicine> medicines) {
    final added = medicines.where((medicine) => !lines.any((line) => line.medicineId == medicine.id)).toList();
    if (added.isEmpty) {
      showMessage('该药品已在方中');
      return;
    }
    for (final medicine in added) {
      ZhongyiMedicineCatalog.instance.putAll([medicine]);
      lines.add(ZhongyiPrescriptionLine.fromMedicine(medicine));
    }
    showMessage('已添加 ${added.length} 味药');
  }

  void removeLine(int index) {
    if (index < 0 || index >= lines.length) return;
    lines.removeAt(index);
    lines.refresh();
  }

  /// 单剂用量输入后刷新计价。
  void updateDosage(int index, double value) {
    if (index < 0 || index >= lines.length) return;
    lines[index].dosageGrams = value;
    lines.refresh();
  }

  /// 套用模板：拉详情、补齐缺失药品、按模板剂量铺开明细。
  Future<int> applyTemplate(ZhongyiTemplate template) async {
    if (template.id <= 0) return 0;
    showLoadingMessage('模板加载中...');
    try {
      final response = await ZhongyiRequest.templateDetail(template.id);
      if (!response.success) {
        showMessage(response.message);
        return 0;
      }
      final detail = ZhongyiTemplate.fromJson(response.mapData);
      final catalog = ZhongyiMedicineCatalog.instance;
      await catalog.ensure(detail.items.map((item) => item.medicineId));

      final next = <ZhongyiPrescriptionLine>[];
      var missing = 0;
      for (final item in detail.items) {
        final medicine = catalog[item.medicineId];
        if (medicine == null) {
          missing++;
          continue;
        }
        next.add(ZhongyiPrescriptionLine.fromMedicine(medicine)..dosageGrams = item.dosageGrams);
      }
      lines.assignAll(next);
      doses.value = detail.doses;
      selectedTemplate.value = detail;
      templateOriginalIds.assignAll(next.map((line) => line.medicineId).toList());
      if (missing > 0) showMessage('模板已带入，$missing 味药未找到');
      return detail.items.length;
    } finally {
      await dismissLoading();
    }
  }

  /// 提交结算，成功返回账单 ID。
  Future<int?> submit() async {
    final message = validate();
    if (message != null) {
      showMessage(message);
      return null;
    }
    submitting.value = true;
    try {
      final patientId = await _resolvePatientId();
      if (patientId == null) return null;

      final response = await ZhongyiRequest.createBill(
        patientId: patientId,
        billingStage: 'treatment',
        items: toBillItems(summary, doses.value),
        remark: _buildRemark(),
      );
      if (!response.success) {
        showMessage(response.message);
        return null;
      }
      final bill = ZhongyiBill.fromJson(response.mapData);
      reset();
      showMessage('结算成功');
      return bill.id;
    } finally {
      submitting.value = false;
    }
  }

  /// 返回第一条不通过的校验提示，全部通过返回 null。
  String? validate() {
    if (patientName.trim().isEmpty) return '请先输入患者姓名';
    if (patientPhone.trim().isEmpty) return '请先输入患者电话';
    if (doses.value <= 0) return '剂数必须大于 0';
    if (lines.isEmpty) return '请至少添加一味药';
    if (lines.any((line) => line.dosageGrams <= 0)) return '单剂用量必须大于 0';
    if (lines.any((line) => line.salePrice < 0)) return '销售价不能小于 0';

    final ids = <int>{};
    for (final line in lines) {
      if (!ids.add(line.medicineId)) return '同一张方不允许重复药品';
    }

    final current = summary;
    if (current.hasShortage) {
      final first = current.items.firstWhere((item) => item.shortage);
      return '${first.line.name}库存不足';
    }
    return null;
  }

  /// 未绑定档案时按姓名匹配或新建，失败返回 null。
  Future<int?> _resolvePatientId() async {
    if (selectedPatientId.value > 0) return selectedPatientId.value;

    final name = patientName.trim();
    final existed = _findPatientByName(name);
    if (existed != null) {
      selectPatient(existed);
      return existed.id;
    }

    final response = await ZhongyiRequest.createPatient(name: name, phone: patientPhone.trim());
    if (!response.success) {
      showMessage(response.message);
      return null;
    }
    final patient = ZhongyiPatient.fromJson(response.mapData);
    selectPatient(patient);
    return patient.id;
  }

  ZhongyiPatient? _findPatientByName(String name) {
    for (final patient in patients) {
      if (patient.name == name) return patient;
    }
    return null;
  }

  /// 备注里记录模板名与加减情况，便于回溯这张方是怎么来的。
  String _buildRemark() {
    final userNotes = notes.trim();
    final templateName = selectedTemplate.value?.name ?? '自定义';
    final modification = _modificationLabel();
    final suffix = modification.isEmpty
        ? '--App使用「$templateName」开方 ${doses.value} 剂。'
        : '--App使用「$templateName」$modification 开方 ${doses.value} 剂。';
    return userNotes.isEmpty ? suffix : '$userNotes$suffix';
  }

  String _modificationLabel() {
    if (selectedTemplate.value == null || templateOriginalIds.isEmpty) return '';
    final original = templateOriginalIds.toSet();
    final current = lines.map((line) => line.medicineId).toSet();
    final added = current.any((id) => !original.contains(id));
    final removed = original.any((id) => !current.contains(id));
    if (added && removed) return '+-加减';
    if (added) return '加味';
    if (removed) return '减味';
    return '';
  }

  void reset() {
    lines.clear();
    notes = '';
    selectedTemplate.value = null;
    templateOriginalIds.clear();
  }
}
