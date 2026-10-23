/// 中医模块权限码，必须与 lib/src/sql/sys_menu_init.sql 中的 sys_menu.permission 一致。
class ZhongyiPermissions {
  ZhongyiPermissions._();

  /// 模块门：任意 `zhongyi:*` 权限即可通过（前缀匹配）。
  static const module = 'zhongyi:*';

  static const medicineList = 'zhongyi:medicine:list';
  static const medicineCreate = 'zhongyi:medicine:create';
  static const medicineUpdate = 'zhongyi:medicine:update';
  static const medicineDelete = 'zhongyi:medicine:delete';

  static const inventoryList = 'zhongyi:inventory:list';
  static const inventoryStockIn = 'zhongyi:inventory:stockIn';
  static const inventoryAdjust = 'zhongyi:inventory:adjust';

  static const patientList = 'zhongyi:patient:list';
  static const patientCreate = 'zhongyi:patient:create';
  static const patientUpdate = 'zhongyi:patient:update';
  static const patientDelete = 'zhongyi:patient:delete';

  static const prescriptionList = 'zhongyi:prescription:list';
  static const prescriptionCreate = 'zhongyi:prescription:create';
  static const prescriptionUpdate = 'zhongyi:prescription:update';
  static const prescriptionDelete = 'zhongyi:prescription:delete';
  static const prescriptionStatus = 'zhongyi:prescription:status';

  static const billingList = 'zhongyi:billing:list';
  static const billingCreate = 'zhongyi:billing:create';
  static const billingDelete = 'zhongyi:billing:delete';
  static const billingPay = 'zhongyi:billing:pay';
  static const billingCancel = 'zhongyi:billing:cancel';
  static const billingRefund = 'zhongyi:billing:refund';
  static const billingRefundApprove = 'zhongyi:billing:refundApprove';
  static const billingRefundComplete = 'zhongyi:billing:refundComplete';

  static const departmentList = 'zhongyi:department:list';
  static const departmentCreate = 'zhongyi:department:create';
  static const departmentUpdate = 'zhongyi:department:update';
  static const departmentDelete = 'zhongyi:department:delete';

  static const staffList = 'zhongyi:staff:list';
  static const staffCreate = 'zhongyi:staff:create';
  static const staffUpdate = 'zhongyi:staff:update';
  static const staffDelete = 'zhongyi:staff:delete';
}
