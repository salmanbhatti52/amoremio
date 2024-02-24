import 'package:get/get.dart';
import 'AccountVerification2.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/assets/assets.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

class AccountVerification1 extends StatefulWidget {
  final String imgUrl;
  final String userName;
   const AccountVerification1({Key? key, required this.imgUrl, required this.userName}) : super(key: key);

  @override
  State<AccountVerification1> createState() => _AccountVerification1State();
}

class _AccountVerification1State extends State<AccountVerification1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Appbar(
                title2: "Account Verification",
                onTap: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: Get.height * 0.08,
                backgroundImage: Image.network(widget.imgUrl).image,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              MyText(
                text: widget.userName,
                fontSize: 22,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: const MyText(
                  text:
                      "To publish your profile you have to verify. Until you are verified you will not be visible to others.",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFFE9E9),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const MyText(
                text: "Prepare For Your Identity Check!",
                fontSize: 18,
                color: Color(0xFFFFE9E9),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const ShapeDecoration(
                        color: AppColor.whiteColor,
                        shape: OvalBorder(),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    const MyText(
                      text: "ID Front",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const ShapeDecoration(
                        color: AppColor.whiteColor,
                        shape: OvalBorder(),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    const MyText(
                      text: "ID Back",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const ShapeDecoration(
                        color: AppColor.whiteColor,
                        shape: OvalBorder(),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    const MyText(
                      text: "Selfie Pose",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const ShapeDecoration(
                        color: AppColor.whiteColor,
                        shape: OvalBorder(),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.03,
                    ),
                    const MyText(
                      text: "Selfie with Written",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.2,
              ),
              LargeButton(
                  text: "Get Verified",
                  width: Get.width * 0.84,
                  height: Get.height * 0.065,
                  containerColor: AppColor.whiteColor,
                  textColor: AppColor.secondaryColor,
                  gradientColor1: AppColor.whiteColor,
                  gradientColor2: AppColor.whiteColor,
                  onTap: () {
                    Get.to(()=> const AccountVerification2(), transition: Transition.rightToLeft, duration: const Duration(milliseconds: 300),);
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
