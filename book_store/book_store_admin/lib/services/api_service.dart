import 'package:book_store_client/book_store_client.dart';


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
  Future<dynamic> login(String username, String password) async {
    try {
      final response = await _client.auth.adminLogin(username, password);
      if (response.isSuccess) {
        return response;
      }
      throw '登录失败';
    } catch (e) {
      throw '登录失败：$e';
    }
  }

  // 获取用户信息
  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      // TODO: 实现获取用户信息的接口
      return {};
    } catch (e) {
      throw '获取用户信息失败：$e';
    }
  }

  // 刷新token
  Future<String> refreshToken() async {
    try {
      // TODO: 实现刷新token的接口
      return '';
    } catch (e) {
      throw '刷新token失败：$e';
    }
  }

  // 获取所有图书
  Future<List<Book>> getBooks() async {
    try {
      final response = await _client.book.list(pageNum: 1, pageSize: 10);
      if (response.isSuccess && response.data != null) {
        return response.data!.data;
      }
      throw '获取图书列表失败：${response.code}';
    } catch (e) {
      throw '获取图书列表失败：$e';
    }
  }

  // 创建图书
  Future<Book> createBook(Book book) async {
    try {
      final response = await _client.book.createBook(book);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      }
      throw '创建图书失败：${response.code}';
    } catch (e) {
      throw '创建图书失败：$e';
    }
  }

  // 更新图书
  Future<Book> updateBook(Book book) async {
    try {
      final response = await _client.book.updateBook(book);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      }
      throw '更新图书失败：${response.code}';
    } catch (e) {
      throw '更新图书失败：$e';
    }
  }

  // 删除图书
  Future<Book?> deleteBook(Book book) async {
    try {
      final response = await _client.book.deleteBook(book);
      if (response.isSuccess && response.data != null) {
        return response.data!;
      }
      throw '删除图书失败：${response.code}';
    } catch (e) {
      throw '删除图书失败：$e';
    }
  }
} 