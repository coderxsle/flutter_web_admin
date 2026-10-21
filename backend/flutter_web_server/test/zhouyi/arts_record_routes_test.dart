import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:flutter_web_server/src/web/routes/api/zhouyi/arts_record_routes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  const expectedPaths = <String>{
    '/api/lxs_arts/record/list',
    '/api/lxs_arts/record/detail/:id',
    '/api/lxs_arts/record/save',
    '/api/lxs_arts/record/update/:id',
    '/api/lxs_arts/record/delete',
    '/api/lxs_arts/record/status',
  };

  test('术数排盘记录接口全部挂载且必须鉴权', () {
    final routes = artsRecordActionRoutes();

    expect(routes.keys.toSet(), expectedPaths);
    for (final entry in routes.entries) {
      expect(entry.key, startsWith('/api/lxs_arts/'));
      expect(entry.value.requireAuth, isTrue, reason: entry.key);
      expect(entry.value.envelope, isA<ServerpodEnvelopeBuilder>(), reason: entry.key);
    }

    final app = RelicRouter();
    routes.forEach(app.injectAt);
    for (final entry in routes.entries) {
      final concretePath = entry.key.replaceAll(':id', '17');
      for (final method in entry.value.methods) {
        expect(app.lookupUri(method, Uri.parse(concretePath)), isA<RouterMatch>(), reason: '$method $concretePath');
      }
    }
  });
}
