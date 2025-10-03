import 'dart:core';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_go_main/logger.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:http_manager/result_analyzed.dart';
import 'package:http_manager/result_extension.dart';
import 'package:getx_go_main/models/page_model.dart';
import 'package:getx_go_main/api/api_result_code.dart';


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

  // 下拉刷新上拉加载的控制器
  final refreshCtrl = EasyRefreshController(controlFinishLoad: true, controlFinishRefresh: true);
  // 分页模型
  PageModel page = PageModel();

  // 数据
  dynamic models;

  // 关闭键盘
  closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

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


  // 下拉刷新的函数
  Future<void> onRefresh() async {
    refreshCtrl.finishRefresh();
    refreshCtrl.resetFooter();
  }

  // 上拉加载的函数
  Future<void> onLoad() async {
    if (page.nextPagination == -1 || recode.value == ResultCode.noMoreData) {
      refreshCtrl.finishLoad(IndicatorResult.noMore);
    } else {
      refreshCtrl.finishLoad(IndicatorResult.success);
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
    if (result.success && result.data != null) {
      if (fromJson != null) {
        if (result.dataIsMap && result.dataIsNotNullOrNotEmpty) {
          if (result.dataContainsKey("pagination")) {
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
      // 解决上拉加载，服务器返回 20003、29999... 时列表数据被清空的的情况
      if(listModel!=null) {
        if (page.nextPagination != -1) listModel.clear();
      }
    }
    // 如果数据为空，需要显示空数据界面，或者无网络界面，否则显示正常界面。
    if (refresh == true) recode.value = result.code!;
    return this;
  }

  // 解析处理数组对象
  BaseController analyzingListData<T>(data, var listModel, FromJson<T>? fromJson, {Complete? complete}) {
    if (fromJson != null && data != null && data.isNotEmpty) {
      final list = (data as List).map((i) => fromJson(i)).toList();
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

  // 解析处理分页列表对象（如果是一个分页的字典对象）
  BaseController analyzingPageData<T>(ResponseAnalyzed result, var listModel, FromJson<T>? fromJson, {Complete? complete}) {
    if (fromJson != null) {
      page = PageModel.fromJson(result.data);
      if (page.dataList != null && page.dataList is List && (page.dataList as List).isNotEmpty) {
        listModel = (listModel as List);
        final list = (page.dataList as List).map((i) => fromJson(i)).toList();
        if (page.pagination != null && page.pagination! <= 1) {
          listModel.clear();
        }
        listModel.addAll(list);
      }
      // 服务器有时候不按标准执行，在不是上拉加载的时候返回了 20003
      if (page.dataList.isEmpty || (page.pagination! <= 0 && result.noMoreData)) {
        (listModel as List).clear();
        // state.value = ResultCode.emptyData; /// todo : 兼容适配旧代码
        recode.value = ResultCode.emptyData;
      }
    } else {
      logger.e("resultAnalyzingModel() ==> fromJson 不能为 null");
    }
    return this;
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
