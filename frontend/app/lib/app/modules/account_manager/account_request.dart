import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:http_manager/http_manager.dart';

class AccountRequest {
  
  // 获取当前用户绑定的公司列表
  static Future<ResponseAnalyzed> getBindCompanyList() async {
    const url = "/auth/v1/basic/customerbinding/getCustomerBindingList";
    final param = {"customerId": AppManager.userAccount?.customerId};
    return await httpManager.postAnalyzing(url, params: param);
  }

  // 获取当前账号的用户，可以绑定的公司列表（已绑定的公司不显示）
  static getUnBindCompanyList() {
    final url = "/auth/v1/basic/customerbinding/getNoBindingCompany";
    return httpManager.postAnalyzing(url);
  }

  // 获取员工其他公司账号
  static getOtherCompanyList() {
    final url = "/auth/v1/basic/customerbinding/getEmployeeOtherCompany";
    return httpManager.postAnalyzing(url);
  }


  // 切换公司
  static Future<ResponseAnalyzed> switchCompany(int customerId) async {
    final url = "/auth/v1/basic/customerbinding/appSwitchCustomerBindingByCustomerId/$customerId";
    return await httpManager.postAnalyzing(url);
  }

  // 绑定账号
  static Future<ResponseAnalyzed> bindAccount(phone, password, companyId) async {
    const url = "/auth/v1/basic/customerbinding/addCustomerBinding";
    final param = {"phone": phone, "password": password, "companyId": companyId};
    return await httpManager.postAnalyzing(url, params: param);
  }

  // 解绑账号
  static Future<ResponseAnalyzed> unbindAccount() async {
    final customerId = AppManager.userAccount?.customerId;
    final url = "/auth/v1/basic/customerbinding/liftBindingByCustomerId/$customerId";
    return await httpManager.postAnalyzing(url);
  }
  }