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
  const ImageWithText({super.key,
    required this.imagePath,
    required this.text,
    required this.width,
    required this.height,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        onTap!();
      },
      child: Column(
        children: [
          SvgPicture.asset(imagePath, width: width, height: height, color: color,),
          MyText(text: text, fontSize: 12, fontWeight: FontWeight.w500, )
        ],
      ),
    );
  }
}
