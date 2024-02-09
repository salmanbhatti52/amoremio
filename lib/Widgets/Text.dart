import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign align;
  final FontStyle? style;
  final TextDecoration? textDecoration;
  final bool softWrap;
  final int? maxLines;
  final TextOverflow overflow;
  const MyText({
    super.key,
    required this.text,
    this.textDecoration,
    this.style,
    this.color = Colors.white,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w600,
    this.align = TextAlign.center,
    this.softWrap = true,
    this.maxLines = 2,
    this.overflow = TextOverflow.fade,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontStyle: style,
        decoration: textDecoration,
        decorationColor: Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: align,
      softWrap: softWrap,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
