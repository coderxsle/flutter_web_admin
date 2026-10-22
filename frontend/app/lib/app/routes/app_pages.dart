import 'package:yun_men_yi_pan/app/modules/bottom_tab_bar/bindings/bottom_tab_binding.dart';
import 'package:yun_men_yi_pan/app/modules/bottom_tab_bar/views/bottom_tab_view.dart';
// import 'package:yun_men_yi_pan/app/modules/home/bindings/home_binding.dart';
// import 'package:yun_men_yi_pan/app/modules/home/views/home_view.dart';
import 'package:yun_men_yi_pan/app/simulator/scan_page.dart';
import 'package:yun_men_yi_pan/app/modules/launching/active_advert_page.dart';
import 'package:yun_men_yi_pan/app/modules/mine/page/about_me_page.dart';
import 'package:yun_men_yi_pan/app/modules/mine/page/mine_page.dart';
import 'package:yun_men_yi_pan/app/modules/mine/page/modify_user_Info_page.dart';
import 'package:yun_men_yi_pan/app/modules/mine/page/my_info_page.dart';
import 'package:yun_men_yi_pan/app/modules/message/page/message_page.dart';
import 'package:yun_men_yi_pan/app/modules/setting/bindings/um_setting_binding.dart';
import 'package:yun_men_yi_pan/app/modules/setting/page/setting_page.dart';
import 'package:yun_men_yi_pan/app/modules/setting/page/um_settting_view.dart';
import 'package:yun_men_yi_pan/app/modules/login/controller/login_account_controller.dart';
import 'package:yun_men_yi_pan/app/modules/login/page/account_delete_page.dart';
import 'package:yun_men_yi_pan/app/modules/login/page/account_register_page.dart';
import 'package:yun_men_yi_pan/app/modules/login/page/account_security_page.dart';
import 'package:yun_men_yi_pan/app/modules/login/page/login_account_page.dart';
import 'package:yun_men_yi_pan/app/modules/login/page/login_code_verify_age.dart';
import 'package:yun_men_yi_pan/app/modules/login/page/modify_password_check_page.dart';
import 'package:yun_men_yi_pan/app/modules/login/page/modify_password_page.dart';
import 'package:yun_men_yi_pan/app/modules/login/page/modify_phone_number_page.dart';
import 'package:yun_men_yi_pan/app/modules/ba_zi/bindings/bazi_input_binding.dart';
import 'package:yun_men_yi_pan/app/modules/ba_zi/page/bazi_glossary_page.dart';
import 'package:yun_men_yi_pan/app/modules/ba_zi/page/bazi_he_pan_page.dart';
import 'package:yun_men_yi_pan/app/modules/ba_zi/page/bazi_input_page.dart';
import 'package:yun_men_yi_pan/app/modules/ba_zi/page/bazi_result_page.dart';
import 'package:yun_men_yi_pan/app/modules/qi_men/bindings/qimen_input_binding.dart';
import 'package:yun_men_yi_pan/app/modules/qi_men/page/qimen_input_page.dart';
import 'package:yun_men_yi_pan/app/modules/qi_men/page/qimen_result_page.dart';
import 'package:yun_men_yi_pan/app/modules/qi_men/page/shigan_keying_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/bindings/arts_history_binding.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/http/arts_record_item.dart';
import 'package:yun_men_yi_pan/app/modules/zhouyi/page/arts_history_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/bindings/zhongyi_billing_binding.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/bindings/zhongyi_prescribe_binding.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/bindings/zhongyi_template_binding.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_billing_detail_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_billing_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_medicine_detail_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_medicine_edit_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_medicine_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_prescribe_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_template_detail_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_template_edit_page.dart';
import 'package:yun_men_yi_pan/app/modules/zhongyi/page/zhongyi_template_page.dart';
import 'package:get/get.dart';

import '../modules/launching/splash_page.dart';

part './app_routes.dart';

class AppPages {
  AppPages._() {
    throw UnimplementedError();
  }

  /// 路由表：仅保留与业务无关的通用页面
  static final routes = [
    GetPage(name: Routes.SCANPAGE, page: () => const ScanPage()),

    // 根路由：启动页按登录态分流；首页与登录页各自注册，冷启动不再依赖 initialRoute
    GetPage(name: Routes.INITIAL, page: () => const SplashPage()),
    GetPage(name: Routes.BOTTOMTABVIEW, page: () => const BottomTabView(), binding: BottomTabBinding()),

    // ===============   登录 / 注册 / 账号   =====================
    GetPage(name: Routes.LOGINPAGE, page: () => const LoginAccountPage(), binding: LoginAccountBinding()),
    GetPage(name: Routes.REGISTERPAGE, page: () => const AccountRegisterPage()),
    GetPage(name: Routes.LOGINSECONDPAGE, page: () => const LoginCodeVerifyPage()),
    GetPage(name: Routes.ACTIVEADVERTPAGE, page: () => const ActiveAdvertPage()),
    GetPage(name: Routes.ACCOUNTSECURITYPAGE, page: () => const AccountSecurityPage()),
    GetPage(name: Routes.MODIFYPHONENUMBERPAGE, page: () => const ModifyPhoneNumberPage()),
    GetPage(name: Routes.MODIFYPASSWORDPAGE, page: () => const ModifyPasswordPage()),
    GetPage(name: Routes.MODIFYSIGNPASSWORDCHECKPAGE, page: () => const ModifyPasswordCheckPage()),
    GetPage(name: Routes.DELETEACCOUNTPAGE, page: () => const DeleteAccountPage()),

    // ===============   首页（已下线，改由底部 Tab 承载） / 我的   =====================
    // GetPage(name: Routes.HOMEVIEW, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(name: Routes.MINEPAGE, page: () => const MinePage()),

    // ===============   个人中心 / 设置 / 消息   =====================
    GetPage(name: Routes.MYINFOPAGE, page: () => const MyInfoPage()),
    GetPage(name: Routes.MODIFYUSERINFOPAGE, page: () => const ModifyUserInfoPage()),
    GetPage(name: Routes.SETTINGPAGE, page: () => const SettingPage()),
    GetPage(name: Routes.ABOUTMEPAGE, page: () => const AboutMePage()),
    GetPage(name: Routes.MESSAGEPAGE, page: () => const MessagePage(), binding: MessageBinding()),
    GetPage(name: Routes.UMSETTINGPAGE, page: () => const UmSettingPage(), binding: UmSettingBinding()),

    // ===============   周易排盘：奇门遁甲 / 四柱八字   =====================
    GetPage(name: Routes.QIMENPAGE, page: () => const QiMenInputPage(), binding: QiMenInputBinding()),
    GetPage(name: Routes.QIMENRESULTPAGE, page: () => const QiMenResultPage()),
    GetPage(name: Routes.SHIGANKEYINGPAGE, page: () => const ShiGanKeyingPage()),
    GetPage(name: Routes.QIMENHISTORYPAGE, page: () => const ArtsHistoryPage(), binding: ArtsHistoryBinding(ArtsRecordType.qimen)),
    GetPage(name: Routes.BAZIPAGE, page: () => const BaziInputPage(), binding: BaziInputBinding()),
    GetPage(name: Routes.BAZIRESULTPAGE, page: () => const BaziResultPage()),
    GetPage(name: Routes.BAZIHEPANPAGE, page: () => const BaziHePanPage()),
    GetPage(name: Routes.BAZIGLOSSARYPAGE, page: () => const BaziGlossaryPage()),
    GetPage(
      name: Routes.BAZIHISTORYPAGE,
      page: () => const ArtsHistoryPage(),
      binding: ArtsHistoryBinding(ArtsRecordType.bazi),
    ),

    // ===============   中医（中药房）   =====================
    GetPage(name: Routes.ZHONGYIPRESCRIBEPAGE, page: () => const ZhongyiPrescribePage(), binding: ZhongyiPrescribeBinding()),
    GetPage(name: Routes.ZHONGYIMEDICINEPAGE, page: () => const ZhongyiMedicinePage()),
    GetPage(name: Routes.ZHONGYIMEDICINEDETAILPAGE, page: () => const ZhongyiMedicineDetailPage()),
    GetPage(name: Routes.ZHONGYIMEDICINEEDITPAGE, page: () => const ZhongyiMedicineEditPage()),
    GetPage(
      name: Routes.ZHONGYITEMPLATEPAGE,
      page: () => const ZhongyiTemplatePage(),
      binding: ZhongyiTemplateBinding(),
    ),
    GetPage(name: Routes.ZHONGYITEMPLATEDETAILPAGE, page: () => const ZhongyiTemplateDetailPage()),
    GetPage(name: Routes.ZHONGYITEMPLATEEDITPAGE, page: () => const ZhongyiTemplateEditPage()),
    GetPage(name: Routes.ZHONGYIBILLINGPAGE, page: () => const ZhongyiBillingPage(), binding: ZhongyiBillingBinding()),
    GetPage(name: Routes.ZHONGYIBILLINGDETAILPAGE, page: () => const ZhongyiBillingDetailPage()),
  ];
}
