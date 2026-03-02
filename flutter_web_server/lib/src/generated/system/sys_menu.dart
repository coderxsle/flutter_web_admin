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
import 'package:serverpod/serverpod.dart' as _i1;

/// 系统菜单权限表（支持目录/菜单/按钮三级权限模型）
/// 设计目标：
/// 1. 兼容前端动态路由（path/component/redirect）
/// 2. 支持菜单展示控制（visible/alwaysShow/activeMenu）
/// 3. 支持标签页行为控制（showInTabs/affix/keepAlive）
/// 4. 支持权限点控制（permission）与软删除审计字段
abstract class SysMenu
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysMenu._({
    this.id,
    required this.name,
    String? permission,
    required this.type,
    int? sort,
    int? parentId,
    this.breadcrumb,
    String? path,
    this.icon,
    this.component,
    this.componentName,
    this.redirect,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    this.activeMenu,
    bool? showInTabs,
    bool? affix,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    bool? deleted,
  }) : permission = permission ?? '',
       sort = sort ?? 0,
       parentId = parentId ?? 0,
       path = path ?? '',
       status = status ?? 1,
       visible = visible ?? true,
       keepAlive = keepAlive ?? true,
       alwaysShow = alwaysShow ?? true,
       showInTabs = showInTabs ?? true,
       affix = affix ?? false,
       createTime = createTime ?? DateTime.now(),
       deleted = deleted ?? false;

  factory SysMenu({
    int? id,
    required String name,
    String? permission,
    required int type,
    int? sort,
    int? parentId,
    String? breadcrumb,
    String? path,
    String? icon,
    String? component,
    String? componentName,
    String? redirect,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    String? activeMenu,
    bool? showInTabs,
    bool? affix,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) = _SysMenuImpl;

  factory SysMenu.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMenu(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      permission: jsonSerialization['permission'] as String?,
      type: jsonSerialization['type'] as int,
      sort: jsonSerialization['sort'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      breadcrumb: jsonSerialization['breadcrumb'] as String?,
      path: jsonSerialization['path'] as String?,
      icon: jsonSerialization['icon'] as String?,
      component: jsonSerialization['component'] as String?,
      componentName: jsonSerialization['componentName'] as String?,
      redirect: jsonSerialization['redirect'] as String?,
      status: jsonSerialization['status'] as int?,
      visible: jsonSerialization['visible'] as bool?,
      keepAlive: jsonSerialization['keepAlive'] as bool?,
      alwaysShow: jsonSerialization['alwaysShow'] as bool?,
      activeMenu: jsonSerialization['activeMenu'] as String?,
      showInTabs: jsonSerialization['showInTabs'] as bool?,
      affix: jsonSerialization['affix'] as bool?,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
      deleted: jsonSerialization['deleted'] as bool?,
    );
  }

  static final t = SysMenuTable();

  static const db = SysMenuRepository._();

  @override
  int? id;

  String name;

  String permission;

  int type;

  int sort;

  int parentId;

  String? breadcrumb;

  String? path;

  String? icon;

  String? component;

  String? componentName;

  String? redirect;

  int status;

  bool visible;

  bool keepAlive;

  bool alwaysShow;

  String? activeMenu;

  bool showInTabs;

  bool affix;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysMenu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysMenu copyWith({
    int? id,
    String? name,
    String? permission,
    int? type,
    int? sort,
    int? parentId,
    String? breadcrumb,
    String? path,
    String? icon,
    String? component,
    String? componentName,
    String? redirect,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    String? activeMenu,
    bool? showInTabs,
    bool? affix,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysMenu',
      if (id != null) 'id': id,
      'name': name,
      'permission': permission,
      'type': type,
      'sort': sort,
      'parentId': parentId,
      if (breadcrumb != null) 'breadcrumb': breadcrumb,
      if (path != null) 'path': path,
      if (icon != null) 'icon': icon,
      if (component != null) 'component': component,
      if (componentName != null) 'componentName': componentName,
      if (redirect != null) 'redirect': redirect,
      'status': status,
      'visible': visible,
      'keepAlive': keepAlive,
      'alwaysShow': alwaysShow,
      if (activeMenu != null) 'activeMenu': activeMenu,
      'showInTabs': showInTabs,
      'affix': affix,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysMenu',
      if (id != null) 'id': id,
      'name': name,
      'permission': permission,
      'type': type,
      'sort': sort,
      'parentId': parentId,
      if (breadcrumb != null) 'breadcrumb': breadcrumb,
      if (path != null) 'path': path,
      if (icon != null) 'icon': icon,
      if (component != null) 'component': component,
      if (componentName != null) 'componentName': componentName,
      if (redirect != null) 'redirect': redirect,
      'status': status,
      'visible': visible,
      'keepAlive': keepAlive,
      'alwaysShow': alwaysShow,
      if (activeMenu != null) 'activeMenu': activeMenu,
      'showInTabs': showInTabs,
      'affix': affix,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysMenuInclude include() {
    return SysMenuInclude._();
  }

  static SysMenuIncludeList includeList({
    _i1.WhereExpressionBuilder<SysMenuTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysMenuTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMenuTable>? orderByList,
    SysMenuInclude? include,
  }) {
    return SysMenuIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMenu.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysMenu.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysMenuImpl extends SysMenu {
  _SysMenuImpl({
    int? id,
    required String name,
    String? permission,
    required int type,
    int? sort,
    int? parentId,
    String? breadcrumb,
    String? path,
    String? icon,
    String? component,
    String? componentName,
    String? redirect,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    String? activeMenu,
    bool? showInTabs,
    bool? affix,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) : super._(
         id: id,
         name: name,
         permission: permission,
         type: type,
         sort: sort,
         parentId: parentId,
         breadcrumb: breadcrumb,
         path: path,
         icon: icon,
         component: component,
         componentName: componentName,
         redirect: redirect,
         status: status,
         visible: visible,
         keepAlive: keepAlive,
         alwaysShow: alwaysShow,
         activeMenu: activeMenu,
         showInTabs: showInTabs,
         affix: affix,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysMenu]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysMenu copyWith({
    Object? id = _Undefined,
    String? name,
    String? permission,
    int? type,
    int? sort,
    int? parentId,
    Object? breadcrumb = _Undefined,
    Object? path = _Undefined,
    Object? icon = _Undefined,
    Object? component = _Undefined,
    Object? componentName = _Undefined,
    Object? redirect = _Undefined,
    int? status,
    bool? visible,
    bool? keepAlive,
    bool? alwaysShow,
    Object? activeMenu = _Undefined,
    bool? showInTabs,
    bool? affix,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMenu(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      permission: permission ?? this.permission,
      type: type ?? this.type,
      sort: sort ?? this.sort,
      parentId: parentId ?? this.parentId,
      breadcrumb: breadcrumb is String? ? breadcrumb : this.breadcrumb,
      path: path is String? ? path : this.path,
      icon: icon is String? ? icon : this.icon,
      component: component is String? ? component : this.component,
      componentName: componentName is String?
          ? componentName
          : this.componentName,
      redirect: redirect is String? ? redirect : this.redirect,
      status: status ?? this.status,
      visible: visible ?? this.visible,
      keepAlive: keepAlive ?? this.keepAlive,
      alwaysShow: alwaysShow ?? this.alwaysShow,
      activeMenu: activeMenu is String? ? activeMenu : this.activeMenu,
      showInTabs: showInTabs ?? this.showInTabs,
      affix: affix ?? this.affix,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysMenuUpdateTable extends _i1.UpdateTable<SysMenuTable> {
  SysMenuUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> permission(String value) => _i1.ColumnValue(
    table.permission,
    value,
  );

  _i1.ColumnValue<int, int> type(int value) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<int, int> sort(int value) => _i1.ColumnValue(
    table.sort,
    value,
  );

  _i1.ColumnValue<int, int> parentId(int value) => _i1.ColumnValue(
    table.parentId,
    value,
  );

  _i1.ColumnValue<String, String> breadcrumb(String? value) => _i1.ColumnValue(
    table.breadcrumb,
    value,
  );

  _i1.ColumnValue<String, String> path(String? value) => _i1.ColumnValue(
    table.path,
    value,
  );

  _i1.ColumnValue<String, String> icon(String? value) => _i1.ColumnValue(
    table.icon,
    value,
  );

  _i1.ColumnValue<String, String> component(String? value) => _i1.ColumnValue(
    table.component,
    value,
  );

  _i1.ColumnValue<String, String> componentName(String? value) =>
      _i1.ColumnValue(
        table.componentName,
        value,
      );

  _i1.ColumnValue<String, String> redirect(String? value) => _i1.ColumnValue(
    table.redirect,
    value,
  );

  _i1.ColumnValue<int, int> status(int value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<bool, bool> visible(bool value) => _i1.ColumnValue(
    table.visible,
    value,
  );

  _i1.ColumnValue<bool, bool> keepAlive(bool value) => _i1.ColumnValue(
    table.keepAlive,
    value,
  );

  _i1.ColumnValue<bool, bool> alwaysShow(bool value) => _i1.ColumnValue(
    table.alwaysShow,
    value,
  );

  _i1.ColumnValue<String, String> activeMenu(String? value) => _i1.ColumnValue(
    table.activeMenu,
    value,
  );

  _i1.ColumnValue<bool, bool> showInTabs(bool value) => _i1.ColumnValue(
    table.showInTabs,
    value,
  );

  _i1.ColumnValue<bool, bool> affix(bool value) => _i1.ColumnValue(
    table.affix,
    value,
  );

  _i1.ColumnValue<String, String> creator(String? value) => _i1.ColumnValue(
    table.creator,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _i1.ColumnValue(
        table.createTime,
        value,
      );

  _i1.ColumnValue<String, String> updater(String? value) => _i1.ColumnValue(
    table.updater,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _i1.ColumnValue(
        table.updateTime,
        value,
      );

  _i1.ColumnValue<bool, bool> deleted(bool value) => _i1.ColumnValue(
    table.deleted,
    value,
  );
}

class SysMenuTable extends _i1.Table<int?> {
  SysMenuTable({super.tableRelation}) : super(tableName: 'sys_menu') {
    updateTable = SysMenuUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    permission = _i1.ColumnString(
      'permission',
      this,
      hasDefault: true,
    );
    type = _i1.ColumnInt(
      'type',
      this,
    );
    sort = _i1.ColumnInt(
      'sort',
      this,
      hasDefault: true,
    );
    parentId = _i1.ColumnInt(
      'parentId',
      this,
      hasDefault: true,
    );
    breadcrumb = _i1.ColumnString(
      'breadcrumb',
      this,
    );
    path = _i1.ColumnString(
      'path',
      this,
      hasDefault: true,
    );
    icon = _i1.ColumnString(
      'icon',
      this,
    );
    component = _i1.ColumnString(
      'component',
      this,
    );
    componentName = _i1.ColumnString(
      'componentName',
      this,
    );
    redirect = _i1.ColumnString(
      'redirect',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
      hasDefault: true,
    );
    visible = _i1.ColumnBool(
      'visible',
      this,
      hasDefault: true,
    );
    keepAlive = _i1.ColumnBool(
      'keepAlive',
      this,
      hasDefault: true,
    );
    alwaysShow = _i1.ColumnBool(
      'alwaysShow',
      this,
      hasDefault: true,
    );
    activeMenu = _i1.ColumnString(
      'activeMenu',
      this,
    );
    showInTabs = _i1.ColumnBool(
      'showInTabs',
      this,
      hasDefault: true,
    );
    affix = _i1.ColumnBool(
      'affix',
      this,
      hasDefault: true,
    );
    creator = _i1.ColumnString(
      'creator',
      this,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updater = _i1.ColumnString(
      'updater',
      this,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
      hasDefault: true,
    );
  }

  late final SysMenuUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnString permission;

  late final _i1.ColumnInt type;

  late final _i1.ColumnInt sort;

  late final _i1.ColumnInt parentId;

  late final _i1.ColumnString breadcrumb;

  late final _i1.ColumnString path;

  late final _i1.ColumnString icon;

  late final _i1.ColumnString component;

  late final _i1.ColumnString componentName;

  late final _i1.ColumnString redirect;

  late final _i1.ColumnInt status;

  late final _i1.ColumnBool visible;

  late final _i1.ColumnBool keepAlive;

  late final _i1.ColumnBool alwaysShow;

  late final _i1.ColumnString activeMenu;

  late final _i1.ColumnBool showInTabs;

  late final _i1.ColumnBool affix;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    permission,
    type,
    sort,
    parentId,
    breadcrumb,
    path,
    icon,
    component,
    componentName,
    redirect,
    status,
    visible,
    keepAlive,
    alwaysShow,
    activeMenu,
    showInTabs,
    affix,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysMenuInclude extends _i1.IncludeObject {
  SysMenuInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysMenu.t;
}

class SysMenuIncludeList extends _i1.IncludeList {
  SysMenuIncludeList._({
    _i1.WhereExpressionBuilder<SysMenuTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysMenu.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysMenu.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMenuTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysMenuTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMenuTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysMenu>(
      where: where?.call(SysMenu.t),
      orderBy: orderBy?.call(SysMenu.t),
      orderByList: orderByList?.call(SysMenu.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMenuTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysMenuTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMenuTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysMenu>(
      where: where?.call(SysMenu.t),
      orderBy: orderBy?.call(SysMenu.t),
      orderByList: orderByList?.call(SysMenu.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysMenu] by its [id] or null if no such row exists.
  Future<SysMenu?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysMenu>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysMenu]s in the list and returns the inserted rows.
  ///
  /// The returned [SysMenu]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysMenu>> insert(
    _i1.Session session,
    List<SysMenu> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysMenu>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysMenu] and returns the inserted row.
  ///
  /// The returned [SysMenu] will have its `id` field set.
  Future<SysMenu> insertRow(
    _i1.Session session,
    SysMenu row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysMenu>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysMenu]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysMenu>> update(
    _i1.Session session,
    List<SysMenu> rows, {
    _i1.ColumnSelections<SysMenuTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysMenu>(
      rows,
      columns: columns?.call(SysMenu.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysMenu]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysMenu> updateRow(
    _i1.Session session,
    SysMenu row, {
    _i1.ColumnSelections<SysMenuTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SysMenuUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SysMenu>(
      id,
      columnValues: columnValues(SysMenu.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysMenu]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SysMenu>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SysMenuUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SysMenuTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysMenuTable>? orderBy,
    _i1.OrderByListBuilder<SysMenuTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SysMenu>(
      columnValues: columnValues(SysMenu.t.updateTable),
      where: where(SysMenu.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMenu.t),
      orderByList: orderByList?.call(SysMenu.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SysMenu]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysMenu>> delete(
    _i1.Session session,
    List<SysMenu> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysMenu>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysMenu].
  Future<SysMenu> deleteRow(
    _i1.Session session,
    SysMenu row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysMenu>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysMenu>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysMenuTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysMenu>(
      where: where(SysMenu.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMenuTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysMenu>(
      where: where?.call(SysMenu.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
