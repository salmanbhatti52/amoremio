import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amoremio/Resources/assets/assets.dart';


class RoundedButton extends StatelessWidget {
  final double width;
  final double height;
  final Color containerColor;
  final double borderSize;
  final Color borderColor;
  final Color? imageColor;
  final String icon;
  final Function onTap;
  const RoundedButton({
    Key? key,
    this.width = 73,
    this.height = 73,
    this.borderSize = 0,
    this.imageColor,
    this.borderColor = Colors.transparent,
    this.icon = ImageAssets.favorite,
    this.containerColor = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: borderSize,
            color: borderColor,
          ),
        ),
        child: Container(
            width: width,
            height: height,
            decoration: ShapeDecoration(
              color: containerColor,
              shape: const OvalBorder(),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 9.36,
                  offset: Offset(0, 4.68),
                  spreadRadius: 0,
                ),
              ]
            ),
            child: Center(
              child: SvgPicture.asset(icon , color: imageColor,),
            )
        ),
      ),
    );
  }
}

class RoundedImage extends StatelessWidget {
  final double width;
  final double height;
  final Color containerColor;
  final double borderSize;
  final Color borderColor;
  final String icon;
  final Function onTap;
  const RoundedImage({
    Key? key,
    this.width = 59,
    this.height = 59,
    this.borderSize = 0,
    this.borderColor = Colors.transparent,
    this.icon = ImageAssets.favorite,
    this.containerColor = Colors.white,
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
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: AssetImage(icon),
            fit: BoxFit.fill,
          ),
          shape: const OvalBorder(
            side: BorderSide(width: 2.07, color: Colors.white),
          ),
        ),
      )
    );
  }
}

class RoundedContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color containerColor;
  final double borderSize;
  final Color borderColor;
  final String icon;
  final Function onTap;
  const RoundedContainer({
    Key? key,
    this.width = 10,
    this.height = 10,
    this.borderSize = 0,
    this.borderColor = Colors.transparent,
    this.icon = ImageAssets.favorite,
    this.containerColor = Colors.white,
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
          decoration:BoxDecoration(
            color: containerColor,
            border: Border.all(
              width: borderSize,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
      ),
    );
  }
}
