import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWithText extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final String text;
  final Color? color;
  final Function? onTap;

  const ImageWithText({
    Key? key, // Fix the key parameter
    required this.imagePath,
    required this.text,
    required this.width,
    required this.height,
    this.color,
    this.onTap,
  }) : super(key: key); // Use super(key: key) to pass the key to the super constructor

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call(); // Use ?.call() to invoke the callback if it's not null
      },
      child: Column(
        children: [
          SvgPicture.asset(imagePath, width: width, height: height, color: color),
          MyText(text: text, fontSize: 12, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }
}