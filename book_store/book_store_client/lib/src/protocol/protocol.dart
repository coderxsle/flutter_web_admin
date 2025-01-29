/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'book.dart' as _i2;
import 'book_category.dart' as _i3;
import 'book_package.dart' as _i4;
import 'book_package_item.dart' as _i5;
import 'book_sale.dart' as _i6;
import 'customer.dart' as _i7;
import 'dict_item.dart' as _i8;
import 'dict_type.dart' as _i9;
import 'inventory_log.dart' as _i10;
import 'party.dart' as _i11;
import 'promotion.dart' as _i12;
import 'region.dart' as _i13;
import 'role_permission.dart' as _i14;
import 'sys_operation_log.dart' as _i15;
import 'sys_resource.dart' as _i16;
import 'sys_role.dart' as _i17;
import 'sys_role_resource.dart' as _i18;
import 'sys_user.dart' as _i19;
import 'sys_user_role.dart' as _i20;
import 'package:book_store_client/src/protocol/book.dart' as _i21;
export 'book.dart';
export 'book_category.dart';
export 'book_package.dart';
export 'book_package_item.dart';
export 'book_sale.dart';
export 'customer.dart';
export 'dict_item.dart';
export 'dict_type.dart';
export 'inventory_log.dart';
export 'party.dart';
export 'promotion.dart';
export 'region.dart';
export 'role_permission.dart';
export 'sys_operation_log.dart';
export 'sys_resource.dart';
export 'sys_role.dart';
export 'sys_role_resource.dart';
export 'sys_user.dart';
export 'sys_user_role.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.Book) {
      return _i2.Book.fromJson(data) as T;
    }
    if (t == _i3.BookCategory) {
      return _i3.BookCategory.fromJson(data) as T;
    }
    if (t == _i4.BookPackage) {
      return _i4.BookPackage.fromJson(data) as T;
    }
    if (t == _i5.BookPackageItem) {
      return _i5.BookPackageItem.fromJson(data) as T;
    }
    if (t == _i6.BookSale) {
      return _i6.BookSale.fromJson(data) as T;
    }
    if (t == _i7.Customer) {
      return _i7.Customer.fromJson(data) as T;
    }
    if (t == _i8.DictItem) {
      return _i8.DictItem.fromJson(data) as T;
    }
    if (t == _i9.DictType) {
      return _i9.DictType.fromJson(data) as T;
    }
    if (t == _i10.InventoryLog) {
      return _i10.InventoryLog.fromJson(data) as T;
    }
    if (t == _i11.Party) {
      return _i11.Party.fromJson(data) as T;
    }
    if (t == _i12.Promotion) {
      return _i12.Promotion.fromJson(data) as T;
    }
    if (t == _i13.Region) {
      return _i13.Region.fromJson(data) as T;
    }
    if (t == _i14.RolePermission) {
      return _i14.RolePermission.fromJson(data) as T;
    }
    if (t == _i15.SysOperationLog) {
      return _i15.SysOperationLog.fromJson(data) as T;
    }
    if (t == _i16.SysResource) {
      return _i16.SysResource.fromJson(data) as T;
    }
    if (t == _i17.SysRole) {
      return _i17.SysRole.fromJson(data) as T;
    }
    if (t == _i18.SysRoleResource) {
      return _i18.SysRoleResource.fromJson(data) as T;
    }
    if (t == _i19.SysUser) {
      return _i19.SysUser.fromJson(data) as T;
    }
    if (t == _i20.SysUserRole) {
      return _i20.SysUserRole.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Book?>()) {
      return (data != null ? _i2.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.BookCategory?>()) {
      return (data != null ? _i3.BookCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.BookPackage?>()) {
      return (data != null ? _i4.BookPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BookPackageItem?>()) {
      return (data != null ? _i5.BookPackageItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.BookSale?>()) {
      return (data != null ? _i6.BookSale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Customer?>()) {
      return (data != null ? _i7.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DictItem?>()) {
      return (data != null ? _i8.DictItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DictType?>()) {
      return (data != null ? _i9.DictType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.InventoryLog?>()) {
      return (data != null ? _i10.InventoryLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Party?>()) {
      return (data != null ? _i11.Party.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Promotion?>()) {
      return (data != null ? _i12.Promotion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Region?>()) {
      return (data != null ? _i13.Region.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.RolePermission?>()) {
      return (data != null ? _i14.RolePermission.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SysOperationLog?>()) {
      return (data != null ? _i15.SysOperationLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.SysResource?>()) {
      return (data != null ? _i16.SysResource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.SysRole?>()) {
      return (data != null ? _i17.SysRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.SysRoleResource?>()) {
      return (data != null ? _i18.SysRoleResource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.SysUser?>()) {
      return (data != null ? _i19.SysUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.SysUserRole?>()) {
      return (data != null ? _i20.SysUserRole.fromJson(data) : null) as T;
    }
    if (t == List<_i21.Book>) {
      return (data as List).map((e) => deserialize<_i21.Book>(e)).toList()
          as dynamic;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.Book) {
      return 'Book';
    }
    if (data is _i3.BookCategory) {
      return 'BookCategory';
    }
    if (data is _i4.BookPackage) {
      return 'BookPackage';
    }
    if (data is _i5.BookPackageItem) {
      return 'BookPackageItem';
    }
    if (data is _i6.BookSale) {
      return 'BookSale';
    }
    if (data is _i7.Customer) {
      return 'Customer';
    }
    if (data is _i8.DictItem) {
      return 'DictItem';
    }
    if (data is _i9.DictType) {
      return 'DictType';
    }
    if (data is _i10.InventoryLog) {
      return 'InventoryLog';
    }
    if (data is _i11.Party) {
      return 'Party';
    }
    if (data is _i12.Promotion) {
      return 'Promotion';
    }
    if (data is _i13.Region) {
      return 'Region';
    }
    if (data is _i14.RolePermission) {
      return 'RolePermission';
    }
    if (data is _i15.SysOperationLog) {
      return 'SysOperationLog';
    }
    if (data is _i16.SysResource) {
      return 'SysResource';
    }
    if (data is _i17.SysRole) {
      return 'SysRole';
    }
    if (data is _i18.SysRoleResource) {
      return 'SysRoleResource';
    }
    if (data is _i19.SysUser) {
      return 'SysUser';
    }
    if (data is _i20.SysUserRole) {
      return 'SysUserRole';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i2.Book>(data['data']);
    }
    if (dataClassName == 'BookCategory') {
      return deserialize<_i3.BookCategory>(data['data']);
    }
    if (dataClassName == 'BookPackage') {
      return deserialize<_i4.BookPackage>(data['data']);
    }
    if (dataClassName == 'BookPackageItem') {
      return deserialize<_i5.BookPackageItem>(data['data']);
    }
    if (dataClassName == 'BookSale') {
      return deserialize<_i6.BookSale>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i7.Customer>(data['data']);
    }
    if (dataClassName == 'DictItem') {
      return deserialize<_i8.DictItem>(data['data']);
    }
    if (dataClassName == 'DictType') {
      return deserialize<_i9.DictType>(data['data']);
    }
    if (dataClassName == 'InventoryLog') {
      return deserialize<_i10.InventoryLog>(data['data']);
    }
    if (dataClassName == 'Party') {
      return deserialize<_i11.Party>(data['data']);
    }
    if (dataClassName == 'Promotion') {
      return deserialize<_i12.Promotion>(data['data']);
    }
    if (dataClassName == 'Region') {
      return deserialize<_i13.Region>(data['data']);
    }
    if (dataClassName == 'RolePermission') {
      return deserialize<_i14.RolePermission>(data['data']);
    }
    if (dataClassName == 'SysOperationLog') {
      return deserialize<_i15.SysOperationLog>(data['data']);
    }
    if (dataClassName == 'SysResource') {
      return deserialize<_i16.SysResource>(data['data']);
    }
    if (dataClassName == 'SysRole') {
      return deserialize<_i17.SysRole>(data['data']);
    }
    if (dataClassName == 'SysRoleResource') {
      return deserialize<_i18.SysRoleResource>(data['data']);
    }
    if (dataClassName == 'SysUser') {
      return deserialize<_i19.SysUser>(data['data']);
    }
    if (dataClassName == 'SysUserRole') {
      return deserialize<_i20.SysUserRole>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
