import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/colors/colors.dart';


class SmallButton extends StatefulWidget {
  final double width;
  final double height;
  final Color containerColor;
  final double borderSize;
  final Color borderColor;
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign align;
  final Function onTap;
  const SmallButton({
    Key? key,
    this.width = 87,
    this.height = 28,
    this.containerColor = Colors.white,
    this.borderSize = 1,
    this.borderColor = Colors.transparent,
    required this.text,
    this.textColor = AppColor.hintTextColor,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.align = TextAlign.center,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SmallButton> createState() => _SmallButtonState();
}

class _SmallButtonState extends State<SmallButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.containerColor,
            border: Border.all(
              width: widget.borderSize,
              color: widget.borderColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              widget.text,
              textAlign: widget.align,
              style: GoogleFonts.nunito(
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
                color: widget.textColor,
              ),
            ),
          ),
      ),
    );
  }
}
