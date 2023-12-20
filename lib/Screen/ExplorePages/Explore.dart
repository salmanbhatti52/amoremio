import 'package:get/get.dart';
import 'ExploreVideoView.dart';
import '../../Widgets/AppBar.dart';
import 'ExploreSearch&Filter.dart';
import 'ExploreVideoViewButton.dart';
import 'package:flutter/material.dart';
import 'ExploreBackgroundContainer.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Widgets/Small_Button.dart';
import 'package:amoremio/Resources/colors/colors.dart';

// ignore: must_be_immutable
class ExplorePage extends StatefulWidget {
  ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

  bool status = false;
  bool selectedIndex1 = true;
  bool selectedIndex2 = false;
  bool selectedIndex3 = false;
  bool selectedIndex4 = false;

  void toggleSwitch(bool newValue) {
    setState(() {
      status = newValue;
    });
  }

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
                    SmallButton(
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      textColor: selectedIndex1 == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      text: "Discover ",
                      onTap: () {
                        selectedIndex1 = true;
                        selectedIndex2 = false;
                        selectedIndex3 = false;
                        selectedIndex4 = false;
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
                    ),
                    SmallButton(
                      text: "Matches ",
                      textColor: selectedIndex2 == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,

                      onTap: () {

                        selectedIndex1 = false;
                        selectedIndex2 = true;
                        selectedIndex3 = false;
                        selectedIndex4 = false;
                        // Get.to(
                        //   () => const UserMatchesPage(),
                        //   duration: const Duration(milliseconds: 350),
                        //   transition: Transition.rightToLeft,
                        // );
                      },
                    ),
                    SmallButton(
                      text: "Liked ",
                      textColor: selectedIndex3 == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      onTap: () {
                        selectedIndex1 = false;
                        selectedIndex2 = false;
                        selectedIndex3 = true;
                        selectedIndex4 = false;
                        },
                    ),
                    SmallButton(
                      text: "Liked You ",
                      textColor: selectedIndex4 == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      onTap: () {
                        selectedIndex1 = false;
                        selectedIndex2 = false;
                        selectedIndex3 = false;
                        selectedIndex4 = true;
                      },
                    ),
                  ],
                ),
              ),
              ExploreVideoContainer(
                  height: MediaQuery.of(context).size.height * 0.61,
                  onTap: (){
                    Get.to( () => const ExploreVideoView(),
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
