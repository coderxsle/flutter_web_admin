import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:test/test.dart';

/// [rest_delegate_utils] 的纯函数测试。
///
/// 重点是 **PATCH 语义**：本项目的 Service 更新方法全是「全量覆盖」，
/// 所以「请求体里没出现的字段」必须靠 delegate 从基线补齐。判断「有没有出现」
/// 只能用 `Map.containsKey` —— 用 `?? fallback` 会让客户端**显式传 null**
/// （清空备注）被静默忽略。这一组断言就是把这个区别钉住。
void main() {
  group('取值 / 校验', () {
    test('trimmedString：空白与 null 都算「没填」', () {
      expect(trimmedString(null), isNull);
      expect(trimmedString(''), isNull);
      expect(trimmedString('   '), isNull);
      expect(trimmedString('  张三 '), '张三');
      expect(trimmedString(12), '12');
    });

    test('requiredText：缺失或空白 → 400，而不是让模型构造函数抛出 500', () {
      for (final body in <Map<String, dynamic>>[
        <String, dynamic>{},
        {'name': null},
        {'name': ''},
        {'name': '  '},
      ]) {
        expect(
          () => requiredText(body, 'name'),
          throwsA(
            isA<RestException>().having((e) => e.httpStatus, 'httpStatus', 400),
          ),
          reason: 'body=$body',
        );
      }
      expect(requiredText({'name': ' 研发部 '}, 'name'), '研发部');
    });

    test('requiredInt：非数字 → 400', () {
      expect(
        () => requiredInt({'type': 'abc'}, 'type'),
        throwsA(isA<RestException>()),
      );
      expect(requiredInt({'type': '2'}, 'type'), 2);
      expect(requiredInt({'type': 3}, 'type'), 3);
    });

    test('asBoolOrNull：容忍 true / "true" / 1 / "1" 这类前端写法', () {
      expect(asBoolOrNull(true), isTrue);
      expect(asBoolOrNull('true'), isTrue);
      expect(asBoolOrNull('TRUE'), isTrue);
      expect(asBoolOrNull(1), isTrue);
      expect(asBoolOrNull('1'), isTrue);
      expect(asBoolOrNull(false), isFalse);
      expect(asBoolOrNull('0'), isFalse);
      expect(asBoolOrNull('随便'), isNull);
      expect(asBoolOrNull(null), isNull);
    });

    test('asIntListOrNull：丢弃非法元素，非 List 返回 null', () {
      expect(asIntListOrNull([1, '2', 3]), [1, 2, 3]);
      expect(asIntListOrNull([1, 'x', null]), [1]);
      expect(asIntListOrNull('1,2'), isNull);
      expect(asIntListOrNull(null), isNull);
    });

    test('normalizedIntList：比 asIntListOrNull 宽松 —— 单值也收、去重、滤掉非正数', () {
      expect(normalizedIntList([3, 1, 3, 2]), [3, 1, 2]); // 去重且保持原顺序
      expect(normalizedIntList(1), [1]); // 单值
      expect(normalizedIntList('2'), [2]); // 字符串单值
      expect(normalizedIntList(['1', 2]), [1, 2]);
      expect(normalizedIntList([0, -1, 5]), [5]); // 非正数被丢弃
      expect(normalizedIntList(null), isEmpty);
      expect(normalizedIntList('abc'), isEmpty);
    });

    // 这一组是 S3 新增的：动作路由的批量入参（resetPassword / cancelUserRoles）
    // 必须自己挡「压根没传」，否则会变成「操作成功但一个都没处理」的 200。
    test('requiredIntList：缺失 / 空数组 / 全非法 → 400', () {
      for (final body in <Map<String, dynamic>>[
        <String, dynamic>{},
        {'ids': null},
        {'ids': <int>[]},
        {'ids': [0, -3]},
        {'ids': ['x']},
      ]) {
        expect(
          () => requiredIntList(body, 'ids'),
          throwsA(
            isA<RestException>().having((e) => e.httpStatus, 'httpStatus', 400),
          ),
          reason: 'body=$body',
        );
      }
    });

    test('requiredIntList：正常取到，并按 aliases 兼容下划线写法', () {
      expect(requiredIntList({'ids': [3, 1, 3]}, 'ids'), [3, 1]);
      expect(requiredIntList({'id': 7}, 'ids', aliases: ['id']), [7]);
      expect(
        requiredIntList({'user_ids': [4, 5]}, 'userIds', aliases: ['user_ids']),
        [4, 5],
      );
      // 主键名优先：两个都传时用 camelCase 那个
      expect(
        requiredIntList(
          {'userIds': [1], 'user_ids': [2]},
          'userIds',
          aliases: ['user_ids'],
        ),
        [1],
      );
    });
  });

  group('PATCH 语义（containsKey，不是 ??）', () {
    test('key 没出现 → 用基线值', () {
      expect(patchText({}, 'description', '旧备注'), '旧备注');
      expect(patchInt({}, 'sort', 7), 7);
      expect(patchBool({}, 'visible', true), isTrue);
      expect(patchIntList({}, 'ids', [1, 2]), [1, 2]);
    });

    test('key 出现且为新值 → 覆盖', () {
      expect(patchText({'description': '新'}, 'description', '旧'), '新');
      expect(patchInt({'sort': 9}, 'sort', 7), 9);
      expect(patchBool({'visible': false}, 'visible', true), isFalse);
      expect(patchIntList({'ids': [3]}, 'ids', [1, 2]), [3]);
    });

    // 这条是这个 group 存在的理由：显式传 null 是「清空」，
    // 必须有别于「没传」。用 `?? fallback` 实现就会退化。
    test('key 出现且为 null / 空串 → 清空（不能退回基线）', () {
      expect(patchText({'description': null}, 'description', '旧备注'), isNull);
      expect(patchText({'description': ''}, 'description', '旧备注'), isNull);
    });

    test('key 出现但值非法 → 得到 null（由上层决定，而不是静默退回基线）', () {
      expect(patchInt({'sort': 'abc'}, 'sort', 7), isNull);
      expect(patchBool({'visible': 'maybe'}, 'visible', true), isNull);
    });
  });

  group('失败判定', () {
    test('ensureOk：成功原样返回，失败抛 400 并透传业务码', () {
      final ok = CommonResponse.success({'id': 1});
      expect(ensureOk(ok), same(ok));

      expect(
        () => ensureOk(CommonResponse.failed('名称已存在')),
        throwsA(
          isA<RestException>()
              .having((e) => e.httpStatus, 'httpStatus', 400)
              .having((e) => e.message, 'message', '名称已存在')
              .having((e) => e.code, 'code', ResultCode.failed.code),
        ),
      );
    });

    test('requireFound：读不到 → 404；读到则返回载荷', () {
      final row = {'id': 1, 'name': '研发部'};
      expect(
        requireFound<Map<String, dynamic>>(CommonResponse.success(row), '部门'),
        same(row),
      );

      // Service 失败
      expect(
        () => requireFound<Map<String, dynamic>>(
          CommonResponse.failed('部门不存在或已删除'),
          '部门',
        ),
        throwsA(
          isA<RestException>()
              .having((e) => e.httpStatus, 'httpStatus', 404)
              .having((e) => e.message, 'message', '部门不存在或已删除'),
        ),
      );

      // 成功但载荷类型不对（等于「拿不到」）
      expect(
        () => requireFound<Map<String, dynamic>>(
          CommonResponse.success('既不是 Map 也不是模型'),
          '部门',
        ),
        throwsA(
          isA<RestException>().having((e) => e.httpStatus, 'httpStatus', 404),
        ),
      );
    });
  });
}
