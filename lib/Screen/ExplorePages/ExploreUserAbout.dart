// import 'package:get/get.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter/material.dart';
// import '../../Widgets/RoundedButton.dart';
// import 'package:amoremio/Widgets/Text.dart';
// // import 'package:bottom_sheet/bottom_sheet.dart';
// import 'package:amoremio/Resources/assets/assets.dart';
// import 'package:amoremio/Resources/colors/colors.dart';
//
// Future aboutExploreUser(BuildContext context) {
//   return showFlexibleBottomSheet(
//     minHeight: Get.height * 0.22,
//     initHeight: 0.65,
//     maxHeight: 0.65,
//     context: context,
//     bottomSheetBorderRadius: const BorderRadius.only(
//       topLeft: Radius.circular(30),
//       topRight: Radius.circular(30),
//     ),
//     builder: _buildBottomSheet,
//     isExpand: false,
//     // isDismissible: false,
//   );
// }
//
// Widget _buildBottomSheet(
//   BuildContext context,
//   ScrollController scrollController,
//   double bottomSheetOffset,
// ) {
//   return Material(
//     child: ListView(
//       // controller: scrollController,
//       shrinkWrap: true,
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         GestureDetector(
//           onTap: (){
//             Get.back();
//           },
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: Get.width * 0.28),
//             child: Container(
//               height: 7,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: const Color(0xFFFFC3C3),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           height: Get.height * 0.65,
//           decoration: const BoxDecoration(
//             color: AppColor.whiteColor,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(27),
//               topRight: Radius.circular(27),
//             ),
//           ),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: Get.width * 0.06,
//                   top: Get.height * 0.02,
//                   right: Get.width * 0.06,
//                   bottom: Get.height * 0.01,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const MyText(
//                       text: "Lady Samurai, 21",
//                       fontSize: 18,
//                       color: AppColor.blackColor,
//                     ),
//                     Row(
//                       children: [
//                         SvgPicture.asset(
//                           ImageAssets.createStory1,
//                           color: AppColor.secondaryColor,
//                         ),
//                         const MyText(
//                           text: "2745",
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14,
//                           color: AppColor.secondaryColor,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                     left: Get.width * 0.06, bottom: Get.height * 0.02),
//                 child: const Row(
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       color: AppColor.secondaryColor,
//                       size: 17,
//                     ),
//                     SizedBox(
//                       width: 3,
//                     ),
//                     MyText(
//                       text: "Tokyo 2.5 Km",
//                       fontWeight: FontWeight.w500,
//                       fontSize: 12,
//                       color: Color(0xFF3B3B3B),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding:  EdgeInsets.only(top: Get.height * 0.01,left: Get.width * 0.06, right: Get.width * 0.045),
//                 child: const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MyText(
//                       text: "About me",
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                       color: AppColor.blackColor,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     MyText(
//                       text:
//                           "Donec a eros justo. Fusce egestas tristique ultrices. Nam tempor, augue nec tincidunt molestie, massa nunc varius arcu, at scelerisque ",
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14,
//                       color: Color(0xFF646464),
//                       align: TextAlign.start,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: Get.height * 0.28,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   SvgPicture.asset(ImageAssets.explore2),
//                   RoundedButton(
//                     onTap: () {},
//                     icon: ImageAssets.block,
//                   ),
//                   RoundedButton(
//                     onTap: () {},
//                     icon: ImageAssets.favorite,
//                     containerColor: Colors.red
//                   ),
//                   SvgPicture.asset(ImageAssets.share),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
