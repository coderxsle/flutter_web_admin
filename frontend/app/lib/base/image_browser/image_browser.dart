// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'simple_pics_wiper.dart';
//
// class SimplePhotoViewDemo extends StatefulWidget {
//   const SimplePhotoViewDemo({super.key});
//
//   @override
//   _SimplePhotoViewDemoState createState() => _SimplePhotoViewDemoState();
// }
//
// class _SimplePhotoViewDemoState extends State<SimplePhotoViewDemo> {
//   List<String> images = <String>[
//     'https://photo.tuchong.com/14649482/f/601672690.jpg',
//     'https://photo.tuchong.com/17325605/f/641585173.jpg',
//     'https://photo.tuchong.com/3541468/f/256561232.jpg',
//     'https://photo.tuchong.com/16709139/f/278778447.jpg',
//     'This is an video',
//     'https://photo.tuchong.com/5040418/f/43305517.jpg',
//     'https://photo.tuchong.com/3019649/f/302699092.jpg'
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         title: const Text('SimplePhotoView'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: GridView.builder(
//           // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//           //   maxCrossAxisExtent: 300,
//           //   crossAxisSpacing: 10,
//           //   mainAxisSpacing: 10,
//           // ),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, // 每行三列
//             childAspectRatio: 1, // 显示宽高比
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//           ),
//           itemBuilder: (BuildContext context, int index) {
//             final String url = images[index];
//             return GestureDetector(
//               child: AspectRatio(
//                 aspectRatio: 1.0,
//                 child: Hero(
//                   tag: url,
//                   child: url == 'This is an video'
//                       ? Container(
//                           alignment: Alignment.center,
//                           child: const Text('This is an video'),
//                         )
//                       : ExtendedImage.network(
//                           url,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//               onTap: () {
//                 // Get.to(()=> SimplePicsWiper(url: url, images: images),
//                 //   opaque: false,
//                 //   transition: Transition.noTransition
//                 // );
//                 Navigator.of(context).push(
//                   PageRouteBuilder(
//                     opaque: false,
//                     pageBuilder: (BuildContext context, _, __) {
//                       return SimplePicsWiper(url: url, images: images);
//                     },
//                   ),
//                 );
//               },
//             );
//           },
//           itemCount: images.length,
//         ),
//       ),
//     );
//   }
// }
