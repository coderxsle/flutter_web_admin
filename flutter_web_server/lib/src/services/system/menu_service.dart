import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

class MenuService {


  /// 添加菜单接口
  static Future<CommonResponse> add(Session session, MenuRequest req) async {
    try {
      final authData = session.authenticated;
      if (authData == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final now = DateTime.now();
      final menu = SysMenu(
        id: null,
        title: req.title,
        permission: req.permission,
        type: req.type,
        sort: req.sort,
        parentId: req.parentId,
        breadcrumb: req.breadcrumb,
        path: req.path,
        icon: req.icon,
        component: req.component,
        componentName: req.componentName,
        redirect: req.redirect,
        status: req.status,
        visible: req.visible,
        keepAlive: req.keepAlive,
        alwaysShow: req.alwaysShow,
        activeMenu: req.activeMenu,
        showInTabs: req.showInTabs,
        affix: req.affix,
        creator: authData.userIdentifier,
        createTime: now,
        updater: authData.userIdentifier,
        updateTime: now,
        deleted: false,
      );

      final data = await SysMenu.db.insertRow(session, menu);
      return CommonResponse.success(data);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '添加菜单失败：$e');
    }
  }


  /// 删除菜单（软删除，支持批量）
  ///
  /// [ids] 菜单ID列表
  /// 返回值：处理结果汇总
  static Future<CommonResponse> delete(Session session, List<int> ids) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final normalizedIds = ids.where((id) => id > 0).toSet().toList();
      if (normalizedIds.isEmpty) {
        return CommonResponse.failed('参数不合法：ids 不能为空，且元素必须大于 0');
      }

      final menus = await SysMenu.db.find(
        session,
        where: (t) => t.id.inSet(normalizedIds.toSet()) & t.deleted.equals(false),
      );

      if (menus.isEmpty) {
        return CommonResponse.success({
          'total': normalizedIds.length,
          'successCount': 0,
          'notFoundCount': normalizedIds.length,
        });
      }

      final now = DateTime.now();
      for (final menu in menus) {
        menu.deleted = true;
        menu.updater = authInfo.userIdentifier;
        menu.updateTime = now;
      }
      await SysMenu.db.update(session, menus);

      return CommonResponse.success({
        'total': normalizedIds.length,
        'successCount': menus.length,
        'notFoundCount': normalizedIds.length - menus.length,
      });
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '删除菜单失败：$e');
    }
  }


  /// 更新菜单信息
  ///
  /// [req] 菜单信息（需包含 id）
  static Future<CommonResponse> update(Session session, MenuRequest req) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      final menuId = req.id;
      if (menuId == null || menuId <= 0) {
        return CommonResponse.failed('参数不合法：菜单ID不能为空');
      }

      final existing = await SysMenu.db.findFirstRow(
        session,
        where: (t) => t.id.equals(menuId) & t.deleted.equals(false),
      );
      if (existing == null) {
        return CommonResponse.failed('菜单不存在或已删除');
      }

      if (req.title.trim().isEmpty) {
        return CommonResponse.failed('菜单名称不能为空');
      }

      existing.title = req.title;
      existing.permission = req.permission ?? '';
      existing.type = req.type;
      existing.sort = req.sort ?? 0;
      existing.parentId = req.parentId ?? 0;
      existing.breadcrumb = req.breadcrumb ?? true;
      existing.path = req.path ?? '';
      existing.icon = req.icon;
      existing.component = req.component;
      existing.componentName = req.componentName;
      existing.redirect = req.redirect;
      existing.status = req.status ?? 1;
      existing.visible = req.visible ?? true;
      existing.keepAlive = req.keepAlive ?? true;
      existing.alwaysShow = req.alwaysShow ?? true;
      existing.activeMenu = req.activeMenu;
      existing.showInTabs = req.showInTabs ?? true;
      existing.affix = req.affix ?? false;
      existing.updater = authInfo.userIdentifier;
      existing.updateTime = DateTime.now();

      final updated = await SysMenu.db.updateRow(session, existing);
      return CommonResponse.success(updated);
    } catch (e) {
      return CommonResponse.failed('更新菜单失败：$e');
    }
  }


  /// 获取当前登录用户的菜单树（合并用户所有角色的菜单）
  ///
  /// 返回值：菜单树列表
  static Future<CommonResponse> getMenuOptions(Session session) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      // 1. 查询当前用户
      final authUserId = authInfo.authUserId;
      session.log('getMenuOptions: authUserId=$authUserId');
      final user = await SysUser.db.findFirstRow(session, where: (t) => t.authUserId.equals(authUserId) & t.deleted.equals(false));
      if (user == null || user.id == null) {
        session.log('getMenuOptions: user not found for authUserId=$authUserId');
        return CommonResponse(code: ResultCode.failed.code, message: '用户不存在');
      }
      session.log('getMenuOptions: userId=${user.id}, username=${user.username}');

      // 2. 查询用户角色
      final userRoles = await SysUserRole.db.find(session, where: (t) => t.userId.equals(user.id!) & t.deleted.equals(false));
      session.log('getMenuOptions: userRoles=${userRoles.length}');
      if (userRoles.isEmpty) {
        return CommonResponse.success([]);
      }
      final roleIds = userRoles.map((r) => r.roleId).toSet();
      session.log('getMenuOptions: roleIds=$roleIds');

      // 3. 查询角色分配的菜单ID
      final roleMenus = await SysRoleMenu.db.find(session, where: (t) => t.roleId.inSet(roleIds) & t.deleted.equals(false));
      session.log('getMenuOptions: roleMenus=${roleMenus.length}');
      if (roleMenus.isEmpty) {
        return CommonResponse.success([]);
      }
      final menuIds = roleMenus.map((e) => e.menuId).toSet();
      session.log('getMenuOptions: menuIds=$menuIds');

      // 4. 查询菜单列表（过滤已删除和停用的菜单）
      final menus = await SysMenu.db.find(session, where: (t) => t.id.inSet(menuIds) & t.status.equals(1) & t.deleted.equals(false),
        orderByList: (t) => [
          Order(column: t.sort),
          Order(column: t.id),
        ],
      );
      session.log('getMenuOptions: menus=${menus.length}');

      // 5. 构建菜单树
      final menuTree = _buildMenuTree(menus);
      session.log('getMenuOptions: menuTree length=${menuTree.length}');
      return CommonResponse.success(menuTree);
    } catch (e) {
      session.log('getMenuOptions error: $e');
      return CommonResponse(code: ResultCode.failed.code, message: '获取用户菜单树失败：$e');
    }
  }


  /// 获取菜单列表
  ///
  /// [name] 菜单名称（模糊匹配）
  /// [status] 菜单状态（1=启用，0=停用）
  /// 返回值：菜单列表（按 sort、id 升序）
  static Future<CommonResponse> getList(Session session, [String? name, String? status]) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final trimmedName = name?.trim();
      final menus = await SysMenu.db.find(
        session,
        where: (t) {
          Expression filter = t.deleted.equals(false);

          if (trimmedName != null && trimmedName.isNotEmpty) {
            filter = filter & t.title.like('%$trimmedName%');
          }

          if (status != null && status.isNotEmpty) {
            filter = filter & t.status.equals(int.tryParse(status));
          }

          return filter;
        },
        orderByList: (t) => [
          Order(column: t.sort),
          Order(column: t.id),
        ],
      );

      final menuTree = _buildMenuListTree(menus);
      return CommonResponse.success(menuTree);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取菜单列表失败：$e');
    }
  }


  /// 获取菜单详情
  ///
  /// [id] 菜单ID
  /// 返回值：菜单详情
  static Future<CommonResponse> getDetail(Session session, int id) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      if (id <= 0) {
        return CommonResponse.failed('参数不合法：id 必须大于 0');
      }

      final menu = await SysMenu.db.findFirstRow(
        session,
        where: (t) => t.id.equals(id) & t.deleted.equals(false),
      );

      if (menu == null) {
        return CommonResponse.failed('菜单不存在或已删除');
      }

      return CommonResponse.success(menu);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取菜单详情失败：$e');
    }
  }


  
  /// 构建菜单树（精简字段，用户登录用户的菜单渲染）
  ///
  /// [menus] 菜单列表
  /// [parentId] 父菜单ID
  /// 返回值：菜单树列表
  static List<Map<String, dynamic>> _buildMenuTree(List<SysMenu> menus, {int parentId = 0}) {
    final tree = <Map<String, dynamic>>[];

    for (final menu in menus) {
      if (menu.parentId != parentId) {
        continue;
      }

      final node = <String, dynamic>{
        'id': (menu.id ?? 0).toString(),
        'title': menu.title,
        'type': menu.type,
        'permission': menu.permission,
      };

      final children = _buildMenuTree(menus, parentId: menu.id ?? 0);
      if (children.isNotEmpty) {
        node['children'] = children;
      }

      tree.add(node);
    }

    return tree;
  }

  
  /// 构建菜单树（菜单列表用）
  ///
  /// [menus] 菜单列表
  /// 返回值：菜单树列表
  static List<Map<String, dynamic>> _buildMenuListTree(List<SysMenu> menus) {
    final nodeMap = <int, Map<String, dynamic>>{};
    final roots = <Map<String, dynamic>>[];

    for (final menu in menus) {
      final id = menu.id;
      if (id == null) continue;

      nodeMap[id] = {
        'id': id,
        'title': menu.title,
        'permission': menu.permission,
        'type': menu.type,
        'sort': menu.sort,
        'parentId': menu.parentId,
        'breadcrumb': menu.breadcrumb,
        'path': menu.path,
        'icon': menu.icon,
        'component': menu.component,
        'componentName': menu.componentName,
        'redirect': menu.redirect,
        'status': menu.status,
        'visible': menu.visible,
        'keepAlive': menu.keepAlive,
        'alwaysShow': menu.alwaysShow,
        'activeMenu': menu.activeMenu,
        'showInTabs': menu.showInTabs,
        'affix': menu.affix,
      };
    }

    for (final menu in menus) {
      final id = menu.id;
      if (id == null) continue;

      final node = nodeMap[id];
      if (node == null) continue;

      final parentId = menu.parentId;
      if (parentId == 0 || !nodeMap.containsKey(parentId)) {
        roots.add(node);
      } else {
        (nodeMap[parentId]!['children'] ??= <Map<String, dynamic>>[]).add(node);
      }
    }

    _sortMenuTree(roots);
    return roots;
  }

  /// 排序菜单树
  /// 
  static void _sortMenuTree(List<Map<String, dynamic>> nodes) {
    nodes.sort((a, b) {
      final sortA = (a['sort'] as int?) ?? 0;
      final sortB = (b['sort'] as int?) ?? 0;
      if (sortA != sortB) return sortA.compareTo(sortB);
      final idA = a['id']?.toString() ?? '';
      final idB = b['id']?.toString() ?? '';
      return idA.compareTo(idB);
    });

    for (final node in nodes) {
      final children = node['children'] as List<Map<String, dynamic>>? ?? const [];
      if (children.isNotEmpty) {
        _sortMenuTree(children);
      }
    }
  }



}
