import 'dart:core';

import 'package:yun_men_yi_pan/base/common_request.dart';
import 'package:yun_men_yi_pan/app/utils/base_model.dart';
import 'package:yun_men_yi_pan/app/utils/common_widget/logger.dart';
import 'package:yun_men_yi_pan/app/utils/constant_api.dart';
import 'package:yun_men_yi_pan/app/utils/result_code.dart';
import 'package:yun_men_yi_pan/app/utils/strings.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_manager/result_analyzed.dart';
import 'package:http_manager/result_extension.dart';
import 'package:permission_handler/permission_handler.dart';

import 'my_dialog.dart';

// 在 GetX 框架中，refresh 和 update 是用于控制器 (GetController) 的两种不同的状态管理方法，它们的作用和使用场景有所区别：
//
// 1. update()
//
// •	作用: update 方法用于刷新特定的 Widget（观察者）。当调用 update() 时，只有那些通过 GetBuilder 注册的观察者会被重新构建。
// •	使用场景: 当你只想更新某个或某些特定部分的 UI 时使用 update()。你可以通过传递一个 id 参数来有选择地更新与这个 id 绑定的 Widgets。
// •	性能: 因为它只更新特定的部分，所以相对性能开销较小，适用于局部更新的场景。
//
// 例子:
//
//   update(['someId']); // 仅更新绑定了 'someId' 的视图
//   update(); // 更新所有观察者
//
// 2. refresh()
//
// •	作用: refresh 方法是用于重新触发整个控制器的逻辑和状态，类似于强制让控制器执行一次初始化操作。通常用于从远程服务器获取数据或完全重置控制器的状态。
// •	使用场景: 当你需要重新加载数据（例如从 API 获取数据）或完全重置控制器的状态时使用 refresh()。适合用于那些需要重置控制器逻辑或数据的场景。
// •	性能: refresh 可能会触发较大的状态变动，因为它会重新初始化控制器或获取新的数据。
//
// 例子:
//
//    controller.refresh(); // 重新加载控制器的数据
//
// 总结：
//
// •	update 用于局部 UI 刷新，性能开销较小，适合局部更新。
// •	refresh 用于重置控制器或重新加载数据，适合全局状态重置。
//
// 两者根据实际需求选择使用，update 更适合频繁的 UI 刷新，而 refresh 适用于较大规模的数据或状态重置。
//

typedef Complete = void Function(dynamic data);
typedef FromJson<T> = T Function(Map<String, dynamic> json);

class BaseController extends GetxController {
  // 根据服务器返回结果码，用来控制界面的变化
  final recode = ResultCode.loading.obs;

  // @Deprecated(
  //   '为了给Controller瘦身，将控制器中的属性变量统一使用State管理'
  //   '请使用 `recode` property'
  //   'This feature was deprecated after v1.6.0',
  //   // class UploadAnnexController extends BaseController {
  //   //   final UploadAnnexState state = UploadAnnexState();
  //   // }
  //   // final name = controller.state.nameTextVC.text;
  // )
  // final state = ResultCode.loading.obs;

  // 下拉刷新上拉加载的控制器
  final refreshCtrl = EasyRefreshController(controlFinishLoad: true, controlFinishRefresh: true);
  // 分页模型
  PageModel _pageModel = PageModel();

  /// 当前分页信息（页码、总页数、是否还有下一页），子类判断上拉用
  PageModel get pageModel => _pageModel;

  // 关闭键盘
  void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  bool isNull(dynamic value) => value == null;
  bool isNotNull(dynamic value) => value != null;
  bool isNullOrEmpty(dynamic value) {
    if (value == null) return true;
    if (value is Map && value.isEmpty) return true;
    if (value is List && value.isEmpty) return true;
    if (value is String && value.isEmpty) return true;
    return false;
  }

  bool isNotNullOrNotEmpty(dynamic value) => !isNullOrEmpty(value);

  // 页面重置
  void pageReset() {
    _pageModel.page = pageNum_default_first;
  }

  //保持界面参数传递方法名一致，子类要重写
  getParam() {}

  // 下拉刷新的函数
  Future<void> onRefresh() async {
    refreshCtrl.finishRefresh();
    refreshCtrl.resetFooter();
  }

  // 上拉加载的函数
  Future<void> onLoad() async {
    if (!_pageModel.hasMore || recode.value == ResultCode.no_more_data) {
      refreshCtrl.finishLoad(IndicatorResult.noMore);
    } else {
      refreshCtrl.finishLoad(IndicatorResult.success);
    }
  }

  //Get.find异常捕获不到，代码执行tryCatch无效。
  T? getFindMy<T>() {
    try {
      return Get.find<T>();
    } catch (e) {
      logger.e('Failed to find dependency: $e');
      return null;
    }
  }



  void argumentsValidation(dynamic arguments, List<String>? keys, String message) {
    if (arguments == null || (arguments is Map && arguments.isEmpty)) {
      showAlertMessage(message);
      return;
    }
    if (keys != null) {
      for (String key in keys) {
        if (!(arguments as Map).containsKey(key)) {
          showAlertMessage("$key $message");
          return;
        }
      }
    }
  }

  // Rx<Model>
  BaseController modelAnalyzing<T>(ResponseAnalyzed result, var model, FromJson<T>? fromJson, {bool? refresh}) {
    return modelAnalyzingWith2(result, model: model, fromJson: fromJson);
  }

  // List<Model> 、 RxList<Model>
  BaseController modelListAnalyzing<T>(ResponseAnalyzed result, var list, FromJson<T>? fromJson, {bool? refresh}) {
    return modelAnalyzingWith2(result, listModel: list, fromJson: fromJson);
  }

  // Model
  BaseController modelAnalyzing2<T>(ResponseAnalyzed result, FromJson<T>? fromJson, Complete? complete, {bool? refresh}) {
    return modelAnalyzingWith2(result, fromJson: fromJson, complete: complete);
  }

  // ListModel
  // modelListAnalyzing2<T>(ResponseAnalyzed result, FromJson<T>? fromJson, Complete? complete) {
  //   modelAnalyzingWith2(result, fromJson: fromJson, complete: complete);
  // }

  // 新增转换，为了不影响以前的旧代码而设
  BaseController modelAnalyzingWith2<T>(ResponseAnalyzed result, {var listModel, var model, FromJson<T>? fromJson, Complete? complete, bool refresh = true}) {
    return modelAnalyzingWith(result, listModel, model, fromJson: fromJson, complete: complete);
  }

  // 一个通用的 analyzing 函数，使用泛型和函数参数
  @Deprecated(
    'Use `modelAnalyzing()` instead. '
    'Use `modelListAnalyzing()` instead. '
    'Use `modelAnalyzing2()` instead. '
    'Use `modelListAnalyzing2()` instead. '
    'This feature was deprecated after v3.1.0',
  )
  BaseController modelAnalyzingWith<T>(ResponseAnalyzed result, var listModel, var model, {FromJson<T>? fromJson, Complete? complete, bool refresh = true}) {
    // 先落状态：分页空结果会在 analyzingPageData 里改成 empty_data，不能被这里覆盖
    if (refresh == true) recode.value = result.code!;
    if (result.success && result.data != null) {
      if (fromJson != null) {
        if (result.dataIsMap && result.dataIsNotNullOrNotEmpty) {
          if (result.dataContainsKey("records")) {
            // todo 解析分页的字典对象
            analyzingPageData(result, listModel, fromJson, complete: complete);
          } else {
            // todo 解析字典对象
            analyzingDictionary(result, model, fromJson, complete: complete);
          }
        }
        if (result.dataIsList && result.dataIsNotNullOrNotEmpty) {
          // todo 解析数组对象
          analyzingListData(result.data, listModel, fromJson, complete: complete);
        }
        if (result.dataIsEmpty) {
          logger.e("result.data = ${result.data} result.data is empty ");
          return this;
        }
      } else {
        logger.e("resultAnalyzingModel() ==> fromJson 不能为 null");
        return this;
      }
    } else {
      // 失败时清空列表；但上拉加载途中失败（还有下一页）不动已有数据
      if (listModel != null && !_pageModel.hasMore) listModel.clear();
    }
    return this;
  }

  // 解析处理数组对象
  BaseController analyzingListData<T>(data, var listModel, FromJson<T>? fromJson, {Complete? complete}) {
    if (fromJson != null && data != null && data.isNotEmpty) {
      final list = (data as List).map((i) => fromJson(i)).whereType<T>().toList();
      if (listModel is RxList) {
        listModel.value = list;
      } else if (listModel is List) {
        listModel.clear();
        listModel.addAll(list);
      } else {
        if (complete != null) complete(list);
      }
    } else {
      logger.e("resultAnalyzingModel() ==> fromJson 不能为 null");
      // throw Exception('fromJson cannot be null.');
    }
    if (complete != null) complete(listModel);
    return this;
  }

  // 解析处理字典对象 (是一个单纯的字典对象)
  BaseController analyzingDictionary<T>(ResponseAnalyzed result, var model, FromJson<T>? fromJson, {Complete? complete}) {
    if (fromJson != null) {
      if (model is Rx) {
        model.value = fromJson(result.data);
      } else {
        if (complete != null) {
          complete(fromJson(result.data));
        } else {
          // 参数以值传递，赋值无法替换，需要调用者实现 complete 接收 data。
          model = fromJson(result.data);
          logger.e("参数以值传递，赋值无法成功，请使用 Rx 类型，或者实现 complete 接收 data");
        }
      }
    } else {
      logger.e("resultAnalyzingModel() ==> fromJson 不能为 null");
    }
    return this;
  }

  // 解析处理分页列表对象（data = {records, total, page, pageSize, totalPage}）
  BaseController analyzingPageData<T>(ResponseAnalyzed result, var listModel, FromJson<T>? fromJson, {Complete? complete}) {
    if (fromJson == null || listModel is! List) {
      logger.e("analyzingPageData() ==> fromJson 不能为 null，listModel 必须是 List");
      return this;
    }
    _pageModel = PageModel.fromJson(result.data);
    final isFirstPage = _pageModel.page <= pageNum_default_first;
    // 第一页是下拉刷新，先清空再填；第二页起是上拉加载，直接追加
    if (isFirstPage) listModel.clear();
    // fromJson 允许返回 null（脏数据丢行），whereType 顺手把 null 过掉
    if (_pageModel.records.isNotEmpty) {
      listModel.addAll(_pageModel.records.map((i) => fromJson(i)).whereType<T>().toList());
    }
    // 只有第一页就没数据才算「空列表」，翻到空页不该把已有数据清掉
    if (isFirstPage && _pageModel.records.isEmpty) recode.value = ResultCode.empty_data;
    return this;
  }

  //检测多组权限:是否有权限没有被允许
  Future<bool> checkPermissionAndroidList(List<Permission> permissionList) async {
    bool hasPermissionNotAllow = false;
    for (var value in permissionList) {
      var status = await value.status;
      if (!status.isGranted) {
        hasPermissionNotAllow = true;
        break;
      }
    }
    return hasPermissionNotAllow;
  }

  // 上传图片
  Future<List<String>> uploadFile(var fileType, var fileTypeName, List images, {Function(dynamic)? callBack}) async {
    List<String> paths = [];
    for (String img in images) {
      if (!img.startsWith(httpStartWithPrefix)) {
        final result = await CommonRequest.uploadFile([img], fileType, fileTypeName);
        if (result.success) {
          // {
          //   "largeUrlSuffix":"",
          //   "smallUrlSuffix":"",
          //   "url":"http://host/resource/fileTypeName/20241008/2024100813550181365399.jpg",
          //   "urlPrefix":"http://192.168.2.193:8181/resource/",
          //   "urlSuffix":"fileTypeName/20241008/2024100813550181365399.jpg"
          // }
          if (callBack != null) callBack(result.data);
          if (result.data.containsKey("urlSuffix")) {
            paths.add(result.data["urlSuffix"]);
          }
        }
      } else {
        // bool isHave = false;
        // for (var file in informationAccessoryList!) {
        //   if (image == file.fileName || image == file.url) {
        //     isHave = true;
        //     break;
        //   }
        // }
        // if (isHave == false) {
        //   // 可能是第二次进入该页面
        //   informationAccessoryList?.add(
        //     InformationAccessoryList(
        //       fileType: fileType,
        //       filePath: image,
        //       fileName: image,
        //       url: image,
        //     )
        //   );
        // }
      }
    }
    return paths;
  }

  // 解析处理数组对象
  analyzingList<T>(FromJson<T>? fromJson, dynamic data, {var listModel, Complete? complete}) {
    List<T> list = [];
    if (data != null && data is List && fromJson != null) {
      list = data.map((i) => fromJson(i)).toList();
      if (listModel is RxList) {
        listModel.value = list;
      } else if (listModel is List) {
        listModel.clear();
        listModel.addAll(list);
      }
      if (complete != null) complete(list);
    } else {
      logger.e("resultAnalyzingModel() ==> fromJson 不能为 null");
      // throw Exception('fromJson cannot be null.');
    }
    return list;
  }
}
