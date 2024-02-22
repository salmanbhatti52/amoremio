import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Resources/assets/assets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import '../Authentication/LoginPage/login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.introImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.linearToSrgbGamma(),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset(
                      ImageAssets.logo,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  ),
                Column(
                  children: [
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 700),
                      child: const MyText(
                        text: "Find your love or a perfect date",
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    LargeButton(
                      text: "Enter",
                      width: Get.width * 0.84,
                      height: Get.height * 0.065,
                      onTap: () {
                        Get.to(
                              () => const LoginPage(),
                          duration: const Duration(milliseconds: 350),
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
