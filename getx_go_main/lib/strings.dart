String home = 'Home';
const AppName = "e车联";
const AppStoreID = "6222330820";

/// 查看 App 在 App Store 中的版本号
const iOSVersionLookupURL = "https://itunes.apple.com/cn/lookup";
/// 打开 App 在 App Store 中的详情页
const iOSAppStoreURL = "https://itunes.apple.com/cn/app/$AppStoreID";

//打开android端应用商店的uri
const marketAndroid = "market://details?id=com.ygxsk.carhome";
const appVersionInfoPlatform = "Android";

const kUserAccountUpdate = 'kUserAccountUpdate'; // 更新用户资料

const isInstalled = "isInstalled"; // 是否是第一次安装

const USER_TOKEN = "kUserDefaultsKeyToken";
const kStoreChange = 'shopChange'; // 店铺切换
const kHomeRefresh = "kHomeRefresh"; // 通知首页刷新,事件通知key
const kUserInfo = 'kUserInfo'; // 用户资料
const kShopInfo = 'kShopInfo'; // 店铺资料
const kAndroidUUID = "androidUuid"; //android端的UUID

const dirDownLoad = "downLoad"; //android端的apk下载目录
const dirComplete = "complete"; //android端的apk下载完毕复制的目录

//----------------------------------------------------------
const shareNumDes = "分享次数";
const browseNumDes = "浏览次数";
const retainCapitalNumDes = "留资数";
//----------------------------------------------------------
const checkYearRange = "使用年限";
const checkPriceRange = "价格区间";
const checkStockStatus = "预警类型";
const checkPutItStatus = "上架状态";
//----------------------------------------------------------

const currentNoFunction = "功能暂未开通~";
//潜客跟进--暂无跟进计划
const stepHasNotPlan = "暂无跟进计划";
//通用的【复制成功】文字
const copyClipboard = "复制成功~";

//车源列表主页搜索框hint
const please_input_keyWords = "请输入关键字";

//通用的提交提示
const titleTips = "提示";
const commitTips = "正在提交";
const commitSuccessTips = "提交成功";
//图片或者文件的上传中
const progressTips = "上传中";
const imagesUploadTips = "图片上传中";


const uploading = "正在上传";
const uploadSuccess = "上传成功";
const submitting = "正在提交";
const submitSuccess = "提交成功";
const successArchived = '归档成功';

const kSaveSuccess = "保存成功";
const kSaveFailure = "保存失败";

const kDeleteSuccess = "删除成功";
const kDeleteFailure = "删除失败";

const typeEmpty = "类型获取失败，请联系管理员";
const errorEmpty = "错误信息：";

//目前在分享获取接口取数据等耗时加载用到
const loadingTips = "加载中";
const shareLinkIsNull = "分享链接是空值~";

const messageReceiveSuccess = "接单成功";
const messageReceiveFail = "接单失败";
const messageForwardSuccess = "转单成功";
const messageForwardFail = "转单失败";
const messageSubmitSuccess = "提交成功";
const messageSubmitFail = "提交失败";
const loadWebViewFail = "网页加载失败";
const actionAbNormal = "执行异常";
const downShareImageAbNormal = "下载车图链接是空值";
const downShareImageOnFail = "下载车图失败";
//用在底部弹窗的多选的方式
const buttonReset = "重置";
const buttonConfirm = "确认";
//意向车辆
const intentCarYes = "已添加为意向车辆";
const intentCarNo = "已取消意向车辆";
//销售顾问不可编辑客流
const canNotEditCustomer = "不可编辑";
const canNotStockNumber = "库存编码不可用，请重新填写";
//请选择日期的提示或者默认提示
const textSelectTimeDefault = "请选择日期";
const repairShopNot = "暂无修理厂商，请联系管理员配置";
const toastCopyPhone = "已复制手机号";
const toastNullPhone = "手机号是空值";
