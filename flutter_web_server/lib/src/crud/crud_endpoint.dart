import 'package:serverpod/serverpod.dart';

// abstract class CrudEndpoint<T> extends Endpoint {
//   @override
//   bool get requireLogin => true;

//   Future<T> create(Session session, T data);

//   Future<T> update(Session session, T data);

//   Future<void> delete(Session session, int id);

//   Future<T?> get(Session session, int id);

//   Future<List<T>> list(Session session);

//   Future<List<T>> listByPage(Session session, int page, int pageSize);
// }