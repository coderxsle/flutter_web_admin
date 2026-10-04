import 'package:flutter_web_server/src/web/routes/api/zhongyi/zhongyi_patient_template_routes.dart';
import 'package:test/test.dart';

void main() {
  group('患者路由', () {
    test('注册列表、详情、增改删接口且全部要求认证', () {
      final routes = patientActionRoutes();
      expect(
        routes.keys,
        containsAll([
          '/api/lxs_zhongyi/patient/list',
          '/api/lxs_zhongyi/patient/detail/:id',
          '/api/lxs_zhongyi/patient/create',
          '/api/lxs_zhongyi/patient/update/:id',
          '/api/lxs_zhongyi/patient/delete',
        ]),
      );
      expect(routes.values.every((route) => route.requireAuth), isTrue);
    });
  });

  group('处方模板路由', () {
    test('注册列表、详情、增改删和启停接口且全部要求认证', () {
      final routes = prescriptionTemplateActionRoutes();
      expect(
        routes.keys,
        containsAll([
          '/api/lxs_zhongyi/prescription-template/list',
          '/api/lxs_zhongyi/prescription-template/detail/:id',
          '/api/lxs_zhongyi/prescription-template/create',
          '/api/lxs_zhongyi/prescription-template/update/:id',
          '/api/lxs_zhongyi/prescription-template/delete',
          '/api/lxs_zhongyi/prescription-template/:id/status',
        ]),
      );
      expect(routes.values.every((route) => route.requireAuth), isTrue);
    });
  });
}
