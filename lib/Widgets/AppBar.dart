import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amoremio/Resources/colors/colors.dart';

import '../Resources/assets/assets.dart';

class ExploreAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String title2;
  const ExploreAppbar({Key? key, this.title = "", this.title2 = ""})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: AppBar(
        backgroundColor: Colors.transparent, // Set a transparent background
        flexibleSpace: gradientColor(context), // Apply the gradient background
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        leading: SvgPicture.asset(ImageAssets.logo),
        leadingWidth: 110,
        title: MyText(
          text: title2,
        ),
        // backgroundColor: globalOrangeColors,
        centerTitle: true,
      ),
    );
  }
}

class CreateStoryAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? icon1;
  final String title2;
  final String title3;
  final String icon;
  const CreateStoryAppbar(
      {Key? key,
      required this.icon,
      this.title3 = "",
      this.icon1,
      this.title2 = ""})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: AppBar(
        backgroundColor: Colors.transparent, // Set a transparent background
        flexibleSpace: gradientColor(context), // Apply the gradient background
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset(ImageAssets.logo),
        ),
        leadingWidth: 110,
        title: MyText(
          text: title2,
        ),
        // backgroundColor: globalOrangeColors,
        centerTitle: true,
        actions: [
          // Row(
          //   children: [
          //     MyText(
          //       text: title3,
          //       fontSize: 14,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(right: 15.0, left: 2),
          //       child: SvgPicture.asset(icon),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final String title2;
  final Function onTap;
  const Appbar(
      {Key? key,
      required this.onTap,
      this.icon = Icons.arrow_back_ios,
      this.title2 = ""})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: AppBar(
        backgroundColor: Colors.transparent, // Set a transparent background
        flexibleSpace: gradientColor(context), // Apply the gradient background
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: GestureDetector(
            onTap: () {
              onTap();
            },
            child: Icon(
              icon,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        title: MyText(
          text: title2,
        ),
        centerTitle: true,
      ),
    );
  }
}

class Appbar2 extends StatelessWidget implements PreferredSizeWidget {
  final IconData icon;
  final String title2;
  final String title;
  final Function onTap1;
  final Function onTap2;
  const Appbar2(
      {Key? key,
      required this.onTap1,
      required this.onTap2,
      this.icon = Icons.arrow_back_ios,
      this.title = "",
      this.title2 = ""})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: AppBar(
        backgroundColor: Colors.transparent, // Set a transparent background
        flexibleSpace: gradientColor(context), // Apply the gradient background
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: GestureDetector(
            onTap: () {
              onTap1();
            },
            child: Icon(
              icon,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, left: 2),
            child: GestureDetector(
              onTap: () {
                onTap2();
              },
              child: MyText(
                text: title,
                fontSize: 14,
              ),
            ),
          ),
        ],
        // leadingWidth: 20,
        title: MyText(
          text: title2,
        ),
        // backgroundColor: globalOrangeColors,
        centerTitle: true,
      ),
    );
  }
}

Widget gradientColor(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(AppColor.primaryColor.value),
          Color(AppColor.primaryColor.value),
        ],
      ),
    ),
  );
}
