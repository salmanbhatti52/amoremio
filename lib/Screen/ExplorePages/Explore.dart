import 'package:get/get.dart';
import 'ExploreVideoView.dart';
import 'ExploreController.dart';
import '../../Widgets/AppBar.dart';
import 'ExploreSearch&Filter.dart';
import 'ExploreVideoViewButton.dart';
import 'package:flutter/material.dart';
import 'ExploreBackgroundContainer.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Widgets/Small_Button.dart';
import 'package:amoremio/Resources/colors/colors.dart';

// ignore: must_be_immutable
class ExplorePage extends StatelessWidget {
  ExplorePage({Key? key}) : super(key: key);

  ExploreController exploreController = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ExploreAppbar(title: "LOGO", title2: "Explore"),
              SizedBox(height: Get.height * 0.02),
              ExploreSearch(),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.04,
                  top: Get.height * 0.033,
                  bottom: Get.height * 0.025,
                ),
                child: const Row(
                  children: [
                    MyText(
                      text: "Categories",
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: Get.width * 0.06,
              //     right: Get.width * 0.06,
              //     top: Get.height * 0.035,
              //     bottom: Get.height * 0.025,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const MyText(
              //         text: "Categories",
              //         fontSize: 18,
              //       ),
              //       Obx(
              //         () => FlutterSwitch(
              //           width: 52.0,
              //           height: 28.0,
              //           toggleSize: 21.0,
              //           activeColor: AppColor.whiteColor,
              //           value: exploreController.status.value,
              //           borderRadius: 16.42,
              //           inactiveColor: const Color(0x87FFAEAE),
              //           activeToggleColor: AppColor.secondaryColor,
              //           // ignore: deprecated_member_use
              //           activeIcon: SvgPicture.asset(ImageAssets.video, color: AppColor.whiteColor,),
              //           // ignore: deprecated_member_use
              //           inactiveIcon: SvgPicture.asset(ImageAssets.video,  color: const Color(0xFF8B8B8B),),
              //           showOnOff: false,
              //           onToggle: (val) {
              //             exploreController.toggleSwitch(val);
              //             if (val == true) {
              //               // e.g., notificationPermissionApiYes();
              //             } else if (val == false) {
              //               // e.g., notificationPermissionApiNo();
              //             } else {
              //             }
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() => SmallButton(
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      textColor: exploreController.selectedIndex1.value == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      text: "Discover ",
                      onTap: () {
                        exploreController.selectedIndex1.value = true;
                        exploreController.selectedIndex2.value = false;
                        exploreController.selectedIndex3.value = false;
                        exploreController.selectedIndex4.value = false;
                        // showDialog(
                        //     context: context,
                        //     barrierColor: Colors.white60,
                        //     barrierDismissible: true,
                        //     builder: (BuildContext context) =>
                        //          CustomDialog(
                        //            width: Get.width * 0.8,
                        //            height: Get.height * 0.25,
                        //            text: 'Opps!',
                        //            text2: 'Only for Premium members!',
                        //            text3: 'Buy Premium',
                        //            color: AppColor.whiteColor,
                        //          ),
                        // );
                      },
                    ),),
                    Obx(() => SmallButton(
                      text: "Matches ",
                      textColor: exploreController.selectedIndex2.value == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,

                      onTap: () {

                        exploreController.selectedIndex1.value = false;
                        exploreController.selectedIndex2.value = true;
                        exploreController.selectedIndex3.value = false;
                        exploreController.selectedIndex4.value = false;
                        // Get.to(
                        //   () => const UserMatchesPage(),
                        //   duration: const Duration(milliseconds: 350),
                        //   transition: Transition.rightToLeft,
                        // );
                      },
                    ),
                    ),
                    Obx(() => SmallButton(
                      text: "Liked ",
                      textColor: exploreController.selectedIndex3.value == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      onTap: () {
                        exploreController.selectedIndex1.value = false;
                        exploreController.selectedIndex2.value = false;
                        exploreController.selectedIndex3.value = true;
                        exploreController.selectedIndex4.value = false;
                        },
                    ),),
                    Obx(() => SmallButton(
                      text: "Liked You ",
                      textColor: exploreController.selectedIndex4.value == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      onTap: () {
                        exploreController.selectedIndex1.value = false;
                        exploreController.selectedIndex2.value = false;
                        exploreController.selectedIndex3.value = false;
                        exploreController.selectedIndex4.value = true;
                      },
                    ),),
                  ],
                ),
              ),
              Obx(
                () => ExploreVideoContainer(
                  height: MediaQuery.of(context).size.height * 0.61,
                  onTap: (){
                    Get.to( () => const ExploreVideoView(),
                      duration: const Duration(seconds: 1),
                      transition: Transition.native,);
                  },
                  value: exploreController.status.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
