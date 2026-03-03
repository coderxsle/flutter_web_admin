import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/utils/datetime_utils.dart';
import 'package:flutter_web_shared/shared.dart';

class DeptEndpoint extends Endpoint {
  // @override
  // bool get requireLogin => true;

  /// 获取部门树（按租户过滤，默认系统租户）
  /// 返回结构：id、parentId、name、sort、status、createTime、description、children
  Future<CommonResponse> getList(Session session) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final rows = await SysDept.db.find(
        session,
        where: (t) => t.deleted.equals(false),
        orderByList: (t) => [
          Order(column: t.parentId),
          Order(column: t.sort),
          Order(column: t.id),
        ],
      );

      final nodeMap = <int, Map<String, dynamic>>{};
      final roots = <Map<String, dynamic>>[];

      for (final row in rows) {
        final id = row.id;
        if (id == null) continue;

        nodeMap[id] = {
          'id': id.toString(),
          'parentId': row.parentId?.toString() ?? '',
          'name': row.name ?? '',
          'sort': row.sort ?? 0,
          'status': row.status ?? 0,
          'createTime': DateTimeFormatter.format(row.createTime),
          'description': row.parentId == null ? '本部' : '',
          'children': <Map<String, dynamic>>[],
        };
      }

      for (final row in rows) {
        final id = row.id;
        if (id == null) continue;

        final node = nodeMap[id];
        if (node == null) continue;

        final parentId = row.parentId;
        if (parentId == null || !nodeMap.containsKey(parentId)) {
          roots.add(node);
        } else {
          (nodeMap[parentId]!['children'] as List<Map<String, dynamic>>).add(node);
        }
      }

      _sortTree(roots);
      return CommonResponse.success(roots);
    } catch (e) {
      return CommonResponse(
        code: ResultCode.failed.code,
        message: '获取部门列表失败：$e',
      );
    }
  }

  void _sortTree(List<Map<String, dynamic>> nodes) {
    nodes.sort((a, b) {
      final sortA = (a['sort'] as int?) ?? 0;
      final sortB = (b['sort'] as int?) ?? 0;
      if (sortA != sortB) return sortA.compareTo(sortB);
      final idA = a['id']?.toString() ?? '';
      final idB = b['id']?.toString() ?? '';
      return idA.compareTo(idB);
    });

    for (final node in nodes) {
      final children = node['children'] as List<Map<String, dynamic>>;
      if (children.isNotEmpty) {
        _sortTree(children);
      }
    }
  }
}

