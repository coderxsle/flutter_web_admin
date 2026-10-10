// import 'package:auto_shop_server/app/modules/home/views/home_view.dart';
// import 'package:get/get.dart';
//
// import '../../app_home/page/home_page.dart';
// import 'package:flutter/material.dart';
//
//
//
// final pageController = PageController();
//
// class IndexView extends StatefulWidget {
//   final int index;
//   const IndexView({super.key, this.index=0});
//   @override
//   _IndexViewState createState() => _IndexViewState();
// }
//
// class _IndexViewState extends State<IndexView>  with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;
//   int _currentIndex = 0;
//   final pageController = PageController();
//   late List<Widget> _pages;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.index;
//
//     _pages = [
//       HomeView(),
//     ];
//     // AppManager.registerBroadcast("IndexViewTapPage", (value) {
//     //   if(mounted){
//     //     if(value.runtimeType == int){
//     //       onTap(value);
//     //     }
//     //   }
//     // });
//
//   }
//
//   void onTap(int index) {
//     // pageController.jumpToPage(index);
//     // if(index == 3) { // 刷新购物车
//         // AppManager.sendBroadcast(kRefreshCartModelEventKey);
//     // }else if (index == 1) {
//         // AppManager.sendBroadcast("reload_service_page");
//     // }
//   }
//
//   void onPageChanged(int index) {
//     setState(() { _currentIndex = index; });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: PageView(
//         controller: pageController,
//         onPageChanged: onPageChanged,
//         physics: const NeverScrollableScrollPhysics(),
//         children: _pages, // 禁止滑动
//       ),
//       // bottomNavigationBar: bottomNavigationBar(),
//     );
//   }
//
//   // Widget bottomNavigationBar() {
//   //   return BottomNavigationBar(
//   //     items: [
//   //       setupItems(tile: "首页", image: "tab_home.png", image_select: "tab_home_active.png"),
//   //       setupItems(tile: "服务", image: "tab_service.png", image_select: "tab_service_active.png"),
//   //       setupItems(tile: "团购", image: "tab_tuangou.png", image_select: "tab_tuangou_active.png"),
//   //       setupItems(tile: "购物车", image: "tab_market.png", image_select: "tab_market_active.png"),
//   //       setupItems(tile: "我的", image: "tab_personal.png", image_select: "tab_personal_active.png"),
//   //     ],
//   //     currentIndex: currentIndex,
//   //     backgroundColor: Colors.white,
//   //     type: BottomNavigationBarType.fixed,
//   //     selectedFontSize :10.0,
//   //     selectedItemColor: Colors.black,
//   //     unselectedFontSize : 10.0,
//   //     unselectedItemColor: Colors.grey,
//   //     onTap: onTap,
//   //   );
//   // }
//
//   // setupItems({required String tile, required String image, required String image_select}) {
//   //   return BottomNavigationBarItem(
//   //     backgroundColor: Colors.transparent,
//   //     icon: Container(
//   //       padding: const EdgeInsets.all(5),
//   //       alignment: Alignment.center,
//   //       child: Image(image: AssetImage("assets/images/$image"), fit: BoxFit.contain,width: 26,),
//   //     ),
//   //     activeIcon: Container(
//   //       padding: const EdgeInsets.all(5),
//   //       alignment: Alignment.center,
//   //       child: Image(image: AssetImage("assets/images/$image_select"), fit: BoxFit.contain,width: 26,),
//   //     ),
//   //     label: tile,
//   //   );
//   // }
//
// }
