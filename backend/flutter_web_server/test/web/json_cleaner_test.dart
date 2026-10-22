import 'package:flutter_web_server/src/utils/json_cleaner.dart';
import 'package:test/test.dart';

void main() {
  group('JsonCleaner 时间格式化', () {
    test('DateTime 输出 yyyy-MM-dd HH:mm:ss，不做时区换算', () {
      final cleaned = JsonCleaner.clean({
        'createTime': DateTime.utc(2026, 10, 22, 11, 33, 40),
      }) as Map<String, dynamic>;
      expect(cleaned['createTime'], '2026-10-22 11:33:40');
    });

    test('ISO 串同样格式化', () {
      final cleaned = JsonCleaner.clean({
        'chartTime': '2026-10-22T11:33:40.000Z',
      }) as Map<String, dynamic>;
      expect(cleaned['chartTime'], '2026-10-22 11:33:40');
    });

    test('纯日期串和非时间字符串保持原样', () {
      final cleaned = JsonCleaner.clean({
        'birthDate': '2026-10-22',
        'title': '2026-10-22 的排盘',
      }) as Map<String, dynamic>;
      expect(cleaned['birthDate'], '2026-10-22');
      expect(cleaned['title'], '2026-10-22 的排盘');
    });

    test('嵌套列表也处理，并剔除 __className__ / password', () {
      final cleaned = JsonCleaner.clean([
        {
          '__className__': 'SysUser',
          'password': 'x',
          'updateTime': DateTime.utc(2026, 1, 2, 3, 4, 5),
        },
      ]) as List;
      expect(cleaned.first, {'updateTime': '2026-01-02 03:04:05'});
    });
  });
}
