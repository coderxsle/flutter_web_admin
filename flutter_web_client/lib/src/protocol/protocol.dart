/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_web_shared/flutter_web_shared.dart' as _iq2hfrj8;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_crud/serverpod_crud.dart' as _imp6a5q0;
import 'airtable/table_detail.dart' as _i6zo5dxe;
import 'airtable/table_fields.dart' as _ir6grwa3;
import 'airtable/table_fields_summary.dart' as _ii16vnmi;
import 'airtable/table_items.dart' as _iy8v68l8;
import 'airtable/table_rows.dart' as _iw3pi7wf;
import 'airtable/tables.dart' as _im6syzw2;
import 'book/book.dart' as _i07puk1i;
import 'book/book_category.dart' as _iw76u6h1;
import 'book/book_inventory_log.dart' as _it8vwnri;
import 'book/book_package.dart' as _icro447r;
import 'book/book_package_item.dart' as _ip0d84gw;
import 'book/book_sale.dart' as _isq1zfl1;
import 'region.dart' as _iyc67j15;
import 'store/store.dart' as _ik4zbmua;
import 'store/store_activity.dart' as _i6y3g69n;
import 'store/store_activity_book.dart' as _iii14bgn;
import 'store/store_book.dart' as _isa4zw2k;
import 'store/store_sales_record.dart' as _i8ny4ayx;
import 'system/infra_api_access_log.dart' as _iw7hk9ss;
import 'system/infra_api_error_log.dart' as _ingv1oqe;
import 'system/infra_file.dart' as _io2rypmv;
import 'system/infra_file_config.dart' as _ijxpuh3r;
import 'system/infra_file_content.dart' as _iso5f9hs;
import 'system/infra_job.dart' as _ig5mzeop;
import 'system/infra_job_log.dart' as _i4qn116k;
import 'system/sys_api.dart' as _isi9k84x;
import 'system/sys_dept.dart' as _ivfqfd00;
import 'system/sys_dict_code.dart' as _idt5f2ag;
import 'system/sys_dict_data.dart' as _i2y54425;
import 'system/sys_login_log.dart' as _irgnrpgq;
import 'system/sys_mail_account.dart' as _ic34qwew;
import 'system/sys_mail_log.dart' as _ilmu3ajp;
import 'system/sys_mail_template.dart' as _ijh7db1i;
import 'system/sys_menu.dart' as _ibxzqk4w;
import 'system/sys_notice.dart' as _i6981plk;
import 'system/sys_notify_message.dart' as _iva9nvja;
import 'system/sys_notify_template.dart' as _iambq962;
import 'system/sys_operate_log.dart' as _ij0sxugq;
import 'system/sys_post.dart' as _iuacl47m;
import 'system/sys_role.dart' as _i27tz95b;
import 'system/sys_role_menu.dart' as _iswjqd5m;
import 'system/sys_sms_channel.dart' as _ihiywatx;
import 'system/sys_sms_code.dart' as _ilisk9oy;
import 'system/sys_sms_log.dart' as _iqxe1cr0;
import 'system/sys_sms_template.dart' as _inyzeokl;
import 'system/sys_social_client.dart' as _izjiqj3m;
import 'system/sys_social_user.dart' as _i1xnvnir;
import 'system/sys_social_user_bind.dart' as _ix7amer0;
import 'system/sys_tenant.dart' as _ik8rxh4m;
import 'system/sys_tenant_package.dart' as _int6abja;
import 'system/sys_user.dart' as _i6862je3;
import 'system/sys_user_post.dart' as _id8l5nua;
import 'system/sys_user_role.dart' as _i2iya5z6;
import 'zhouyi/qimen.dart' as _i0gvvhpy;
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

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(dynamic data, [Type? t]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i6zo5dxe.AirTableDetail) {
      return _i6zo5dxe.AirTableDetail.fromJson(data) as T;
    }
    if (t == _ir6grwa3.AirTableFields) {
      return _ir6grwa3.AirTableFields.fromJson(data) as T;
    }
    if (t == _ii16vnmi.AirTableFieldsSummary) {
      return _ii16vnmi.AirTableFieldsSummary.fromJson(data) as T;
    }
    if (t == _iy8v68l8.AirTableItems) {
      return _iy8v68l8.AirTableItems.fromJson(data) as T;
    }
    if (t == _iw3pi7wf.AirTableRows) {
      return _iw3pi7wf.AirTableRows.fromJson(data) as T;
    }
    if (t == _im6syzw2.AirTables) {
      return _im6syzw2.AirTables.fromJson(data) as T;
    }
    if (t == _i07puk1i.Book) {
      return _i07puk1i.Book.fromJson(data) as T;
    }
    if (t == _iw76u6h1.BookCategory) {
      return _iw76u6h1.BookCategory.fromJson(data) as T;
    }
    if (t == _it8vwnri.BookInventoryLog) {
      return _it8vwnri.BookInventoryLog.fromJson(data) as T;
    }
    if (t == _icro447r.BookPackage) {
      return _icro447r.BookPackage.fromJson(data) as T;
    }
    if (t == _ip0d84gw.BookPackageItem) {
      return _ip0d84gw.BookPackageItem.fromJson(data) as T;
    }
    if (t == _isq1zfl1.BookSale) {
      return _isq1zfl1.BookSale.fromJson(data) as T;
    }
    if (t == _iyc67j15.Region) {
      return _iyc67j15.Region.fromJson(data) as T;
    }
    if (t == _ik4zbmua.Store) {
      return _ik4zbmua.Store.fromJson(data) as T;
    }
    if (t == _i6y3g69n.StoreActivity) {
      return _i6y3g69n.StoreActivity.fromJson(data) as T;
    }
    if (t == _iii14bgn.StoreActivityBook) {
      return _iii14bgn.StoreActivityBook.fromJson(data) as T;
    }
    if (t == _isa4zw2k.StoreBook) {
      return _isa4zw2k.StoreBook.fromJson(data) as T;
    }
    if (t == _i8ny4ayx.StoreSalesRecord) {
      return _i8ny4ayx.StoreSalesRecord.fromJson(data) as T;
    }
    if (t == _iw7hk9ss.InfraApiAccessLog) {
      return _iw7hk9ss.InfraApiAccessLog.fromJson(data) as T;
    }
    if (t == _ingv1oqe.InfraApiErrorLog) {
      return _ingv1oqe.InfraApiErrorLog.fromJson(data) as T;
    }
    if (t == _io2rypmv.InfraFile) {
      return _io2rypmv.InfraFile.fromJson(data) as T;
    }
    if (t == _ijxpuh3r.InfraFileConfig) {
      return _ijxpuh3r.InfraFileConfig.fromJson(data) as T;
    }
    if (t == _iso5f9hs.InfraFileContent) {
      return _iso5f9hs.InfraFileContent.fromJson(data) as T;
    }
    if (t == _ig5mzeop.InfraJob) {
      return _ig5mzeop.InfraJob.fromJson(data) as T;
    }
    if (t == _i4qn116k.InfraJobLog) {
      return _i4qn116k.InfraJobLog.fromJson(data) as T;
    }
    if (t == _isi9k84x.SysApi) {
      return _isi9k84x.SysApi.fromJson(data) as T;
    }
    if (t == _ivfqfd00.SysDept) {
      return _ivfqfd00.SysDept.fromJson(data) as T;
    }
    if (t == _idt5f2ag.SysDictCode) {
      return _idt5f2ag.SysDictCode.fromJson(data) as T;
    }
    if (t == _i2y54425.SysDictData) {
      return _i2y54425.SysDictData.fromJson(data) as T;
    }
    if (t == _irgnrpgq.SysLoginLog) {
      return _irgnrpgq.SysLoginLog.fromJson(data) as T;
    }
    if (t == _ic34qwew.SysMailAccount) {
      return _ic34qwew.SysMailAccount.fromJson(data) as T;
    }
    if (t == _ilmu3ajp.SysMailLog) {
      return _ilmu3ajp.SysMailLog.fromJson(data) as T;
    }
    if (t == _ijh7db1i.SysMailTemplate) {
      return _ijh7db1i.SysMailTemplate.fromJson(data) as T;
    }
    if (t == _ibxzqk4w.SysMenu) {
      return _ibxzqk4w.SysMenu.fromJson(data) as T;
    }
    if (t == _i6981plk.SysNotice) {
      return _i6981plk.SysNotice.fromJson(data) as T;
    }
    if (t == _iva9nvja.SysNotifyMessage) {
      return _iva9nvja.SysNotifyMessage.fromJson(data) as T;
    }
    if (t == _iambq962.SysNotifyTemplate) {
      return _iambq962.SysNotifyTemplate.fromJson(data) as T;
    }
    if (t == _ij0sxugq.SysOperateLog) {
      return _ij0sxugq.SysOperateLog.fromJson(data) as T;
    }
    if (t == _iuacl47m.SysPost) {
      return _iuacl47m.SysPost.fromJson(data) as T;
    }
    if (t == _i27tz95b.SysRole) {
      return _i27tz95b.SysRole.fromJson(data) as T;
    }
    if (t == _iswjqd5m.SysRoleMenu) {
      return _iswjqd5m.SysRoleMenu.fromJson(data) as T;
    }
    if (t == _ihiywatx.SysSmsChannel) {
      return _ihiywatx.SysSmsChannel.fromJson(data) as T;
    }
    if (t == _ilisk9oy.SysSmsCode) {
      return _ilisk9oy.SysSmsCode.fromJson(data) as T;
    }
    if (t == _iqxe1cr0.SysSmsLog) {
      return _iqxe1cr0.SysSmsLog.fromJson(data) as T;
    }
    if (t == _inyzeokl.SysSmsTemplate) {
      return _inyzeokl.SysSmsTemplate.fromJson(data) as T;
    }
    if (t == _izjiqj3m.SysSocialClient) {
      return _izjiqj3m.SysSocialClient.fromJson(data) as T;
    }
    if (t == _i1xnvnir.SysSocialUser) {
      return _i1xnvnir.SysSocialUser.fromJson(data) as T;
    }
    if (t == _ix7amer0.SysSocialUserBind) {
      return _ix7amer0.SysSocialUserBind.fromJson(data) as T;
    }
    if (t == _ik8rxh4m.SysTenant) {
      return _ik8rxh4m.SysTenant.fromJson(data) as T;
    }
    if (t == _int6abja.SysTenantPackage) {
      return _int6abja.SysTenantPackage.fromJson(data) as T;
    }
    if (t == _i6862je3.SysUser) {
      return _i6862je3.SysUser.fromJson(data) as T;
    }
    if (t == _id8l5nua.SysUserPost) {
      return _id8l5nua.SysUserPost.fromJson(data) as T;
    }
    if (t == _i2iya5z6.SysUserRole) {
      return _i2iya5z6.SysUserRole.fromJson(data) as T;
    }
    if (t == _i0gvvhpy.Qimen) {
      return _i0gvvhpy.Qimen.fromJson(data) as T;
    }
    if (t == _isc.getType<_i6zo5dxe.AirTableDetail?>()) {
      return (data != null ? _i6zo5dxe.AirTableDetail.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ir6grwa3.AirTableFields?>()) {
      return (data != null ? _ir6grwa3.AirTableFields.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ii16vnmi.AirTableFieldsSummary?>()) {
      return (data != null
              ? _ii16vnmi.AirTableFieldsSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iy8v68l8.AirTableItems?>()) {
      return (data != null ? _iy8v68l8.AirTableItems.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iw3pi7wf.AirTableRows?>()) {
      return (data != null ? _iw3pi7wf.AirTableRows.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_im6syzw2.AirTables?>()) {
      return (data != null ? _im6syzw2.AirTables.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i07puk1i.Book?>()) {
      return (data != null ? _i07puk1i.Book.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iw76u6h1.BookCategory?>()) {
      return (data != null ? _iw76u6h1.BookCategory.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_it8vwnri.BookInventoryLog?>()) {
      return (data != null ? _it8vwnri.BookInventoryLog.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icro447r.BookPackage?>()) {
      return (data != null ? _icro447r.BookPackage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ip0d84gw.BookPackageItem?>()) {
      return (data != null ? _ip0d84gw.BookPackageItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_isq1zfl1.BookSale?>()) {
      return (data != null ? _isq1zfl1.BookSale.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iyc67j15.Region?>()) {
      return (data != null ? _iyc67j15.Region.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ik4zbmua.Store?>()) {
      return (data != null ? _ik4zbmua.Store.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i6y3g69n.StoreActivity?>()) {
      return (data != null ? _i6y3g69n.StoreActivity.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iii14bgn.StoreActivityBook?>()) {
      return (data != null ? _iii14bgn.StoreActivityBook.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_isa4zw2k.StoreBook?>()) {
      return (data != null ? _isa4zw2k.StoreBook.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8ny4ayx.StoreSalesRecord?>()) {
      return (data != null ? _i8ny4ayx.StoreSalesRecord.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iw7hk9ss.InfraApiAccessLog?>()) {
      return (data != null ? _iw7hk9ss.InfraApiAccessLog.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ingv1oqe.InfraApiErrorLog?>()) {
      return (data != null ? _ingv1oqe.InfraApiErrorLog.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_io2rypmv.InfraFile?>()) {
      return (data != null ? _io2rypmv.InfraFile.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijxpuh3r.InfraFileConfig?>()) {
      return (data != null ? _ijxpuh3r.InfraFileConfig.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iso5f9hs.InfraFileContent?>()) {
      return (data != null ? _iso5f9hs.InfraFileContent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ig5mzeop.InfraJob?>()) {
      return (data != null ? _ig5mzeop.InfraJob.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4qn116k.InfraJobLog?>()) {
      return (data != null ? _i4qn116k.InfraJobLog.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isi9k84x.SysApi?>()) {
      return (data != null ? _isi9k84x.SysApi.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ivfqfd00.SysDept?>()) {
      return (data != null ? _ivfqfd00.SysDept.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idt5f2ag.SysDictCode?>()) {
      return (data != null ? _idt5f2ag.SysDictCode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i2y54425.SysDictData?>()) {
      return (data != null ? _i2y54425.SysDictData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irgnrpgq.SysLoginLog?>()) {
      return (data != null ? _irgnrpgq.SysLoginLog.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ic34qwew.SysMailAccount?>()) {
      return (data != null ? _ic34qwew.SysMailAccount.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ilmu3ajp.SysMailLog?>()) {
      return (data != null ? _ilmu3ajp.SysMailLog.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijh7db1i.SysMailTemplate?>()) {
      return (data != null ? _ijh7db1i.SysMailTemplate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ibxzqk4w.SysMenu?>()) {
      return (data != null ? _ibxzqk4w.SysMenu.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i6981plk.SysNotice?>()) {
      return (data != null ? _i6981plk.SysNotice.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iva9nvja.SysNotifyMessage?>()) {
      return (data != null ? _iva9nvja.SysNotifyMessage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iambq962.SysNotifyTemplate?>()) {
      return (data != null ? _iambq962.SysNotifyTemplate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ij0sxugq.SysOperateLog?>()) {
      return (data != null ? _ij0sxugq.SysOperateLog.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iuacl47m.SysPost?>()) {
      return (data != null ? _iuacl47m.SysPost.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i27tz95b.SysRole?>()) {
      return (data != null ? _i27tz95b.SysRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iswjqd5m.SysRoleMenu?>()) {
      return (data != null ? _iswjqd5m.SysRoleMenu.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ihiywatx.SysSmsChannel?>()) {
      return (data != null ? _ihiywatx.SysSmsChannel.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ilisk9oy.SysSmsCode?>()) {
      return (data != null ? _ilisk9oy.SysSmsCode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqxe1cr0.SysSmsLog?>()) {
      return (data != null ? _iqxe1cr0.SysSmsLog.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inyzeokl.SysSmsTemplate?>()) {
      return (data != null ? _inyzeokl.SysSmsTemplate.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izjiqj3m.SysSocialClient?>()) {
      return (data != null ? _izjiqj3m.SysSocialClient.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1xnvnir.SysSocialUser?>()) {
      return (data != null ? _i1xnvnir.SysSocialUser.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ix7amer0.SysSocialUserBind?>()) {
      return (data != null ? _ix7amer0.SysSocialUserBind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ik8rxh4m.SysTenant?>()) {
      return (data != null ? _ik8rxh4m.SysTenant.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_int6abja.SysTenantPackage?>()) {
      return (data != null ? _int6abja.SysTenantPackage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6862je3.SysUser?>()) {
      return (data != null ? _i6862je3.SysUser.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_id8l5nua.SysUserPost?>()) {
      return (data != null ? _id8l5nua.SysUserPost.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i2iya5z6.SysUserRole?>()) {
      return (data != null ? _i2iya5z6.SysUserRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i0gvvhpy.Qimen?>()) {
      return (data != null ? _i0gvvhpy.Qimen.fromJson(data) : null) as T;
    }
    if (t == List<_ii16vnmi.AirTableFieldsSummary>) {
      return (data as List)
              .map((e) => deserialize<_ii16vnmi.AirTableFieldsSummary>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ii16vnmi.AirTableFieldsSummary>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ii16vnmi.AirTableFieldsSummary>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iy8v68l8.AirTableItems>) {
      return (data as List)
              .map((e) => deserialize<_iy8v68l8.AirTableItems>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iy8v68l8.AirTableItems>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iy8v68l8.AirTableItems>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ir6grwa3.AirTableFields>) {
      return (data as List)
              .map((e) => deserialize<_ir6grwa3.AirTableFields>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ir6grwa3.AirTableFields>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ir6grwa3.AirTableFields>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iw3pi7wf.AirTableRows>) {
      return (data as List)
              .map((e) => deserialize<_iw3pi7wf.AirTableRows>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iw3pi7wf.AirTableRows>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iw3pi7wf.AirTableRows>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _isc.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_ibxzqk4w.SysMenu>) {
      return (data as List)
              .map((e) => deserialize<_ibxzqk4w.SysMenu>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ibxzqk4w.SysMenu>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ibxzqk4w.SysMenu>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_isi9k84x.SysApi>) {
      return (data as List)
              .map((e) => deserialize<_isi9k84x.SysApi>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_isi9k84x.SysApi>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_isi9k84x.SysApi>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == dynamic) {
      return deserializeDynamicFieldValue(data) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _iq2hfrj8.BaseResponse) {
      return _iq2hfrj8.BaseResponse.fromJson(data) as T;
    }
    if (t == _iq2hfrj8.CommonResponse) {
      return _iq2hfrj8.CommonResponse.fromJson(data) as T;
    }
    if (t == _iq2hfrj8.PageResponse) {
      return _iq2hfrj8.PageResponse.fromJson(data) as T;
    }
    if (t == _imp6a5q0.QueryRequest) {
      return _imp6a5q0.QueryRequest.fromJson(data) as T;
    }
    if (t == _imp6a5q0.QueryFilter) {
      return _imp6a5q0.QueryFilter.fromJson(data) as T;
    }
    if (t == _imp6a5q0.QuerySort) {
      return _imp6a5q0.QuerySort.fromJson(data) as T;
    }
    if (t == _isc.getType<_iq2hfrj8.BaseResponse?>()) {
      return (data != null ? _iq2hfrj8.BaseResponse.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iq2hfrj8.CommonResponse?>()) {
      return (data != null ? _iq2hfrj8.CommonResponse.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iq2hfrj8.PageResponse?>()) {
      return (data != null ? _iq2hfrj8.PageResponse.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imp6a5q0.QueryRequest?>()) {
      return (data != null ? _imp6a5q0.QueryRequest.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imp6a5q0.QueryFilter?>()) {
      return (data != null ? _imp6a5q0.QueryFilter.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imp6a5q0.QuerySort?>()) {
      return (data != null ? _imp6a5q0.QuerySort.fromJson(data) : null) as T;
    }
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iq2hfrj8.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _imp6a5q0.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iq2hfrj8.BaseResponse => 'BaseResponse',
      _iq2hfrj8.CommonResponse => 'CommonResponse',
      _iq2hfrj8.PageResponse => 'PageResponse',
      _imp6a5q0.QueryRequest => 'QueryRequest',
      _imp6a5q0.QueryFilter => 'QueryFilter',
      _imp6a5q0.QuerySort => 'QuerySort',
      _i6zo5dxe.AirTableDetail => 'AirTableDetail',
      _ir6grwa3.AirTableFields => 'AirTableFields',
      _ii16vnmi.AirTableFieldsSummary => 'AirTableFieldsSummary',
      _iy8v68l8.AirTableItems => 'AirTableItems',
      _iw3pi7wf.AirTableRows => 'AirTableRows',
      _im6syzw2.AirTables => 'AirTables',
      _i07puk1i.Book => 'Book',
      _iw76u6h1.BookCategory => 'BookCategory',
      _it8vwnri.BookInventoryLog => 'BookInventoryLog',
      _icro447r.BookPackage => 'BookPackage',
      _ip0d84gw.BookPackageItem => 'BookPackageItem',
      _isq1zfl1.BookSale => 'BookSale',
      _iyc67j15.Region => 'Region',
      _ik4zbmua.Store => 'Store',
      _i6y3g69n.StoreActivity => 'StoreActivity',
      _iii14bgn.StoreActivityBook => 'StoreActivityBook',
      _isa4zw2k.StoreBook => 'StoreBook',
      _i8ny4ayx.StoreSalesRecord => 'StoreSalesRecord',
      _iw7hk9ss.InfraApiAccessLog => 'InfraApiAccessLog',
      _ingv1oqe.InfraApiErrorLog => 'InfraApiErrorLog',
      _io2rypmv.InfraFile => 'InfraFile',
      _ijxpuh3r.InfraFileConfig => 'InfraFileConfig',
      _iso5f9hs.InfraFileContent => 'InfraFileContent',
      _ig5mzeop.InfraJob => 'InfraJob',
      _i4qn116k.InfraJobLog => 'InfraJobLog',
      _isi9k84x.SysApi => 'SysApi',
      _ivfqfd00.SysDept => 'SysDept',
      _idt5f2ag.SysDictCode => 'SysDictCode',
      _i2y54425.SysDictData => 'SysDictData',
      _irgnrpgq.SysLoginLog => 'SysLoginLog',
      _ic34qwew.SysMailAccount => 'SysMailAccount',
      _ilmu3ajp.SysMailLog => 'SysMailLog',
      _ijh7db1i.SysMailTemplate => 'SysMailTemplate',
      _ibxzqk4w.SysMenu => 'SysMenu',
      _i6981plk.SysNotice => 'SysNotice',
      _iva9nvja.SysNotifyMessage => 'SysNotifyMessage',
      _iambq962.SysNotifyTemplate => 'SysNotifyTemplate',
      _ij0sxugq.SysOperateLog => 'SysOperateLog',
      _iuacl47m.SysPost => 'SysPost',
      _i27tz95b.SysRole => 'SysRole',
      _iswjqd5m.SysRoleMenu => 'SysRoleMenu',
      _ihiywatx.SysSmsChannel => 'SysSmsChannel',
      _ilisk9oy.SysSmsCode => 'SysSmsCode',
      _iqxe1cr0.SysSmsLog => 'SysSmsLog',
      _inyzeokl.SysSmsTemplate => 'SysSmsTemplate',
      _izjiqj3m.SysSocialClient => 'SysSocialClient',
      _i1xnvnir.SysSocialUser => 'SysSocialUser',
      _ix7amer0.SysSocialUserBind => 'SysSocialUserBind',
      _ik8rxh4m.SysTenant => 'SysTenant',
      _int6abja.SysTenantPackage => 'SysTenantPackage',
      _i6862je3.SysUser => 'SysUser',
      _id8l5nua.SysUserPost => 'SysUserPost',
      _i2iya5z6.SysUserRole => 'SysUserRole',
      _i0gvvhpy.Qimen => 'Qimen',
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
      case _iq2hfrj8.BaseResponse():
        return 'BaseResponse';
      case _iq2hfrj8.CommonResponse():
        return 'CommonResponse';
      case _iq2hfrj8.PageResponse():
        return 'PageResponse';
      case _imp6a5q0.QueryRequest():
        return 'QueryRequest';
      case _imp6a5q0.QueryFilter():
        return 'QueryFilter';
      case _imp6a5q0.QuerySort():
        return 'QuerySort';
      case _i6zo5dxe.AirTableDetail():
        return 'AirTableDetail';
      case _ir6grwa3.AirTableFields():
        return 'AirTableFields';
      case _ii16vnmi.AirTableFieldsSummary():
        return 'AirTableFieldsSummary';
      case _iy8v68l8.AirTableItems():
        return 'AirTableItems';
      case _iw3pi7wf.AirTableRows():
        return 'AirTableRows';
      case _im6syzw2.AirTables():
        return 'AirTables';
      case _i07puk1i.Book():
        return 'Book';
      case _iw76u6h1.BookCategory():
        return 'BookCategory';
      case _it8vwnri.BookInventoryLog():
        return 'BookInventoryLog';
      case _icro447r.BookPackage():
        return 'BookPackage';
      case _ip0d84gw.BookPackageItem():
        return 'BookPackageItem';
      case _isq1zfl1.BookSale():
        return 'BookSale';
      case _iyc67j15.Region():
        return 'Region';
      case _ik4zbmua.Store():
        return 'Store';
      case _i6y3g69n.StoreActivity():
        return 'StoreActivity';
      case _iii14bgn.StoreActivityBook():
        return 'StoreActivityBook';
      case _isa4zw2k.StoreBook():
        return 'StoreBook';
      case _i8ny4ayx.StoreSalesRecord():
        return 'StoreSalesRecord';
      case _iw7hk9ss.InfraApiAccessLog():
        return 'InfraApiAccessLog';
      case _ingv1oqe.InfraApiErrorLog():
        return 'InfraApiErrorLog';
      case _io2rypmv.InfraFile():
        return 'InfraFile';
      case _ijxpuh3r.InfraFileConfig():
        return 'InfraFileConfig';
      case _iso5f9hs.InfraFileContent():
        return 'InfraFileContent';
      case _ig5mzeop.InfraJob():
        return 'InfraJob';
      case _i4qn116k.InfraJobLog():
        return 'InfraJobLog';
      case _isi9k84x.SysApi():
        return 'SysApi';
      case _ivfqfd00.SysDept():
        return 'SysDept';
      case _idt5f2ag.SysDictCode():
        return 'SysDictCode';
      case _i2y54425.SysDictData():
        return 'SysDictData';
      case _irgnrpgq.SysLoginLog():
        return 'SysLoginLog';
      case _ic34qwew.SysMailAccount():
        return 'SysMailAccount';
      case _ilmu3ajp.SysMailLog():
        return 'SysMailLog';
      case _ijh7db1i.SysMailTemplate():
        return 'SysMailTemplate';
      case _ibxzqk4w.SysMenu():
        return 'SysMenu';
      case _i6981plk.SysNotice():
        return 'SysNotice';
      case _iva9nvja.SysNotifyMessage():
        return 'SysNotifyMessage';
      case _iambq962.SysNotifyTemplate():
        return 'SysNotifyTemplate';
      case _ij0sxugq.SysOperateLog():
        return 'SysOperateLog';
      case _iuacl47m.SysPost():
        return 'SysPost';
      case _i27tz95b.SysRole():
        return 'SysRole';
      case _iswjqd5m.SysRoleMenu():
        return 'SysRoleMenu';
      case _ihiywatx.SysSmsChannel():
        return 'SysSmsChannel';
      case _ilisk9oy.SysSmsCode():
        return 'SysSmsCode';
      case _iqxe1cr0.SysSmsLog():
        return 'SysSmsLog';
      case _inyzeokl.SysSmsTemplate():
        return 'SysSmsTemplate';
      case _izjiqj3m.SysSocialClient():
        return 'SysSocialClient';
      case _i1xnvnir.SysSocialUser():
        return 'SysSocialUser';
      case _ix7amer0.SysSocialUserBind():
        return 'SysSocialUserBind';
      case _ik8rxh4m.SysTenant():
        return 'SysTenant';
      case _int6abja.SysTenantPackage():
        return 'SysTenantPackage';
      case _i6862je3.SysUser():
        return 'SysUser';
      case _id8l5nua.SysUserPost():
        return 'SysUserPost';
      case _i2iya5z6.SysUserRole():
        return 'SysUserRole';
      case _i0gvvhpy.Qimen():
        return 'Qimen';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iq2hfrj8.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'flutter_web_shared.$className';
    }
    className = _imp6a5q0.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_crud.$className';
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
      return deserialize<_iq2hfrj8.BaseResponse>(data['data']);
    }
    if (dataClassName == 'CommonResponse') {
      return deserialize<_iq2hfrj8.CommonResponse>(data['data']);
    }
    if (dataClassName == 'PageResponse') {
      return deserialize<_iq2hfrj8.PageResponse>(data['data']);
    }
    if (dataClassName == 'QueryRequest') {
      return deserialize<_imp6a5q0.QueryRequest>(data['data']);
    }
    if (dataClassName == 'QueryFilter') {
      return deserialize<_imp6a5q0.QueryFilter>(data['data']);
    }
    if (dataClassName == 'QuerySort') {
      return deserialize<_imp6a5q0.QuerySort>(data['data']);
    }
    if (dataClassName == 'AirTableDetail') {
      return deserialize<_i6zo5dxe.AirTableDetail>(data['data']);
    }
    if (dataClassName == 'AirTableFields') {
      return deserialize<_ir6grwa3.AirTableFields>(data['data']);
    }
    if (dataClassName == 'AirTableFieldsSummary') {
      return deserialize<_ii16vnmi.AirTableFieldsSummary>(data['data']);
    }
    if (dataClassName == 'AirTableItems') {
      return deserialize<_iy8v68l8.AirTableItems>(data['data']);
    }
    if (dataClassName == 'AirTableRows') {
      return deserialize<_iw3pi7wf.AirTableRows>(data['data']);
    }
    if (dataClassName == 'AirTables') {
      return deserialize<_im6syzw2.AirTables>(data['data']);
    }
    if (dataClassName == 'Book') {
      return deserialize<_i07puk1i.Book>(data['data']);
    }
    if (dataClassName == 'BookCategory') {
      return deserialize<_iw76u6h1.BookCategory>(data['data']);
    }
    if (dataClassName == 'BookInventoryLog') {
      return deserialize<_it8vwnri.BookInventoryLog>(data['data']);
    }
    if (dataClassName == 'BookPackage') {
      return deserialize<_icro447r.BookPackage>(data['data']);
    }
    if (dataClassName == 'BookPackageItem') {
      return deserialize<_ip0d84gw.BookPackageItem>(data['data']);
    }
    if (dataClassName == 'BookSale') {
      return deserialize<_isq1zfl1.BookSale>(data['data']);
    }
    if (dataClassName == 'Region') {
      return deserialize<_iyc67j15.Region>(data['data']);
    }
    if (dataClassName == 'Store') {
      return deserialize<_ik4zbmua.Store>(data['data']);
    }
    if (dataClassName == 'StoreActivity') {
      return deserialize<_i6y3g69n.StoreActivity>(data['data']);
    }
    if (dataClassName == 'StoreActivityBook') {
      return deserialize<_iii14bgn.StoreActivityBook>(data['data']);
    }
    if (dataClassName == 'StoreBook') {
      return deserialize<_isa4zw2k.StoreBook>(data['data']);
    }
    if (dataClassName == 'StoreSalesRecord') {
      return deserialize<_i8ny4ayx.StoreSalesRecord>(data['data']);
    }
    if (dataClassName == 'InfraApiAccessLog') {
      return deserialize<_iw7hk9ss.InfraApiAccessLog>(data['data']);
    }
    if (dataClassName == 'InfraApiErrorLog') {
      return deserialize<_ingv1oqe.InfraApiErrorLog>(data['data']);
    }
    if (dataClassName == 'InfraFile') {
      return deserialize<_io2rypmv.InfraFile>(data['data']);
    }
    if (dataClassName == 'InfraFileConfig') {
      return deserialize<_ijxpuh3r.InfraFileConfig>(data['data']);
    }
    if (dataClassName == 'InfraFileContent') {
      return deserialize<_iso5f9hs.InfraFileContent>(data['data']);
    }
    if (dataClassName == 'InfraJob') {
      return deserialize<_ig5mzeop.InfraJob>(data['data']);
    }
    if (dataClassName == 'InfraJobLog') {
      return deserialize<_i4qn116k.InfraJobLog>(data['data']);
    }
    if (dataClassName == 'SysApi') {
      return deserialize<_isi9k84x.SysApi>(data['data']);
    }
    if (dataClassName == 'SysDept') {
      return deserialize<_ivfqfd00.SysDept>(data['data']);
    }
    if (dataClassName == 'SysDictCode') {
      return deserialize<_idt5f2ag.SysDictCode>(data['data']);
    }
    if (dataClassName == 'SysDictData') {
      return deserialize<_i2y54425.SysDictData>(data['data']);
    }
    if (dataClassName == 'SysLoginLog') {
      return deserialize<_irgnrpgq.SysLoginLog>(data['data']);
    }
    if (dataClassName == 'SysMailAccount') {
      return deserialize<_ic34qwew.SysMailAccount>(data['data']);
    }
    if (dataClassName == 'SysMailLog') {
      return deserialize<_ilmu3ajp.SysMailLog>(data['data']);
    }
    if (dataClassName == 'SysMailTemplate') {
      return deserialize<_ijh7db1i.SysMailTemplate>(data['data']);
    }
    if (dataClassName == 'SysMenu') {
      return deserialize<_ibxzqk4w.SysMenu>(data['data']);
    }
    if (dataClassName == 'SysNotice') {
      return deserialize<_i6981plk.SysNotice>(data['data']);
    }
    if (dataClassName == 'SysNotifyMessage') {
      return deserialize<_iva9nvja.SysNotifyMessage>(data['data']);
    }
    if (dataClassName == 'SysNotifyTemplate') {
      return deserialize<_iambq962.SysNotifyTemplate>(data['data']);
    }
    if (dataClassName == 'SysOperateLog') {
      return deserialize<_ij0sxugq.SysOperateLog>(data['data']);
    }
    if (dataClassName == 'SysPost') {
      return deserialize<_iuacl47m.SysPost>(data['data']);
    }
    if (dataClassName == 'SysRole') {
      return deserialize<_i27tz95b.SysRole>(data['data']);
    }
    if (dataClassName == 'SysRoleMenu') {
      return deserialize<_iswjqd5m.SysRoleMenu>(data['data']);
    }
    if (dataClassName == 'SysSmsChannel') {
      return deserialize<_ihiywatx.SysSmsChannel>(data['data']);
    }
    if (dataClassName == 'SysSmsCode') {
      return deserialize<_ilisk9oy.SysSmsCode>(data['data']);
    }
    if (dataClassName == 'SysSmsLog') {
      return deserialize<_iqxe1cr0.SysSmsLog>(data['data']);
    }
    if (dataClassName == 'SysSmsTemplate') {
      return deserialize<_inyzeokl.SysSmsTemplate>(data['data']);
    }
    if (dataClassName == 'SysSocialClient') {
      return deserialize<_izjiqj3m.SysSocialClient>(data['data']);
    }
    if (dataClassName == 'SysSocialUser') {
      return deserialize<_i1xnvnir.SysSocialUser>(data['data']);
    }
    if (dataClassName == 'SysSocialUserBind') {
      return deserialize<_ix7amer0.SysSocialUserBind>(data['data']);
    }
    if (dataClassName == 'SysTenant') {
      return deserialize<_ik8rxh4m.SysTenant>(data['data']);
    }
    if (dataClassName == 'SysTenantPackage') {
      return deserialize<_int6abja.SysTenantPackage>(data['data']);
    }
    if (dataClassName == 'SysUser') {
      return deserialize<_i6862je3.SysUser>(data['data']);
    }
    if (dataClassName == 'SysUserPost') {
      return deserialize<_id8l5nua.SysUserPost>(data['data']);
    }
    if (dataClassName == 'SysUserRole') {
      return deserialize<_i2iya5z6.SysUserRole>(data['data']);
    }
    if (dataClassName == 'Qimen') {
      return deserialize<_i0gvvhpy.Qimen>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('flutter_web_shared.')) {
      data['className'] = dataClassName.substring(19);
      return _iq2hfrj8.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_crud.')) {
      data['className'] = dataClassName.substring(15);
      return _imp6a5q0.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iacc.Protocol().registerHostProtocol('flutter_web', this);
    _iaic.Protocol().registerHostProtocol('flutter_web', this);
    _iq2hfrj8.Protocol().registerHostProtocol('flutter_web', this);
    _imp6a5q0.Protocol().registerHostProtocol('flutter_web', this);
  }

  @override
  String getModuleName() => 'flutter_web';

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
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
