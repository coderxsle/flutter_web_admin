import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_prescription_template_service.dart';
import 'package:test/test.dart';

void main() {
  test('处方模板明细保存模板、药品、剂量和排序信息', () {
    final item = ZhongyiPrescriptionTemplateItem(
      templateId: 11,
      medicineId: 23,
      sortOrder: 2,
      dosageGrams: 12.5,
      dosageUnit: 'g',
      role: '君',
      dosageText: '一钱',
      usageMethod: '先煎',
    );

    expect(item.templateId, 11);
    expect(item.medicineId, 23);
    expect(item.sortOrder, 2);
    expect(item.dosageGrams, 12.5);
    expect(item.dosageUnit, 'g');
    expect(item.role, '君');
  });

  test('模板保留 legacy itemsJson，同时支持来源和医生字段', () {
    final template = ZhongyiPrescriptionTemplate(
      name: '感冒模板',
      scope: 'personal',
      itemsJson: '[{"medicine_id":23,"dosage_grams":12.5}]',
      sourceType: 'patient_record',
      sourceId: 99,
      doctorId: 7,
    );

    expect(template.itemsJson, contains('medicine_id'));
    expect(template.sourceType, 'patient_record');
    expect(template.sourceId, 99);
    expect(template.doctorId, 7);
  });

  test('模板响应优先使用明细表数据，不把旧 JSON 当作新数据源', () {
    final template = ZhongyiPrescriptionTemplate(
      id: 11,
      name: '清热方',
      scope: 'personal',
      itemsJson: '[{"medicine_id":999,"dosage_grams":1}]',
      sourceType: 'record',
      sourceId: 30,
      doctorId: 7,
      creator: 'doctor-a',
      updater: 'doctor-b',
    );
    final items = [
      ZhongyiPrescriptionTemplateItem(id: 5, templateId: 11, medicineId: 23, sortOrder: 1, dosageGrams: 12.5),
    ];

    final json = ZhongyiPrescriptionTemplateService.templateToJson(template, items);

    expect(json['source_type'], 'record');
    expect(json['source_id'], 30);
    expect(json['doctor_id'], 7);
    expect(json['creator'], 'doctor-a');
    expect(json['updater'], 'doctor-b');
    expect(json['items'], [containsPair('medicine_id', 23)]);
    expect((json['items'] as List).single, containsPair('id', 5));
  });
}
