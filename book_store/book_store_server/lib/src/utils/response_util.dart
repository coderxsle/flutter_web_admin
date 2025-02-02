import 'package:book_store_shared/book_store_shared.dart';
import 'package:serverpod/serverpod.dart';

// typedef CommonResponse = Map<String, dynamic>;

// abstract class ResponseUtil {
//   /// 成功返回结果
//   static Map<String, dynamic> success(dynamic data) {
//     return {
//       'code': 0,
//       'message': 'success',
//       'data': data is SerializableModel ? data.toJson() : data,
//     };
//   }

//   /// 失败返回结果
//   static Map<String, dynamic> failed([String? message]) {
//     return {
//       'code': ResultCode.failed.code,
//       'message': message ?? ResultCode.failed.message,
//     };
//   }
// }