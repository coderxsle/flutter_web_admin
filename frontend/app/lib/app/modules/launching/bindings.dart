// 原 BindingsController 已删除：全工程无引用，且空 Binding 无法迁移（Binds 断言 binds 非空）。
// 以下为原文件注释留档。


// class CounterController extends GetxController {
//   var count = 0.obs;
//   void increment() {
//     count++;
//   }
// }
//
// 在需要的使用的界面
// CounterController controllerl = Get.find();
// print(controller.count);


// 在 GetMaterialApp 中配置 initialBinding: BindingsController()。
// 在 BindingsController 中重写 dependencies()。
// 并且使用 Get.lazyPut(() => ...() 进行延迟到使用时加载。
// 这样避免了 Get.put(CounterController()) 在 A 页面创建。
// 而 A 界面还未加载，直接进入 B 界面 Get.find<CounterController>(); 时会报错的问题。

// 如果在继承了 Bindings 之后，在重写 dependencies 中进行 Get.lazyPut(CounterController());
// 那么在使用  HistoryPage extends GetView<HistoryController> 界面进行过一次pop操作，
// 或者是 get.off 后，移除内存后会将 dependencies 中加载的 Get.lazyPut(CounterController()); 移除
// 导致第二次创建 HistoryPage 界面后报错：
// "HistoryController" not found.
// You need to call "Get.put(HistoryController())" or "Get.lazyPut(()=>HistoryController())"
// 所以在 dependencies 中加载的是不会被干掉的界面
// 解决方案是在 routes 中进行配置，如下所示：
// GetPage(name: "/HistoryPage", page: ()=> const HistoryPage(), binding: HistoryBinding()),
//  2023-7-22 18:21

// Get.lazyPut(() => CounterController());
// Get.lazyPut(() => EvaluationHistoryController());
