import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:test/test.dart';

/// [ServerpodEnvelopeBuilder] 的形状测试 —— 它是 S1.5「信封收口」的核心：
/// typed Endpoint 与 REST Route 必须产出**同一份** JSON，否则前端要写两套解析。
///
/// 这些断言不需要数据库、不需要起进程，纯函数式验证。
void main() {
  const envelope = ServerpodEnvelopeBuilder();

  group('success', () {
    test('普通载荷 → {code:20000, message:"succeed", data:…}', () {
      expect(envelope.success({'id': 1, 'name': '张三'}), {
        'code': ResultCode.success.code,
        'message': 'succeed',
        'data': {'id': 1, 'name': '张三'},
      });
    });

    test('复用 CommonResponse 即等于 typed 侧的输出', () {
      final typed = CommonResponse.success({'id': 1}).toJson();
      expect(envelope.success(CommonResponse.success({'id': 1})), typed);
    });

    // 这是最容易写错的一条：Service 已经返回了信封，若再包一层就会变成
    // {code, message, data: {code, message, data}} —— 前端拿不到字段。
    test('载荷本身是 CommonResponse 时直接采用，不再套一层', () {
      final json = envelope.success(CommonResponse.success('pem-string'));
      expect(json['data'], 'pem-string');
      expect(json['data'], isNot(isA<Map>()));
    });

    test('data 为 null 时不输出 data 键（与 typed 一致）', () {
      expect(envelope.success(null, message: '删除成功'), {
        'code': ResultCode.success.code,
        'message': '删除成功',
      });
    });

    test('走 JsonCleaner：剔除 __className__ 与 password', () {
      final json = envelope.success({
        '__className__': 'SysUser',
        'id': 1,
        'password': r'pbkdf2$…',
      });
      expect(json['data'], {'id': 1});
    });
  });

  group('page', () {
    test('分页元信息摊平到顶层，message 是空串（对齐 PageResponse）', () {
      final json = envelope.page(
        RestPage<Object?>(
          data: [
            {'id': 1},
          ],
          page: 2,
          pageSize: 10,
          total: 15,
        ),
      );

      expect(json['code'], ResultCode.success.code);
      expect(json['message'], '');
      expect(json['page'], 2);
      expect(json['pageSize'], 10);
      expect(json['total'], 15);
      expect(json['totalPage'], 2);
      expect(json['data'], [
        {'id': 1},
      ]);
    });

    test('输出与 typed 侧的 PageResponse 逐字节一致', () {
      final rest = envelope.page(
        RestPage<Object?>(
          data: [
            {'id': 1},
          ],
          page: 1,
          pageSize: 10,
          total: 1,
        ),
      );
      final typed = PageResponse.restPage(
        data: [
          {'id': 1},
        ],
        page: 1,
        pageSize: 10,
        total: 1,
      ).toJson();

      expect(rest, typed);
    });
  });

  group('failure', () {
    test('CRUD Core 传来的 HTTP 风格兜底值被翻译成项目业务码', () {
      expect(envelope.failure('x', code: 400)['code'], ResultCode.validateFailed.code);
      expect(envelope.failure('x', code: 401)['code'], ResultCode.unauthorized.code);
      expect(envelope.failure('x', code: 403)['code'], ResultCode.forbidden.code);
      expect(envelope.failure('x', code: 404)['code'], ResultCode.validateFailed.code);
      expect(envelope.failure('x', code: 500)['code'], ResultCode.failed.code);
    });

    test('null → 50000（框架只说“失败了”）', () {
      expect(envelope.failure('boom'), {
        'code': ResultCode.failed.code,
        'message': 'boom',
      });
    });

    test('明确的业务码原样透传（不会与那五个 HTTP 值撞车）', () {
      expect(envelope.failure('用户已存在', code: 50000)['code'], 50000);
      expect(envelope.failure('参数不合法', code: 40400)['code'], 40400);
    });

    test('失败响应不带 data 键', () {
      expect(envelope.failure('x').containsKey('data'), isFalse);
    });
  });
}
