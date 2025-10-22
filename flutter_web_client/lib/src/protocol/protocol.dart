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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'auth/login_response.dart' as _i2;
import 'system/infra_api_error_log.dart' as _i3;
import 'book/book_category.dart' as _i4;
import 'book/book_inventory_log.dart' as _i5;
import 'book/book_package.dart' as _i6;
import 'book/book_package_item.dart' as _i7;
import 'book/book_sale.dart' as _i8;
import 'custom/customer.dart' as _i9;
import 'region.dart' as _i10;
import 'store/store.dart' as _i11;
import 'store/store_activity.dart' as _i12;
import 'store/store_activity_book.dart' as _i13;
import 'store/store_book.dart' as _i14;
import 'store/store_sales_record.dart' as _i15;
import 'zhouyi/qimen.dart' as _i16;
import 'system/infra_api_access_log.dart' as _i17;
import 'book/book.dart' as _i18;
import 'system/infra_file.dart' as _i19;
import 'system/infra_file_config.dart' as _i20;
import 'system/infra_file_content.dart' as _i21;
import 'system/infra_job.dart' as _i22;
import 'system/infra_job_log.dart' as _i23;
import 'system/sys_dept.dart' as _i24;
import 'system/sys_dict_data.dart' as _i25;
import 'system/sys_dict_type.dart' as _i26;
import 'system/sys_login_log.dart' as _i27;
import 'system/sys_mail_account.dart' as _i28;
import 'system/sys_mail_log.dart' as _i29;
import 'system/sys_mail_template.dart' as _i30;
import 'system/sys_menu.dart' as _i31;
import 'system/sys_notice.dart' as _i32;
import 'system/sys_notify_message.dart' as _i33;
import 'system/sys_user_role.dart' as _i34;
import 'system/sys_operate_log.dart' as _i35;
import 'system/sys_post.dart' as _i36;
import 'system/sys_role.dart' as _i37;
import 'system/sys_role_menu.dart' as _i38;
import 'system/sys_sms_channel.dart' as _i39;
import 'system/sys_sms_code.dart' as _i40;
import 'system/sys_sms_log.dart' as _i41;
import 'system/sys_sms_template.dart' as _i42;
import 'system/sys_social_client.dart' as _i43;
import 'system/sys_social_user.dart' as _i44;
import 'system/sys_social_user_bind.dart' as _i45;
import 'system/sys_tenant.dart' as _i46;
import 'system/sys_tenant_package.dart' as _i47;
import 'system/sys_user.dart' as _i48;
import 'system/sys_user_post.dart' as _i49;
import 'system/sys_notify_template.dart' as _i50;
import 'package:flutter_web_admin_shared/flutter_web_admin_shared.dart' as _i51;
export 'auth/login_response.dart';
export 'book/book.dart';
export 'book/book_category.dart';
export 'book/book_inventory_log.dart';
export 'book/book_package.dart';
export 'book/book_package_item.dart';
export 'book/book_sale.dart';
export 'custom/customer.dart';
export 'region.dart';
export 'store/store.dart';
export 'store/store_activity.dart';
export 'store/store_activity_book.dart';
export 'store/store_book.dart';
export 'store/store_sales_record.dart';
export 'zhouyi/qimen.dart';
export 'system/infra_api_access_log.dart';
export 'system/infra_api_error_log.dart';
export 'system/infra_file.dart';
export 'system/infra_file_config.dart';
export 'system/infra_file_content.dart';
export 'system/infra_job.dart';
export 'system/infra_job_log.dart';
export 'system/sys_dept.dart';
export 'system/sys_dict_data.dart';
export 'system/sys_dict_type.dart';
export 'system/sys_login_log.dart';
export 'system/sys_mail_account.dart';
export 'system/sys_mail_log.dart';
export 'system/sys_mail_template.dart';
export 'system/sys_menu.dart';
export 'system/sys_notice.dart';
export 'system/sys_notify_message.dart';
export 'system/sys_notify_template.dart';
export 'system/sys_operate_log.dart';
export 'system/sys_post.dart';
export 'system/sys_role.dart';
export 'system/sys_role_menu.dart';
export 'system/sys_sms_channel.dart';
export 'system/sys_sms_code.dart';
export 'system/sys_sms_log.dart';
export 'system/sys_sms_template.dart';
export 'system/sys_social_client.dart';
export 'system/sys_social_user.dart';
export 'system/sys_social_user_bind.dart';
export 'system/sys_tenant.dart';
export 'system/sys_tenant_package.dart';
export 'system/sys_user.dart';
export 'system/sys_user_post.dart';
export 'system/sys_user_role.dart';
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
    if (t == _i2.LoginResponse) {
      return _i2.LoginResponse.fromJson(data) as T;
    }
    if (t == _i3.InfraApiErrorLog) {
      return _i3.InfraApiErrorLog.fromJson(data) as T;
    }
    if (t == _i4.BookCategory) {
      return _i4.BookCategory.fromJson(data) as T;
    }
    if (t == _i5.BookInventoryLog) {
      return _i5.BookInventoryLog.fromJson(data) as T;
    }
    if (t == _i6.BookPackage) {
      return _i6.BookPackage.fromJson(data) as T;
    }
    if (t == _i7.BookPackageItem) {
      return _i7.BookPackageItem.fromJson(data) as T;
    }
    if (t == _i8.BookSale) {
      return _i8.BookSale.fromJson(data) as T;
    }
    if (t == _i9.Customer) {
      return _i9.Customer.fromJson(data) as T;
    }
    if (t == _i10.Region) {
      return _i10.Region.fromJson(data) as T;
    }
    if (t == _i11.Store) {
      return _i11.Store.fromJson(data) as T;
    }
    if (t == _i12.StoreActivity) {
      return _i12.StoreActivity.fromJson(data) as T;
    }
    if (t == _i13.StoreActivityBook) {
      return _i13.StoreActivityBook.fromJson(data) as T;
    }
    if (t == _i14.StoreBook) {
      return _i14.StoreBook.fromJson(data) as T;
    }
    if (t == _i15.StoreSalesRecord) {
      return _i15.StoreSalesRecord.fromJson(data) as T;
    }
    if (t == _i16.Qimen) {
      return _i16.Qimen.fromJson(data) as T;
    }
    if (t == _i17.InfraApiAccessLog) {
      return _i17.InfraApiAccessLog.fromJson(data) as T;
    }
    if (t == _i18.Book) {
      return _i18.Book.fromJson(data) as T;
    }
    if (t == _i19.InfraFile) {
      return _i19.InfraFile.fromJson(data) as T;
    }
    if (t == _i20.InfraFileConfig) {
      return _i20.InfraFileConfig.fromJson(data) as T;
    }
    if (t == _i21.InfraFileContent) {
      return _i21.InfraFileContent.fromJson(data) as T;
    }
    if (t == _i22.InfraJob) {
      return _i22.InfraJob.fromJson(data) as T;
    }
    if (t == _i23.InfraJobLog) {
      return _i23.InfraJobLog.fromJson(data) as T;
    }
    if (t == _i24.SysDept) {
      return _i24.SysDept.fromJson(data) as T;
    }
    if (t == _i25.SysDictData) {
      return _i25.SysDictData.fromJson(data) as T;
    }
    if (t == _i26.SysDictType) {
      return _i26.SysDictType.fromJson(data) as T;
    }
    if (t == _i27.SysLoginLog) {
      return _i27.SysLoginLog.fromJson(data) as T;
    }
    if (t == _i28.SysMailAccount) {
      return _i28.SysMailAccount.fromJson(data) as T;
    }
    if (t == _i29.SysMailLog) {
      return _i29.SysMailLog.fromJson(data) as T;
    }
    if (t == _i30.SysMailTemplate) {
      return _i30.SysMailTemplate.fromJson(data) as T;
    }
    if (t == _i31.SysMenu) {
      return _i31.SysMenu.fromJson(data) as T;
    }
    if (t == _i32.SysNotice) {
      return _i32.SysNotice.fromJson(data) as T;
    }
    if (t == _i33.SysNotifyMessage) {
      return _i33.SysNotifyMessage.fromJson(data) as T;
    }
    if (t == _i34.SysUserRole) {
      return _i34.SysUserRole.fromJson(data) as T;
    }
    if (t == _i35.SysOperateLog) {
      return _i35.SysOperateLog.fromJson(data) as T;
    }
    if (t == _i36.SysPost) {
      return _i36.SysPost.fromJson(data) as T;
    }
    if (t == _i37.SysRole) {
      return _i37.SysRole.fromJson(data) as T;
    }
    if (t == _i38.SysRoleMenu) {
      return _i38.SysRoleMenu.fromJson(data) as T;
    }
    if (t == _i39.SysSmsChannel) {
      return _i39.SysSmsChannel.fromJson(data) as T;
    }
    if (t == _i40.SysSmsCode) {
      return _i40.SysSmsCode.fromJson(data) as T;
    }
    if (t == _i41.SysSmsLog) {
      return _i41.SysSmsLog.fromJson(data) as T;
    }
    if (t == _i42.SysSmsTemplate) {
      return _i42.SysSmsTemplate.fromJson(data) as T;
    }
    if (t == _i43.SysSocialClient) {
      return _i43.SysSocialClient.fromJson(data) as T;
    }
    if (t == _i44.SysSocialUser) {
      return _i44.SysSocialUser.fromJson(data) as T;
    }
    if (t == _i45.SysSocialUserBind) {
      return _i45.SysSocialUserBind.fromJson(data) as T;
    }
    if (t == _i46.SysTenant) {
      return _i46.SysTenant.fromJson(data) as T;
    }
    if (t == _i47.SysTenantPackage) {
      return _i47.SysTenantPackage.fromJson(data) as T;
    }
    if (t == _i48.SysUser) {
      return _i48.SysUser.fromJson(data) as T;
    }
    if (t == _i49.SysUserPost) {
      return _i49.SysUserPost.fromJson(data) as T;
    }
    if (t == _i50.SysNotifyTemplate) {
      return _i50.SysNotifyTemplate.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.LoginResponse?>()) {
      return (data != null ? _i2.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.InfraApiErrorLog?>()) {
      return (data != null ? _i3.InfraApiErrorLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.BookCategory?>()) {
      return (data != null ? _i4.BookCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BookInventoryLog?>()) {
      return (data != null ? _i5.BookInventoryLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.BookPackage?>()) {
      return (data != null ? _i6.BookPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.BookPackageItem?>()) {
      return (data != null ? _i7.BookPackageItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.BookSale?>()) {
      return (data != null ? _i8.BookSale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Customer?>()) {
      return (data != null ? _i9.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Region?>()) {
      return (data != null ? _i10.Region.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Store?>()) {
      return (data != null ? _i11.Store.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.StoreActivity?>()) {
      return (data != null ? _i12.StoreActivity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.StoreActivityBook?>()) {
      return (data != null ? _i13.StoreActivityBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.StoreBook?>()) {
      return (data != null ? _i14.StoreBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.StoreSalesRecord?>()) {
      return (data != null ? _i15.StoreSalesRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Qimen?>()) {
      return (data != null ? _i16.Qimen.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.InfraApiAccessLog?>()) {
      return (data != null ? _i17.InfraApiAccessLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Book?>()) {
      return (data != null ? _i18.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.InfraFile?>()) {
      return (data != null ? _i19.InfraFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.InfraFileConfig?>()) {
      return (data != null ? _i20.InfraFileConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.InfraFileContent?>()) {
      return (data != null ? _i21.InfraFileContent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.InfraJob?>()) {
      return (data != null ? _i22.InfraJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.InfraJobLog?>()) {
      return (data != null ? _i23.InfraJobLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.SysDept?>()) {
      return (data != null ? _i24.SysDept.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.SysDictData?>()) {
      return (data != null ? _i25.SysDictData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.SysDictType?>()) {
      return (data != null ? _i26.SysDictType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SysLoginLog?>()) {
      return (data != null ? _i27.SysLoginLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SysMailAccount?>()) {
      return (data != null ? _i28.SysMailAccount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SysMailLog?>()) {
      return (data != null ? _i29.SysMailLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SysMailTemplate?>()) {
      return (data != null ? _i30.SysMailTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SysMenu?>()) {
      return (data != null ? _i31.SysMenu.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SysNotice?>()) {
      return (data != null ? _i32.SysNotice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.SysNotifyMessage?>()) {
      return (data != null ? _i33.SysNotifyMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SysUserRole?>()) {
      return (data != null ? _i34.SysUserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.SysOperateLog?>()) {
      return (data != null ? _i35.SysOperateLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.SysPost?>()) {
      return (data != null ? _i36.SysPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.SysRole?>()) {
      return (data != null ? _i37.SysRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.SysRoleMenu?>()) {
      return (data != null ? _i38.SysRoleMenu.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.SysSmsChannel?>()) {
      return (data != null ? _i39.SysSmsChannel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.SysSmsCode?>()) {
      return (data != null ? _i40.SysSmsCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.SysSmsLog?>()) {
      return (data != null ? _i41.SysSmsLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SysSmsTemplate?>()) {
      return (data != null ? _i42.SysSmsTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.SysSocialClient?>()) {
      return (data != null ? _i43.SysSocialClient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SysSocialUser?>()) {
      return (data != null ? _i44.SysSocialUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SysSocialUserBind?>()) {
      return (data != null ? _i45.SysSocialUserBind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SysTenant?>()) {
      return (data != null ? _i46.SysTenant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SysTenantPackage?>()) {
      return (data != null ? _i47.SysTenantPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SysUser?>()) {
      return (data != null ? _i48.SysUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SysUserPost?>()) {
      return (data != null ? _i49.SysUserPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.SysNotifyTemplate?>()) {
      return (data != null ? _i50.SysNotifyTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.SysMenu>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.SysMenu>(e)).toList()
          : null) as T;
    }
    if (t == _i51.BaseResponse) {
      return _i51.BaseResponse.fromJson(data) as T;
    }
    if (t == _i51.CommonResponse) {
      return _i51.CommonResponse.fromJson(data) as T;
    }
    if (t == _i51.PageResponse) {
      return _i51.PageResponse.fromJson(data) as T;
    }
    if (t == _i1.getType<_i51.BaseResponse?>()) {
      return (data != null ? _i51.BaseResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.CommonResponse?>()) {
      return (data != null ? _i51.CommonResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.PageResponse?>()) {
      return (data != null ? _i51.PageResponse.fromJson(data) : null) as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    switch (data) {
      case _i51.BaseResponse():
        return 'BaseResponse';
      case _i51.CommonResponse():
        return 'CommonResponse';
      case _i51.PageResponse():
        return 'PageResponse';
      case _i2.LoginResponse():
        return 'LoginResponse';
      case _i3.InfraApiErrorLog():
        return 'InfraApiErrorLog';
      case _i4.BookCategory():
        return 'BookCategory';
      case _i5.BookInventoryLog():
        return 'BookInventoryLog';
      case _i6.BookPackage():
        return 'BookPackage';
      case _i7.BookPackageItem():
        return 'BookPackageItem';
      case _i8.BookSale():
        return 'BookSale';
      case _i9.Customer():
        return 'Customer';
      case _i10.Region():
        return 'Region';
      case _i11.Store():
        return 'Store';
      case _i12.StoreActivity():
        return 'StoreActivity';
      case _i13.StoreActivityBook():
        return 'StoreActivityBook';
      case _i14.StoreBook():
        return 'StoreBook';
      case _i15.StoreSalesRecord():
        return 'StoreSalesRecord';
      case _i16.Qimen():
        return 'Qimen';
      case _i17.InfraApiAccessLog():
        return 'InfraApiAccessLog';
      case _i18.Book():
        return 'Book';
      case _i19.InfraFile():
        return 'InfraFile';
      case _i20.InfraFileConfig():
        return 'InfraFileConfig';
      case _i21.InfraFileContent():
        return 'InfraFileContent';
      case _i22.InfraJob():
        return 'InfraJob';
      case _i23.InfraJobLog():
        return 'InfraJobLog';
      case _i24.SysDept():
        return 'SysDept';
      case _i25.SysDictData():
        return 'SysDictData';
      case _i26.SysDictType():
        return 'SysDictType';
      case _i27.SysLoginLog():
        return 'SysLoginLog';
      case _i28.SysMailAccount():
        return 'SysMailAccount';
      case _i29.SysMailLog():
        return 'SysMailLog';
      case _i30.SysMailTemplate():
        return 'SysMailTemplate';
      case _i31.SysMenu():
        return 'SysMenu';
      case _i32.SysNotice():
        return 'SysNotice';
      case _i33.SysNotifyMessage():
        return 'SysNotifyMessage';
      case _i34.SysUserRole():
        return 'SysUserRole';
      case _i35.SysOperateLog():
        return 'SysOperateLog';
      case _i36.SysPost():
        return 'SysPost';
      case _i37.SysRole():
        return 'SysRole';
      case _i38.SysRoleMenu():
        return 'SysRoleMenu';
      case _i39.SysSmsChannel():
        return 'SysSmsChannel';
      case _i40.SysSmsCode():
        return 'SysSmsCode';
      case _i41.SysSmsLog():
        return 'SysSmsLog';
      case _i42.SysSmsTemplate():
        return 'SysSmsTemplate';
      case _i43.SysSocialClient():
        return 'SysSocialClient';
      case _i44.SysSocialUser():
        return 'SysSocialUser';
      case _i45.SysSocialUserBind():
        return 'SysSocialUserBind';
      case _i46.SysTenant():
        return 'SysTenant';
      case _i47.SysTenantPackage():
        return 'SysTenantPackage';
      case _i48.SysUser():
        return 'SysUser';
      case _i49.SysUserPost():
        return 'SysUserPost';
      case _i50.SysNotifyTemplate():
        return 'SysNotifyTemplate';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'BaseResponse') {
      return deserialize<_i51.BaseResponse>(data['data']);
    }
    if (dataClassName == 'CommonResponse') {
      return deserialize<_i51.CommonResponse>(data['data']);
    }
    if (dataClassName == 'PageResponse') {
      return deserialize<_i51.PageResponse>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i2.LoginResponse>(data['data']);
    }
    if (dataClassName == 'InfraApiErrorLog') {
      return deserialize<_i3.InfraApiErrorLog>(data['data']);
    }
    if (dataClassName == 'BookCategory') {
      return deserialize<_i4.BookCategory>(data['data']);
    }
    if (dataClassName == 'BookInventoryLog') {
      return deserialize<_i5.BookInventoryLog>(data['data']);
    }
    if (dataClassName == 'BookPackage') {
      return deserialize<_i6.BookPackage>(data['data']);
    }
    if (dataClassName == 'BookPackageItem') {
      return deserialize<_i7.BookPackageItem>(data['data']);
    }
    if (dataClassName == 'BookSale') {
      return deserialize<_i8.BookSale>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i9.Customer>(data['data']);
    }
    if (dataClassName == 'Region') {
      return deserialize<_i10.Region>(data['data']);
    }
    if (dataClassName == 'Store') {
      return deserialize<_i11.Store>(data['data']);
    }
    if (dataClassName == 'StoreActivity') {
      return deserialize<_i12.StoreActivity>(data['data']);
    }
    if (dataClassName == 'StoreActivityBook') {
      return deserialize<_i13.StoreActivityBook>(data['data']);
    }
    if (dataClassName == 'StoreBook') {
      return deserialize<_i14.StoreBook>(data['data']);
    }
    if (dataClassName == 'StoreSalesRecord') {
      return deserialize<_i15.StoreSalesRecord>(data['data']);
    }
    if (dataClassName == 'Qimen') {
      return deserialize<_i16.Qimen>(data['data']);
    }
    if (dataClassName == 'InfraApiAccessLog') {
      return deserialize<_i17.InfraApiAccessLog>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i18.Book>(data['data']);
    }
    if (dataClassName == 'InfraFile') {
      return deserialize<_i19.InfraFile>(data['data']);
    }
    if (dataClassName == 'InfraFileConfig') {
      return deserialize<_i20.InfraFileConfig>(data['data']);
    }
    if (dataClassName == 'InfraFileContent') {
      return deserialize<_i21.InfraFileContent>(data['data']);
    }
    if (dataClassName == 'InfraJob') {
      return deserialize<_i22.InfraJob>(data['data']);
    }
    if (dataClassName == 'InfraJobLog') {
      return deserialize<_i23.InfraJobLog>(data['data']);
    }
    if (dataClassName == 'SysDept') {
      return deserialize<_i24.SysDept>(data['data']);
    }
    if (dataClassName == 'SysDictData') {
      return deserialize<_i25.SysDictData>(data['data']);
    }
    if (dataClassName == 'SysDictType') {
      return deserialize<_i26.SysDictType>(data['data']);
    }
    if (dataClassName == 'SysLoginLog') {
      return deserialize<_i27.SysLoginLog>(data['data']);
    }
    if (dataClassName == 'SysMailAccount') {
      return deserialize<_i28.SysMailAccount>(data['data']);
    }
    if (dataClassName == 'SysMailLog') {
      return deserialize<_i29.SysMailLog>(data['data']);
    }
    if (dataClassName == 'SysMailTemplate') {
      return deserialize<_i30.SysMailTemplate>(data['data']);
    }
    if (dataClassName == 'SysMenu') {
      return deserialize<_i31.SysMenu>(data['data']);
    }
    if (dataClassName == 'SysNotice') {
      return deserialize<_i32.SysNotice>(data['data']);
    }
    if (dataClassName == 'SysNotifyMessage') {
      return deserialize<_i33.SysNotifyMessage>(data['data']);
    }
    if (dataClassName == 'SysUserRole') {
      return deserialize<_i34.SysUserRole>(data['data']);
    }
    if (dataClassName == 'SysOperateLog') {
      return deserialize<_i35.SysOperateLog>(data['data']);
    }
    if (dataClassName == 'SysPost') {
      return deserialize<_i36.SysPost>(data['data']);
    }
    if (dataClassName == 'SysRole') {
      return deserialize<_i37.SysRole>(data['data']);
    }
    if (dataClassName == 'SysRoleMenu') {
      return deserialize<_i38.SysRoleMenu>(data['data']);
    }
    if (dataClassName == 'SysSmsChannel') {
      return deserialize<_i39.SysSmsChannel>(data['data']);
    }
    if (dataClassName == 'SysSmsCode') {
      return deserialize<_i40.SysSmsCode>(data['data']);
    }
    if (dataClassName == 'SysSmsLog') {
      return deserialize<_i41.SysSmsLog>(data['data']);
    }
    if (dataClassName == 'SysSmsTemplate') {
      return deserialize<_i42.SysSmsTemplate>(data['data']);
    }
    if (dataClassName == 'SysSocialClient') {
      return deserialize<_i43.SysSocialClient>(data['data']);
    }
    if (dataClassName == 'SysSocialUser') {
      return deserialize<_i44.SysSocialUser>(data['data']);
    }
    if (dataClassName == 'SysSocialUserBind') {
      return deserialize<_i45.SysSocialUserBind>(data['data']);
    }
    if (dataClassName == 'SysTenant') {
      return deserialize<_i46.SysTenant>(data['data']);
    }
    if (dataClassName == 'SysTenantPackage') {
      return deserialize<_i47.SysTenantPackage>(data['data']);
    }
    if (dataClassName == 'SysUser') {
      return deserialize<_i48.SysUser>(data['data']);
    }
    if (dataClassName == 'SysUserPost') {
      return deserialize<_i49.SysUserPost>(data['data']);
    }
    if (dataClassName == 'SysNotifyTemplate') {
      return deserialize<_i50.SysNotifyTemplate>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
