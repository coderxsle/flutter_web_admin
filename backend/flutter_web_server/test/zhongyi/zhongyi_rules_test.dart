import 'package:flutter_web_server/src/services/zhongyi/zhongyi_rules.dart';
import 'package:test/test.dart';

void main() {
  group('库存数量规则', () {
    test('允许正数入库或调整', () {
      expect(ZhongyiRules.adjustStock(current: 8, change: 2.5), 10.5);
    });

    test('拒绝零变更、非有限值和负库存', () {
      expect(() => ZhongyiRules.adjustStock(current: 8, change: 0), throwsArgumentError);
      expect(() => ZhongyiRules.adjustStock(current: 8, change: double.nan), throwsArgumentError);
      expect(() => ZhongyiRules.adjustStock(current: 1, change: -1.1), throwsArgumentError);
    });
  });

  group('收费与退款金额规则', () {
    test('退款不能大于已收且尚未退回的金额', () {
      expect(
        () =>
            ZhongyiRules.validateRefundAmount(paidAmount: 100, refundedAmount: 20, pendingRefundAmount: 30, amount: 51),
        throwsArgumentError,
      );
      expect(
        ZhongyiRules.validateRefundAmount(paidAmount: 100, refundedAmount: 20, pendingRefundAmount: 30, amount: 50),
        50,
      );
    });

    test('支付状态根据实收与退款进度计算', () {
      expect(ZhongyiRules.paymentStatus(total: 100, paid: 0, refunded: 0), 'unpaid');
      expect(ZhongyiRules.paymentStatus(total: 100, paid: 40, refunded: 0), 'partially_paid');
      expect(ZhongyiRules.paymentStatus(total: 100, paid: 100, refunded: 0), 'paid');
      expect(ZhongyiRules.paymentStatus(total: 100, paid: 100, refunded: 20, hasPendingRefund: true), 'refunding');
      expect(ZhongyiRules.paymentStatus(total: 100, paid: 100, refunded: 100), 'refunded');
    });
  });

  group('处方模板药味校验', () {
    test('只接受有正药品 ID 和正剂量的药味', () {
      expect(
        ZhongyiRules.validateTemplateItems([
          {'medicine_id': 3, 'dosage_grams': 10},
        ]),
        [
          {'medicine_id': 3, 'dosage_grams': 10, 'sort_order': 0, 'dosage_unit': 'g'},
        ],
      );
      expect(
        () => ZhongyiRules.validateTemplateItems([
          {'medicine_id': 3, 'dosage_grams': 0},
        ]),
        throwsArgumentError,
      );
      expect(
        () => ZhongyiRules.validateTemplateItems([
          {'medicine_id': -1, 'dosage_grams': 2},
        ]),
        throwsArgumentError,
      );
    });
  });

  group('患者列表完整投影', () {
    test('列表返回所有患者档案字段且不修改原始值', () {
      final patient = {
        'id': 9,
        'name': '测试患者',
        'gender': 2,
        'birth_date': '1990-01-01',
        'phone': '13800000000',
        'occupation': '教师',
        'blood_type': 'A',
        'constitution': '气虚质',
        'source': 'manual',
        'create_time': '2026-10-04T10:00:00.000Z',
        'update_time': '2026-10-04T11:00:00.000Z',
        'id_card': 'sensitive-id',
        'address': 'sensitive-address',
        'emergency_contact': '紧急联系人',
        'emergency_phone': '13900000000',
        'allergy_history': 'sensitive-history',
        'medical_history': 'sensitive-medical-history',
        'family_history': 'sensitive-family-history',
      };

      expect(ZhongyiRules.patientSummary(patient), patient);
    });
  });
}
