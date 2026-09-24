import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

import 'crud_engines.dart';

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

      // 收敛（决策 4）：插入走 BaseService.create。
      final data = await SystemCrudEngines.menu.create(session, menu);
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

      // 收敛（决策 4）：软删走 BaseService.deleteBatch，统计直接取 CrudBatchResult。
      //
      // ⚠️ 行为变更：deleteBatch 只收 id、拿不到实体，**不维护**
      // updater / updateTime（原实现在这里会写这两个字段）。
      final batch = await SystemCrudEngines.menu.deleteBatch(session, normalizedIds);

      // 直接把 CrudBatchResult 交出去（不再手抄成 {total, successCount,
      // notFoundCount} 的 Map）：REST 侧 `POST /deleteBatch` 的响应契约需要
      // `successIds` / `failedIds` 供前端逐条提示，抄一半的 Map 会让那两个
      // 字段恒为空 —— 前端 user/index.vue 的「N 条不存在」就是这么没显示出来的。
      return CommonResponse.success(batch);
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

      // 收敛（决策 4）：读取基线改走 BaseService.get（含租户 + 软删过滤）。
      final existing = await SystemCrudEngines.menu.get(session, menuId);
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

      // 收敛（决策 4）：写回走 BaseService.update（先按 id+tenantId+deleted=false 复核基线）。
      final updated = await SystemCrudEngines.menu.update(session, existing);
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
          t.sort.asc(),
          t.id.asc(),
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
      // 收敛（决策 4）：全表查询走 findAllByEngine（引擎负责租户 + 软删）。
      //
      // ⚠️ 行为变更：旧实现没有租户条件，收敛后按 session.tenantId 过滤
      // （`sys_menu.tenantId` 是 2026-09-24 才补上的列）。
      // ⚠️ 不要换成 getList：分页语义会把整棵菜单树截断。
      final menus = await findAllByEngine(
        SystemCrudEngines.menu,
        session,
        where: (t) {
          final conditions = <Expression>[
            if (trimmedName != null && trimmedName.isNotEmpty)
              t.title.like('%$trimmedName%'),
            if (status != null && status.isNotEmpty)
              t.status.equals(int.tryParse(status)),
          ];
          if (conditions.isEmpty) return null;
          return conditions.reduce((a, b) => a & b);
        },
        orderByList: (t) => [
          t.sort.asc(),
          t.id.asc(),
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

      // 收敛（决策 4）：详情改走 BaseService.get（含租户 + 软删过滤）。
      final menu = await SystemCrudEngines.menu.get(session, id);

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
