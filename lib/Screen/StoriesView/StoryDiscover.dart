import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../Resources/assets/assets.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Resources/colors/colors.dart';

class StoryDiscover extends StatelessWidget {
  final String selectedValue;
  final void Function(String?)? onChanged;

  const StoryDiscover({
    Key? key,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isDismissible: false,
          builder: (BuildContext context) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {Get.back();},
                ),
                buildBottomSheet(onChanged!),
              ],
            );
          },
        );
      },
      child: Container(
        width: Get.width * 0.24,
        padding: const EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          color: const Color(0x14EDEDED),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: selectedValue,
              fontSize: 12,
            ),
            const Icon(
              Icons.arrow_drop_down_sharp,
              color: AppColor.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBottomSheet(void Function(String?) onChanged) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      margin: const EdgeInsets.only(right: 17, bottom: 52),
      width: Get.width * 0.27,
      height: Get.height * 0.145,
      padding: const EdgeInsets.only(left: 3),
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13),
            bottomLeft: Radius.circular(13),
            bottomRight: Radius.circular(13),
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              onChanged("discover");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageAssets.discover,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 3,
                ),
                const MyText(
                  text: "Discover",
                  color: AppColor.blackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Color(0x7CDCDCDC),
            height: 0.34,
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              onChanged("matches");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageAssets.match,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 3,
                ),
                const MyText(
                  text: "Matches",
                  color: AppColor.blackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Color(0x7CDCDCDC),
            height: 0.34,
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              onChanged("liked");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  ImageAssets.liked,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 5,
                ),
                const MyText(
                  text: "Liked",
                  color: AppColor.blackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
