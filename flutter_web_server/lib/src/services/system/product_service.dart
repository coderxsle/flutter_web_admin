import 'package:serverpod/serverpod.dart' as sp;
import 'package:serverpod_crud/serverpod_crud.dart';

import 'package:flutter_web_server/src/crud/crud_runtime_factory.dart';
import 'package:flutter_web_server/src/generated/book/book.dart';
import 'package:flutter_web_server/src/services/system/db_audit_service.dart';

class ProductCrudMeta {
  static final CrudEntityMeta<Book, BookTable> instance = CrudEntityMeta<Book, BookTable>(
    descriptor: EntityDescriptor<Book, BookTable>.fromDb(
      db: Book.db,
      table: Book.t,
      idColumn: (t) => t.id as sp.ColumnInt,
      tenantIdColumn: (t) => t.tenantId,
      deletedColumn: (t) => t.isDeleted,
      getId: (m) => m.id,
      setTenantId: (m, tenantId) => m.tenantId = tenantId,
      setDeleted: (m, deleted) => m.isDeleted = deleted,
      columnMap: {
        'id': (t) => t.id,
        'tenantId': (t) => t.tenantId,
        'name': (t) => t.name,
        'isbn': (t) => t.isbn,
        'author': (t) => t.author,
        'keyword': (t) => t.keyword,
        'publisher': (t) => t.publisher,
        'originalPrice': (t) => t.originalPrice,
        'categoryId': (t) => t.categoryId,
        'createTime': (t) => t.createTime,
        'updateTime': (t) => t.updateTime,
      },
      keywordColumns: (t) => [t.name, t.author, t.publisher, t.keyword],
      fieldAliases: {'createdAt': 'createTime', 'updatedAt': 'updateTime'},
    ),
    decodeModel: (data) => data is Book ? data : Book.fromJson(Map<String, dynamic>.from(data as Map)),
    runtime: CrudRuntimeFactory.create(),
    entityName: 'product',
  );
}

class ProductService extends AutoCrudService<Book, BookTable> {
  ProductService() : super(ProductCrudMeta.instance, auditService: const DbAuditService<Book>(type: 'product'));

  
}
