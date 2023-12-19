import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter/material.dart';
import '../Resources/colors/colors.dart';

class DividerOR extends StatelessWidget {
  const DividerOR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0.28,
          child: Container(
            width: 146,
            // width:  Get.width * 0.4,
            decoration: const  ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: AppColor.hintTextColor,
                ),
              ),
            ),
          ),
        ),
        const MyText(
          text: " OR  ",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColor.hintTextColor,
        ),
        Opacity(
          opacity: 0.28,
          child: Container(
            width: 146,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: AppColor.hintTextColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
