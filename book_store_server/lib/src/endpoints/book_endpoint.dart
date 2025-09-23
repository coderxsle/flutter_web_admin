import 'package:book_store_server/src/generated/protocol.dart';
import 'package:book_store_shared/book_store_shared.dart';
import 'package:serverpod/serverpod.dart';

class BookEndpoint extends Endpoint {

  /// 创建图书
  Future<CommonResponse> createBook(Session session, Book book) async {
    try {
      final result = await Book.db.insertRow(session, book);
      return CommonResponse.success(result);
    } catch (e) {
      return CommonResponse.failed('创建图书失败：$e');
    }
  }

  /// 更新图书
  Future<CommonResponse> updateBook(Session session, Book book) async {
    try {
      final result = await Book.db.updateRow(session, book);
      return CommonResponse.success(result);
    } catch (e) {
      return CommonResponse.failed('更新图书失败：$e');
    }
  }

  /// 删除图书
  Future<CommonResponse> deleteBook(Session session, Book book) async {
    try {
      book.isDeleted = true;
      final result = await Book.db.updateRow(session, book);
      return CommonResponse.success(result);
    } catch (e) {
      return CommonResponse.failed('删除图书失败：$e');
    }
  }

  /// 获取图书
  Future<CommonResponse> getBook(Session session, int id) async {
    try {
      final result = await Book.db.findById(session, id);
      return CommonResponse.success(result);
    } catch (e) {
      return CommonResponse.failed('获取图书失败：$e');
    }
  }

  /// 获取所有图书
  Future<PageResponse> list(Session session, {int pageNum = 1, int pageSize = 10}) async {
    try {
      final total = await Book.db.count(session);
      final skip = (pageNum - 1) * pageSize;
      final books = await Book.db.find(
        session,
        limit: pageSize,
        offset: skip,
        orderBy: (t) => t.updateTime,
        orderDescending: true,
        where: (t) => t.isDeleted.equals(false),
      );
      final pagedBooks = PageResponse.success(
        books,
        pageNum: pageNum,
        pageSize: pageSize,
        total: total,
      );

      LoggerTool.jsonFormat(pagedBooks);

      logger.i('服务器已成功返回：PageResponse 模型');

      return pagedBooks;
    } catch (e) {
      return PageResponse.error('获取图书列表失败：$e');
    }
  }
}
