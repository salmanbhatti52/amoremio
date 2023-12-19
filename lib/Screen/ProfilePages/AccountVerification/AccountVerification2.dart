import 'package:get/get.dart';
import 'AccountVerifyBox.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';
import 'package:amoremio/Screen/ProfilePages/AccountVerification/AccountVerification3.dart';

class AccountVerification2 extends StatelessWidget {
  const AccountVerification2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Appbar(
                title2: "ID verification",
                onTap: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const AccountVerifyBox(
                icon1: Icons.check,
                color1: AppColor.whiteColor,
                color2: Colors.transparent,
                color3: Colors.transparent,
                color4: Colors.transparent,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              Container(
                width: Get.width * 0.9,
                height: Get.height * 0.29,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ImageAssets.imagePick),
                    const MyText(
                      text: "Drop Your File Here",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF232323),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const MyText(
                text: "Upload Your Front ID Image\nfor verification",
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              SizedBox(
                height: Get.height * 0.2,
              ),
              LargeButton(
                text: "Next",
                width: Get.width * 0.84,
                height: Get.height * 0.065,
                containerColor: AppColor.whiteColor,
                textColor: AppColor.secondaryColor,
                gradientColor1: AppColor.whiteColor,
                gradientColor2: AppColor.whiteColor,
                onTap: () {
                  Get.to(
                    () => const AccountVerification3(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
