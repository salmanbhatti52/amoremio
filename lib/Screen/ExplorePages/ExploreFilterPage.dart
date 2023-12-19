// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Import GetX package
// import 'package:syncfusion_flutter_sliders/sliders.dart';
//
// import '../../Resources/colors/colors.dart';
// import '../../Widgets/Text.dart';
//
// class CustomDialog extends StatelessWidget {
//   final String selectedGender;
//   final ValueChanged<String> onGenderChanged;
//   final ValueChanged<String> onLocationChanged;
//   final double sliderValue;
//   final ValueChanged<dynamic> onSliderChanged;
//
//   CustomDialog({
//     required this.selectedGender,
//     required this.onGenderChanged,
//     required this.onLocationChanged,
//     required this.sliderValue,
//     required this.onSliderChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       alignment: Alignment.center,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(25.0),
//       ),
//       child: Container(
//         width: Get.width,
//         height: Get.height * 0.38,
//         decoration: BoxDecoration(
//           color: const Color(0xFFF8F8F8),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: Get.height * 0.03),
//             Container(
//               width: Get.width * 0.7,
//               height: Get.height * 0.055,
//               // ... Customize your dropdown widget here
//             ),
//             SizedBox(height: Get.height * 0.03),
//             Container(
//               width: Get.width * 0.7,
//               height: Get.height * 0.055,
//               // ... Customize your text input widget here
//             ),
//             SizedBox(height: Get.height * 0.03),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 20.0),
//                   child: MyText(
//                     text: "Select Range",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: AppColor.blackColor,
//                   ),
//                 ),
//                 SfSlider(
//                   min: 0.0,
//                   max: 1000.0,
//                   value: sliderValue,
//                   interval: 50,
//                   enableTooltip: true,
//                   inactiveColor: const Color(0xFFD9D9D9),
//                   activeColor: AppColor.primaryColor,
//                   minorTicksPerInterval: 1,
//                   onChanged: onSliderChanged,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       MyText(
//                         text: "50 Km",
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: AppColor.blackColor,
//                       ),
//                       MyText(
//                         text: "1000 Km",
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: AppColor.blackColor,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: Get.height * 0.01),
//             const MyText(
//               text: "Blocked Users",
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: AppColor.secondaryColor,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
