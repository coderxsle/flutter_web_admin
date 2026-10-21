part of 'app_pages.dart';

/// 路由名称索引：仅保留通用页面
abstract class Routes {
  Routes._();

  static const INITIAL                 = _Paths.INITIAL;
  static const SCANPAGE                = _Paths.SCANPAGE;
  static const BOTTOMTABVIEW           = _Paths.BOTTOMTABVIEW;
  static const HOMEVIEW                = _Paths.HOMEVIEW;
  static const MINEPAGE                = _Paths.MINEPAGE;
  static const LOGINPAGE               = _Paths.LOGINPAGE;
  static const ACTIVEADVERTPAGE        = _Paths.ACTIVEADVERTPAGE;
  static const REGISTERPAGE            = _Paths.REGISTERPAGE;
  static const LOGINSECONDPAGE         = _Paths.LOGINSECONDPAGE;
  static const ACCOUNTSECURITYPAGE     = _Paths.ACCOUNTSECURITYPAGE;
  static const MODIFYPHONENUMBERPAGE   = _Paths.MODIFYPHONENUMBERPAGE;
  static const MODIFYPASSWORDPAGE      = _Paths.MODIFYPASSWORDPAGE;
  static const MODIFYSIGNPASSWORDCHECKPAGE = _Paths.MODIFYSIGNPASSWORDCHECKPAGE;
  static const DELETEACCOUNTPAGE       = _Paths.DELETEACCOUNTPAGE;
  static const MYINFOPAGE              = _Paths.MYINFOPAGE;
  static const MODIFYUSERINFOPAGE      = _Paths.MODIFYUSERINFOPAGE;
  static const SETTINGPAGE             = _Paths.SETTINGPAGE;
  static const ABOUTMEPAGE             = _Paths.ABOUTMEPAGE;
  static const MESSAGEPAGE             = _Paths.MESSAGEPAGE;
  static const UMSETTINGPAGE           = _Paths.UMSETTINGPAGE;

  // ===============   周易排盘   =====================
  static const QIMENPAGE               = _Paths.QIMENPAGE;
  static const QIMENRESULTPAGE         = _Paths.QIMENRESULTPAGE;
  static const SHIGANKEYINGPAGE        = _Paths.SHIGANKEYINGPAGE;
  static const QIMENHISTORYPAGE        = _Paths.QIMENHISTORYPAGE;
  static const BAZIPAGE                = _Paths.BAZIPAGE;
  static const BAZIRESULTPAGE          = _Paths.BAZIRESULTPAGE;
  static const BAZIHEPANPAGE           = _Paths.BAZIHEPANPAGE;
  static const BAZIGLOSSARYPAGE        = _Paths.BAZIGLOSSARYPAGE;
  static const BAZIHISTORYPAGE         = _Paths.BAZIHISTORYPAGE;

  // ===============   中医（中药房）   =====================
  static const ZHONGYIPRESCRIBEPAGE      = _Paths.ZHONGYIPRESCRIBEPAGE;
  static const ZHONGYIMEDICINEPAGE       = _Paths.ZHONGYIMEDICINEPAGE;
  static const ZHONGYIMEDICINEDETAILPAGE = _Paths.ZHONGYIMEDICINEDETAILPAGE;
  static const ZHONGYIMEDICINEEDITPAGE   = _Paths.ZHONGYIMEDICINEEDITPAGE;
  static const ZHONGYITEMPLATEPAGE       = _Paths.ZHONGYITEMPLATEPAGE;
  static const ZHONGYITEMPLATEDETAILPAGE = _Paths.ZHONGYITEMPLATEDETAILPAGE;
  static const ZHONGYITEMPLATEEDITPAGE   = _Paths.ZHONGYITEMPLATEEDITPAGE;
  static const ZHONGYIBILLINGPAGE        = _Paths.ZHONGYIBILLINGPAGE;
  static const ZHONGYIBILLINGDETAILPAGE  = _Paths.ZHONGYIBILLINGDETAILPAGE;
}

abstract class _Paths {
  _Paths._();

  static const INITIAL                 = '/';
  static const SCANPAGE                = '/ScanPage';
  static const BOTTOMTABVIEW           = '/BottomTabView';
  static const HOMEVIEW                = '/HomeView';
  static const MINEPAGE                = '/MinePage';
  static const LOGINPAGE               = '/LoginAccountPage';
  static const ACTIVEADVERTPAGE        = '/ActiveAdvertPage';
  static const REGISTERPAGE            = '/RegisterPage';
  static const LOGINSECONDPAGE         = '/LoginSecondPage';
  static const ACCOUNTSECURITYPAGE     = '/AccountSecurityPage';
  static const MODIFYPHONENUMBERPAGE   = '/ModifyPhoneNumberPage';
  static const MODIFYPASSWORDPAGE      = '/ModifyPasswordPage';
  static const MODIFYSIGNPASSWORDCHECKPAGE = '/ModifySignPasswordCheckPage';
  static const DELETEACCOUNTPAGE       = '/DeleteAccountPage';
  static const MYINFOPAGE              = '/MyInfoPage';
  static const MODIFYUSERINFOPAGE      = '/ModifyUserInfoPage';
  static const SETTINGPAGE             = '/SettingPage';
  static const ABOUTMEPAGE             = '/AboutMePage';
  static const MESSAGEPAGE             = '/MessagePage';
  static const UMSETTINGPAGE           = '/UmSettingPage';

  // ===============   周易排盘   =====================
  static const QIMENPAGE               = '/QiMenInputPage';
  static const QIMENRESULTPAGE         = '/QiMenResultPage';
  static const SHIGANKEYINGPAGE        = '/ShiGanKeyingPage';
  static const QIMENHISTORYPAGE        = '/QiMenHistoryPage';
  static const BAZIPAGE                = '/BaziInputPage';
  static const BAZIRESULTPAGE          = '/BaziResultPage';
  static const BAZIHEPANPAGE           = '/BaziHePanPage';
  static const BAZIGLOSSARYPAGE        = '/BaziGlossaryPage';
  static const BAZIHISTORYPAGE         = '/BaziHistoryPage';

  // ===============   中医（中药房）   =====================
  static const ZHONGYIPRESCRIBEPAGE      = '/ZhongyiPrescribePage';
  static const ZHONGYIMEDICINEPAGE       = '/ZhongyiMedicinePage';
  static const ZHONGYIMEDICINEDETAILPAGE = '/ZhongyiMedicineDetailPage';
  static const ZHONGYIMEDICINEEDITPAGE   = '/ZhongyiMedicineEditPage';
  static const ZHONGYITEMPLATEPAGE       = '/ZhongyiTemplatePage';
  static const ZHONGYITEMPLATEDETAILPAGE = '/ZhongyiTemplateDetailPage';
  static const ZHONGYITEMPLATEEDITPAGE   = '/ZhongyiTemplateEditPage';
  static const ZHONGYIBILLINGPAGE        = '/ZhongyiBillingPage';
  static const ZHONGYIBILLINGDETAILPAGE  = '/ZhongyiBillingDetailPage';
}
