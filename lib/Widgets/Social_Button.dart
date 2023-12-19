import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';


class SocialButton extends StatelessWidget {
  final double width;
  final double height;
  final Color containerColor;
  final double borderSize;
  final Color borderColor;
  final Color gradientColor1;
  final Color gradientColor2;
  final String text;
  final String icon;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign align;
  final Function onTap;
  const SocialButton({
    Key? key,
    this.width = 155,
    this.height = 39,
    this.icon = ImageAssets.google,
    this.containerColor = Colors.white,
    this.borderSize = 1,
    this.borderColor = Colors.transparent,
    this.gradientColor1 = Colors.transparent,
    this.gradientColor2 = Colors.transparent,
    required this.text,
    this.textColor = AppColor.googleColor,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w500,
    this.align = TextAlign.center,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            width: borderSize,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SvgPicture.asset(icon),
            ),
            Text(
              text,
              textAlign: align,
              style: GoogleFonts.nunito(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
