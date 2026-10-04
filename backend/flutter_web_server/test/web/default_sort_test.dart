import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:test/test.dart';

/// 列表**默认排序**的离线断言 —— 不需要 Serverpod 实例、不需要 DB。
///
/// `QueryEngine.pageQuery` 只在显式 `sort` 为空时才用 `defaultSort`，这里钉住的
/// 是「默认排序怎么推导」这一步：它就是 `GET /api/book/getList` 最新在前的依据。
void main() {
  group('BaseService.deriveDefaultSort', () {
    test('有 updateTime：updateTime desc + id desc', () {
      expect(BaseService.deriveDefaultSort(Book.t), const [
        QuerySort(field: 'updateTime', order: 'desc'),
        QuerySort(field: 'id', order: 'desc'),
      ]);
    });

    test('没有 updateTime 时退到 createTime', () {
      expect(BaseService.deriveDefaultSort(SysOperateLog.t), const [
        QuerySort(field: 'createTime', order: 'desc'),
        QuerySort(field: 'id', order: 'desc'),
      ]);
    });

    test('两个时间列都没有就不排序（返回 null，保持原行为）', () {
      expect(BaseService.deriveDefaultSort(AirTables.t), isNull);
    });
  });
}
