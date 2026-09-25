import '../core/crud_models.dart';

/// 协议无关的分页结果。
///
/// 只有四个字段 —— 分页信封长什么样**由业务项目的信封构造器决定**，本类
/// 不预设形状。`totalPage` 现算，不参与传输。
///
/// 与框架内部的 `CrudPage<T>` 的分工：`CrudPage` 是 Service 层的返回契约
/// （`SerializableModel`，服务 typed 协议），本类是 REST 侧交给信封的载荷，
/// 刻意不实现任何序列化接口。
class RestPage<T> {
  const RestPage({ required this.data, this.page = 1, this.pageSize = 20, this.total = 0 });

  /// 从 [CrudPage] 转换。
  factory RestPage.fromCrudPage(CrudPage<T> page) => RestPage<T>(
    data: page.data,
    page: page.page,
    pageSize: page.pageSize,
    total: page.total,
  );

  final List<T> data;
  final int page;
  final int pageSize;
  final int total;

  int get totalPage => pageSize <= 0 ? 0 : (total / pageSize).ceil();

  /// 抹掉载荷的静态类型，交给信封处理。
  RestPage<Object?> toPayload() => RestPage<Object?>(
    data: data,
    page: page,
    pageSize: pageSize,
    total: total,
  );
}
