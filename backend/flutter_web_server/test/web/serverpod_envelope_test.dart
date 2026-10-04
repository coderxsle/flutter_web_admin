import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:test/test.dart';

/// [ServerpodEnvelopeBuilder] 的形状测试 —— 它是 S1.5「信封收口」的核心：
/// 业务项目与 CRUD Core 之间只有这一个接缝，REST 的 JSON 长什么样全由它决定。
///
/// ⚠️ 2026-09-26 起三分支同源：「单对象 / 列表」走 `CommonResponse.toJson()`，
/// 「分页」走 `PageResponse.toJson()`（2026-09-24 的摊平分歧已收口到该类），
/// 两者不再各有一套形状。
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

    // 批量删的响应契约：前端 `BatchOperationResult<Id>` 要读 successIds /
    // failedIds 来逐条提示，所以这 5 个字段一个都不能丢。
    //
    // ⚠️ `CrudBatchResult` 是 `SerializableModel` 而不是 `CommonResponse`，
    // 走的是 `CommonResponse.success(...).toJson()` 里 `data is SerializableModel`
    // 那条支路 —— 这条断言就是把它钉住。
    test('CrudBatchResult 作为载荷时 5 个字段完整保留', () {
      final json = envelope.success(
        const CrudBatchResult(
          total: 3,
          successCount: 2,
          notFoundCount: 1,
          successIds: [1, 2],
          failedIds: [3],
        ),
        message: '删除成功',
      );

      expect(json['code'], ResultCode.success.code);
      expect(json['message'], '删除成功');
      expect(json['data'], {
        'total': 3,
        'successCount': 2,
        'notFoundCount': 1,
        'successIds': [1, 2],
        'failedIds': [3],
      });
    });
  });

  group('page（团队式分页信封：分页元信息全部进 data）', () {
    test('data = {records, total, page, pageSize, totalPage}，顶层只剩 code/message', () {
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

      expect(json.keys.toSet(), {'code', 'message', 'data'});
      expect(json['code'], ResultCode.success.code);
      // 分页成功的 message 是空串（PageResponse.restPage 的默认值），
      // 与普通成功的 'succeed' 不同 —— 这是既有行为，别"顺手统一"。
      expect(json['message'], '');
      expect(json['data'], {
        'records': [
          {'id': 1},
        ],
        'total': 15,
        'page': 2,
        'pageSize': 10,
        'totalPage': 2,
      });
    });

    // 2026-09-26 收口：`PageResponse.toJson()` 本身就是信封形状，
    // 信封不再重排，两侧因此**逐字节一致**。
    //
    // 保留这条断言是为了把「同源」钉住 —— 它同时守住两个方向：
    // 前端契约（`data.records` / `data.total`）与 typed 侧形状不再漂移成两套。
    test('与 typed 侧的 PageResponse 形状**一致**（同一份 toJson）', () {
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
      expect((rest['data'] as Map)['total'], 1);
      // 分页元信息不再摊在顶层（摊平是 2026-09-24 前的旧形状）。
      expect(rest.containsKey('total'), isFalse);
    });

    // user / role 的列表、airtable 的三个分页接口都由 Service 直接返回
    // `PageResponse`，走的是 `success()` 里 `data is CommonResponse` 那条支路。
    // 两条支路必须折成同一个形状，否则「同一个 getList 契约」就只是一句口号。
    test('success(PageResponse) 与 page(RestPage) 折成同一形状', () {
      final viaService = PageResponse.restPage(
        data: [
          {'id': 1},
        ],
        page: 3,
        pageSize: 20,
        total: 41,
      );

      expect(
        envelope.success(viaService),
        envelope.page(
          RestPage<Object?>(
            data: [
              {'id': 1},
            ],
            page: 3,
            pageSize: 20,
            total: 41,
          ),
        ),
      );
    });

    test('payload 里的 DateTime 被 JsonCleaner 转成字符串（不会漏给 jsonEncode）', () {
      final json = envelope.page(
        RestPage<Object?>(
          data: [
            {'id': 1, 'createTime': DateTime.utc(2026, 9, 24, 3)},
          ],
          page: 1,
          pageSize: 10,
          total: 1,
        ),
      );

      final data = json['data'] as Map<String, dynamic>;
      final row = (data['records'] as List).single as Map;

      // ⚠️ 具体格式由 `JsonCleaner` 定，是**本地时间**的 `yyyy-MM-dd HH:mm:ss`
      // （不是 ISO），所以这里不钉字符串内容 —— 只钉「它已经不是 DateTime
      // 对象了」，那才是会让 `jsonEncode` 直接抛、REST 变 500 的东西。
      expect(row['createTime'], isA<String>());
      expect(() => encodeEnvelope(json), returnsNormally);
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

  group('httpStatusFor（业务失败的对外状态码口径）', () {
    test('业务失败一律 200 —— 成败只由 body 的 code 表达', () {
      // 400（业务规则拒绝 / 入参非法）、404（读不到）、403（无权限）全压成 200。
      for (final status in [400, 403, 404]) {
        expect(
          envelope.httpStatusFor(RestException(status, 'x')),
          200,
          reason: 'HTTP $status 应被压成 200',
        );
      }
      expect(
        envelope.httpStatusFor(const RestException.badRequest('昵称不能为空')),
        200,
      );
      expect(
        envelope.httpStatusFor(const RestException.notFound('用户不存在或已删除')),
        200,
      );
    });

    test('⚠️ 401 必须放行 —— 前端靠真实 401 触发 refresh token', () {
      // 这条是硬约束：http.ts 的 401 分支在「非 2xx」那一侧，
      // 压成 200 会让登录态无法续期。
      expect(
        envelope.httpStatusFor(const RestException.unauthorized()),
        401,
      );
      expect(envelope.httpStatusFor(RestException(401, 'x')), 401);
    });

    test('body 业务码不受状态码口径影响', () {
      // 压成 200 之后，业务码仍是原样透传的那个。
      const bizFailed = RestException(400, '用户已存在', code: 50000);
      expect(envelope.httpStatusFor(bizFailed), 200);
      expect(
        envelope.failure(bizFailed.message, code: bizFailed.code)['code'],
        50000,
      );
      // 兜底的 HTTP 风格值仍按老规则翻译。
      const notFound = RestException.notFound('用户不存在或已删除');
      expect(envelope.httpStatusFor(notFound), 200);
      expect(
        envelope.failure(notFound.message, code: notFound.code)['code'],
        ResultCode.validateFailed.code,
      );
    });

    test('框架默认实现仍是「HTTP 语义优先」（未被业务项目覆写时不变）', () {
      const plain = PlainEnvelopeBuilder();
      expect(plain.httpStatusFor(RestException(400, 'x')), 400);
      expect(plain.httpStatusFor(const RestException.notFound('x')), 404);
      expect(plain.httpStatusFor(const RestException.unauthorized()), 401);
    });
  });
}
