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
import 'store/store_activity_book.dart' as _i3;
import 'airtable/table_fields_summary.dart' as _i4;
import 'airtable/table_items.dart' as _i5;
import 'airtable/table_rows.dart' as _i6;
import 'airtable/tables.dart' as _i7;
import 'airtable/table_fields.dart' as _i8;
import 'book/book.dart' as _i9;
import 'book/book_category.dart' as _i10;
import 'book/book_inventory_log.dart' as _i11;
import 'book/book_package.dart' as _i12;
import 'book/book_package_item.dart' as _i13;
import 'book/book_sale.dart' as _i14;
import 'common/pagination.dart' as _i15;
import 'custom/customer.dart' as _i16;
import 'region.dart' as _i17;
import 'store/store.dart' as _i18;
import 'store/store_activity.dart' as _i19;
import 'airtable/table_detail.dart' as _i20;
import 'store/store_book.dart' as _i21;
import 'store/store_sales_record.dart' as _i22;
import 'zhouyi/qimen.dart' as _i23;
import 'system/infra_api_access_log.dart' as _i24;
import 'system/infra_api_error_log.dart' as _i25;
import 'system/infra_file.dart' as _i26;
import 'system/infra_file_config.dart' as _i27;
import 'system/infra_file_content.dart' as _i28;
import 'system/infra_job.dart' as _i29;
import 'system/infra_job_log.dart' as _i30;
import 'system/sys_dept.dart' as _i31;
import 'system/sys_dict_data.dart' as _i32;
import 'system/sys_dict_type.dart' as _i33;
import 'system/sys_login_log.dart' as _i34;
import 'system/sys_mail_account.dart' as _i35;
import 'system/sys_mail_log.dart' as _i36;
import 'system/sys_mail_template.dart' as _i37;
import 'system/sys_user_role.dart' as _i38;
import 'system/sys_notice.dart' as _i39;
import 'system/sys_notify_message.dart' as _i40;
import 'system/sys_notify_template.dart' as _i41;
import 'system/sys_operate_log.dart' as _i42;
import 'system/sys_post.dart' as _i43;
import 'system/sys_role.dart' as _i44;
import 'system/sys_role_menu.dart' as _i45;
import 'system/sys_sms_channel.dart' as _i46;
import 'system/sys_sms_code.dart' as _i47;
import 'system/sys_sms_log.dart' as _i48;
import 'system/sys_sms_template.dart' as _i49;
import 'system/sys_social_client.dart' as _i50;
import 'system/sys_social_user.dart' as _i51;
import 'system/sys_social_user_bind.dart' as _i52;
import 'system/sys_tenant.dart' as _i53;
import 'system/sys_tenant_package.dart' as _i54;
import 'system/sys_user.dart' as _i55;
import 'system/sys_user_post.dart' as _i56;
import 'system/sys_menu.dart' as _i57;
import 'package:flutter_web_shared/shared.dart' as _i58;
export 'airtable/table_detail.dart';
export 'airtable/table_fields.dart';
export 'airtable/table_fields_summary.dart';
export 'airtable/table_items.dart';
export 'airtable/table_rows.dart';
export 'airtable/tables.dart';
export 'auth/login_response.dart';
export 'book/book.dart';
export 'book/book_category.dart';
export 'book/book_inventory_log.dart';
export 'book/book_package.dart';
export 'book/book_package_item.dart';
export 'book/book_sale.dart';
export 'common/pagination.dart';
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
    if (t == _i3.StoreActivityBook) {
      return _i3.StoreActivityBook.fromJson(data) as T;
    }
    if (t == _i4.AirTableFieldsSummary) {
      return _i4.AirTableFieldsSummary.fromJson(data) as T;
    }
    if (t == _i5.AirTableItems) {
      return _i5.AirTableItems.fromJson(data) as T;
    }
    if (t == _i6.AirTableRows) {
      return _i6.AirTableRows.fromJson(data) as T;
    }
    if (t == _i7.AirTables) {
      return _i7.AirTables.fromJson(data) as T;
    }
    if (t == _i8.AirTableFields) {
      return _i8.AirTableFields.fromJson(data) as T;
    }
    if (t == _i9.Book) {
      return _i9.Book.fromJson(data) as T;
    }
    if (t == _i10.BookCategory) {
      return _i10.BookCategory.fromJson(data) as T;
    }
    if (t == _i11.BookInventoryLog) {
      return _i11.BookInventoryLog.fromJson(data) as T;
    }
    if (t == _i12.BookPackage) {
      return _i12.BookPackage.fromJson(data) as T;
    }
    if (t == _i13.BookPackageItem) {
      return _i13.BookPackageItem.fromJson(data) as T;
    }
    if (t == _i14.BookSale) {
      return _i14.BookSale.fromJson(data) as T;
    }
    if (t == _i15.Pagination) {
      return _i15.Pagination.fromJson(data) as T;
    }
    if (t == _i16.Customer) {
      return _i16.Customer.fromJson(data) as T;
    }
    if (t == _i17.Region) {
      return _i17.Region.fromJson(data) as T;
    }
    if (t == _i18.Store) {
      return _i18.Store.fromJson(data) as T;
    }
    if (t == _i19.StoreActivity) {
      return _i19.StoreActivity.fromJson(data) as T;
    }
    if (t == _i20.AirTableDetail) {
      return _i20.AirTableDetail.fromJson(data) as T;
    }
    if (t == _i21.StoreBook) {
      return _i21.StoreBook.fromJson(data) as T;
    }
    if (t == _i22.StoreSalesRecord) {
      return _i22.StoreSalesRecord.fromJson(data) as T;
    }
    if (t == _i23.Qimen) {
      return _i23.Qimen.fromJson(data) as T;
    }
    if (t == _i24.InfraApiAccessLog) {
      return _i24.InfraApiAccessLog.fromJson(data) as T;
    }
    if (t == _i25.InfraApiErrorLog) {
      return _i25.InfraApiErrorLog.fromJson(data) as T;
    }
    if (t == _i26.InfraFile) {
      return _i26.InfraFile.fromJson(data) as T;
    }
    if (t == _i27.InfraFileConfig) {
      return _i27.InfraFileConfig.fromJson(data) as T;
    }
    if (t == _i28.InfraFileContent) {
      return _i28.InfraFileContent.fromJson(data) as T;
    }
    if (t == _i29.InfraJob) {
      return _i29.InfraJob.fromJson(data) as T;
    }
    if (t == _i30.InfraJobLog) {
      return _i30.InfraJobLog.fromJson(data) as T;
    }
    if (t == _i31.SysDept) {
      return _i31.SysDept.fromJson(data) as T;
    }
    if (t == _i32.SysDictData) {
      return _i32.SysDictData.fromJson(data) as T;
    }
    if (t == _i33.SysDictType) {
      return _i33.SysDictType.fromJson(data) as T;
    }
    if (t == _i34.SysLoginLog) {
      return _i34.SysLoginLog.fromJson(data) as T;
    }
    if (t == _i35.SysMailAccount) {
      return _i35.SysMailAccount.fromJson(data) as T;
    }
    if (t == _i36.SysMailLog) {
      return _i36.SysMailLog.fromJson(data) as T;
    }
    if (t == _i37.SysMailTemplate) {
      return _i37.SysMailTemplate.fromJson(data) as T;
    }
    if (t == _i38.SysUserRole) {
      return _i38.SysUserRole.fromJson(data) as T;
    }
    if (t == _i39.SysNotice) {
      return _i39.SysNotice.fromJson(data) as T;
    }
    if (t == _i40.SysNotifyMessage) {
      return _i40.SysNotifyMessage.fromJson(data) as T;
    }
    if (t == _i41.SysNotifyTemplate) {
      return _i41.SysNotifyTemplate.fromJson(data) as T;
    }
    if (t == _i42.SysOperateLog) {
      return _i42.SysOperateLog.fromJson(data) as T;
    }
    if (t == _i43.SysPost) {
      return _i43.SysPost.fromJson(data) as T;
    }
    if (t == _i44.SysRole) {
      return _i44.SysRole.fromJson(data) as T;
    }
    if (t == _i45.SysRoleMenu) {
      return _i45.SysRoleMenu.fromJson(data) as T;
    }
    if (t == _i46.SysSmsChannel) {
      return _i46.SysSmsChannel.fromJson(data) as T;
    }
    if (t == _i47.SysSmsCode) {
      return _i47.SysSmsCode.fromJson(data) as T;
    }
    if (t == _i48.SysSmsLog) {
      return _i48.SysSmsLog.fromJson(data) as T;
    }
    if (t == _i49.SysSmsTemplate) {
      return _i49.SysSmsTemplate.fromJson(data) as T;
    }
    if (t == _i50.SysSocialClient) {
      return _i50.SysSocialClient.fromJson(data) as T;
    }
    if (t == _i51.SysSocialUser) {
      return _i51.SysSocialUser.fromJson(data) as T;
    }
    if (t == _i52.SysSocialUserBind) {
      return _i52.SysSocialUserBind.fromJson(data) as T;
    }
    if (t == _i53.SysTenant) {
      return _i53.SysTenant.fromJson(data) as T;
    }
    if (t == _i54.SysTenantPackage) {
      return _i54.SysTenantPackage.fromJson(data) as T;
    }
    if (t == _i55.SysUser) {
      return _i55.SysUser.fromJson(data) as T;
    }
    if (t == _i56.SysUserPost) {
      return _i56.SysUserPost.fromJson(data) as T;
    }
    if (t == _i57.SysMenu) {
      return _i57.SysMenu.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.LoginResponse?>()) {
      return (data != null ? _i2.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.StoreActivityBook?>()) {
      return (data != null ? _i3.StoreActivityBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AirTableFieldsSummary?>()) {
      return (data != null ? _i4.AirTableFieldsSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.AirTableItems?>()) {
      return (data != null ? _i5.AirTableItems.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AirTableRows?>()) {
      return (data != null ? _i6.AirTableRows.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AirTables?>()) {
      return (data != null ? _i7.AirTables.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AirTableFields?>()) {
      return (data != null ? _i8.AirTableFields.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Book?>()) {
      return (data != null ? _i9.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.BookCategory?>()) {
      return (data != null ? _i10.BookCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.BookInventoryLog?>()) {
      return (data != null ? _i11.BookInventoryLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.BookPackage?>()) {
      return (data != null ? _i12.BookPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.BookPackageItem?>()) {
      return (data != null ? _i13.BookPackageItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.BookSale?>()) {
      return (data != null ? _i14.BookSale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Pagination?>()) {
      return (data != null ? _i15.Pagination.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Customer?>()) {
      return (data != null ? _i16.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Region?>()) {
      return (data != null ? _i17.Region.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Store?>()) {
      return (data != null ? _i18.Store.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.StoreActivity?>()) {
      return (data != null ? _i19.StoreActivity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.AirTableDetail?>()) {
      return (data != null ? _i20.AirTableDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.StoreBook?>()) {
      return (data != null ? _i21.StoreBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.StoreSalesRecord?>()) {
      return (data != null ? _i22.StoreSalesRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Qimen?>()) {
      return (data != null ? _i23.Qimen.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.InfraApiAccessLog?>()) {
      return (data != null ? _i24.InfraApiAccessLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.InfraApiErrorLog?>()) {
      return (data != null ? _i25.InfraApiErrorLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.InfraFile?>()) {
      return (data != null ? _i26.InfraFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.InfraFileConfig?>()) {
      return (data != null ? _i27.InfraFileConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.InfraFileContent?>()) {
      return (data != null ? _i28.InfraFileContent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.InfraJob?>()) {
      return (data != null ? _i29.InfraJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.InfraJobLog?>()) {
      return (data != null ? _i30.InfraJobLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SysDept?>()) {
      return (data != null ? _i31.SysDept.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SysDictData?>()) {
      return (data != null ? _i32.SysDictData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.SysDictType?>()) {
      return (data != null ? _i33.SysDictType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SysLoginLog?>()) {
      return (data != null ? _i34.SysLoginLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.SysMailAccount?>()) {
      return (data != null ? _i35.SysMailAccount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.SysMailLog?>()) {
      return (data != null ? _i36.SysMailLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.SysMailTemplate?>()) {
      return (data != null ? _i37.SysMailTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.SysUserRole?>()) {
      return (data != null ? _i38.SysUserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.SysNotice?>()) {
      return (data != null ? _i39.SysNotice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.SysNotifyMessage?>()) {
      return (data != null ? _i40.SysNotifyMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.SysNotifyTemplate?>()) {
      return (data != null ? _i41.SysNotifyTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SysOperateLog?>()) {
      return (data != null ? _i42.SysOperateLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.SysPost?>()) {
      return (data != null ? _i43.SysPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SysRole?>()) {
      return (data != null ? _i44.SysRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SysRoleMenu?>()) {
      return (data != null ? _i45.SysRoleMenu.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SysSmsChannel?>()) {
      return (data != null ? _i46.SysSmsChannel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SysSmsCode?>()) {
      return (data != null ? _i47.SysSmsCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SysSmsLog?>()) {
      return (data != null ? _i48.SysSmsLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SysSmsTemplate?>()) {
      return (data != null ? _i49.SysSmsTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.SysSocialClient?>()) {
      return (data != null ? _i50.SysSocialClient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SysSocialUser?>()) {
      return (data != null ? _i51.SysSocialUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.SysSocialUserBind?>()) {
      return (data != null ? _i52.SysSocialUserBind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.SysTenant?>()) {
      return (data != null ? _i53.SysTenant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.SysTenantPackage?>()) {
      return (data != null ? _i54.SysTenantPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.SysUser?>()) {
      return (data != null ? _i55.SysUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.SysUserPost?>()) {
      return (data != null ? _i56.SysUserPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.SysMenu?>()) {
      return (data != null ? _i57.SysMenu.fromJson(data) : null) as T;
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
    if (t == _i1.getType<List<_i57.SysMenu>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i57.SysMenu>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.AirTableItems>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.AirTableItems>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.AirTableFields>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i8.AirTableFields>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.AirTableRows>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i6.AirTableRows>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.AirTableItems>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.AirTableItems>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.AirTableFieldsSummary>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.AirTableFieldsSummary>(e))
              .toList()
          : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i58.BaseResponse) {
      return _i58.BaseResponse.fromJson(data) as T;
    }
    if (t == _i58.CommonResponse) {
      return _i58.CommonResponse.fromJson(data) as T;
    }
    if (t == _i58.PageResponse) {
      return _i58.PageResponse.fromJson(data) as T;
    }
    if (t == _i1.getType<_i58.BaseResponse?>()) {
      return (data != null ? _i58.BaseResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.CommonResponse?>()) {
      return (data != null ? _i58.CommonResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.PageResponse?>()) {
      return (data != null ? _i58.PageResponse.fromJson(data) : null) as T;
    }
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    switch (data) {
      case _i58.BaseResponse():
        return 'BaseResponse';
      case _i58.CommonResponse():
        return 'CommonResponse';
      case _i58.PageResponse():
        return 'PageResponse';
      case _i2.LoginResponse():
        return 'LoginResponse';
      case _i3.StoreActivityBook():
        return 'StoreActivityBook';
      case _i4.AirTableFieldsSummary():
        return 'AirTableFieldsSummary';
      case _i5.AirTableItems():
        return 'AirTableItems';
      case _i6.AirTableRows():
        return 'AirTableRows';
      case _i7.AirTables():
        return 'AirTables';
      case _i8.AirTableFields():
        return 'AirTableFields';
      case _i9.Book():
        return 'Book';
      case _i10.BookCategory():
        return 'BookCategory';
      case _i11.BookInventoryLog():
        return 'BookInventoryLog';
      case _i12.BookPackage():
        return 'BookPackage';
      case _i13.BookPackageItem():
        return 'BookPackageItem';
      case _i14.BookSale():
        return 'BookSale';
      case _i15.Pagination():
        return 'Pagination';
      case _i16.Customer():
        return 'Customer';
      case _i17.Region():
        return 'Region';
      case _i18.Store():
        return 'Store';
      case _i19.StoreActivity():
        return 'StoreActivity';
      case _i20.AirTableDetail():
        return 'AirTableDetail';
      case _i21.StoreBook():
        return 'StoreBook';
      case _i22.StoreSalesRecord():
        return 'StoreSalesRecord';
      case _i23.Qimen():
        return 'Qimen';
      case _i24.InfraApiAccessLog():
        return 'InfraApiAccessLog';
      case _i25.InfraApiErrorLog():
        return 'InfraApiErrorLog';
      case _i26.InfraFile():
        return 'InfraFile';
      case _i27.InfraFileConfig():
        return 'InfraFileConfig';
      case _i28.InfraFileContent():
        return 'InfraFileContent';
      case _i29.InfraJob():
        return 'InfraJob';
      case _i30.InfraJobLog():
        return 'InfraJobLog';
      case _i31.SysDept():
        return 'SysDept';
      case _i32.SysDictData():
        return 'SysDictData';
      case _i33.SysDictType():
        return 'SysDictType';
      case _i34.SysLoginLog():
        return 'SysLoginLog';
      case _i35.SysMailAccount():
        return 'SysMailAccount';
      case _i36.SysMailLog():
        return 'SysMailLog';
      case _i37.SysMailTemplate():
        return 'SysMailTemplate';
      case _i38.SysUserRole():
        return 'SysUserRole';
      case _i39.SysNotice():
        return 'SysNotice';
      case _i40.SysNotifyMessage():
        return 'SysNotifyMessage';
      case _i41.SysNotifyTemplate():
        return 'SysNotifyTemplate';
      case _i42.SysOperateLog():
        return 'SysOperateLog';
      case _i43.SysPost():
        return 'SysPost';
      case _i44.SysRole():
        return 'SysRole';
      case _i45.SysRoleMenu():
        return 'SysRoleMenu';
      case _i46.SysSmsChannel():
        return 'SysSmsChannel';
      case _i47.SysSmsCode():
        return 'SysSmsCode';
      case _i48.SysSmsLog():
        return 'SysSmsLog';
      case _i49.SysSmsTemplate():
        return 'SysSmsTemplate';
      case _i50.SysSocialClient():
        return 'SysSocialClient';
      case _i51.SysSocialUser():
        return 'SysSocialUser';
      case _i52.SysSocialUserBind():
        return 'SysSocialUserBind';
      case _i53.SysTenant():
        return 'SysTenant';
      case _i54.SysTenantPackage():
        return 'SysTenantPackage';
      case _i55.SysUser():
        return 'SysUser';
      case _i56.SysUserPost():
        return 'SysUserPost';
      case _i57.SysMenu():
        return 'SysMenu';
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
      return deserialize<_i58.BaseResponse>(data['data']);
    }
    if (dataClassName == 'CommonResponse') {
      return deserialize<_i58.CommonResponse>(data['data']);
    }
    if (dataClassName == 'PageResponse') {
      return deserialize<_i58.PageResponse>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i2.LoginResponse>(data['data']);
    }
    if (dataClassName == 'StoreActivityBook') {
      return deserialize<_i3.StoreActivityBook>(data['data']);
    }
    if (dataClassName == 'AirTableFieldsSummary') {
      return deserialize<_i4.AirTableFieldsSummary>(data['data']);
    }
    if (dataClassName == 'AirTableItems') {
      return deserialize<_i5.AirTableItems>(data['data']);
    }
    if (dataClassName == 'AirTableRows') {
      return deserialize<_i6.AirTableRows>(data['data']);
    }
    if (dataClassName == 'AirTables') {
      return deserialize<_i7.AirTables>(data['data']);
    }
    if (dataClassName == 'AirTableFields') {
      return deserialize<_i8.AirTableFields>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i9.Book>(data['data']);
    }
    if (dataClassName == 'BookCategory') {
      return deserialize<_i10.BookCategory>(data['data']);
    }
    if (dataClassName == 'BookInventoryLog') {
      return deserialize<_i11.BookInventoryLog>(data['data']);
    }
    if (dataClassName == 'BookPackage') {
      return deserialize<_i12.BookPackage>(data['data']);
    }
    if (dataClassName == 'BookPackageItem') {
      return deserialize<_i13.BookPackageItem>(data['data']);
    }
    if (dataClassName == 'BookSale') {
      return deserialize<_i14.BookSale>(data['data']);
    }
    if (dataClassName == 'Pagination') {
      return deserialize<_i15.Pagination>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i16.Customer>(data['data']);
    }
    if (dataClassName == 'Region') {
      return deserialize<_i17.Region>(data['data']);
    }
    if (dataClassName == 'Store') {
      return deserialize<_i18.Store>(data['data']);
    }
    if (dataClassName == 'StoreActivity') {
      return deserialize<_i19.StoreActivity>(data['data']);
    }
    if (dataClassName == 'AirTableDetail') {
      return deserialize<_i20.AirTableDetail>(data['data']);
    }
    if (dataClassName == 'StoreBook') {
      return deserialize<_i21.StoreBook>(data['data']);
    }
    if (dataClassName == 'StoreSalesRecord') {
      return deserialize<_i22.StoreSalesRecord>(data['data']);
    }
    if (dataClassName == 'Qimen') {
      return deserialize<_i23.Qimen>(data['data']);
    }
    if (dataClassName == 'InfraApiAccessLog') {
      return deserialize<_i24.InfraApiAccessLog>(data['data']);
    }
    if (dataClassName == 'InfraApiErrorLog') {
      return deserialize<_i25.InfraApiErrorLog>(data['data']);
    }
    if (dataClassName == 'InfraFile') {
      return deserialize<_i26.InfraFile>(data['data']);
    }
    if (dataClassName == 'InfraFileConfig') {
      return deserialize<_i27.InfraFileConfig>(data['data']);
    }
    if (dataClassName == 'InfraFileContent') {
      return deserialize<_i28.InfraFileContent>(data['data']);
    }
    if (dataClassName == 'InfraJob') {
      return deserialize<_i29.InfraJob>(data['data']);
    }
    if (dataClassName == 'InfraJobLog') {
      return deserialize<_i30.InfraJobLog>(data['data']);
    }
    if (dataClassName == 'SysDept') {
      return deserialize<_i31.SysDept>(data['data']);
    }
    if (dataClassName == 'SysDictData') {
      return deserialize<_i32.SysDictData>(data['data']);
    }
    if (dataClassName == 'SysDictType') {
      return deserialize<_i33.SysDictType>(data['data']);
    }
    if (dataClassName == 'SysLoginLog') {
      return deserialize<_i34.SysLoginLog>(data['data']);
    }
    if (dataClassName == 'SysMailAccount') {
      return deserialize<_i35.SysMailAccount>(data['data']);
    }
    if (dataClassName == 'SysMailLog') {
      return deserialize<_i36.SysMailLog>(data['data']);
    }
    if (dataClassName == 'SysMailTemplate') {
      return deserialize<_i37.SysMailTemplate>(data['data']);
    }
    if (dataClassName == 'SysUserRole') {
      return deserialize<_i38.SysUserRole>(data['data']);
    }
    if (dataClassName == 'SysNotice') {
      return deserialize<_i39.SysNotice>(data['data']);
    }
    if (dataClassName == 'SysNotifyMessage') {
      return deserialize<_i40.SysNotifyMessage>(data['data']);
    }
    if (dataClassName == 'SysNotifyTemplate') {
      return deserialize<_i41.SysNotifyTemplate>(data['data']);
    }
    if (dataClassName == 'SysOperateLog') {
      return deserialize<_i42.SysOperateLog>(data['data']);
    }
    if (dataClassName == 'SysPost') {
      return deserialize<_i43.SysPost>(data['data']);
    }
    if (dataClassName == 'SysRole') {
      return deserialize<_i44.SysRole>(data['data']);
    }
    if (dataClassName == 'SysRoleMenu') {
      return deserialize<_i45.SysRoleMenu>(data['data']);
    }
    if (dataClassName == 'SysSmsChannel') {
      return deserialize<_i46.SysSmsChannel>(data['data']);
    }
    if (dataClassName == 'SysSmsCode') {
      return deserialize<_i47.SysSmsCode>(data['data']);
    }
    if (dataClassName == 'SysSmsLog') {
      return deserialize<_i48.SysSmsLog>(data['data']);
    }
    if (dataClassName == 'SysSmsTemplate') {
      return deserialize<_i49.SysSmsTemplate>(data['data']);
    }
    if (dataClassName == 'SysSocialClient') {
      return deserialize<_i50.SysSocialClient>(data['data']);
    }
    if (dataClassName == 'SysSocialUser') {
      return deserialize<_i51.SysSocialUser>(data['data']);
    }
    if (dataClassName == 'SysSocialUserBind') {
      return deserialize<_i52.SysSocialUserBind>(data['data']);
    }
    if (dataClassName == 'SysTenant') {
      return deserialize<_i53.SysTenant>(data['data']);
    }
    if (dataClassName == 'SysTenantPackage') {
      return deserialize<_i54.SysTenantPackage>(data['data']);
    }
    if (dataClassName == 'SysUser') {
      return deserialize<_i55.SysUser>(data['data']);
    }
    if (dataClassName == 'SysUserPost') {
      return deserialize<_i56.SysUserPost>(data['data']);
    }
    if (dataClassName == 'SysMenu') {
      return deserialize<_i57.SysMenu>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
