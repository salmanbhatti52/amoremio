import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Resources/assets/assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileContainer extends StatelessWidget {
  final String icon;
  final String icon2;
  final Function onTap;
  final String text;
  final Color textColor;
  final Color? imageColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign align;
  const ProfileContainer({
    Key? key,
    required this.text,
    this.imageColor,
    this.textColor = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.align = TextAlign.center,
    this.icon2 = ImageAssets.backArrow,
    required this.onTap,
    this.icon = ImageAssets.google,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(icon,color: imageColor,),
                  SizedBox(width: Get.width * 0.02,),
                  Text(
                    text,
                    textAlign: align,
                    style: GoogleFonts.poppins(
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(icon2),
            ],
          ),
        ),
      ),
    );
  }
}
