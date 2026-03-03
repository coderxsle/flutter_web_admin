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
import 'common/base_model.dart' as _i14;
import 'common/pagination.dart' as _i15;
import 'custom/customer.dart' as _i16;
import 'region.dart' as _i17;
import 'responses/login.dart' as _i18;
import 'responses/user_info.dart' as _i19;
import 'store/store.dart' as _i20;
import 'store/store_activity.dart' as _i21;
import 'store/store_activity_book.dart' as _i22;
import 'store/store_book.dart' as _i23;
import 'store/store_sales_record.dart' as _i24;
import 'system/infra_api_access_log.dart' as _i25;
import 'system/infra_api_error_log.dart' as _i26;
import 'system/infra_file.dart' as _i27;
import 'system/infra_file_config.dart' as _i28;
import 'system/infra_file_content.dart' as _i29;
import 'system/infra_job.dart' as _i30;
import 'system/infra_job_log.dart' as _i31;
import 'system/sys_api.dart' as _i32;
import 'system/sys_dept.dart' as _i33;
import 'system/sys_dict_data.dart' as _i34;
import 'system/sys_dict_type.dart' as _i35;
import 'system/sys_login_log.dart' as _i36;
import 'system/sys_mail_account.dart' as _i37;
import 'system/sys_mail_log.dart' as _i38;
import 'system/sys_mail_template.dart' as _i39;
import 'system/sys_menu.dart' as _i40;
import 'system/sys_notice.dart' as _i41;
import 'system/sys_notify_message.dart' as _i42;
import 'system/sys_notify_template.dart' as _i43;
import 'system/sys_operate_log.dart' as _i44;
import 'system/sys_post.dart' as _i45;
import 'system/sys_role.dart' as _i46;
import 'system/sys_role_menu.dart' as _i47;
import 'system/sys_sms_channel.dart' as _i48;
import 'system/sys_sms_code.dart' as _i49;
import 'system/sys_sms_log.dart' as _i50;
import 'system/sys_sms_template.dart' as _i51;
import 'system/sys_social_client.dart' as _i52;
import 'system/sys_social_user.dart' as _i53;
import 'system/sys_social_user_bind.dart' as _i54;
import 'system/sys_tenant.dart' as _i55;
import 'system/sys_tenant_package.dart' as _i56;
import 'system/sys_user.dart' as _i57;
import 'system/sys_user_post.dart' as _i58;
import 'system/sys_user_role.dart' as _i59;
import 'zhouyi/qimen.dart' as _i60;
import 'package:flutter_web_shared/shared.dart' as _i61;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i62;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i63;
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
export 'common/base_model.dart';
export 'common/pagination.dart';
export 'custom/customer.dart';
export 'region.dart';
export 'responses/login.dart';
export 'responses/user_info.dart';
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
    if (t == _i14.BaseClass) {
      return _i14.BaseClass.fromJson(data) as T;
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
    if (t == _i18.LoginResponse) {
      return _i18.LoginResponse.fromJson(data) as T;
    }
    if (t == _i19.UserInfoResponse) {
      return _i19.UserInfoResponse.fromJson(data) as T;
    }
    if (t == _i20.Store) {
      return _i20.Store.fromJson(data) as T;
    }
    if (t == _i21.StoreActivity) {
      return _i21.StoreActivity.fromJson(data) as T;
    }
    if (t == _i22.StoreActivityBook) {
      return _i22.StoreActivityBook.fromJson(data) as T;
    }
    if (t == _i23.StoreBook) {
      return _i23.StoreBook.fromJson(data) as T;
    }
    if (t == _i24.StoreSalesRecord) {
      return _i24.StoreSalesRecord.fromJson(data) as T;
    }
    if (t == _i25.InfraApiAccessLog) {
      return _i25.InfraApiAccessLog.fromJson(data) as T;
    }
    if (t == _i26.InfraApiErrorLog) {
      return _i26.InfraApiErrorLog.fromJson(data) as T;
    }
    if (t == _i27.InfraFile) {
      return _i27.InfraFile.fromJson(data) as T;
    }
    if (t == _i28.InfraFileConfig) {
      return _i28.InfraFileConfig.fromJson(data) as T;
    }
    if (t == _i29.InfraFileContent) {
      return _i29.InfraFileContent.fromJson(data) as T;
    }
    if (t == _i30.InfraJob) {
      return _i30.InfraJob.fromJson(data) as T;
    }
    if (t == _i31.InfraJobLog) {
      return _i31.InfraJobLog.fromJson(data) as T;
    }
    if (t == _i32.SysApi) {
      return _i32.SysApi.fromJson(data) as T;
    }
    if (t == _i33.SysDept) {
      return _i33.SysDept.fromJson(data) as T;
    }
    if (t == _i34.SysDictData) {
      return _i34.SysDictData.fromJson(data) as T;
    }
    if (t == _i35.SysDictType) {
      return _i35.SysDictType.fromJson(data) as T;
    }
    if (t == _i36.SysLoginLog) {
      return _i36.SysLoginLog.fromJson(data) as T;
    }
    if (t == _i37.SysMailAccount) {
      return _i37.SysMailAccount.fromJson(data) as T;
    }
    if (t == _i38.SysMailLog) {
      return _i38.SysMailLog.fromJson(data) as T;
    }
    if (t == _i39.SysMailTemplate) {
      return _i39.SysMailTemplate.fromJson(data) as T;
    }
    if (t == _i40.SysMenu) {
      return _i40.SysMenu.fromJson(data) as T;
    }
    if (t == _i41.SysNotice) {
      return _i41.SysNotice.fromJson(data) as T;
    }
    if (t == _i42.SysNotifyMessage) {
      return _i42.SysNotifyMessage.fromJson(data) as T;
    }
    if (t == _i43.SysNotifyTemplate) {
      return _i43.SysNotifyTemplate.fromJson(data) as T;
    }
    if (t == _i44.SysOperateLog) {
      return _i44.SysOperateLog.fromJson(data) as T;
    }
    if (t == _i45.SysPost) {
      return _i45.SysPost.fromJson(data) as T;
    }
    if (t == _i46.SysRole) {
      return _i46.SysRole.fromJson(data) as T;
    }
    if (t == _i47.SysRoleMenu) {
      return _i47.SysRoleMenu.fromJson(data) as T;
    }
    if (t == _i48.SysSmsChannel) {
      return _i48.SysSmsChannel.fromJson(data) as T;
    }
    if (t == _i49.SysSmsCode) {
      return _i49.SysSmsCode.fromJson(data) as T;
    }
    if (t == _i50.SysSmsLog) {
      return _i50.SysSmsLog.fromJson(data) as T;
    }
    if (t == _i51.SysSmsTemplate) {
      return _i51.SysSmsTemplate.fromJson(data) as T;
    }
    if (t == _i52.SysSocialClient) {
      return _i52.SysSocialClient.fromJson(data) as T;
    }
    if (t == _i53.SysSocialUser) {
      return _i53.SysSocialUser.fromJson(data) as T;
    }
    if (t == _i54.SysSocialUserBind) {
      return _i54.SysSocialUserBind.fromJson(data) as T;
    }
    if (t == _i55.SysTenant) {
      return _i55.SysTenant.fromJson(data) as T;
    }
    if (t == _i56.SysTenantPackage) {
      return _i56.SysTenantPackage.fromJson(data) as T;
    }
    if (t == _i57.SysUser) {
      return _i57.SysUser.fromJson(data) as T;
    }
    if (t == _i58.SysUserPost) {
      return _i58.SysUserPost.fromJson(data) as T;
    }
    if (t == _i59.SysUserRole) {
      return _i59.SysUserRole.fromJson(data) as T;
    }
    if (t == _i60.Qimen) {
      return _i60.Qimen.fromJson(data) as T;
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
    if (t == _i1.getType<_i14.BaseClass?>()) {
      return (data != null ? _i14.BaseClass.fromJson(data) : null) as T;
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
    if (t == _i1.getType<_i18.LoginResponse?>()) {
      return (data != null ? _i18.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.UserInfoResponse?>()) {
      return (data != null ? _i19.UserInfoResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Store?>()) {
      return (data != null ? _i20.Store.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.StoreActivity?>()) {
      return (data != null ? _i21.StoreActivity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.StoreActivityBook?>()) {
      return (data != null ? _i22.StoreActivityBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.StoreBook?>()) {
      return (data != null ? _i23.StoreBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.StoreSalesRecord?>()) {
      return (data != null ? _i24.StoreSalesRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.InfraApiAccessLog?>()) {
      return (data != null ? _i25.InfraApiAccessLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.InfraApiErrorLog?>()) {
      return (data != null ? _i26.InfraApiErrorLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.InfraFile?>()) {
      return (data != null ? _i27.InfraFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.InfraFileConfig?>()) {
      return (data != null ? _i28.InfraFileConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.InfraFileContent?>()) {
      return (data != null ? _i29.InfraFileContent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.InfraJob?>()) {
      return (data != null ? _i30.InfraJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.InfraJobLog?>()) {
      return (data != null ? _i31.InfraJobLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SysApi?>()) {
      return (data != null ? _i32.SysApi.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.SysDept?>()) {
      return (data != null ? _i33.SysDept.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SysDictData?>()) {
      return (data != null ? _i34.SysDictData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.SysDictType?>()) {
      return (data != null ? _i35.SysDictType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.SysLoginLog?>()) {
      return (data != null ? _i36.SysLoginLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.SysMailAccount?>()) {
      return (data != null ? _i37.SysMailAccount.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.SysMailLog?>()) {
      return (data != null ? _i38.SysMailLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.SysMailTemplate?>()) {
      return (data != null ? _i39.SysMailTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.SysMenu?>()) {
      return (data != null ? _i40.SysMenu.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.SysNotice?>()) {
      return (data != null ? _i41.SysNotice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.SysNotifyMessage?>()) {
      return (data != null ? _i42.SysNotifyMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.SysNotifyTemplate?>()) {
      return (data != null ? _i43.SysNotifyTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.SysOperateLog?>()) {
      return (data != null ? _i44.SysOperateLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SysPost?>()) {
      return (data != null ? _i45.SysPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SysRole?>()) {
      return (data != null ? _i46.SysRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SysRoleMenu?>()) {
      return (data != null ? _i47.SysRoleMenu.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SysSmsChannel?>()) {
      return (data != null ? _i48.SysSmsChannel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SysSmsCode?>()) {
      return (data != null ? _i49.SysSmsCode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.SysSmsLog?>()) {
      return (data != null ? _i50.SysSmsLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SysSmsTemplate?>()) {
      return (data != null ? _i51.SysSmsTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.SysSocialClient?>()) {
      return (data != null ? _i52.SysSocialClient.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.SysSocialUser?>()) {
      return (data != null ? _i53.SysSocialUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.SysSocialUserBind?>()) {
      return (data != null ? _i54.SysSocialUserBind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.SysTenant?>()) {
      return (data != null ? _i55.SysTenant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.SysTenantPackage?>()) {
      return (data != null ? _i56.SysTenantPackage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.SysUser?>()) {
      return (data != null ? _i57.SysUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.SysUserPost?>()) {
      return (data != null ? _i58.SysUserPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.SysUserRole?>()) {
      return (data != null ? _i59.SysUserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.Qimen?>()) {
      return (data != null ? _i60.Qimen.fromJson(data) : null) as T;
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
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i40.SysMenu>) {
      return (data as List).map((e) => deserialize<_i40.SysMenu>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i40.SysMenu>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i40.SysMenu>(e)).toList()
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
    if (t == List<_i32.SysApi>) {
      return (data as List).map((e) => deserialize<_i32.SysApi>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i32.SysApi>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<_i32.SysApi>(e)).toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i61.BaseResponse) {
      return _i61.BaseResponse.fromJson(data) as T;
    }
    if (t == _i61.CommonResponse) {
      return _i61.CommonResponse.fromJson(data) as T;
    }
    if (t == _i61.PageResponse) {
      return _i61.PageResponse.fromJson(data) as T;
    }
    if (t == _i1.getType<_i61.BaseResponse?>()) {
      return (data != null ? _i61.BaseResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.CommonResponse?>()) {
      return (data != null ? _i61.CommonResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.PageResponse?>()) {
      return (data != null ? _i61.PageResponse.fromJson(data) : null) as T;
    }
    try {
      return _i62.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i63.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i61.BaseResponse => 'BaseResponse',
      _i61.CommonResponse => 'CommonResponse',
      _i61.PageResponse => 'PageResponse',
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
      _i14.BaseClass => 'BaseClass',
      _i15.Pagination => 'Pagination',
      _i16.Customer => 'Customer',
      _i17.Region => 'Region',
      _i18.LoginResponse => 'LoginResponse',
      _i19.UserInfoResponse => 'UserInfoResponse',
      _i20.Store => 'Store',
      _i21.StoreActivity => 'StoreActivity',
      _i22.StoreActivityBook => 'StoreActivityBook',
      _i23.StoreBook => 'StoreBook',
      _i24.StoreSalesRecord => 'StoreSalesRecord',
      _i25.InfraApiAccessLog => 'InfraApiAccessLog',
      _i26.InfraApiErrorLog => 'InfraApiErrorLog',
      _i27.InfraFile => 'InfraFile',
      _i28.InfraFileConfig => 'InfraFileConfig',
      _i29.InfraFileContent => 'InfraFileContent',
      _i30.InfraJob => 'InfraJob',
      _i31.InfraJobLog => 'InfraJobLog',
      _i32.SysApi => 'SysApi',
      _i33.SysDept => 'SysDept',
      _i34.SysDictData => 'SysDictData',
      _i35.SysDictType => 'SysDictType',
      _i36.SysLoginLog => 'SysLoginLog',
      _i37.SysMailAccount => 'SysMailAccount',
      _i38.SysMailLog => 'SysMailLog',
      _i39.SysMailTemplate => 'SysMailTemplate',
      _i40.SysMenu => 'SysMenu',
      _i41.SysNotice => 'SysNotice',
      _i42.SysNotifyMessage => 'SysNotifyMessage',
      _i43.SysNotifyTemplate => 'SysNotifyTemplate',
      _i44.SysOperateLog => 'SysOperateLog',
      _i45.SysPost => 'SysPost',
      _i46.SysRole => 'SysRole',
      _i47.SysRoleMenu => 'SysRoleMenu',
      _i48.SysSmsChannel => 'SysSmsChannel',
      _i49.SysSmsCode => 'SysSmsCode',
      _i50.SysSmsLog => 'SysSmsLog',
      _i51.SysSmsTemplate => 'SysSmsTemplate',
      _i52.SysSocialClient => 'SysSocialClient',
      _i53.SysSocialUser => 'SysSocialUser',
      _i54.SysSocialUserBind => 'SysSocialUserBind',
      _i55.SysTenant => 'SysTenant',
      _i56.SysTenantPackage => 'SysTenantPackage',
      _i57.SysUser => 'SysUser',
      _i58.SysUserPost => 'SysUserPost',
      _i59.SysUserRole => 'SysUserRole',
      _i60.Qimen => 'Qimen',
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
      case _i61.BaseResponse():
        return 'BaseResponse';
      case _i61.CommonResponse():
        return 'CommonResponse';
      case _i61.PageResponse():
        return 'PageResponse';
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
      case _i14.BaseClass():
        return 'BaseClass';
      case _i15.Pagination():
        return 'Pagination';
      case _i16.Customer():
        return 'Customer';
      case _i17.Region():
        return 'Region';
      case _i18.LoginResponse():
        return 'LoginResponse';
      case _i19.UserInfoResponse():
        return 'UserInfoResponse';
      case _i20.Store():
        return 'Store';
      case _i21.StoreActivity():
        return 'StoreActivity';
      case _i22.StoreActivityBook():
        return 'StoreActivityBook';
      case _i23.StoreBook():
        return 'StoreBook';
      case _i24.StoreSalesRecord():
        return 'StoreSalesRecord';
      case _i25.InfraApiAccessLog():
        return 'InfraApiAccessLog';
      case _i26.InfraApiErrorLog():
        return 'InfraApiErrorLog';
      case _i27.InfraFile():
        return 'InfraFile';
      case _i28.InfraFileConfig():
        return 'InfraFileConfig';
      case _i29.InfraFileContent():
        return 'InfraFileContent';
      case _i30.InfraJob():
        return 'InfraJob';
      case _i31.InfraJobLog():
        return 'InfraJobLog';
      case _i32.SysApi():
        return 'SysApi';
      case _i33.SysDept():
        return 'SysDept';
      case _i34.SysDictData():
        return 'SysDictData';
      case _i35.SysDictType():
        return 'SysDictType';
      case _i36.SysLoginLog():
        return 'SysLoginLog';
      case _i37.SysMailAccount():
        return 'SysMailAccount';
      case _i38.SysMailLog():
        return 'SysMailLog';
      case _i39.SysMailTemplate():
        return 'SysMailTemplate';
      case _i40.SysMenu():
        return 'SysMenu';
      case _i41.SysNotice():
        return 'SysNotice';
      case _i42.SysNotifyMessage():
        return 'SysNotifyMessage';
      case _i43.SysNotifyTemplate():
        return 'SysNotifyTemplate';
      case _i44.SysOperateLog():
        return 'SysOperateLog';
      case _i45.SysPost():
        return 'SysPost';
      case _i46.SysRole():
        return 'SysRole';
      case _i47.SysRoleMenu():
        return 'SysRoleMenu';
      case _i48.SysSmsChannel():
        return 'SysSmsChannel';
      case _i49.SysSmsCode():
        return 'SysSmsCode';
      case _i50.SysSmsLog():
        return 'SysSmsLog';
      case _i51.SysSmsTemplate():
        return 'SysSmsTemplate';
      case _i52.SysSocialClient():
        return 'SysSocialClient';
      case _i53.SysSocialUser():
        return 'SysSocialUser';
      case _i54.SysSocialUserBind():
        return 'SysSocialUserBind';
      case _i55.SysTenant():
        return 'SysTenant';
      case _i56.SysTenantPackage():
        return 'SysTenantPackage';
      case _i57.SysUser():
        return 'SysUser';
      case _i58.SysUserPost():
        return 'SysUserPost';
      case _i59.SysUserRole():
        return 'SysUserRole';
      case _i60.Qimen():
        return 'Qimen';
    }
    className = _i62.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i63.Protocol().getClassNameForObject(data);
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
      return deserialize<_i61.BaseResponse>(data['data']);
    }
    if (dataClassName == 'CommonResponse') {
      return deserialize<_i61.CommonResponse>(data['data']);
    }
    if (dataClassName == 'PageResponse') {
      return deserialize<_i61.PageResponse>(data['data']);
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
    if (dataClassName == 'BaseClass') {
      return deserialize<_i14.BaseClass>(data['data']);
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
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i18.LoginResponse>(data['data']);
    }
    if (dataClassName == 'UserInfoResponse') {
      return deserialize<_i19.UserInfoResponse>(data['data']);
    }
    if (dataClassName == 'Store') {
      return deserialize<_i20.Store>(data['data']);
    }
    if (dataClassName == 'StoreActivity') {
      return deserialize<_i21.StoreActivity>(data['data']);
    }
    if (dataClassName == 'StoreActivityBook') {
      return deserialize<_i22.StoreActivityBook>(data['data']);
    }
    if (dataClassName == 'StoreBook') {
      return deserialize<_i23.StoreBook>(data['data']);
    }
    if (dataClassName == 'StoreSalesRecord') {
      return deserialize<_i24.StoreSalesRecord>(data['data']);
    }
    if (dataClassName == 'InfraApiAccessLog') {
      return deserialize<_i25.InfraApiAccessLog>(data['data']);
    }
    if (dataClassName == 'InfraApiErrorLog') {
      return deserialize<_i26.InfraApiErrorLog>(data['data']);
    }
    if (dataClassName == 'InfraFile') {
      return deserialize<_i27.InfraFile>(data['data']);
    }
    if (dataClassName == 'InfraFileConfig') {
      return deserialize<_i28.InfraFileConfig>(data['data']);
    }
    if (dataClassName == 'InfraFileContent') {
      return deserialize<_i29.InfraFileContent>(data['data']);
    }
    if (dataClassName == 'InfraJob') {
      return deserialize<_i30.InfraJob>(data['data']);
    }
    if (dataClassName == 'InfraJobLog') {
      return deserialize<_i31.InfraJobLog>(data['data']);
    }
    if (dataClassName == 'SysApi') {
      return deserialize<_i32.SysApi>(data['data']);
    }
    if (dataClassName == 'SysDept') {
      return deserialize<_i33.SysDept>(data['data']);
    }
    if (dataClassName == 'SysDictData') {
      return deserialize<_i34.SysDictData>(data['data']);
    }
    if (dataClassName == 'SysDictType') {
      return deserialize<_i35.SysDictType>(data['data']);
    }
    if (dataClassName == 'SysLoginLog') {
      return deserialize<_i36.SysLoginLog>(data['data']);
    }
    if (dataClassName == 'SysMailAccount') {
      return deserialize<_i37.SysMailAccount>(data['data']);
    }
    if (dataClassName == 'SysMailLog') {
      return deserialize<_i38.SysMailLog>(data['data']);
    }
    if (dataClassName == 'SysMailTemplate') {
      return deserialize<_i39.SysMailTemplate>(data['data']);
    }
    if (dataClassName == 'SysMenu') {
      return deserialize<_i40.SysMenu>(data['data']);
    }
    if (dataClassName == 'SysNotice') {
      return deserialize<_i41.SysNotice>(data['data']);
    }
    if (dataClassName == 'SysNotifyMessage') {
      return deserialize<_i42.SysNotifyMessage>(data['data']);
    }
    if (dataClassName == 'SysNotifyTemplate') {
      return deserialize<_i43.SysNotifyTemplate>(data['data']);
    }
    if (dataClassName == 'SysOperateLog') {
      return deserialize<_i44.SysOperateLog>(data['data']);
    }
    if (dataClassName == 'SysPost') {
      return deserialize<_i45.SysPost>(data['data']);
    }
    if (dataClassName == 'SysRole') {
      return deserialize<_i46.SysRole>(data['data']);
    }
    if (dataClassName == 'SysRoleMenu') {
      return deserialize<_i47.SysRoleMenu>(data['data']);
    }
    if (dataClassName == 'SysSmsChannel') {
      return deserialize<_i48.SysSmsChannel>(data['data']);
    }
    if (dataClassName == 'SysSmsCode') {
      return deserialize<_i49.SysSmsCode>(data['data']);
    }
    if (dataClassName == 'SysSmsLog') {
      return deserialize<_i50.SysSmsLog>(data['data']);
    }
    if (dataClassName == 'SysSmsTemplate') {
      return deserialize<_i51.SysSmsTemplate>(data['data']);
    }
    if (dataClassName == 'SysSocialClient') {
      return deserialize<_i52.SysSocialClient>(data['data']);
    }
    if (dataClassName == 'SysSocialUser') {
      return deserialize<_i53.SysSocialUser>(data['data']);
    }
    if (dataClassName == 'SysSocialUserBind') {
      return deserialize<_i54.SysSocialUserBind>(data['data']);
    }
    if (dataClassName == 'SysTenant') {
      return deserialize<_i55.SysTenant>(data['data']);
    }
    if (dataClassName == 'SysTenantPackage') {
      return deserialize<_i56.SysTenantPackage>(data['data']);
    }
    if (dataClassName == 'SysUser') {
      return deserialize<_i57.SysUser>(data['data']);
    }
    if (dataClassName == 'SysUserPost') {
      return deserialize<_i58.SysUserPost>(data['data']);
    }
    if (dataClassName == 'SysUserRole') {
      return deserialize<_i59.SysUserRole>(data['data']);
    }
    if (dataClassName == 'Qimen') {
      return deserialize<_i60.Qimen>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i62.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i63.Protocol().deserializeByClassName(data);
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
      return _i62.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i63.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
