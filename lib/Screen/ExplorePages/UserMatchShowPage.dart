import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Resources/assets/assets.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Widgets/background_Image_container.dart';

import '../ChatPages/ChatDetailsPage/ChatDetailsPage.dart';
import '../ChatPages/ChatPage/ChatPage.dart';

class UserMatchesPage extends StatelessWidget {
  const UserMatchesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageContainer(
        imagePath: ImageAssets.backImage,
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            const MyText(
              text: "It’s a Match!",
            ),
            const SizedBox(
              height: 30,
            ),
            const MyText(
              text: "Congratulations! She also liked\nyou!",
              fontSize: 18,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: Image.asset(ImageAssets.smallPic).image,
                ),
                const SizedBox(
                  width: 35,
                ),
                CircleAvatar(
                  backgroundImage: Image.asset(ImageAssets.smallPic).image,
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            LargeButton(
              text: "Say Hi ! ",
              width: Get.width * 0.84,
              height: Get.height * 0.065,
              textColor: AppColor.secondaryColor,
              containerColor: AppColor.whiteColor,
              gradientColor1: AppColor.whiteColor,
              gradientColor2: AppColor.whiteColor,
              onTap: () {
                Get.to(
                  () => ChatDetailsPage(),
                  // arguments: [
                  //   {"email": emailController.text.toString()},
                  // ],
                  duration: const Duration(milliseconds: 350),
                  transition: Transition.rightToLeft,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
