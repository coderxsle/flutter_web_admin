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
}
