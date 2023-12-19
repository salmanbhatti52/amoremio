// import 'package:bottom_sheet/bottom_sheet.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../Resources/assets/assets.dart';
// import '../../Resources/colors/colors.dart';
// import '../../Widgets/Small_Button.dart';
// import '../../Widgets/Text.dart';
// import 'package:get/get.dart';
//
// class VideoPlaySheet extends StatelessWidget {
//   const VideoPlaySheet({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return showFlexibleBottomSheet(
//       minHeight: 0,
//       initHeight: 0.65,
//       maxHeight: 0.65,
//       context: context,
//       bottomSheetBorderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(30),
//         topRight: Radius.circular(30),
//       ),
//       builder: (BuildContext context ScrollController scrollController,
//           double bottomSheetOffset,){
//
//       }
//     );
//   }
// }
//
// //
// // Future<dynamic> videoPlaySheet(BuildContext context) {
// //   return showFlexibleBottomSheet(
// //     minHeight: 0,
// //     initHeight: 0.65,
// //     maxHeight: 0.65,
// //     context: context,
// //     bottomSheetBorderRadius: const BorderRadius.only(
// //       topLeft: Radius.circular(30),
// //       topRight: Radius.circular(30),
// //     ),
// //     builder: _buildBottomSheet,
// //     isExpand: false,
// //   );
// // }
// //
// // Widget _buildBottomSheet(
// //     BuildContext context,
// //     ScrollController scrollController,
// //     double bottomSheetOffset,
// //     ) {
// //   return Material(
// //     child: ListView(
// //       controller: scrollController,
// //       shrinkWrap: true,
// //       children: [
// //         const SizedBox(
// //           height: 5,
// //         ),
// //         Padding(
// //           padding: EdgeInsets.symmetric(horizontal: Get.width * 0.28),
// //           child: Container(
// //             height: 7,
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(12),
// //               color: const Color(0xFFFFC3C3),
// //             ),
// //           ),
// //         ),
// //         Padding(
// //           padding: EdgeInsets.symmetric(vertical: Get.height * 0.035),
// //           child: const MyText(
// //             text: "Blocked Users",
// //             fontSize: 18,
// //             color: AppColor.blackColor,
// //           ),
// //         ),
// //         Container(
// //           color: Colors.white.withOpacity(0.800000011920929),
// //           height: Get.height * 0.61, //300,
// //           child: ListView.builder(
// //             shrinkWrap: true,
// //             scrollDirection: Axis.vertical,
// //             itemCount: 12,
// //             itemBuilder: (BuildContext context, int index) {
// //               return Padding(
// //                 padding: EdgeInsets.symmetric(
// //                     horizontal: Get.width * 0.03, vertical: Get.height * 0.011),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         CircleAvatar(
// //                             backgroundColor: Colors.transparent,
// //                             backgroundImage:
// //                             Image.asset(ImageAssets.smallPic).image),
// //                         const SizedBox(
// //                           width: 13,
// //                         ),
// //                         Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             const MyText(
// //                               text: "Lady Samurai, 21",
// //                               color: AppColor.blackColor,
// //                               fontSize: 14,
// //                               fontWeight: FontWeight.w500,
// //                             ),
// //                             Row(
// //                               children: [
// //                                 Row(
// //                                   children: [
// //                                     SvgPicture.asset(
// //                                       ImageAssets.locationWhite,
// //                                       color: AppColor.secondaryColor,
// //                                     ),
// //                                     const MyText(
// //                                       text: "Tokyo 2.5 Km",
// //                                       color: Color(0xFF3B3B3B),
// //                                       fontSize: 12,
// //                                       fontWeight: FontWeight.w500,
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                     SmallButton(
// //                       text: "Unblock",
// //                       textColor: AppColor.secondaryColor,
// //                       onTap: () {},
// //                       containerColor: Colors.transparent,
// //                       borderColor: const Color(0xFFD5D5D5),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }