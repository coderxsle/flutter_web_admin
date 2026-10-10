import 'dart:async';

import 'package:auto_shop_server/app/utils/result_code.dart';
import 'package:auto_shop_server/main_api.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:http_manager/http_manager.dart';
import 'package:path/path.dart' as p;

import '../app/utils/common_widget/logger.dart';
import '../app/utils/image_tools.dart';
import '../app/utils/strings.dart';
import '../app/modules/launching/loacal_storage.dart';


class CommonRequest {
  static Future<ResponseAnalyzed> get() async {
    String url = "";
    final param = {"": ""};
    return await httpManager.getAnalyzing(url, params: param);
  }

  static Future<ResponseAnalyzed> post() async {
    String url = "";
    final param = {"": ""};
    return await httpManager.postAnalyzing(url, params: param);
  }



  //---------------------------------------------------------------
  //整个APP的上传日志接口
  static Future<ResponseAnalyzed?> addLog(String requestPath, var param) async {
    if (ObjectUtil.isEmpty(requestPath) || requestPath.contains(errorLog)) {
      //logger.d("addLog return");
      return null;
    }
    const url = "/pub/v1/errorLog/addLog";
    return await httpManager.postAnalyzing(url, params: param);
  }
  //------------------------------------------------------------------


  // 用户点击客户的电话号码上报服务器
  static Future<ResponseAnalyzed> addCallHistory(var cid, var phone, var type) async {
    String url = "/auth/v1/motor/callhistory/addCallHistory";
    final param = {"communityId": cid, "phone": phone, "businessType": type};
    return await httpManager.postAnalyzing(url, params: param);
  }

  // 公用的图片上传接口
  static Future<ResponseAnalyzed> uploadFile(List images, var file, var fileTypeName) async {
    String url = "/auth/v1/upload/uploadFile";
    final imageFiles = await ImageTool.imageFiles(images);
    FormData formData = FormData.fromMap({'file': imageFiles, "fileType": fileTypeName});
    return await httpManager.uploadAnalyzing(url, formData);
  }

  // 公用的图片上传接口
  static Future<ResponseAnalyzed> uploadWithUrl(String url, List images, var file, var fileTypeName) async {
    final imageFiles = await ImageTool.imageFiles(images);
    FormData formData = FormData.fromMap({'file': imageFiles, "fileType": fileTypeName});
    return await httpManager.uploadAnalyzing(url, formData);
  }

  // 上传图片, 支持多文件上传, 所有数据上传成功后，回调一次
  static Future<List<UploadFileResponse>> uploadFile2(List files, var fileTypeName, {ProgressCallback? progress}) async {
    List<UploadFileResponse> responses = [];
    for (int i = 0; i < files.length; i++) {
      String file = files[i];
      final result = await CommonRequest.singleUploadFile(file, fileTypeName, progress: progress);
      if (result.success) {
        final resp = UploadFileResponse.fromJson(result.data);
        responses.add(resp);
      } else {
        logger.e("上传失败：${result.message}");
      }
    }
    return responses;
  }

  // 单文件上床，可以支持 PDF 文件
  static Future<ResponseAnalyzed> singleUploadFile(String filePath, var fileTypeName, {ProgressCallback? progress}) async {
    String url = "/auth/v1/motor/usedcardocument/uploadFile";
    String fileExtension = p.extension(filePath).toLowerCase();
    List<MultipartFile> file = [];
    FormData formData;
    if (fileExtension == '.jpg' || fileExtension == '.jpeg' || fileExtension == '.png') {
      file = await ImageTool.imageFiles([filePath]); // 压缩图片
      formData = FormData.fromMap({'file': file, 'fileTypeName': fileTypeName});
    }else {
      final object = await MultipartFile.fromFile(filePath, filename: filePath.split('/').last);
      file.add(object);
      formData = FormData.fromMap({'file': file, 'fileName': filePath.split('/').last});
    }
    final response = await httpManager.upload(url, formData, onSendProgress: progress);
    return await ResponseAnalyzed.analyzingAndCheckup(response);
  }





  /// 上传文件的公共方法，支持过滤已上传的文件并上传新的文件。
  ///
  /// 该方法接收文件列表字符串，将其中已上传到服务器的文件过滤掉，
  /// 并上传新的文件到指定服务器地址。上传完成后，将所有文件的 URL 后缀拼接为一个字符串返回。
  ///
  /// 参数:
  /// - [fileListString]: 逗号分隔的文件列表字符串，可能包含已上传和未上传的文件。
  /// - [fileType]: 上传文件的类型，用于指定上传的文件类别（例如图片、文档等）。
  /// - [prefix]: (可选) 用于匹配服务器上的文件前缀，默认值为 `""`，可用于剥离文件的 URL 前缀。
  ///
  /// 返回值:
  /// 返回处理后的文件列表字符串，已上传的文件将替换为其 URL 后缀，并与新上传的文件一起拼接。
  ///
  /// 使用场景:
  /// 该方法适用于需要批量上传文件的场景，特别是当部分文件已存在于服务器中，
  /// 只需上传新增文件的场景，例如图片上传、附件上传等。
  ///
  static Future<String> uploadRemoveUrlPrefix(String fileListString, String fileType, {String? prefix, ProgressCallback? progress}) async {
    if (fileListString.isNotEmpty) {
      // 将文件列表字符串拆分为列表并分类处理
      List<String> fileList = fileListString.split(",");
      // 提取已有的服务器图片，并去掉前缀
      prefix = prefix ?? urlPrefix;
      List<String> images = fileList.where((file) => file.startsWith('http')).map((img) => img.replaceFirst(prefix!, '')).toList();
      // 提取未上传的本地图片
      List<String> newFiles = fileList.where((file) => !file.startsWith('http')).toList();

      // 如果有新图片需要上传
      if (newFiles.isNotEmpty) {
        // 上传未上传的图片并等待上传完成
        final uploadedFiles = await CommonRequest.uploadFile2(newFiles, fileType, progress: progress);
        // 上传成功后，获取文件的 url 后缀
        List<String> uploadedFilePaths = uploadedFiles.map((e) => e.urlSuffix).toList();
        // 拼接已上传的图片和新上传的图片
        final allImages = [...uploadedFilePaths, ...images].join(",");
        return allImages;
      } else {
        // 如果没有新的文件上传，直接返回处理后的已有文件
        return images.join(",");
      }
    }
    return "";  // 如果文件列表为空，返回空字符串
  }












  /// 下载文件
  /// url 下载地址 （如有中文，请进行编码处理 String encodedUrl = Uri.encodeFull(url);）
  /// savePath 保存路径 (请注意区分系统平台和设备类型) Directory tempDir = await getTemporaryDirectory();
  /// fileName 保存文件的名字
  /// 获取设备的临时目录路径：Directory tempDir = await getTemporaryDirectory();
  static Future<ResponseAnalyzed> downloadFile(String url, String savePath, String fileName,
      {ProgressCallback? onReceiveProgress,CancelToken? cancelToken}) async {

    if (url.startsWith("http")) httpManager.baseUrl = "";
    String encodedUrl = Uri.encodeFull(url);
    final response = await httpManager.downloadFile(encodedUrl, savePath, fileName, onReceiveProgress: (received, total) {
      if (onReceiveProgress != null) {
        onReceiveProgress(received, total);
      }
      // 可以显示下载进度
      if (total != -1) {
        logger.i('${(received / total * 100).toStringAsFixed(0)}%');
      }
    },cancelToken: cancelToken);
    // ResponseAnalyzed result = ResponseAnalyzed.analyzingAndCheckup(response);
    ResponseAnalyzed result = ResponseAnalyzed(
        code: "${response.statusCode}", message: response.statusMessage, data: response.data);
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      // 切换到原来的环境
      final isDebug = localStorageRead("isDebugBaseUrl") == true;
      httpManager.baseUrl = isDebug ? baseURLTest : baseURL;
    });

    if(ObjectUtil.isEmpty(result)){
      if(!ObjectUtil.isEmpty(cancelToken)){
        cancelToken!.cancel();
      }
    }
    return result;
  }

  // OCR 识别
  static Future<Response?> ocr(var file) async {
    httpManager.baseUrl = ocrUrl;
    final imageFiles = await ImageTool.imageFiles([file]);
    FormData formData = FormData.fromMap({"file": imageFiles});
    final result = await httpManager.upload("/identify/ocr", formData);
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      // 切换到原来的环境
      final isDebug = localStorageRead("isDebugBaseUrl") == true;
      httpManager.baseUrl = isDebug ? baseURLTest : baseURL;
    });
    return result;
  }

  //新增：微信号识别
  static Future<Response?> ocrWechat(var file) async {
    httpManager.baseUrl = ocrUrl;
    final imageFiles = await ImageTool.imageFiles([file]);
    FormData formData = FormData.fromMap({"file": imageFiles});
    final result = await httpManager.upload("/identify/wechat/number", formData);
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      // 切换到原来的环境
      final isDebug = localStorageRead("isDebugBaseUrl") == true;
      httpManager.baseUrl = isDebug ? baseURLTest : baseURL;
    });
    return result;
  }

  static Future<Response?> ocrCarNo(var file) async {
    httpManager.baseUrl = ocrUrl;
    final imageFiles = await ImageTool.imageFiles([file]);
    FormData formData = FormData.fromMap({"file": imageFiles});
    final result = await httpManager.upload("/identify/license_plate", formData);
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      // 切换到原来的环境
      final isDebug = localStorageRead("isDebugBaseUrl") == true;
      httpManager.baseUrl = isDebug ? baseURLTest : baseURL;
    });
    return result;
  }

  /// 上传身份证进行识别
  static Future<Response?> uploadImage(String file) async {
    httpManager.baseUrl = ocrUrl;
    final imageFiles = await ImageTool.imageFiles([file]);
    FormData formData = FormData.fromMap({"file": imageFiles});
    final result = await httpManager.upload("/upload/file", formData);
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      // 切换到原来的环境
      final isDebug = localStorageRead("isDebugBaseUrl") == true;
      httpManager.baseUrl = isDebug ? baseURLTest : baseURL;
    });
    return result;
  }
}



class UploadFileResponse {
  final String fileName;
  final String url;
  final String urlPrefix;
  final String urlSuffix;
  final String filePath;    // 某些借口用的是这个参数作为路径，而非 urlSuffix
  const UploadFileResponse({
     this.url = "",
     this.urlPrefix = "",
     this.urlSuffix = "",
     this.fileName = "",
     this.filePath = "",
  });
  factory UploadFileResponse.fromJson(Map<String, dynamic> json) {
    return UploadFileResponse(
      url: json['url'] ?? '',
      urlPrefix: json['urlPrefix'] ?? '',
      urlSuffix: json['urlSuffix'] ?? '',
      fileName: json['fileName'] ?? '',
      filePath: json['filePath'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'urlPrefix': urlPrefix,
      'urlSuffix': urlSuffix,
      'fileName': fileName,
      'filePath': filePath,
    };
  }
}