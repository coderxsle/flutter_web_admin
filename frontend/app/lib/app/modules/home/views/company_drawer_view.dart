import 'package:auto_shop_server/app/models/user_company_manager_model.dart';
import 'package:auto_shop_server/app/modules/account/views/bind_account_page.dart';
import 'package:auto_shop_server/app/modules/account_manager/account_manager.dart';
import 'package:auto_shop_server/app/modules/home/controllers/home_controller.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/common_widget.dart';
import 'package:auto_shop_server/app/utils/common_widget/my_dialog.dart';
import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyDrawerView extends StatefulWidget {
  const CompanyDrawerView({super.key});
  @override
  State<CompanyDrawerView> createState() => _CompanyDrawerViewState();
}

class _CompanyDrawerViewState extends State<CompanyDrawerView> {

  // 当前账户的用户ID
  int? currentCustomerId;

  @override
  void initState() {
    getCurrentBindCompanyList();
    super.initState();
  }
  
  // 获取当前用户所在的企业列表
  void getCurrentBindCompanyList() async {
    // todo: 获取当前用户所在的企业，绑定的企业，抽屉展示用
    // todo: 还未完成
    final result = await AccountManager.getBindCompanyList();
    if (result.success) {
      UserCompanyManagerModel model = UserCompanyManagerModel.fromJson(result.data);
      model.presentLogin?.isSelected = true;
      currentCustomerId = model.presentLogin?.customerId;
      AccountManager.currentCompany = model.presentLogin;
      AccountManager.otherCompanyList = model.otherCustomerList;

      AccountManager.bindCompanyList?.clear();
      AccountManager.bindCompanyList?.add(model.presentLogin!);
      AccountManager.bindCompanyList?.addAll(model.otherCustomerList??[]);
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // Color(0xFFE53935),  // 鲜艳红色
              // Color(0xFFB71C1C),  // 深色
              // Color(0xFF7F0000),  // 暗红色
              Color.fromARGB(255, 39, 54, 222),  // 亮蓝色
              Color.fromARGB(255, 19, 69, 145),  // 中蓝色
              Color.fromARGB(255, 8, 33, 92),  // 深蓝色
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: Column( 
          children: [
            // 用户信息头部
            _buildUserHeader(),
            // 企业列表
            Expanded(
              child: _buildCompanyList(),
            ),
            // 底部功能区 高级功能 + 设置
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 80.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: imageNetwork(AccountManager.currentCompany?.photoUrl??"", width: 60, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppManager.userAccount?.trueName??"",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        AccountManager.currentCompany?.actorStr??"",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      SizedBox(
                        width: 200.w,
                        child: Text(
                          AccountManager.currentCompany?.companyName??"", 
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ], 
              ),
              // Positioned(
              //   right: 0,
              //   child: IconButton(
              //     icon: const Icon(Icons.qr_code, color: Colors.white),
              //     onPressed: () {
              //       // 处理二维码点击
              //     },
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: AccountManager.bindCompanyList!.length + 1,  // +1 是为了添加"绑定账号"选项
      itemBuilder: (context, index) {
        if (index < (AccountManager.bindCompanyList?.length ?? 0)) {
          final company = AccountManager.bindCompanyList?[index];
          return _buildCompanyItem(
            company?.companyName ?? "",
            isSelected: AccountManager.bindCompanyList?.length == 1 ? true : company?.isSelected ?? false,
            onTap: () => _handleCompanySwitch(context, company?.customerId ?? 0),
          );
        } else {
          return _buildAddCompanyItem();
        }
      },
    );
  }

  Widget _buildCompanyItem(String name, {bool isSelected = false, VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? const Color.fromARGB(255, 214, 78, 65) : Color.fromARGB(255, 49, 80, 152),
      ),
      child: ListTile(
        selected: isSelected,
        leading: CircleAvatar(
          radius: 18.r,
          backgroundColor: isSelected ? Colors.green : Colors.white12, 
          child: Icon(Icons.business, color: isSelected ? Colors.white : Colors.grey, size: 20),
        ),
        title: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              const Icon(Icons.check, color: Colors.white)
            else
              GestureDetector(
                onTap: () => _handleUnbindCompany(),
                child: const Icon(Icons.close, color: Colors.white70),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildAddCompanyItem() {
    return ListTile(
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: Colors.white24,
        child: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
      title: Text(
        '绑定账号',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
        ),
      ),
      onTap: () {
        Get.to(() => BindAccountPage(callback: (bool result) {
          if (result) { 
            Get.back();
            showSuccessMessage("绑定成功");
            getCurrentBindCompanyList();
            final controller = Get.find<HomeController>();
            controller.getHomeData(); 
          }
        },));
      },
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          // Expanded(
          //   child: TextButton.icon(      
          //       // 设置内容居左显示
          //     style: TextButton.styleFrom(
          //       alignment: Alignment.centerLeft,
          //     ),      
          //     icon: const Icon(Icons.star, color: Color.fromARGB(179, 236, 174, 5)),
          //     label: Text(
          //       '高级功能',
          //       style: TextStyle(
          //         color: Colors.white70,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     onPressed: () {
          //       // 处理高级功能点击
          //     },
          //   )
          // ),

          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white70),
            onPressed: () {
              // 处理设置点击
              Get.toNamed("/MinePage");
            },
          ),
        ],
      ),
    );
  }

  void _handleCompanySwitch(context, int customerId) async {
    if (customerId == currentCustomerId) return;
    showLoadingMessage("正在切换企业"); 
    final ok = await AccountManager.switchCompany(customerId);
    dismissAlertDialog();
    if (ok == true) {
      showSuccessMessage("切换企业成功");
      // 关闭抽屉视图
      Navigator.pop(context);
      // 切换企业后，刷新数据   
      getCurrentBindCompanyList();
      final controller = Get.find<HomeController>();
      controller.getHomeData(); 
    }
  }

  // 添加解绑方法
  void _handleUnbindCompany() {
    showAlertDialog(
      title: '提示',
      message: '确定要解绑该企业账号吗？',
      confirm: () async {
        showLoadingMessage("正在解绑...");
        final ok = await AccountManager.unbindAccount();
        dismissAlertDialog();
        if (ok) {
          dismissAlertDialog();
          showSuccessMessage("解绑成功");
          getCurrentBindCompanyList();
        }
      },
    );
  }

} 