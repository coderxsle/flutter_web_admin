
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

class ProductService {
  

  static Future<CommonResponse> getDetail(Session session, int id) async {
    return CommonResponse(code: 20000, message: "message");
  }

  static Future<CommonResponse> getPriceList(Session session) async {
    return CommonResponse(code: 20000, message: "message");
  }
}
