import '../UserCoins.dart';
import 'package:get/get.dart';
import '../ProfileScreen.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../Widgets/ProfileContainer.dart';
import '../Referral Pages/ReferralsPage.dart';
import '../AccountsSettings/AccountSettings.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../AccountVerification/AccountVerification1.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool status = false;
  void toggleSwitch(bool newValue) {
    setState(() {
      status = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const ExploreAppbar(title: "LOGO", title2: "Profile",),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: Get.height * 0.08,
                    backgroundImage: Image.asset(ImageAssets.mediumImage).image,
                  ),
                  Positioned(
                    bottom: Get.height * 0.024,
                    left: Get.width * 0.065,
                    child: const MyText(
                      text: "NOT VERIFIED",
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   left: Get.width * 0.09,
                  //   child: Container(
                  //     width: Get.width * 0.18,
                  //     height: Get.height * 0.024,
                  //     decoration: ShapeDecoration(
                  //       gradient: const LinearGradient(
                  //         begin: Alignment(0.85, -0.53),
                  //         end: Alignment(-0.85, 0.53),
                  //         colors: [Colors.white, Color(0xFFFFBFBF)],
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(17),
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         SvgPicture.asset(ImageAssets.diamond),
                  //         const MyText(
                  //           text: "PRO",
                  //           fontSize: 12,
                  //           color: AppColor.secondaryColor,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyText(
                    text: "Lubana Antique",
                    fontSize: 22,
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  // SvgPicture.asset(ImageAssets.blueTick),
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Container(
                width: Get.width * 0.5,
                height: Get.height * 0.05,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.23999999463558197),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ImageAssets.healthicons,
                      color: AppColor.whiteColor,
                    ),
                    const MyText(
                      text: " 78676",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: Get.width * 0.07,
                    ),
                    const Icon(
                      Icons.attach_money_rounded,
                      color: AppColor.whiteColor,
                    ),
                    const MyText(
                      text: "135,70",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: MyText(
                  text:
                      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              LargeButton(
                width: Get.width * 0.84,
                height: Get.height * 0.065,
                text: "Verify your Account Now",
                containerColor: AppColor.secondaryColor,
                gradientColor1: AppColor.secondaryColor,
                gradientColor2: AppColor.secondaryColor,
                borderColor: AppColor.whiteColor,
                borderSize: 1.2,
                onTap: () {
                  Get.to(
                    () => const AccountVerification1(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  );
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 400),
                child: ProfileContainer(
                  text: 'Your Profile',
                  icon: ImageAssets.yourProfile,
                  onTap: () {
                    Get.to(
                          () => UserProfile(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 500),
                child: ProfileContainer(
                  text: 'Your Coins',
                  icon: ImageAssets.buyCoins,
                  imageColor: Color(0xffDDC911),
                  onTap: () {
                    Get.to(
                          () => UserCoins(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 600),
                child: ProfileContainer(
                  text: 'Account Settings',
                  icon: ImageAssets.account,
                  onTap: () {
                    Get.to(
                          () => AccountSettings(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 700),
                child: ProfileContainer(
                  text: 'Referrals ',
                  icon: ImageAssets.refrel,
                  imageColor: Color(0xff04B4FF),
                  onTap: () {
                    Get.to(
                          () => ReferralsPage(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 800),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: Get.width * 0.85,
                    height: Get.height * 0.06,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                ImageAssets.notificationAlarm,
                                color: Color(0xff9CEE33),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              const MyText(
                                text: "Notifications",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.blackColor,
                              ),
                            ],
                          ),
                          FlutterSwitch(
                              width: 36,
                              height: 19,
                              toggleSize: 12.0,
                              value: status,
                              borderRadius: 11,
                              inactiveColor: Color(0xFFC6C6C6),
                              activeColor: AppColor.secondaryColor,
                              activeToggleColor: AppColor.whiteColor,
                              inactiveToggleColor: Color(0xFFD9D9D9),
                              showOnOff: false,
                              onToggle: (val) {
                                toggleSwitch(val);
                                print("val $val");
                                if (val == true) {
                                  // e.g., notificationPermissionApiYes();
                                } else if (val == false) {
                                  // e.g., notificationPermissionApiNo();
                                } else {
                                  print("Error ");
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              FadeInLeft(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 900),
                child: ProfileContainer(
                  text: 'Logout ',
                  icon: ImageAssets.logout,
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}