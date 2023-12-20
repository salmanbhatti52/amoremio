import 'package:get/get.dart';
import 'BlockUserDetails.dart';
import '../../Widgets/AppBar.dart';
import 'ExploreVideoViewButton.dart';
import 'package:flutter/material.dart';
import 'ExploreBackgroundContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../BottomNavigationBar/BottomNavigationBar.dart';

// Future blockedUser(BuildContext context) {
//   return showFlexibleBottomSheet(
//     minHeight: 0,
//     initHeight: 0.65,
//     maxHeight: 0.65,
//     context: context,
//     bottomSheetBorderRadius: const BorderRadius.only(
//       topLeft: Radius.circular(30),
//       topRight: Radius.circular(30),
//     ),
//     builder: _buildBottomSheet,
//     isExpand: false,
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
//       controller: scrollController,
//       shrinkWrap: true,
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: Get.width * 0.28),
//           child: Container(
//             height: 7,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: const Color(0xFFFFC3C3),
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: Get.height * 0.035),
//           child: const MyText(
//             text: "Blocked Users",
//             fontSize: 18,
//             color: AppColor.blackColor,
//           ),
//         ),
//         Container(
//           color: Colors.white.withOpacity(0.800000011920929),
//           height: Get.height * 0.61, //300,
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             itemCount: 12,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: Get.width * 0.03, vertical: Get.height * 0.011),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                             backgroundColor: Colors.transparent,
//                             backgroundImage:
//                                 Image.asset(ImageAssets.smallPic).image),
//                         const SizedBox(
//                           width: 13,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const MyText(
//                               text: "Lady Samurai, 21",
//                               color: AppColor.blackColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             Row(
//                               children: [
//                                 Row(
//                                   children: [
//                                     SvgPicture.asset(
//                                       ImageAssets.locationWhite,
//                                       color: AppColor.secondaryColor,
//                                     ),
//                                     const MyText(
//                                       text: "Tokyo 2.5 Km",
//                                       color: Color(0xFF3B3B3B),
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SmallButton(
//                       text: "Unblock",
//                       textColor: AppColor.secondaryColor,
//                       onTap: () {},
//                       containerColor: Colors.transparent,
//                       borderColor: const Color(0xFFD5D5D5),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }

class BlockedUser extends StatefulWidget {
   const BlockedUser({Key? key}) : super(key: key);

  @override
  State<BlockedUser> createState() => _BlockedUserState();
}

class _BlockedUserState extends State<BlockedUser> {

  final TextEditingController searchController = TextEditingController();
  bool status = false;

  void toggleSwitch(bool newValue) {
   setState(() {
     status = newValue;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Blocked Users",
        onTap: () {
          Get.to(()=> MyBottomNavigationBar());
        },
      ),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              Container(
                width: Get.width * 0.9,
                height: Get.height * 0.055,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.whiteColor,
                ),
                child: Center(
                  child: TextField(
                    autofocus: false,
                    cursorColor: AppColor.hintTextColor,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColor.hintTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.03, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: AppColor.hintContainerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: AppColor.hintContainerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          size: 25,
                          color: AppColor.hintTextColor,
                        ),
                      ),
                      hintText: "Search",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColor.hintTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              ExploreVideoContainer(
                      height: MediaQuery.of(context).size.height * 0.8,
                  onTap: (){
                        Get.to(()=> const BlockUserDetails(),
                          duration: const Duration(seconds: 1),
                          transition: Transition.native,);
                  },
                  value: status,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
