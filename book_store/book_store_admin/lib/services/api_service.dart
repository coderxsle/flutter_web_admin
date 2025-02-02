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
  Future<PageResponse<dynamic>> getBooks() async {
    try {
      print('开始获取图书列表...');
      final response = await _client.book.list(pageNum: 1, pageSize: 10);
      
      print('服务器响应: ${response?.data}');  // 移除 toJson 调用
      print('响应类型: ${response.runtimeType}');
      
      if (response == null || response.data == null) {
        print('警告：响应数据为空');
        return PageResponse(
          pageNum: 1,
          pageSize: 10,
          total: 0,
          totalPage: 0,
          data: [],
        );
      }
      
      return response;
    } catch (e, stackTrace) {
      print('获取图书列表时发生错误:');
      print('错误类型: ${e.runtimeType}');
      print('错误信息: $e');
      print('堆栈跟踪: $stackTrace');
      
      if (e is TypeError) {
        throw '数据类型错误：$e';
      }
      throw '获取图书列表失败：$e';
    }
  }

  // 创建图书
  Future<CommonResponse> createBook(Book book) async {
    try {
      return await _client.book.createBook(book);
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