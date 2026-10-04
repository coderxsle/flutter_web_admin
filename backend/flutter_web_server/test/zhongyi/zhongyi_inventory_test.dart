import 'package:flutter_web_server/src/services/zhongyi/zhongyi_inventory_service.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/web/routes/api/zhongyi/medicine_inventory_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  group('药品与库存路由契约', () {
    test('兼容前端药品、价格、库存与流水路径', () {
      final routes = zhongyiMedicineInventoryRoutes();

      expect(routes.keys.toSet(), {
        '/api/lxs_zhongyi/medicine/list',
        '/api/lxs_zhongyi/medicine/options',
        '/api/lxs_zhongyi/medicine/detail/:id',
        '/api/lxs_zhongyi/medicine/create',
        '/api/lxs_zhongyi/medicine/update/:id',
        '/api/lxs_zhongyi/medicine/delete',
        '/api/lxs_zhongyi/medicine/:id/prices',
        '/api/lxs_zhongyi/inventory/list',
        '/api/lxs_zhongyi/inventory/detail/:id',
        '/api/lxs_zhongyi/inventory/stock-in',
        '/api/lxs_zhongyi/inventory/adjust',
        '/api/lxs_zhongyi/inventory/transaction/list',
      });
    });

    test('药品价格同一路径同时支持 GET / POST，且所有接口要求鉴权和项目响应信封', () {
      final routes = zhongyiMedicineInventoryRoutes();
      final prices = routes['/api/lxs_zhongyi/medicine/:id/prices']!;

      expect(prices.methods, {Method.get, Method.post});
      for (final entry in routes.entries) {
        expect(entry.value.requireAuth, isTrue, reason: entry.key);
        expect(entry.value.envelope, isA<ServerpodEnvelopeBuilder>(), reason: entry.key);
      }
    });
  });

  group('库存与价格校验', () {
    test('入库数量必须是有限正数，价格允许零但不能为负或非有限值', () {
      expect(ZhongyiInventoryService.validateStockInQuantity(2.5), 2.5);
      expect(ZhongyiInventoryService.validateMedicinePrice(0), 0);
      expect(() => ZhongyiInventoryService.validateStockInQuantity(0), throwsArgumentError);
      expect(() => ZhongyiInventoryService.validateStockInQuantity(double.infinity), throwsArgumentError);
      expect(() => ZhongyiInventoryService.validateMedicinePrice(-0.1), throwsArgumentError);
      expect(() => ZhongyiInventoryService.validateMedicinePrice(double.nan), throwsArgumentError);
    });

    test('库存调整允许增减但拒绝零变化、非有限输入和负库存', () {
      expect(ZhongyiInventoryService.stockAfterChange(current: 8, change: 2.5), 10.5);
      expect(ZhongyiInventoryService.stockAfterChange(current: 8, change: -3), 5);
      expect(() => ZhongyiInventoryService.stockAfterChange(current: 1, change: -1.1), throwsArgumentError);
      expect(() => ZhongyiInventoryService.stockAfterChange(current: 8, change: 0), throwsArgumentError);
      expect(() => ZhongyiInventoryService.stockAfterChange(current: 8, change: double.nan), throwsArgumentError);
    });
  });

  group('snake_case 响应', () {
    test('药品模型输出 FastapiAdmin 所用字段名，且性味归经从 JSON 字符串还原为对象', () {
      final json = ZhongyiInventoryService.medicineToMap(
        ZhongyiMedicine(
          id: 12,
          tenantId: 99,
          medicineCode: 'M001',
          prefix: '炒',
          name: '白术',
          pinyin: 'baizhu',
          propertiesJson: '{"nature":"温"}',
        ),
      );

      expect(json['medicine_code'], 'M001');
      expect(json['prefix'], '炒');
      expect(json['name'], '白术');
      expect(json.containsKey('base_name'), isFalse);
      expect(json['properties'], {'nature': '温'});
      expect(json.containsKey('tenantId'), isFalse);
    });

    test('药品展示名为「前缀 + 基名」，无前缀时只显示基名', () {
      expect(
        ZhongyiInventoryService.medicineDisplayName(
          ZhongyiMedicine(id: 1, medicineCode: 'M001', prefix: '炙', name: '黄芪', tenantId: 0),
        ),
        '炙黄芪',
      );
      expect(
        ZhongyiInventoryService.medicineDisplayName(
          ZhongyiMedicine(id: 2, medicineCode: 'M002', name: '当归', tenantId: 0),
        ),
        '当归',
      );
    });

    test('库存批次响应使用 snake_case，并把药品展示名作为非数据库字段回填', () {
      final json = ZhongyiInventoryService.inventoryToMap(
        ZhongyiMedicineInventory(
          id: 7,
          medicineId: 12,
          batchNumber: 'B-2026',
          supplierId: 3,
          quantityG: 500,
          unit: 'g',
          purchasePrice: 0.09,
          productionDate: DateTime(2026, 1, 2),
          expiryDate: DateTime(2027, 1, 2),
          storageLocation: 'A-01',
          description: '首营批次',
        ),
        medicineName: '炙黄芪',
      );

      expect(json['medicine_id'], 12);
      expect(json['medicine_name'], '炙黄芪');
      expect(json['batch_number'], 'B-2026');
      expect(json['supplier_id'], 3);
      expect(json['quantity_g'], 500);
      expect(json['purchase_price'], 0.09);
      expect(json['storage_location'], 'A-01');
      expect(json['is_exhausted'], isFalse);
      expect(json['description'], '首营批次');
      expect(json.containsKey('tenantId'), isFalse);
    });

    test('库存变动流水响应使用 snake_case', () {
      final json = ZhongyiInventoryService.transactionToMap(
        ZhongyiInventoryTransaction(
          id: 4,
          tenantId: 8,
          medicineId: 12,
          inventoryId: 9,
          batchNumber: 'B-1',
          transactionType: 'stock_in',
          quantityChangeG: 3,
          quantityBeforeG: 2,
          quantityAfterG: 5,
        ),
      );

      expect(json['medicine_id'], 12);
      expect(json['inventory_id'], 9);
      expect(json['quantity_change'], 3);
      expect(json['quantity_before'], 2);
      expect(json['quantity_after'], 5);
      expect(json.containsKey('tenantId'), isFalse);
    });
  });
}
