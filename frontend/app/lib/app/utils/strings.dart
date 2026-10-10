// ignore_for_file: constant_identifier_names

import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/main_api.dart';
import 'package:auto_shop_server/res/assets_res.dart';

String home = 'Home';
const AppName = "云门医盘";
const AppStoreID = "6463350860";
String get urlPrefix => httpManager.baseUrl.startsWith(baseURL) ? "$baseURL/resource/" : "$baseURLTest/resource/";

/// 查看 App 在 App Store 中的版本号
const iOSVersionLookupURL = "https://itunes.apple.com/cn/lookup";

/// 打开 App 在 App Store 中的详情页
const iOSAppStoreURL = "https://itunes.apple.com/cn/app/$AppStoreID";
//打开android端应用商店的uri
const marketAndroid = "market://details?id=com.coderxslee.ymyp";
const appVersionInfoPlatform = "Android";
const app_database = 'app_database.db';

const kUserAccountUpdate = 'kUserAccountUpdate'; // 更新用户资料

const IS_FIRST_INSTALL = "isFirstInstall";
const USER_TOKEN = "kUserDefaultsKeyToken";
const kStoreChange = 'shopChange'; // 店铺切换
const kHomeRefresh = "kHomeRefresh"; // 通知首页刷新,事件通知key
const kUserInfo = 'kUserInfo'; // 用户资料
const kShopInfo = 'kShopInfo'; // 店铺资料
const kAndroidUUID = "androidUuid"; //android端的UUID

const dirDownLoad = "downLoad"; //android端的apk下载目录
const dirComplete = "complete"; //android端的apk下载完毕复制的目录

//服务协议
const agreementUrl = "https://echelianhtml.ygxpt.com/agreement/index.html";
//隐私政策
const privacyUrl = "https://echelianhtml.ygxpt.com/privacy/index.html";

//价格的标志单位是[元]
const unitMoney = '元';
//单位是天
const unitDay = '天';
const unitHour = '小时';
const unitPerson = '人';
const unitMoneyThousand = '万元';
const symbolMoney = '￥';
const unitMileage = '公里';
const unitMileageThousand = '万公里';
const unitNumberOfTimes = '次';
const nullChar = 'null';
//传递空参给后台的
const upLoadNullParam = "";
//中间分隔符
const middleSplit = '/';
//做decimal的
const decimal10000 = "10000";
//换行操作，为了打印日志看日志方便用
const newLineTwo = "\n\n";

//开启权限说明的标题内容
const String permission_title_single = "开启单权限声明";
const String permission_title_list = "开启多权限声明";
//打开右侧设置权限的按钮
const String permission_setting = "设置权限";
const String permission_cancel = "取消";
const String owner_server_down = "服务器下载";
const String market_server_down = "应用市场更新";
const String not_update = "取消";
//单独的需要相机权限的能力
const String permission_content_camera = "本应用需要打开您的相机权限,以便完成该模块拍摄图片功能";
//开启权限说明 携带有相机和存储
const String permission_content_camera_storage = "本应用需要打开您的相机和存储权限,以便完成该模块拍摄图片、存储图片功能";
//开启权限说明 携带有扫一扫功能的提示
const String permission_content_camera_scan_storage = "本应用需要打开您的相机和存储权限,以便完成该模块扫一扫、拍摄图片、预览图片、存储图片、选择图片的功能";
//相机相册存储
const String permission_content_camera_album_storage = "本应用需要打开您的相机和存储权限,以便完成该模块拍摄图片、预览图片、存储图片、选择图片的功能";
//单独的相册权限
const String permission_content_album_storage = "本应用需要打开您的相册的存储权限,以便完成该模块预览图片、存储图片、选择图片的功能";
//通知权限的打开
const String permission_content_post_notifications = "本应用需要打开您的通知权限,以便接收消息通知";
//需要打开读取手机状态的权限
const String permission_content_phone_state = "本应用需要打开您的读取手机状态的权限，以便完成第三方支付需要读取您手机支付信息的权限";
//需要打开您的存储权限
const String permission_content_storage = "本应用需要打开您的存储权限，以便完成对于APP升级包的存储或者您存储其他文件的功能";
//权限被用户拒绝只能打开系统设置来
const String permission_open_setting = "权限被永久拒绝，只能通过系统设置更改~";
//dio和flutter_downloader通用
const String newVersionDownLoading = "新版本下载中";
const String completedMessage = "下载完成";
//-----------------------------------------------------------------------------------
//测试用占位图片
const imageTest = "https://pic.rmb.bdstatic.com/bjh/events/a367c1c6e404fc4c4172523e56f42146.png";

//时间格式-比较短的
const timeFormatDateShort2 = 'yyyy-M-d'; //"yyyy-MM-dd"
// const timeFormatDateShort = 'yyyy-MM-dd'; //"yyyy-MM-dd"
const timeFormatDateShortCN = 'yyyy年M月';
//时间格式完整较长
// const timeFormatDateLong = 'yyyy-MM-dd HH:mm:ss';

const timeMMStart = ' 00:00';
const timeMMEnd = ' 23:59';

const timeMMSSStartLong = ' 00:00:00';
const timeMMSSEndLong = ' 23:59:59';
//项目之中做拼接的特殊符号
const splicingMy = '#';

//时间格式完整特别长
const timeFormatDateTooLong = 'yyyy-MM-dd-HH-mm-ss-SSS';
const timeFormatDateTooLong2 = 'yyyy.MM.dd.HH.mm.ss.SSS';
//APK下载存放路径的标志
const app_update_android_download_url = "apk_download_url";
//-----------------------------------------------------------------------------------
//图片上传前缀标志判断
const httpStartWithPrefix = 'http';
//涉及上传-图片上传前缀标志判断的keu
const fileServerUrlKey = 'fileServerUrl';
//图片的路径，上传给后台的形式是：/fileTypeName/20240806/2024080615141633418434.jpg
const fileUrlUpLoadKey = 'fileUrl';
//以本地图片截取的名称标志，例如：//storage/emulated/0/middlelow/IMAGE_20240624_102454265.jpg
const fileLocalNameKey = 'fileLocalName';
//-----------------------------------------------------------------------------------
//从后台过去过来填充九宫格图片携带http的完整路径：
//http://host/resource//fileStore/excelpath/20241101/2024110114340672018171.jpg
const fileServerUrlWithHttpKey = 'fileServerUrlWithHttp';
//服务器后台填充的地址路径例如：/file/fileStore/excelpath/20241101/2024110114340672018171.jpg
const fileServerTomcatPathKey = 'fileServerTomcatPath';
//文件最短的名字例如：2024110114340672826765.jpg
const fileShortNameKey = 'fileShortName';
//上传时候携带的内容
const fileUpLoadNameKey = 'fileUpLoadName';
//-----------------------------------------------------------------------------------

//后台给定的后缀urlSuffix标志，例如：/fileTypeName/20240806/2024080615141633418434.jpg
const urlSuffixKey = 'urlSuffix';
//获取上传图片全路径的key
const urlKey = 'url';
//-------------------------------------------------
const keyIndex = 'index'; //当前指示
const keyLabel = 'label'; //任意
const keyUpLoadValue = 'upLoadValue'; //需要上传的参数
//按钮的索引，有的需要填写一个空值
const buttonIndexConstant = '9991';
// -------------------------------------------------
//动态选项卡的key:目前只有【客户关怀-优惠券】用到
const typeIndex = "typeIndex";
//动态选项卡的key:目前只有【客户关怀-优惠券】用到
const typeTitle = "typeTitle";
//动态选项卡的key:目前只有【我的登记】之中默认数字用到
const typeCount = "typeCount";
// -------------------------------------------------
//下载安装包key
const keyApkName = "apkName";
//下载apk的任务id
const keyTaskId = "taskId";

//包含上传错误日志标志
const errorLog = "errorLog";

//打印日志标志
const logCatTag = "itChen:";
//捕获异常的提示
// const tryCatchTag = "捕获异常=>";
//异常提示
// const actionException = "执行异常~";
//后台响应的data是空值
const dataIsNull = "data响应是空";
//占位土
const placeholder_115 = AssetsRes.PLACEHOLDER_115;
//
// const doubleDefaultString = "0.0";
const doubleDefaultString = "0.00";
//用在数字上多个地方用到的0
const zeroDefaultString = "0";

//传值相关------------------------------------------------
//传递给webView的url
const arguments_url = "url";
//传递给webView的title //携带标题，也有是按钮跳转携带按钮文字
const arguments_title = "title";
//跳转页面传递：目的要做什么
const arguments_intent = 'intent';
//跳转页面传递：整个model实体
const arguments_model = 'model';
//携带的是列表数据
const arguments_listData = 'listData';
const arg_type = 'type';
const arg_timestamp = 'timestamp';
//携带是否是编辑表单的标志
const arguments_isEditForm = 'isEdit';

//携带原始图片
const arguments_imageOriginal = 'imageOriginal';
//携带选中图片
const arguments_imageSelect = 'imageSelect';
//标志从哪里跳转过来
const arguments_jumpFromWhere = 'jumpFromWhere';
//单张图片下载逻辑
const imageDownloader_send_port = 'imageDownloader_send_port';
//----------------------------------------------------------
//----------------------------------------------------------
// granted：权限已授予。
// denied：权限被拒绝，但可以再次请求。
// restricted：系统限制了访问权限。
// permanentlyDenied：权限被永久拒绝，只能通过系统设置更改。
// limited：权限有限授予。
// provisional：临时权限。
const permanentlyDenied = "您的应用权限被系统禁用，请手动设置权限~";

//页面解析pageModel的key
const pageModelKeyIsList = 'list';

const currentNoFunction = "功能暂未开通~";
const stepHasNotPlan = "暂无跟进计划";
//通用的【复制成功】文字
const copyClipboard = "复制成功~";

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
const downShareImageOnFail = "下载图片失败";
//用在底部弹窗的多选的方式
const buttonReset = "重置";
const buttonConfirm = "确认";
//请选择日期的提示或者默认提示
const textSelectTimeDefault = "请选择日期";
const toastCopyPhone = "已复制手机号";
const toastNullPhone = "手机号是空值";
//代表是android的请求最新的必须更新的版本号
const requestMinRequiredVersionAndroid = "1";

const jpegStr = ".jpeg";