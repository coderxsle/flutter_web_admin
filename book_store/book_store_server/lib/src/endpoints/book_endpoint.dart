import 'package:serverpod/server.dart';
import 'package:book_store_server/src/generated/protocol.dart';

class BookEndpoint extends Endpoint {

  /// 创建图书
  Future<Book> createBook(Session session, Book book) async {
    return await session.db.insertRow(book);
  }

  /// 更新图书
  Future<Book> updateBook(Session session, Book book) async {
    return await session.db.updateRow(book);
  }

  /// 删除图书
  Future<Book?> deleteBook(Session session, Book book) async {
    return await session.db.deleteRow<Book>(book);
  }

  /// 获取图书
  Future<Book?> getBook(Session session, int id) async {
    return await session.db.findById<Book>(id);
  }

  /// 获取所有图书
  Future<List<Book>> getBooks(Session session) async {
    return await session.db.find<Book>();
  }
}
