import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/utils/datetime_utils.dart';
import 'package:flutter_web_shared/shared.dart';

/// 规则相关接口
///
/// 当前仅提供一个基础的列表查询接口，后续可以根据具体业务补充
/// 创建、编辑、删除等方法，并接入真实数据库模型。
class RoleEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 获取角色（规则）列表
  ///
  /// 当前根据 `sys_role` 表返回所有「未删除」的角色记录，
  /// 如需按租户或状态过滤，可后续扩展参数。
  Future<CommonResponse> getList(Session session) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final roles = await SysRole.db.find(
        session,
        where: (t) => t.deleted.equals(false),
        orderByList: (t) => [
          Order(column: t.sort),
          Order(column: t.id),
        ],
      );

      // 前端需要根据 type 控制是否可编辑：
      // 约定：type = 1 为系统内置角色（不可编辑），type = 2 为自定义角色（可编辑）
      final list = roles.map((role) {
        final json = role.toJsonForProtocol();
        json['disabled'] = role.type == 1;

        // 处理时间格式：统一转为本地时间字符串，方便前端展示
        json['createTime'] = DateTimeFormatter.format(role.createTime);
        json['updateTime'] = DateTimeFormatter.format(role.updateTime);

        return json;
      }).toList();

      return CommonResponse.success(list);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取角色列表失败：$e');
    }
  }
}

