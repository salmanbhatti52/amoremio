import 'package:amoremio/Resources/assets/assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Screen/IntroPage/IntroPage.dart';
import 'package:amoremio/Screen/ExplorePages/ExploreBackgroundContainer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.to(
          () => const IntroPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: Center(
          child: SvgPicture.asset(
            ImageAssets.logo,
            height: 170,
          ),
        ),
      ),
    );
  }
}
