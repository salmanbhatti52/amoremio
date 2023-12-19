import 'package:animate_do/animate_do.dart';

import 'CoinsShop.dart';
import 'PaymentMwthods/PaymentMethod.dart';
import 'WithdrawCoins.dart';
import 'UpgradeAccount.dart';
import 'package:get/get.dart';
import '../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import '../../Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Widgets/ProfileContainer.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';

class UserCoins extends StatelessWidget {
  const UserCoins({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Your Coins",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                  width: Get.width * 0.88,
                  height: Get.height * 0.36,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(ImageAssets.yourCoins),
                        ),
                        const MyText(
                          text: "Total Coins",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.hintTextColor,
                        ),
                        const MyText(
                          text: "10,000",
                          fontSize: 58,
                          fontWeight: FontWeight.w600,
                          color: AppColor.secondaryColor,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        LargeButton(
                          text: "Save Changes",
                          onTap: () {
                              Get.to(
                                    () => const CoinsShop(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 300),
                              );
                          },
                          containerColor: AppColor.whiteColor,
                          gradientColor1: const Color(0xFFDA9228),
                          gradientColor2: const Color(0xFFEE4433),
                          borderColor: AppColor.whiteColor,
                          textColor: AppColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              FadeInLeft(
                animate: true,
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 600),
                child: ProfileContainer(
                  text: 'Withdraw Coins',
                  icon: ImageAssets.withdraw,
                  imageColor: const Color(0xff00B4B4),
                  onTap: () {
                    Get.to(
                          () => WithdrawCoins(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              FadeInDown(
                animate: true,
                child: ProfileContainer(
                  text: 'Payment Methods',
                  icon: ImageAssets.payment,
                  onTap: () {
                    Get.to(
                          () => const PaymentMethod(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              FadeInRight(
                animate: true,
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 600),
                child: ProfileContainer(
                  text: 'Upgrade Account',
                  icon: ImageAssets.diamond,
                  onTap: () {
                    Get.to(
                          () => UpgradeAccount(),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
