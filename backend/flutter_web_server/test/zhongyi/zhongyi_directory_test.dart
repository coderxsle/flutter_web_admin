import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_directory_service.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:flutter_web_server/src/web/routes/api/zhongyi/directory_routes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  group('科室与员工目录路由', () {
    const expectedMethods = <String, Set<Method>>{
      '/api/lxs_zhongyi/department/list': {Method.get},
      '/api/lxs_zhongyi/department/tree': {Method.get},
      '/api/lxs_zhongyi/department/detail/:id': {Method.get},
      '/api/lxs_zhongyi/department/create': {Method.post},
      '/api/lxs_zhongyi/department/update/:id': {Method.put},
      '/api/lxs_zhongyi/department/delete': {Method.delete},
      '/api/lxs_zhongyi/staff/list': {Method.get},
      '/api/lxs_zhongyi/staff/detail/:id': {Method.get},
      '/api/lxs_zhongyi/staff/create': {Method.post},
      '/api/lxs_zhongyi/staff/update/:id': {Method.put},
      '/api/lxs_zhongyi/staff/delete': {Method.delete},
    };

    test('包含所有科室与员工操作，路径方法、鉴权及信封均明确', () {
      final routes = zhongyiDirectoryActionRoutes();

      expect(routes.keys.toSet(), expectedMethods.keys.toSet());
      for (final entry in expectedMethods.entries) {
        final route = routes[entry.key]!;
        expect(route.methods, entry.value, reason: entry.key);
        expect(route.requireAuth, isTrue, reason: entry.key);
        expect(route.envelope, isA<ServerpodEnvelopeBuilder>(), reason: entry.key);
      }
    });

    test('全部动作路径可挂载且字面量与 id 参数都能命中', () {
      final app = RelicRouter();
      zhongyiDirectoryActionRoutes().forEach(app.injectAt);

      final concretePaths = <(Method, String)>[
        (Method.get, '/api/lxs_zhongyi/department/list'),
        (Method.get, '/api/lxs_zhongyi/department/tree'),
        (Method.get, '/api/lxs_zhongyi/department/detail/7'),
        (Method.post, '/api/lxs_zhongyi/department/create'),
        (Method.put, '/api/lxs_zhongyi/department/update/7'),
        (Method.delete, '/api/lxs_zhongyi/department/delete'),
        (Method.get, '/api/lxs_zhongyi/staff/list'),
        (Method.get, '/api/lxs_zhongyi/staff/detail/8'),
        (Method.post, '/api/lxs_zhongyi/staff/create'),
        (Method.put, '/api/lxs_zhongyi/staff/update/8'),
        (Method.delete, '/api/lxs_zhongyi/staff/delete'),
      ];

      for (final (method, path) in concretePaths) {
        expect(app.lookupUri(method, Uri.parse(path)), isA<RouterMatch>(), reason: '$method $path');
        expect(app.lookupUri(Method.options, Uri.parse(path)), isA<RouterMatch>(), reason: 'OPTIONS $path');
      }
    });
  });

  group('科室树与输出字段', () {
    test('树按排序构建，并把孤立父节点的记录提升为根节点', () {
      final rows = [
        ZhongyiDepartment(id: 4, tenantId: 99, name: '儿科', code: 'PED', parentId: 2, sortOrder: 2),
        ZhongyiDepartment(id: 3, tenantId: 99, name: '内科', code: 'INT', parentId: 0, sortOrder: 2),
        ZhongyiDepartment(id: 2, tenantId: 99, name: '门诊部', code: 'CLINIC', parentId: 0, sortOrder: 1),
        ZhongyiDepartment(id: 5, tenantId: 99, name: '眼科', code: 'EYE', parentId: 404, sortOrder: 1),
      ];

      final tree = ZhongyiDirectoryService.buildDepartmentTree(rows);

      expect(tree.map((node) => node['id']), [2, 5, 3]);
      expect((tree.first['children'] as List).single['id'], 4);
      expect(tree.first.keys, containsAll(['parent_id', 'sort_order', 'is_active', 'children']));
      expect(tree.first.keys, isNot(contains('tenant_id')));
      expect(tree.first.keys, isNot(contains('deleted')));
    });

    test('员工输出使用 snake_case 且不扩展返回用户个人资料', () {
      final staff = ZhongyiStaff(
        id: 12,
        tenantId: 99,
        userId: 31,
        departmentId: 4,
        employeeCode: 'EMP-12',
        professionalTitle: '主治医师',
        licenseNumber: 'LIC-123',
        isDoctor: true,
      );

      final result = ZhongyiDirectoryService.staffToJson(staff);

      expect(result['employee_code'], 'EMP-12');
      expect(result['user_id'], 31);
      expect(result['is_doctor'], isTrue);
      expect(result.keys, isNot(contains('tenant_id')));
      expect(result.keys, isNot(contains('deleted')));
      expect(result.keys, isNot(contains('phone')));
      expect(result.keys, isNot(contains('email')));
      expect(result.keys, isNot(contains('password')));
    });
  });
}
