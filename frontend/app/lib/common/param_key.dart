//接口传递参数的key值内容，避开硬编码，或者不小心改动字母造成的错误
class ParamKey {
  ParamKey._internal();

  //一个拼接字符串常用的
  static const keySplit = "#";
  static const keySplitValue = ":";
  static const requestTime = "requestTime";
  static const interfaceAddress = "interfaceAddress";
  static const inputBox = "inputBox";
  static const trueName = "trueName";
  static const phone = "phone";
  static const loginName = "loginName";
  static const requestMethod = "requestMethod";
  static const phoneBrand = "phoneBrand";
  static const phoneModel = "phoneModel";
  static const phoneVersion = "phoneVersion";
  //报错接口请求的参数
  static const requestParam = "requestParam";
  //报错接口报错的内容
  static const errorContent = "errorContent";
//------------------------------------------------------------------

//------------------------------------------------------------------
  //手动标志推送设置的开关
  static const kNoticeSwitch = "notice";
  static const kSoundSwitch = "sound";
  static const kShockSwitch = "shock";
  static const kMiddayRestSwitch = "midday";
  static const kPersonAlizSwitch = "personAliz";
//------------------------------------------------------------------

  static const shopInfoId = "shopInfoId";
  //2025/4/18新增的
  static const userToken = "userToken";
  // static const serviceLife = "serviceLife";//有重复？
  static const pagination = "pagination"; //
  static const pageSize = "pageSize"; //
  static const customerId = "customerId";
  static const sourceId = "sourceId";

  static const keyword = "keyword";
  //--------------------------------------------------
  //--------------------------------------------------
  static const beginTime = "beginTime";
  static const endTime = "endTime";
  //----------------------------------------------------------------
  //----------------------------------------------------------------
  static const status = "status";
  static const remark = "remark";
  static const files = "files";
  static const carBrandId = "carBrandId";
  static const imgUrls = "imgUrls";
  //身份证号
  static const idCard = "idCard";

  //---------------------------------------------------
  //---------------------------------------------------
  //---------------------------------------------------
  //---------------------------------------------------
  //---------------------------------------------------
  static const companyName = "companyName";
  static const position = "position";
  //-----------------------------------------------------------------------
}
