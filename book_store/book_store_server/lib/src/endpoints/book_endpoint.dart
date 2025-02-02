import 'package:book_store_server/src/generated/protocol.dart';
import 'package:book_store_shared/book_store_shared.dart';
import 'package:serverpod/server.dart';

class BookEndpoint extends Endpoint {

  /// 创建图书
  Future<CommonResponse> createBook(Session session, Book book) async {
    try {
      final result = await session.db.insertRow(book);
      return CommonResponse.success(result);
    } catch (e) {
      return CommonResponse.failed('创建图书失败：$e');
    }
  }

  /// 更新图书
  Future<CommonResponse> updateBook(Session session, Book book) async {
    try {
      final result = await session.db.updateRow(book);
      return CommonResponse.success(result);
    } catch (e) {
      return CommonResponse.failed('更新图书失败：$e');
    }
  }

  /// 删除图书
  Future<CommonResponse> deleteBook(Session session, Book book) async {
    try {
      final result = await session.db.deleteRow<Book>(book);
      return CommonResponse.success(result);
    } catch (e) {
      return CommonResponse.failed('删除图书失败：$e');
    }
  }

  /// 获取图书
  Future<CommonResponse> getBook(Session session, int id) async {
    try {
      final result = await session.db.findById<Book>(id);
      return CommonResponse.success(result);
    } catch (e) {
      return CommonResponse.failed('获取图书失败：$e');
    }
  }

  /// 获取所有图书
  Future<PageResponse> list(Session session, {
    int pageNum = 1,
    int pageSize = 10,
  }) async {
    try {
      final books = await session.db.find<Book>();
      final start = (pageNum - 1) * pageSize;
      final pagedBooks = books.skip(start).take(pageSize).toList();
      return PageResponse.success(
        pagedBooks,
        pageNum: pageNum,
        pageSize: pageSize,
        total: books.length,
      );
    } catch (e) {
      return PageResponse.error('获取图书列表失败：$e');
    }
  }
}
