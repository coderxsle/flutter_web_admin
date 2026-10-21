import 'package:http_manager/http_manager.dart';

/// 术数排盘记录接口，与 backend/flutter_web_server 的 `/api/lxs_arts/record` 一一对应。
///
/// 写入口只有一个 [save]：按 `client_key` 幂等，排盘先落一条、之后补卦解/反馈
/// 再上报同一次，服务端覆盖同一行，不会产生重复记录。
class ArtsRecordRequest {
  static const String base = '/api/lxs_arts/record';

  /// 新增或覆盖一条记录
  static Future<ResponseAnalyzed> save(Map<String, dynamic> body) async {
    return await httpManager.postAnalyzing('$base/save', params: body);
  }

  /// 分页查询，返回 `{records, total, page, pageSize, totalPage}` 的标准信封
  static Future<ResponseAnalyzed> fetch({
    required String artsType,
    int page = 1,
    int pageSize = 20,
    String keyword = '',
  }) async {
    return await httpManager.getAnalyzing('$base/list', params: {
      'page': page,
      'pageSize': pageSize,
      'arts_type': artsType,
      if (keyword.trim().isNotEmpty) 'keyword': keyword.trim(),
    });
  }

  /// 批量删除（软删，服务端置 deleted=true）
  static Future<ResponseAnalyzed> remove(List<int> ids) async {
    return await httpManager.postAnalyzing('$base/delete', params: {'ids': ids});
  }
}
