import 'package:flutter/material.dart';
import '../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeButton extends StatelessWidget {
  final double width;
  final double height;
  final Color containerColor;
  final double borderSize;
  final Color borderColor;
  final Color gradientColor1;
  final Color gradientColor2;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign align;
  final Function onTap;
  const LargeButton({
    Key? key,
    this.width = 330,
    this.height = 54,
    this.containerColor = Colors.transparent,
    this.borderSize = 0,
    this.borderColor = Colors.transparent,
    this.gradientColor1 = AppColor.primaryColor,
    this.gradientColor2 = AppColor.secondaryColor,
    required this.text,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
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
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            width: borderSize,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Color(gradientColor1.value),
              Color(gradientColor2.value),
            ],
            begin:  Alignment.center,
            end:  Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: align,
            style: GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
