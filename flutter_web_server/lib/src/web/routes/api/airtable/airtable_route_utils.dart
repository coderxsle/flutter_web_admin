/// airtable REST 路由组内部的公共取值工具。
///
/// ## 为什么单独一个文件
///
/// 这里的两个函数都**只对 airtable 有意义**：
/// * [paginationOf] 把 query 里散着写的 `page` / `pageSize` / `keyword` 收成一个
///   `Pagination` 对象。A 档资源走的是框架 `_ListRoute` 内部那一套
///   （`BaseRestRoute` 里自带），airtable 是手写路由，得自己来。
/// * [intOrNull] 只用来读「可选正整数」入参（`index`）。
///
/// 放进 `rest_delegate_utils.dart` 会把 `Request` 这个 HTTP 类型带进那个
/// 纯翻译工具库，反而是污染，所以留在 airtable 目录下。
library;

import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 从 query 组一个 `Pagination`。
///
/// 认三种写法，容忍度与框架的 `_ListRoute` 一致：
/// * `page`（默认 1）
/// * `pageSize`，兼容下划线写法 `page_size`（默认 20）
/// * `keyword`（可为空）
///
/// ⚠️ `pageSize` 的服务端上限由 Service 决定，这里**不做 clamp** ——
/// airtable 这一支本来就没有上限，加了会变成行为变化。
Pagination paginationOf(Request request) => Pagination(
  page: request.queryInt('page') ?? 1,
  pageSize: request.queryInt('pageSize') ?? request.queryInt('page_size') ?? 20,
  keyword: request.queryString('keyword'),
);

/// 读一个可选的正整数：非数字 / `<= 0` / 缺失都返回 `null`。
int? intOrNull(Object? value) {
  final parsed = asIntOrNull(value);
  if (parsed == null || parsed <= 0) return null;
  return parsed;
}
