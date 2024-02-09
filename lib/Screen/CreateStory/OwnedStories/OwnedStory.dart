import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';

// ignore: must_be_immutable
class OwnedStory extends StatelessWidget {
  final double height;
  final Function onTap;
  const OwnedStory({
    Key? key,
    required this.height,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: const Center(child: MyText(text: 'No owned stories yet!')),
      // child: GridView.builder(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 3,
      //       crossAxisSpacing: 8.0,
      //       mainAxisSpacing: 0.0,
      //       childAspectRatio: 1 / 1.5,
      //   ),
      //   itemCount: 21,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Column(
      //       children: [
      //         GestureDetector(
      //           onTap: (){
      //             onTap();
      //           },
      //           child: Stack(
      //             children: [
      //               Image.asset(
      //                 ImageAssets.exploreImage,
      //                 width: 107.53,
      //                 height: 138,
      //               ),
      //               Positioned(
      //                 right: 1,
      //                 top: 7,
      //                 child: Container(
      //                   width: Get.width * 0.18,
      //                   height: 13,
      //                   decoration: ShapeDecoration(
      //                     color: AppColor.whiteColor.withOpacity(0.4),
      //                     shape: const RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.only(
      //                         topRight: Radius.circular(6.50),
      //                         bottomLeft: Radius.circular(2),
      //                       ),
      //                     ),
      //                   ),
      //                   child: const Row(
      //                     children: [
      //                       Icon(
      //                         Icons.watch_later,
      //                         size: 10,
      //                         color: AppColor.whiteColor,
      //                       ),
      //                       MyText(
      //                         text: " October 2023",
      //                         fontSize: 8,
      //                         fontWeight: FontWeight.w400,
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Image.asset(
      //               ImageAssets.smallPic,
      //               width: 14,
      //               height: 14,
      //             ),
      //             const SizedBox(
      //               width: 5,
      //             ),
      //             const MyText(
      //               text: "Stephanie, 23",
      //               fontSize: 12,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ],
      //         ),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
