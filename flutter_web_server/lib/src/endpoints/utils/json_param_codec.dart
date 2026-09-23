import 'dart:convert';

/// 「JSON 文本参数」解码失败时抛出。
///
/// 这是服务端内部的中转异常，不直接暴露给客户端：端点方法捕获它之后会转成
/// `CommonResponse.failed('参数不合法：...')`。
class JsonParamFormatException implements Exception {
  const JsonParamFormatException(this.message);

  /// 面向调用方的中文说明（不含「参数不合法」这类统一前缀，由端点补）。
  final String message;

  @override
  String toString() => message;
}

/// 「JSON 文本参数」编解码工具，供 `addByJsonParams` / `updateByJsonParams`
/// 这类以 `String` 形参接收请求体的端点方法共用。
///
/// ## 为什么需要它
///
/// Serverpod 4 对形参声明为 `dynamic` / `Map<String, dynamic>` 的方法，会走
/// `deserializeDynamicFieldValue`，要求线格式**带类型标签**：
///
/// ```json
/// {"className":"Map","data":{"id":{"className":"int","data":2}}}
/// ```
///
/// 也就是每个字段值还要再包一层 `{className, data}`。普通前端 / curl 无法自然构造，
/// 直接传 `{"id":2}` 会抛 `No deserialization found for type named null`，
/// 换成 `Map<String, dynamic>` 只是把报错改成 `got int instead`。
///
/// 因此凡是要接收普通 JSON 对象的端点方法，形参只能声明成 `String`，
/// 把 JSON 文本收进来后用本工具解回 `Map`。
///
/// ## 为什么单独放一个文件
///
/// 1. **不会被注册成路由**。`BaseEndpoint` 是 `Endpoint` 的子类，它上面新增的
///    **公开**方法会被 Serverpod 自动注册成一条 HTTP 路由
///    （`/user/addByJsonParams` 就是这么来的）。把工具方法放进非 Endpoint 的类里，
///    就不存在这个风险。
/// 2. **谁都能复用**，不限于 `BaseEndpoint` 的子类。
/// 3. 纯函数、无副作用，便于单独写单元测试。
class JsonParamCodec {
  const JsonParamCodec._();

  /// 把端点收到的 JSON 文本参数解析成对象 Map。
  ///
  /// - [raw]：端点形参收到的原始字符串
  /// - [paramName]：形参名，仅用于拼错误信息，让报错能指回是哪个参数传错了
  ///
  /// 解析失败时抛 [JsonParamFormatException]，由调用方决定怎么转成业务响应。
  static Map<String, dynamic> decodeObject(String raw, {required String paramName}) {
    final dynamic decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException catch (e) {
      throw JsonParamFormatException('$paramName 不是合法的 JSON 文本（${e.message}）');
    }

    if (decoded is! Map) {
      throw JsonParamFormatException(
        '$paramName 必须是 JSON 对象文本，例如 {"id":2,"deptId":5}',
      );
    }

    return decoded.cast<String, dynamic>();
  }
}
