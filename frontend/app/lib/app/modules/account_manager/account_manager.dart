import 'dart:convert';

import 'package:auto_shop_server/app/models/user_company_manager_model.dart';
import 'package:auto_shop_server/app/modules/home/models/shop_model.dart';
import 'package:auto_shop_server/app/modules/home/request/home_request.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/my_dialog.dart';
import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:auto_shop_server/app/modules/launching/loacal_storage.dart';
import 'package:auto_shop_server/database/db_manager.dart';
import 'package:auto_shop_server/app/modules/login/model/user_account.dart';
import 'package:auto_shop_server/common/widgets/search_list_view.dart';
import 'package:get/get.dart';
import 'package:http_manager/http_manager.dart';

import 'account_request.dart';

class AccountManager {

  // 
  static const String _key = "login_history";

  // 当前用户所在的企业列表
  static UserCompanyManagerModel? companyManager;

  // 当前用户所在的企业列表
  static UserCompanyModel? currentCompany;

  // 当前用户绑定的企业列表
  static List<UserCompanyModel>? bindCompanyList = [];

  // 当前用户可以绑定的企业列表
  static List<UserCompanyModel>? unBindCompanyList = [];

  // 当前用户其他企业的账号列表
  static List<UserCompanyModel>? otherCompanyList = [];
  
  
  // 获取当前用户绑定的企业列表
  static Future<ResponseAnalyzed> getBindCompanyList() async {
    return await AccountRequest.getBindCompanyList();
  }


  // 获取当前账号，可以绑定的公司列表
  static selectUnBindCompanyList({required SelectedCallBack onSelected}) async {
    showLoadingMessage("正在获取企业列表");
    final result = await AccountRequest.getUnBindCompanyList();
    _showCompanyList(result, onSelected: onSelected);
  }

  // 获取当前账号，其他的公司列表
  static selectOtherCompanyList({required SelectedCallBack onSelected}) async {
    showLoadingMessage("正在获取企业列表");
    final result = await AccountRequest.getOtherCompanyList(); 
    _showCompanyList(result, onSelected: onSelected);
  }

  // 切换企业
  static Future<bool> switchCompany(int customerId) async {
    final result = await AccountRequest.switchCompany(customerId);
    if (result.success) {
      AppManager.userAccount = UserAccount.fromJson(result.data);

      final result2 = await HomeRequest.getShopList();
      if (result.success) {
        List<ShopModel> shops = (result2.data as List).map((i) => ShopModel.fromJson(i)).toList();
        AppManager.setShopModel(shops.first);

        Map<String, dynamic> baseParam = {
          "shopInfoId": AppManager.currentShop?.shopInfoId, 
          "shopId": AppManager.currentShop?.shopInfoId
        };
        httpManager.setBaseParam(baseParam);

        // 切换到当前用户
        DBManager.switchBaseSpace();

        return true;
      }else {
        showMessage("切换企业失败，请联系管理员");
        return false;
      }
    }
    return false;
  }

  // 绑定账号
  static Future<bool> bindAccount(String phone, String password, int companyId) async {
    final result = await AccountRequest.bindAccount(phone, password, companyId);
    return result.success ? true : false;
  }

  /// 解绑企业账号
  static Future<bool> unbindAccount() async {
    final result = await AccountRequest.unbindAccount();
    return result.success ? true : false;
  }

  // 显示企业列表
  static _showCompanyList(var result, {required SelectedCallBack onSelected}) {
    List<UserCompanyModel> series = [];
    if (result.data is List && result.data!.isNotEmpty) {
      series = (result.data as List).map((i) => UserCompanyModel.fromJson(i)).toList();
    }
    dismissLoading();
    if (series.isEmpty) {
      showMessage("当前没有企业，请联系管理员配置");
      return;
    }
    List<SearchListViewModel> models = [];
    for (var e in series) {
      models.add(SearchListViewModel(title: e.companyName, id: e.companyId));
    }
    SearchListView.show(Get.context!, models: models, isSort: true, onSelected: (model) {
      onSelected(model);
      Get.back();
    });
  }










 /// 获取历史账号和密码列表
  static Future<List<Map<String, String>>> getLoginHistory() async {
    // 读取数据后进行类型转换
    List<dynamic>? jsonStringList = localStorageRead(_key);
    if (jsonStringList == null) return [];

    return jsonStringList.map((jsonString) {
      return Map<String, String>.from(json.decode(jsonString));
    }).toList();
  }

  /// 添加新的账号和密码到历史记录
  static Future<void> addAccountToHistory(String account, String password) async {
    List<dynamic>? jsonStringList = localStorageRead(_key);
    List<String> historyList = jsonStringList?.cast<String>() ?? [];
    
    Map<String, String> newEntry = {account: password};

    // 删除已存在的相同账号（若存在）
    historyList.removeWhere((jsonString) {
      Map<String, String> entry = Map<String, String>.from(json.decode(jsonString));
      return entry.containsKey(account);
    });

    historyList.insert(0, json.encode(newEntry));
    // 限制列表长度为10
    if (historyList.length > 10) {
      historyList = historyList.sublist(0, 10);
    }
    await localStorageWrite(_key, historyList);
  }

  /// 获取某个账号的密码
  static Future<String?> getPasswordForAccount(String account) async {
    List<Map<String, String>> history = await getLoginHistory();
    for (var entry in history) {
      if (entry.containsKey(account)) {
        return entry[account];
      }
    }
    return null;
  }
}