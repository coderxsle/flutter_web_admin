import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/product_service.dart';
import 'base_endpoint.dart';

class ProductEndpoint extends AutoCrudEndpoint<Book, BookTable, ProductService> {
  @override
  final ProductService service = ProductService();

  
}
