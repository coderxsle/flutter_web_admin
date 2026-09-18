/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// 系统菜单权限表（支持目录/菜单/按钮三级权限模型）
/// 设计目标：
/// 1. 兼容前端动态路由（path/component/redirect）
/// 2. 支持菜单展示控制（visible/alwaysShow/activeMenu）
/// 3. 支持标签页行为控制（showInTabs/affix/keepAlive）
/// 4. 支持权限点控制（permission）与软删除审计字段
abstract class SysMenu
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysMenu._({
    this.id,
    int? parentId,
    required this.type,
    required this.title,
    this.icon,
    String? permission,
    String? path,
    this.redirect,
    this.component,
    this.componentName,
    this.activeMenu,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : parentId = parentId ?? 0,
       permission = permission ?? '',
       path = path ?? '',
       sort = sort ?? 0,
       status = status ?? 1,
       breadcrumb = breadcrumb ?? true,
       visible = visible ?? true,
       keepAlive = keepAlive ?? true,
       alwaysShow = alwaysShow ?? true,
       showInTabs = showInTabs ?? true,
       affix = affix ?? false,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysMenu({
    int? id,
    int? parentId,
    required int type,
    required String title,
    String? icon,
    String? permission,
    String? path,
    String? redirect,
    String? component,
    String? componentName,
    String? activeMenu,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysMenuImpl;

  factory SysMenu.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMenu(
      id: jsonSerialization['id'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      type: jsonSerialization['type'] as int,
      title: jsonSerialization['title'] as String,
      icon: jsonSerialization['icon'] as String?,
      permission: jsonSerialization['permission'] as String?,
      path: jsonSerialization['path'] as String?,
      redirect: jsonSerialization['redirect'] as String?,
      component: jsonSerialization['component'] as String?,
      componentName: jsonSerialization['componentName'] as String?,
      activeMenu: jsonSerialization['activeMenu'] as String?,
      sort: jsonSerialization['sort'] as int?,
      status: jsonSerialization['status'] as int?,
      breadcrumb: jsonSerialization['breadcrumb'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['breadcrumb']),
      visible: jsonSerialization['visible'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['visible']),
      keepAlive: jsonSerialization['keepAlive'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['keepAlive']),
      alwaysShow: jsonSerialization['alwaysShow'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['alwaysShow']),
      showInTabs: jsonSerialization['showInTabs'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['showInTabs']),
      affix: jsonSerialization['affix'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['affix']),
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
    );
  }

  static final t = SysMenuTable();

  static const db = SysMenuRepository._();

  @override
  int? id;

  int parentId;

  int type;

  String title;

  String? icon;

  String permission;

  String? path;

  String? redirect;

  String? component;

  String? componentName;

  String? activeMenu;

  int sort;

  int status;

  bool breadcrumb;

  bool visible;

  bool keepAlive;

  bool alwaysShow;

  bool showInTabs;

  bool affix;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysMenu]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysMenu copyWith({
    int? id,
    int? parentId,
    int? type,
    String? title,
    String? icon,
    String? permission,
    String? path,
    String? redirect,
    String? component,
    String? componentName,
    String? activeMenu,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysMenu',
      if (id != null) 'id': id,
      'parentId': parentId,
      'type': type,
      'title': title,
      if (icon != null) 'icon': icon,
      'permission': permission,
      if (path != null) 'path': path,
      if (redirect != null) 'redirect': redirect,
      if (component != null) 'component': component,
      if (componentName != null) 'componentName': componentName,
      if (activeMenu != null) 'activeMenu': activeMenu,
      'sort': sort,
      'status': status,
      'breadcrumb': breadcrumb,
      'visible': visible,
      'keepAlive': keepAlive,
      'alwaysShow': alwaysShow,
      'showInTabs': showInTabs,
      'affix': affix,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysMenu',
      if (id != null) 'id': id,
      'parentId': parentId,
      'type': type,
      'title': title,
      if (icon != null) 'icon': icon,
      'permission': permission,
      if (path != null) 'path': path,
      if (redirect != null) 'redirect': redirect,
      if (component != null) 'component': component,
      if (componentName != null) 'componentName': componentName,
      if (activeMenu != null) 'activeMenu': activeMenu,
      'sort': sort,
      'status': status,
      'breadcrumb': breadcrumb,
      'visible': visible,
      'keepAlive': keepAlive,
      'alwaysShow': alwaysShow,
      'showInTabs': showInTabs,
      'affix': affix,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static SysMenuInclude include() {
    return SysMenuInclude._();
  }

  static SysMenuIncludeList includeList({
    _is.WhereExpressionBuilder<SysMenuTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysMenuTable>? orderBy,
    _is.OrderByListBuilder<SysMenuTable>? orderByList,
    SysMenuInclude? include,
  }) {
    return SysMenuIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMenu.t),
      orderByList: orderByList?.call(SysMenu.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysMenuImpl extends SysMenu {
  _SysMenuImpl({
    int? id,
    int? parentId,
    required int type,
    required String title,
    String? icon,
    String? permission,
    String? path,
    String? redirect,
    String? component,
    String? componentName,
    String? activeMenu,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) : super._(
         id: id,
         parentId: parentId,
         type: type,
         title: title,
         icon: icon,
         permission: permission,
         path: path,
         redirect: redirect,
         component: component,
         componentName: componentName,
         activeMenu: activeMenu,
         sort: sort,
         status: status,
         breadcrumb: breadcrumb,
         visible: visible,
         keepAlive: keepAlive,
         alwaysShow: alwaysShow,
         showInTabs: showInTabs,
         affix: affix,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysMenu]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysMenu copyWith({
    Object? id = _Undefined,
    int? parentId,
    int? type,
    String? title,
    Object? icon = _Undefined,
    String? permission,
    Object? path = _Undefined,
    Object? redirect = _Undefined,
    Object? component = _Undefined,
    Object? componentName = _Undefined,
    Object? activeMenu = _Undefined,
    int? sort,
    int? status,
    bool? breadcrumb,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    bool? showInTabs,
    bool? affix,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysMenu(
      id: id is int? ? id : this.id,
      parentId: parentId ?? this.parentId,
      type: type ?? this.type,
      title: title ?? this.title,
      icon: icon is String? ? icon : this.icon,
      permission: permission ?? this.permission,
      path: path is String? ? path : this.path,
      redirect: redirect is String? ? redirect : this.redirect,
      component: component is String? ? component : this.component,
      componentName: componentName is String?
          ? componentName
          : this.componentName,
      activeMenu: activeMenu is String? ? activeMenu : this.activeMenu,
      sort: sort ?? this.sort,
      status: status ?? this.status,
      breadcrumb: breadcrumb ?? this.breadcrumb,
      visible: visible ?? this.visible,
      keepAlive: keepAlive ?? this.keepAlive,
      alwaysShow: alwaysShow ?? this.alwaysShow,
      showInTabs: showInTabs ?? this.showInTabs,
      affix: affix ?? this.affix,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class SysMenuUpdateTable extends _is.UpdateTable<SysMenuTable> {
  SysMenuUpdateTable(super.table);

  _is.ColumnValue<int, int> parentId(int value) =>
      _is.ColumnValue(table.parentId, value);

  _is.ColumnValue<int, int> type(int value) =>
      _is.ColumnValue(table.type, value);

  _is.ColumnValue<String, String> title(String value) =>
      _is.ColumnValue(table.title, value);

  _is.ColumnValue<String, String> icon(String? value) =>
      _is.ColumnValue(table.icon, value);

  _is.ColumnValue<String, String> permission(String value) =>
      _is.ColumnValue(table.permission, value);

  _is.ColumnValue<String, String> path(String? value) =>
      _is.ColumnValue(table.path, value);

  _is.ColumnValue<String, String> redirect(String? value) =>
      _is.ColumnValue(table.redirect, value);

  _is.ColumnValue<String, String> component(String? value) =>
      _is.ColumnValue(table.component, value);

  _is.ColumnValue<String, String> componentName(String? value) =>
      _is.ColumnValue(table.componentName, value);

  _is.ColumnValue<String, String> activeMenu(String? value) =>
      _is.ColumnValue(table.activeMenu, value);

  _is.ColumnValue<int, int> sort(int value) =>
      _is.ColumnValue(table.sort, value);

  _is.ColumnValue<int, int> status(int value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<bool, bool> breadcrumb(bool value) =>
      _is.ColumnValue(table.breadcrumb, value);

  _is.ColumnValue<bool, bool> visible(bool value) =>
      _is.ColumnValue(table.visible, value);

  _is.ColumnValue<bool, bool> keepAlive(bool value) =>
      _is.ColumnValue(table.keepAlive, value);

  _is.ColumnValue<bool, bool> alwaysShow(bool value) =>
      _is.ColumnValue(table.alwaysShow, value);

  _is.ColumnValue<bool, bool> showInTabs(bool value) =>
      _is.ColumnValue(table.showInTabs, value);

  _is.ColumnValue<bool, bool> affix(bool value) =>
      _is.ColumnValue(table.affix, value);

  _is.ColumnValue<bool, bool> deleted(bool value) =>
      _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) =>
      _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);
}

class SysMenuTable extends _is.Table<int?> {
  SysMenuTable({super.tableRelation}) : super(tableName: 'sys_menu') {
    updateTable = SysMenuUpdateTable(this);
    parentId = _is.ColumnInt('parentId', this, hasDefault: true);
    type = _is.ColumnInt('type', this);
    title = _is.ColumnString('title', this);
    icon = _is.ColumnString('icon', this);
    permission = _is.ColumnString('permission', this, hasDefault: true);
    path = _is.ColumnString('path', this, hasDefault: true);
    redirect = _is.ColumnString('redirect', this);
    component = _is.ColumnString('component', this);
    componentName = _is.ColumnString('componentName', this);
    activeMenu = _is.ColumnString('activeMenu', this);
    sort = _is.ColumnInt('sort', this, hasDefault: true);
    status = _is.ColumnInt('status', this, hasDefault: true);
    breadcrumb = _is.ColumnBool('breadcrumb', this, hasDefault: true);
    visible = _is.ColumnBool('visible', this, hasDefault: true);
    keepAlive = _is.ColumnBool('keepAlive', this, hasDefault: true);
    alwaysShow = _is.ColumnBool('alwaysShow', this, hasDefault: true);
    showInTabs = _is.ColumnBool('showInTabs', this, hasDefault: true);
    affix = _is.ColumnBool('affix', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
  }

  late final SysMenuUpdateTable updateTable;

  late final _is.ColumnInt parentId;

  late final _is.ColumnInt type;

  late final _is.ColumnString title;

  late final _is.ColumnString icon;

  late final _is.ColumnString permission;

  late final _is.ColumnString path;

  late final _is.ColumnString redirect;

  late final _is.ColumnString component;

  late final _is.ColumnString componentName;

  late final _is.ColumnString activeMenu;

  late final _is.ColumnInt sort;

  late final _is.ColumnInt status;

  late final _is.ColumnBool breadcrumb;

  late final _is.ColumnBool visible;

  late final _is.ColumnBool keepAlive;

  late final _is.ColumnBool alwaysShow;

  late final _is.ColumnBool showInTabs;

  late final _is.ColumnBool affix;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    parentId,
    type,
    title,
    icon,
    permission,
    path,
    redirect,
    component,
    componentName,
    activeMenu,
    sort,
    status,
    breadcrumb,
    visible,
    keepAlive,
    alwaysShow,
    showInTabs,
    affix,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class SysMenuInclude extends _is.IncludeObject {
  SysMenuInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysMenu.t;
}

class SysMenuIncludeList extends _is.IncludeList {
  SysMenuIncludeList._({
    _is.WhereExpressionBuilder<SysMenuTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysMenu.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysMenu.t;
}

class SysMenuRepository {
  const SysMenuRepository._();

  /// Returns a list of [SysMenu]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<SysMenu>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysMenuTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysMenuTable>? orderBy,
    _is.OrderByListBuilder<SysMenuTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysMenu>(
      where: where?.call(SysMenu.t),
      orderBy: orderBy?.call(SysMenu.t),
      orderByList: orderByList?.call(SysMenu.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysMenu] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<SysMenu?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysMenuTable>? where,
    int? offset,
    _is.OrderByBuilder<SysMenuTable>? orderBy,
    _is.OrderByListBuilder<SysMenuTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysMenu>(
      where: where?.call(SysMenu.t),
      orderBy: orderBy?.call(SysMenu.t),
      orderByList: orderByList?.call(SysMenu.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysMenu] by its [id] or null if no such row exists.
  Future<SysMenu?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysMenu>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysMenu]s in the list and returns the inserted rows.
  ///
  /// The returned [SysMenu]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMenu>> insert(
    _is.DatabaseSession session,
    List<SysMenu> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysMenu>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysMenu] and returns the inserted row.
  ///
  /// The returned [SysMenu] will have its `id` field set.
  Future<SysMenu> insertRow(
    _is.DatabaseSession session,
    SysMenu row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysMenu>(row, transaction: transaction);
  }

  /// Upserts all [SysMenu]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [SysMenu]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMenu>> upsert(
    _is.DatabaseSession session,
    List<SysMenu> rows, {
    required _is.ColumnSelections<SysMenuTable> conflictColumns,
    _is.ColumnSelections<SysMenuTable>? updateColumns,
    _is.WhereExpressionBuilder<SysMenuTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysMenu>(
      rows,
      conflictColumns: conflictColumns(SysMenu.t),
      updateColumns: updateColumns?.call(SysMenu.t),
      updateWhere: updateWhere?.call(SysMenu.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysMenu] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [SysMenu] will have its `id` field set.
  Future<SysMenu?> upsertRow(
    _is.DatabaseSession session,
    SysMenu row, {
    required _is.ColumnSelections<SysMenuTable> conflictColumns,
    _is.ColumnSelections<SysMenuTable>? updateColumns,
    _is.WhereExpressionBuilder<SysMenuTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysMenu>(
      row,
      conflictColumns: conflictColumns(SysMenu.t),
      updateColumns: updateColumns?.call(SysMenu.t),
      updateWhere: updateWhere?.call(SysMenu.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysMenu]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMenu>> update(
    _is.DatabaseSession session,
    List<SysMenu> rows, {
    _is.ColumnSelections<SysMenuTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysMenu>(
      rows,
      columns: columns?.call(SysMenu.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysMenu]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysMenu> updateRow(
    _is.DatabaseSession session,
    SysMenu row, {
    _is.ColumnSelections<SysMenuTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysMenu>(
      row,
      columns: columns?.call(SysMenu.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysMenu] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysMenu?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysMenuUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysMenu>(
      id,
      columnValues: columnValues(SysMenu.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysMenu]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMenu>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysMenuUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysMenuTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysMenuTable>? orderBy,
    _is.OrderByListBuilder<SysMenuTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysMenu>(
      columnValues: columnValues(SysMenu.t.updateTable),
      where: where(SysMenu.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMenu.t),
      orderByList: orderByList?.call(SysMenu.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysMenu]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMenu>> delete(
    _is.DatabaseSession session,
    List<SysMenu> rows, {
    _is.OrderByBuilder<SysMenuTable>? orderBy,
    _is.OrderByListBuilder<SysMenuTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysMenu>(
      rows,
      orderBy: orderBy?.call(SysMenu.t),
      orderByList: orderByList?.call(SysMenu.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysMenu].
  Future<SysMenu> deleteRow(
    _is.DatabaseSession session,
    SysMenu row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysMenu>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMenu>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysMenuTable> where,
    _is.OrderByBuilder<SysMenuTable>? orderBy,
    _is.OrderByListBuilder<SysMenuTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysMenu>(
      where: where(SysMenu.t),
      orderBy: orderBy?.call(SysMenu.t),
      orderByList: orderByList?.call(SysMenu.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysMenuTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysMenu>(
      where: where?.call(SysMenu.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysMenu] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysMenuTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysMenu>(
      where: where(SysMenu.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
