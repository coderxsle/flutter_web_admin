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
import 'airtable/table_detail.dart' as _i2;
import 'airtable/table_fields.dart' as _i3;
import 'airtable/table_fields_summary.dart' as _i4;
import 'airtable/table_items.dart' as _i5;
import 'airtable/table_rows.dart' as _i6;
import 'airtable/tables.dart' as _i7;
import 'book/book.dart' as _i8;
import 'book/book_category.dart' as _i9;
import 'book/book_inventory_log.dart' as _i10;
import 'book/book_package.dart' as _i11;
import 'book/book_package_item.dart' as _i12;
import 'book/book_sale.dart' as _i13;
import 'region.dart' as _i14;
import 'store/store.dart' as _i15;
import 'store/store_activity.dart' as _i16;
import 'store/store_activity_book.dart' as _i17;
import 'store/store_book.dart' as _i18;
import 'store/store_sales_record.dart' as _i19;
import 'system/infra_api_access_log.dart' as _i20;
import 'system/infra_api_error_log.dart' as _i21;
import 'system/infra_file.dart' as _i22;
import 'system/infra_file_config.dart' as _i23;
import 'system/infra_file_content.dart' as _i24;
import 'system/infra_job.dart' as _i25;
import 'system/infra_job_log.dart' as _i26;
import 'system/sys_api.dart' as _i27;
import 'system/sys_dept.dart' as _i28;
import 'system/sys_dict_code.dart' as _i29;
import 'system/sys_dict_data.dart' as _i30;
import 'system/sys_login_log.dart' as _i31;
import 'system/sys_mail_account.dart' as _i32;
import 'system/sys_mail_log.dart' as _i33;
import 'system/sys_mail_template.dart' as _i34;
import 'system/sys_menu.dart' as _i35;
import 'system/sys_notice.dart' as _i36;
import 'system/sys_notify_message.dart' as _i37;
import 'system/sys_notify_template.dart' as _i38;
import 'system/sys_operate_log.dart' as _i39;
import 'system/sys_post.dart' as _i40;
import 'system/sys_role.dart' as _i41;
import 'system/sys_role_menu.dart' as _i42;
import 'system/sys_sms_channel.dart' as _i43;
import 'system/sys_sms_code.dart' as _i44;
import 'system/sys_sms_log.dart' as _i45;
import 'system/sys_sms_template.dart' as _i46;
import 'system/sys_social_client.dart' as _i47;
import 'system/sys_social_user.dart' as _i48;
import 'system/sys_social_user_bind.dart' as _i49;
import 'system/sys_tenant.dart' as _i50;
import 'system/sys_tenant_package.dart' as _i51;
import 'system/sys_user.dart' as _i52;
import 'system/sys_user_post.dart' as _i53;
import 'system/sys_user_role.dart' as _i54;
import 'zhouyi/qimen.dart' as _i55;
import 'package:flutter_web_shared/flutter_web_shared.dart' as _i56;
import 'package:serverpod_crud/serverpod_crud.dart' as _i57;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i58;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i59;
export 'airtable/table_detail.dart';
export 'airtable/table_fields.dart';
export 'airtable/table_fields_summary.dart';
export 'airtable/table_items.dart';
export 'airtable/table_rows.dart';
export 'airtable/tables.dart';
export 'book/book.dart';
export 'book/book_category.dart';
export 'book/book_inventory_log.dart';
export 'book/book_package.dart';
export 'book/book_package_item.dart';
export 'book/book_sale.dart';
export 'region.dart';
export 'store/store.dart';
export 'store/store_activity.dart';
export 'store/store_activity_book.dart';
export 'store/store_book.dart';
export 'store/store_sales_record.dart';
export 'system/infra_api_access_log.dart';
export 'system/infra_api_error_log.dart';
export 'system/infra_file.dart';
export 'system/infra_file_config.dart';
export 'system/infra_file_content.dart';
export 'system/infra_job.dart';
export 'system/infra_job_log.dart';
export 'system/sys_api.dart';
export 'system/sys_dept.dart';
export 'system/sys_dict_code.dart';
export 'system/sys_dict_data.dart';
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
export 'zhouyi/qimen.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AirTableDetail) {
      return _i2.AirTableDetail.fromJson(data) as T;
    }
    if (t == _i3.AirTableFields) {
      return _i3.AirTableFields.fromJson(data) as T;
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
    if (t == _i8.Book) {
      return _i8.Book.fromJson(data) as T;
    }
    if (t == _i9.BookCategory) {
      return _i9.BookCategory.fromJson(data) as T;
    }
    if (t == _i10.BookInventoryLog) {
      return _i10.BookInventoryLog.fromJson(data) as T;
    }
    if (t == _i11.BookPackage) {
      return _i11.BookPackage.fromJson(data) as T;
    }
    if (t == _i12.BookPackageItem) {
      return _i12.BookPackageItem.fromJson(data) as T;
    }
    if (t == _i13.BookSale) {
      return _i13.BookSale.fromJson(data) as T;
    }
    if (t == _i14.Region) {
      return _i14.Region.fromJson(data) as T;
    }
    if (t == _i15.Store) {
      return _i15.Store.fromJson(data) as T;
    }
    if (t == _i16.StoreActivity) {
      return _i16.StoreActivity.fromJson(data) as T;
    }
    if (t == _i17.StoreActivityBook) {
      return _i17.StoreActivityBook.fromJson(data) as T;
    }
    if (t == _i18.StoreBook) {
      return _i18.StoreBook.fromJson(data) as T;
    }
    if (t == _i19.StoreSalesRecord) {
      return _i19.StoreSalesRecord.fromJson(data) as T;
    }
    if (t == _i20.InfraApiAccessLog) {
      return _i20.InfraApiAccessLog.fromJson(data) as T;
    }
    if (t == _i21.InfraApiErrorLog) {
      return _i21.InfraApiErrorLog.fromJson(data) as T;
    }
    if (t == _i22.InfraFile) {
      return _i22.InfraFile.fromJson(data) as T;
    }
    if (t == _i23.InfraFileConfig) {
      return _i23.InfraFileConfig.fromJson(data) as T;
    }
    if (t == _i24.InfraFileContent) {
      return _i24.InfraFileContent.fromJson(data) as T;
    }
    if (t == _i25.InfraJob) {
      return _i25.InfraJob.fromJson(data) as T;
    }
    if (t == _i26.InfraJobLog) {
      return _i26.InfraJobLog.fromJson(data) as T;
    }
    if (t == _i27.SysApi) {
      return _i27.SysApi.fromJson(data) as T;
    }
    if (t == _i28.SysDept) {
      return _i28.SysDept.fromJson(data) as T;
    }
    if (t == _i29.SysDictCode) {
      return _i29.SysDictCode.fromJson(data) as T;
    }
    if (t == _i30.SysDictData) {
      return _i30.SysDictData.fromJson(data) as T;
    }
    if (t == _i31.SysLoginLog) {
      return _i31.SysLoginLog.fromJson(data) as T;
    }
    if (t == _i32.SysMailAccount) {
      return _i32.SysMailAccount.fromJson(data) as T;
    }
    if (t == _i33.SysMailLog) {
      return _i33.SysMailLog.fromJson(data) as T;
    }
    if (t == _i34.SysMailTemplate) {
      return _i34.SysMailTemplate.fromJson(data) as T;
    }
    if (t == _i35.SysMenu) {
      return _i35.SysMenu.fromJson(data) as T;
    }
    if (t == _i36.SysNotice) {
      return _i36.SysNotice.fromJson(data) as T;
    }
    if (t == _i37.SysNotifyMessage) {
      return _i37.SysNotifyMessage.fromJson(data) as T;
    }
    if (t == _i38.SysNotifyTemplate) {
      return _i38.SysNotifyTemplate.fromJson(data) as T;
    }
    if (t == _i39.SysOperateLog) {
      return _i39.SysOperateLog.fromJson(data) as T;
    }
    if (t == _i40.SysPost) {
      return _i40.SysPost.fromJson(data) as T;
    }
    if (t == _i41.SysRole) {
      return _i41.SysRole.fromJson(data) as T;
    }
    if (t == _i42.SysRoleMenu) {
      return _i42.SysRoleMenu.fromJson(data) as T;
    }
    if (t == _i43.SysSmsChannel) {
      return _i43.SysSmsChannel.fromJson(data) as T;
    }
    if (t == _i44.SysSmsCode) {
      return _i44.SysSmsCode.fromJson(data) as T;
    }
    if (t == _i45.SysSmsLog) {
      return _i45.SysSmsLog.fromJson(data) as T;
    }
    if (t == _i46.SysSmsTemplate) {
      return _i46.SysSmsTemplate.fromJson(data) as T;
    }
    if (t == _i47.SysSocialClient) {
      return _i47.SysSocialClient.fromJson(data) as T;
    }
    if (t == _i48.SysSocialUser) {
      return _i48.SysSocialUser.fromJson(data) as T;
    }
    if (t == _i49.SysSocialUserBind) {
      return _i49.SysSocialUserBind.fromJson(data) as T;
    }
    if (t == _i50.SysTenant) {
      return _i50.SysTenant.fromJson(data) as T;
    }
    if (t == _i51.SysTenantPackage) {
      return _i51.SysTenantPackage.fromJson(data) as T;
    }
    if (t == _i52.SysUser) {
      return _i52.SysUser.fromJson(data) as T;
    }
    if (t == _i53.SysUserPost) {
      return _i53.SysUserPost.fromJson(data) as T;
    }
    if (t == _i54.SysUserRole) {
      return _i54.SysUserRole.fromJson(data) as T;
    }
    if (t == _i55.Qimen) {
      return _i55.Qimen.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AirTableDetail?>()) {
      return (data != null ? _i2.AirTableDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AirTableFields?>()) {
      return (data != null ? _i3.AirTableFields.fromJson(data) : null) as T;
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
    if (t == _i1.getType<_i8.Book?>()) {
      return (data != null ? _i8.Book.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.BookCategory?>()) {
      return (data != null ? _i9.BookCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.BookInventoryLog?>()) {
      return (data != null ? _i10.BookInventoryLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.BookPackage?>()) {
      return (data != null ? _i11.BookPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.BookPackageItem?>()) {
      return (data != null ? _i12.BookPackageItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.BookSale?>()) {
      return (data != null ? _i13.BookSale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Region?>()) {
      return (data != null ? _i14.Region.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Store?>()) {
      return (data != null ? _i15.Store.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.StoreActivity?>()) {
      return (data != null ? _i16.StoreActivity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.StoreActivityBook?>()) {
      return (data != null ? _i17.StoreActivityBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.StoreBook?>()) {
      return (data != null ? _i18.StoreBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.StoreSalesRecord?>()) {
      return (data != null ? _i19.StoreSalesRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.InfraApiAccessLog?>()) {
      return (data != null ? _i20.InfraApiAccessLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.InfraApiErrorLog?>()) {
      return (data != null ? _i21.InfraApiErrorLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.InfraFile?>()) {
      return (data != null ? _i22.InfraFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.InfraFileConfig?>()) {
      return (data != null ? _i23.InfraFileConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.InfraFileContent?>()) {
      return (data != null ? _i24.InfraFileContent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.InfraJob?>()) {
      return (data != null ? _i25.InfraJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.InfraJobLog?>()) {
      return (data != null ? _i26.InfraJobLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SysApi?>()) {
      return (data != null ? _i27.SysApi.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SysDept?>()) {
      return (data != null ? _i28.SysDept.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SysDictCode?>()) {
      return (data != null ? _i29.SysDictCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.SysDictData?>()) {
      return (data != null ? _i30.SysDictData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.SysLoginLog?>()) {
      return (data != null ? _i31.SysLoginLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SysMailAccount?>()) {
      return (data != null ? _i32.SysMailAccount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.SysMailLog?>()) {
      return (data != null ? _i33.SysMailLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SysMailTemplate?>()) {
      return (data != null ? _i34.SysMailTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.SysMenu?>()) {
      return (data != null ? _i35.SysMenu.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.SysNotice?>()) {
      return (data != null ? _i36.SysNotice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.SysNotifyMessage?>()) {
      return (data != null ? _i37.SysNotifyMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.SysNotifyTemplate?>()) {
      return (data != null ? _i38.SysNotifyTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.SysOperateLog?>()) {
      return (data != null ? _i39.SysOperateLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.SysPost?>()) {
      return (data != null ? _i40.SysPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.SysRole?>()) {
      return (data != null ? _i41.SysRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SysRoleMenu?>()) {
      return (data != null ? _i42.SysRoleMenu.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.SysSmsChannel?>()) {
      return (data != null ? _i43.SysSmsChannel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SysSmsCode?>()) {
      return (data != null ? _i44.SysSmsCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SysSmsLog?>()) {
      return (data != null ? _i45.SysSmsLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SysSmsTemplate?>()) {
      return (data != null ? _i46.SysSmsTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SysSocialClient?>()) {
      return (data != null ? _i47.SysSocialClient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SysSocialUser?>()) {
      return (data != null ? _i48.SysSocialUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SysSocialUserBind?>()) {
      return (data != null ? _i49.SysSocialUserBind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.SysTenant?>()) {
      return (data != null ? _i50.SysTenant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SysTenantPackage?>()) {
      return (data != null ? _i51.SysTenantPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.SysUser?>()) {
      return (data != null ? _i52.SysUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.SysUserPost?>()) {
      return (data != null ? _i53.SysUserPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.SysUserRole?>()) {
      return (data != null ? _i54.SysUserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.Qimen?>()) {
      return (data != null ? _i55.Qimen.fromJson(data) : null) as T;
    }
    if (t == List<_i4.AirTableFieldsSummary>) {
      return (data as List)
              .map((e) => deserialize<_i4.AirTableFieldsSummary>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i4.AirTableFieldsSummary>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i4.AirTableFieldsSummary>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i5.AirTableItems>) {
      return (data as List)
              .map((e) => deserialize<_i5.AirTableItems>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i5.AirTableItems>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i5.AirTableItems>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i3.AirTableFields>) {
      return (data as List)
              .map((e) => deserialize<_i3.AirTableFields>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i3.AirTableFields>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i3.AirTableFields>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i6.AirTableRows>) {
      return (data as List)
              .map((e) => deserialize<_i6.AirTableRows>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i6.AirTableRows>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i6.AirTableRows>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i35.SysMenu>) {
      return (data as List).map((e) => deserialize<_i35.SysMenu>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i35.SysMenu>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i35.SysMenu>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i27.SysApi>) {
      return (data as List).map((e) => deserialize<_i27.SysApi>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i27.SysApi>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i27.SysApi>(e)).toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i56.BaseResponse) {
      return _i56.BaseResponse.fromJson(data) as T;
    }
    if (t == _i56.CommonResponse) {
      return _i56.CommonResponse.fromJson(data) as T;
    }
    if (t == _i56.PageResponse) {
      return _i56.PageResponse.fromJson(data) as T;
    }
    if (t == _i57.QueryRequest) {
      return _i57.QueryRequest.fromJson(data) as T;
    }
    if (t == _i57.QueryFilter) {
      return _i57.QueryFilter.fromJson(data) as T;
    }
    if (t == _i57.QuerySort) {
      return _i57.QuerySort.fromJson(data) as T;
    }
    if (t == _i1.getType<_i56.BaseResponse?>()) {
      return (data != null ? _i56.BaseResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.CommonResponse?>()) {
      return (data != null ? _i56.CommonResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.PageResponse?>()) {
      return (data != null ? _i56.PageResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.QueryRequest?>()) {
      return (data != null ? _i57.QueryRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.QueryFilter?>()) {
      return (data != null ? _i57.QueryFilter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.QuerySort?>()) {
      return (data != null ? _i57.QuerySort.fromJson(data) : null) as T;
    }
    try {
      return _i58.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i59.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i56.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i57.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i56.BaseResponse => 'BaseResponse',
      _i56.CommonResponse => 'CommonResponse',
      _i56.PageResponse => 'PageResponse',
      _i57.QueryRequest => 'QueryRequest',
      _i57.QueryFilter => 'QueryFilter',
      _i57.QuerySort => 'QuerySort',
      _i2.AirTableDetail => 'AirTableDetail',
      _i3.AirTableFields => 'AirTableFields',
      _i4.AirTableFieldsSummary => 'AirTableFieldsSummary',
      _i5.AirTableItems => 'AirTableItems',
      _i6.AirTableRows => 'AirTableRows',
      _i7.AirTables => 'AirTables',
      _i8.Book => 'Book',
      _i9.BookCategory => 'BookCategory',
      _i10.BookInventoryLog => 'BookInventoryLog',
      _i11.BookPackage => 'BookPackage',
      _i12.BookPackageItem => 'BookPackageItem',
      _i13.BookSale => 'BookSale',
      _i14.Region => 'Region',
      _i15.Store => 'Store',
      _i16.StoreActivity => 'StoreActivity',
      _i17.StoreActivityBook => 'StoreActivityBook',
      _i18.StoreBook => 'StoreBook',
      _i19.StoreSalesRecord => 'StoreSalesRecord',
      _i20.InfraApiAccessLog => 'InfraApiAccessLog',
      _i21.InfraApiErrorLog => 'InfraApiErrorLog',
      _i22.InfraFile => 'InfraFile',
      _i23.InfraFileConfig => 'InfraFileConfig',
      _i24.InfraFileContent => 'InfraFileContent',
      _i25.InfraJob => 'InfraJob',
      _i26.InfraJobLog => 'InfraJobLog',
      _i27.SysApi => 'SysApi',
      _i28.SysDept => 'SysDept',
      _i29.SysDictCode => 'SysDictCode',
      _i30.SysDictData => 'SysDictData',
      _i31.SysLoginLog => 'SysLoginLog',
      _i32.SysMailAccount => 'SysMailAccount',
      _i33.SysMailLog => 'SysMailLog',
      _i34.SysMailTemplate => 'SysMailTemplate',
      _i35.SysMenu => 'SysMenu',
      _i36.SysNotice => 'SysNotice',
      _i37.SysNotifyMessage => 'SysNotifyMessage',
      _i38.SysNotifyTemplate => 'SysNotifyTemplate',
      _i39.SysOperateLog => 'SysOperateLog',
      _i40.SysPost => 'SysPost',
      _i41.SysRole => 'SysRole',
      _i42.SysRoleMenu => 'SysRoleMenu',
      _i43.SysSmsChannel => 'SysSmsChannel',
      _i44.SysSmsCode => 'SysSmsCode',
      _i45.SysSmsLog => 'SysSmsLog',
      _i46.SysSmsTemplate => 'SysSmsTemplate',
      _i47.SysSocialClient => 'SysSocialClient',
      _i48.SysSocialUser => 'SysSocialUser',
      _i49.SysSocialUserBind => 'SysSocialUserBind',
      _i50.SysTenant => 'SysTenant',
      _i51.SysTenantPackage => 'SysTenantPackage',
      _i52.SysUser => 'SysUser',
      _i53.SysUserPost => 'SysUserPost',
      _i54.SysUserRole => 'SysUserRole',
      _i55.Qimen => 'Qimen',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('flutter_web.', '');
    }

    switch (data) {
      case _i56.BaseResponse():
        return 'BaseResponse';
      case _i56.CommonResponse():
        return 'CommonResponse';
      case _i56.PageResponse():
        return 'PageResponse';
      case _i57.QueryRequest():
        return 'QueryRequest';
      case _i57.QueryFilter():
        return 'QueryFilter';
      case _i57.QuerySort():
        return 'QuerySort';
      case _i2.AirTableDetail():
        return 'AirTableDetail';
      case _i3.AirTableFields():
        return 'AirTableFields';
      case _i4.AirTableFieldsSummary():
        return 'AirTableFieldsSummary';
      case _i5.AirTableItems():
        return 'AirTableItems';
      case _i6.AirTableRows():
        return 'AirTableRows';
      case _i7.AirTables():
        return 'AirTables';
      case _i8.Book():
        return 'Book';
      case _i9.BookCategory():
        return 'BookCategory';
      case _i10.BookInventoryLog():
        return 'BookInventoryLog';
      case _i11.BookPackage():
        return 'BookPackage';
      case _i12.BookPackageItem():
        return 'BookPackageItem';
      case _i13.BookSale():
        return 'BookSale';
      case _i14.Region():
        return 'Region';
      case _i15.Store():
        return 'Store';
      case _i16.StoreActivity():
        return 'StoreActivity';
      case _i17.StoreActivityBook():
        return 'StoreActivityBook';
      case _i18.StoreBook():
        return 'StoreBook';
      case _i19.StoreSalesRecord():
        return 'StoreSalesRecord';
      case _i20.InfraApiAccessLog():
        return 'InfraApiAccessLog';
      case _i21.InfraApiErrorLog():
        return 'InfraApiErrorLog';
      case _i22.InfraFile():
        return 'InfraFile';
      case _i23.InfraFileConfig():
        return 'InfraFileConfig';
      case _i24.InfraFileContent():
        return 'InfraFileContent';
      case _i25.InfraJob():
        return 'InfraJob';
      case _i26.InfraJobLog():
        return 'InfraJobLog';
      case _i27.SysApi():
        return 'SysApi';
      case _i28.SysDept():
        return 'SysDept';
      case _i29.SysDictCode():
        return 'SysDictCode';
      case _i30.SysDictData():
        return 'SysDictData';
      case _i31.SysLoginLog():
        return 'SysLoginLog';
      case _i32.SysMailAccount():
        return 'SysMailAccount';
      case _i33.SysMailLog():
        return 'SysMailLog';
      case _i34.SysMailTemplate():
        return 'SysMailTemplate';
      case _i35.SysMenu():
        return 'SysMenu';
      case _i36.SysNotice():
        return 'SysNotice';
      case _i37.SysNotifyMessage():
        return 'SysNotifyMessage';
      case _i38.SysNotifyTemplate():
        return 'SysNotifyTemplate';
      case _i39.SysOperateLog():
        return 'SysOperateLog';
      case _i40.SysPost():
        return 'SysPost';
      case _i41.SysRole():
        return 'SysRole';
      case _i42.SysRoleMenu():
        return 'SysRoleMenu';
      case _i43.SysSmsChannel():
        return 'SysSmsChannel';
      case _i44.SysSmsCode():
        return 'SysSmsCode';
      case _i45.SysSmsLog():
        return 'SysSmsLog';
      case _i46.SysSmsTemplate():
        return 'SysSmsTemplate';
      case _i47.SysSocialClient():
        return 'SysSocialClient';
      case _i48.SysSocialUser():
        return 'SysSocialUser';
      case _i49.SysSocialUserBind():
        return 'SysSocialUserBind';
      case _i50.SysTenant():
        return 'SysTenant';
      case _i51.SysTenantPackage():
        return 'SysTenantPackage';
      case _i52.SysUser():
        return 'SysUser';
      case _i53.SysUserPost():
        return 'SysUserPost';
      case _i54.SysUserRole():
        return 'SysUserRole';
      case _i55.Qimen():
        return 'Qimen';
    }
    className = _i58.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i59.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
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
      return deserialize<_i56.BaseResponse>(data['data']);
    }
    if (dataClassName == 'CommonResponse') {
      return deserialize<_i56.CommonResponse>(data['data']);
    }
    if (dataClassName == 'PageResponse') {
      return deserialize<_i56.PageResponse>(data['data']);
    }
    if (dataClassName == 'QueryRequest') {
      return deserialize<_i57.QueryRequest>(data['data']);
    }
    if (dataClassName == 'QueryFilter') {
      return deserialize<_i57.QueryFilter>(data['data']);
    }
    if (dataClassName == 'QuerySort') {
      return deserialize<_i57.QuerySort>(data['data']);
    }
    if (dataClassName == 'AirTableDetail') {
      return deserialize<_i2.AirTableDetail>(data['data']);
    }
    if (dataClassName == 'AirTableFields') {
      return deserialize<_i3.AirTableFields>(data['data']);
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
    if (dataClassName == 'Book') {
      return deserialize<_i8.Book>(data['data']);
    }
    if (dataClassName == 'BookCategory') {
      return deserialize<_i9.BookCategory>(data['data']);
    }
    if (dataClassName == 'BookInventoryLog') {
      return deserialize<_i10.BookInventoryLog>(data['data']);
    }
    if (dataClassName == 'BookPackage') {
      return deserialize<_i11.BookPackage>(data['data']);
    }
    if (dataClassName == 'BookPackageItem') {
      return deserialize<_i12.BookPackageItem>(data['data']);
    }
    if (dataClassName == 'BookSale') {
      return deserialize<_i13.BookSale>(data['data']);
    }
    if (dataClassName == 'Region') {
      return deserialize<_i14.Region>(data['data']);
    }
    if (dataClassName == 'Store') {
      return deserialize<_i15.Store>(data['data']);
    }
    if (dataClassName == 'StoreActivity') {
      return deserialize<_i16.StoreActivity>(data['data']);
    }
    if (dataClassName == 'StoreActivityBook') {
      return deserialize<_i17.StoreActivityBook>(data['data']);
    }
    if (dataClassName == 'StoreBook') {
      return deserialize<_i18.StoreBook>(data['data']);
    }
    if (dataClassName == 'StoreSalesRecord') {
      return deserialize<_i19.StoreSalesRecord>(data['data']);
    }
    if (dataClassName == 'InfraApiAccessLog') {
      return deserialize<_i20.InfraApiAccessLog>(data['data']);
    }
    if (dataClassName == 'InfraApiErrorLog') {
      return deserialize<_i21.InfraApiErrorLog>(data['data']);
    }
    if (dataClassName == 'InfraFile') {
      return deserialize<_i22.InfraFile>(data['data']);
    }
    if (dataClassName == 'InfraFileConfig') {
      return deserialize<_i23.InfraFileConfig>(data['data']);
    }
    if (dataClassName == 'InfraFileContent') {
      return deserialize<_i24.InfraFileContent>(data['data']);
    }
    if (dataClassName == 'InfraJob') {
      return deserialize<_i25.InfraJob>(data['data']);
    }
    if (dataClassName == 'InfraJobLog') {
      return deserialize<_i26.InfraJobLog>(data['data']);
    }
    if (dataClassName == 'SysApi') {
      return deserialize<_i27.SysApi>(data['data']);
    }
    if (dataClassName == 'SysDept') {
      return deserialize<_i28.SysDept>(data['data']);
    }
    if (dataClassName == 'SysDictCode') {
      return deserialize<_i29.SysDictCode>(data['data']);
    }
    if (dataClassName == 'SysDictData') {
      return deserialize<_i30.SysDictData>(data['data']);
    }
    if (dataClassName == 'SysLoginLog') {
      return deserialize<_i31.SysLoginLog>(data['data']);
    }
    if (dataClassName == 'SysMailAccount') {
      return deserialize<_i32.SysMailAccount>(data['data']);
    }
    if (dataClassName == 'SysMailLog') {
      return deserialize<_i33.SysMailLog>(data['data']);
    }
    if (dataClassName == 'SysMailTemplate') {
      return deserialize<_i34.SysMailTemplate>(data['data']);
    }
    if (dataClassName == 'SysMenu') {
      return deserialize<_i35.SysMenu>(data['data']);
    }
    if (dataClassName == 'SysNotice') {
      return deserialize<_i36.SysNotice>(data['data']);
    }
    if (dataClassName == 'SysNotifyMessage') {
      return deserialize<_i37.SysNotifyMessage>(data['data']);
    }
    if (dataClassName == 'SysNotifyTemplate') {
      return deserialize<_i38.SysNotifyTemplate>(data['data']);
    }
    if (dataClassName == 'SysOperateLog') {
      return deserialize<_i39.SysOperateLog>(data['data']);
    }
    if (dataClassName == 'SysPost') {
      return deserialize<_i40.SysPost>(data['data']);
    }
    if (dataClassName == 'SysRole') {
      return deserialize<_i41.SysRole>(data['data']);
    }
    if (dataClassName == 'SysRoleMenu') {
      return deserialize<_i42.SysRoleMenu>(data['data']);
    }
    if (dataClassName == 'SysSmsChannel') {
      return deserialize<_i43.SysSmsChannel>(data['data']);
    }
    if (dataClassName == 'SysSmsCode') {
      return deserialize<_i44.SysSmsCode>(data['data']);
    }
    if (dataClassName == 'SysSmsLog') {
      return deserialize<_i45.SysSmsLog>(data['data']);
    }
    if (dataClassName == 'SysSmsTemplate') {
      return deserialize<_i46.SysSmsTemplate>(data['data']);
    }
    if (dataClassName == 'SysSocialClient') {
      return deserialize<_i47.SysSocialClient>(data['data']);
    }
    if (dataClassName == 'SysSocialUser') {
      return deserialize<_i48.SysSocialUser>(data['data']);
    }
    if (dataClassName == 'SysSocialUserBind') {
      return deserialize<_i49.SysSocialUserBind>(data['data']);
    }
    if (dataClassName == 'SysTenant') {
      return deserialize<_i50.SysTenant>(data['data']);
    }
    if (dataClassName == 'SysTenantPackage') {
      return deserialize<_i51.SysTenantPackage>(data['data']);
    }
    if (dataClassName == 'SysUser') {
      return deserialize<_i52.SysUser>(data['data']);
    }
    if (dataClassName == 'SysUserPost') {
      return deserialize<_i53.SysUserPost>(data['data']);
    }
    if (dataClassName == 'SysUserRole') {
      return deserialize<_i54.SysUserRole>(data['data']);
    }
    if (dataClassName == 'Qimen') {
      return deserialize<_i55.Qimen>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i58.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i59.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i58.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i59.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
