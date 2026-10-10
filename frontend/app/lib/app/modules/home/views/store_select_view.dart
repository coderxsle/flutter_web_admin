// import 'package:auto_shop_server/app/modules/home/request/home_request.dart';
// import 'package:auto_shop_server/app/utils/app_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../utils/global.dart';
// import '../../../utils/result_code.dart';
// import '../models/shop_model.dart';


// class StoreSelectView extends StatefulWidget {
//   const StoreSelectView({super.key});

//   @override
//   State<StoreSelectView> createState() => _StoreSelectViewState();
// }

// class _StoreSelectViewState extends State<StoreSelectView> {

//   List<ShopModel> _models = [];

//   @override
//   void initState() {
//     super.initState();
//     getStoreList();
//   }

//   getStoreList() async {
//     showLoadingMessage("数据获取中...");
//     var result = await HomeRequest.getShopList();
//     if (result.success) {
//       _models = (result.data as List).map((i) => ShopModel.fromJson(i)).toList();
//     }
//     dismissLoading();
//     setState(() { });
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: PageBackgroundColor,
//       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//       alignment: Alignment.center,
//       child: SafeArea(
//         child: Column(
//           children: [
//             Row(children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: ()=> Get.back(),
//                   child: Container(
//                     height: 64, alignment: Alignment.center,
//                     color: Colors.white,
//                     child: const Icon(Icons.close),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 5,
//                 child: Container(
//                   height: 64,
//                   alignment: Alignment.center,
//                   color: Colors.white,
//                   child: const NavigatorTitle("选择店铺"),
//                 ),
//               ),
//               Expanded(
//                   child: Container(
//                     color: BGColor_white_255,
//                     height: 64,
//                     alignment: Alignment.center,
//                     child: const Text(
//                       "", style: TextStyle(fontSize: 18, color: Colors.black),),
//                   )),
//             ],),
//             Expanded(
//               child: ListView.builder(
//                   padding: const EdgeInsets.fromLTRB(0, 15, 0, 1),
//                   itemCount: _models.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       behavior: HitTestBehavior.opaque,
//                       onTap: () {
//                         debugPrint("选择了${_models[index].shopName}");
//                         AppManager.setShopModel(_models[index]);
//                         debugPrint("AppManager.currentShop = ${_models[index].shopName}");
//                         AppManager.sendBroadcast(kHomeRefresh);
//                         Get.back();
//                       },
//                       child: Container(
//                         color: Colors.white,
//                         padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
//                         alignment: Alignment.center,
//                         child: Text(_models[index].shopName!,
//                             style: const TextStyle(
//                                 fontSize: 18, color: Font_Color_Black_34)),
//                       ),
//                     );

//                 }
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }
