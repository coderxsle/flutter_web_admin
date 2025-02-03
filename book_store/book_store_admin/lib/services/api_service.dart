import 'package:book_store_client/book_store_client.dart';
import 'package:book_store_shared/book_store_shared.dart';


class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late final Client _client;

  ApiService init() {
    _client = Client('http://localhost:8080/');
    // ..connectivityMonitor = FlutterConnectivityMonitor();
    return this;
  }

  // 登录
  Future<CommonResponse> login(String username, String password) async {
    return await _client.auth.adminLogin(username, password);
  }

  // 获取用户信息
  Future<CommonResponse> getUserInfo() async {
    return await _client.auth.getUserInfo();
  }

  // 刷新token
  Future<CommonResponse> refreshToken() async {
    return await _client.auth.refreshToken();
  }

  // 获取所有图书
  Future<PageResponse<dynamic>> getBooks(int page) async {
    return await _client.book.list(pageNum: page, pageSize: 10);
  }

  // 创建图书
  Future<CommonResponse> createBook(Book book) async {
    return await _client.book.createBook(book);
  }

  // 更新图书
  Future<CommonResponse> updateBook(Book book) async {
    return await _client.book.updateBook(book);
  }

  // 删除图书
  Future<CommonResponse> deleteBook(Book book) async {
    return await _client.book.deleteBook(book);
  }
} 