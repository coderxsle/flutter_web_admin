/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// 用于存储书店客户/会员的基本信息
/// customer: 面向前台的客户/会员账户系统
abstract class Customer implements _i1.TableRow, _i1.ProtocolSerialization {
  Customer._({
    this.id,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  })  : userName = userName ?? '',
        password = password ?? '',
        nickname = nickname ?? '',
        phone = phone ?? '',
        email = email ?? '',
        status = status ?? 0,
        memberLevel = memberLevel ?? 0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now();

  factory Customer({
    int? id,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _CustomerImpl;

  factory Customer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Customer(
      id: jsonSerialization['id'] as int?,
      userName: jsonSerialization['userName'] as String,
      password: jsonSerialization['password'] as String,
      nickname: jsonSerialization['nickname'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      status: jsonSerialization['status'] as int,
      memberLevel: jsonSerialization['memberLevel'] as int,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = CustomerTable();

  static const db = CustomerRepository._();

  @override
  int? id;

  /// 用户名（唯一）
  String userName;

  /// 密码
  String password;

  /// 昵称
  String nickname;

  /// 手机号
  String phone;

  /// 邮箱
  String email;

  /// 账户状态：0-正常，1-禁用
  int status;

  /// 会员等级：0-普通会员，1-银卡会员，2-金卡会员
  int memberLevel;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  @override
  _i1.Table get table => t;

  Customer copyWith({
    int? id,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userName': userName,
      'password': password,
      'nickname': nickname,
      'phone': phone,
      'email': email,
      'status': status,
      'memberLevel': memberLevel,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userName': userName,
      'password': password,
      'nickname': nickname,
      'phone': phone,
      'email': email,
      'status': status,
      'memberLevel': memberLevel,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  static CustomerInclude include() {
    return CustomerInclude._();
  }

  static CustomerIncludeList includeList({
    _i1.WhereExpressionBuilder<CustomerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CustomerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CustomerTable>? orderByList,
    CustomerInclude? include,
  }) {
    return CustomerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Customer.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Customer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerImpl extends Customer {
  _CustomerImpl({
    int? id,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super._(
          id: id,
          userName: userName,
          password: password,
          nickname: nickname,
          phone: phone,
          email: email,
          status: status,
          memberLevel: memberLevel,
          createTime: createTime,
          updateTime: updateTime,
        );

  @override
  Customer copyWith({
    Object? id = _Undefined,
    String? userName,
    String? password,
    String? nickname,
    String? phone,
    String? email,
    int? status,
    int? memberLevel,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return Customer(
      id: id is int? ? id : this.id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      status: status ?? this.status,
      memberLevel: memberLevel ?? this.memberLevel,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class CustomerTable extends _i1.Table {
  CustomerTable({super.tableRelation}) : super(tableName: 'customer') {
    userName = _i1.ColumnString(
      'userName',
      this,
      hasDefault: true,
    );
    password = _i1.ColumnString(
      'password',
      this,
      hasDefault: true,
    );
    nickname = _i1.ColumnString(
      'nickname',
      this,
      hasDefault: true,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
      hasDefault: true,
    );
    email = _i1.ColumnString(
      'email',
      this,
      hasDefault: true,
    );
    status = _i1.ColumnInt(
      'status',
      this,
      hasDefault: true,
    );
    memberLevel = _i1.ColumnInt(
      'memberLevel',
      this,
      hasDefault: true,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
      hasDefault: true,
    );
  }

  /// 用户名（唯一）
  late final _i1.ColumnString userName;

  /// 密码
  late final _i1.ColumnString password;

  /// 昵称
  late final _i1.ColumnString nickname;

  /// 手机号
  late final _i1.ColumnString phone;

  /// 邮箱
  late final _i1.ColumnString email;

  /// 账户状态：0-正常，1-禁用
  late final _i1.ColumnInt status;

  /// 会员等级：0-普通会员，1-银卡会员，2-金卡会员
  late final _i1.ColumnInt memberLevel;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  @override
  List<_i1.Column> get columns => [
        id,
        userName,
        password,
        nickname,
        phone,
        email,
        status,
        memberLevel,
        createTime,
        updateTime,
      ];
}

class CustomerInclude extends _i1.IncludeObject {
  CustomerInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Customer.t;
}

class CustomerIncludeList extends _i1.IncludeList {
  CustomerIncludeList._({
    _i1.WhereExpressionBuilder<CustomerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Customer.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Customer.t;
}

class CustomerRepository {
  const CustomerRepository._();

  Future<List<Customer>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CustomerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CustomerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CustomerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Customer>(
      where: where?.call(Customer.t),
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Customer?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CustomerTable>? where,
    int? offset,
    _i1.OrderByBuilder<CustomerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CustomerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Customer>(
      where: where?.call(Customer.t),
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Customer?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Customer>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Customer>> insert(
    _i1.Session session,
    List<Customer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Customer>(
      rows,
      transaction: transaction,
    );
  }

  Future<Customer> insertRow(
    _i1.Session session,
    Customer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Customer>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Customer>> update(
    _i1.Session session,
    List<Customer> rows, {
    _i1.ColumnSelections<CustomerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Customer>(
      rows,
      columns: columns?.call(Customer.t),
      transaction: transaction,
    );
  }

  Future<Customer> updateRow(
    _i1.Session session,
    Customer row, {
    _i1.ColumnSelections<CustomerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Customer>(
      row,
      columns: columns?.call(Customer.t),
      transaction: transaction,
    );
  }

  Future<List<Customer>> delete(
    _i1.Session session,
    List<Customer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Customer>(
      rows,
      transaction: transaction,
    );
  }

  Future<Customer> deleteRow(
    _i1.Session session,
    Customer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Customer>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Customer>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CustomerTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Customer>(
      where: where(Customer.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CustomerTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Customer>(
      where: where?.call(Customer.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
