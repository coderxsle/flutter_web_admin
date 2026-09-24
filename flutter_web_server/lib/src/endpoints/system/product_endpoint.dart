import 'package:flutter_web_server/src/services/system/product_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

/// 图书模块的示例 Endpoint。
///
/// ## ⚠️ S5 只做了「退裸」，没有删除
///
/// 它原先继承 `BaseEndpoint<Book, BookTable>` —— 注意类型参数写的是 `Book`
/// 而不是 `Product`（复制粘贴遗留）。`Book` / `BookTable` 只是用来给基类装配
/// 通用 CRUD 的，本类**自己那两个方法完全没用到它们**，所以退成裸 [Endpoint]
/// 后行为不变。
///
/// 同时消失的是继承来的那 6 条路由（`getList` / `update` / `delete` /
/// `deleteBatch` / `addByJsonParams` / `updateByJsonParams`）—— 这个模块是
/// 半成品，typed 侧和 REST 侧都没接，属于上游模板遗留。
class ProductEndpoint extends Endpoint {
  /// 获取产品详情
  ///
  /// ⚠️ 实现是空壳（`ProductService` 直接返回一个固定 `CommonResponse`）。
  Future<CommonResponse> getDetail(Session session, int id) async {
    return ProductService.getDetail(session, id);
  }

  /// 查询价格历史
  ///
  /// ⚠️ 同样是空壳。
  Future<CommonResponse> getPriceList(Session session) async {
    return ProductService.getPriceList(session);
  }
}
