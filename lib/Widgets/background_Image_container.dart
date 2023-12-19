import 'package:flutter/material.dart';
import '../Resources/assets/assets.dart';

class ImageContainer extends StatelessWidget {
  final Widget child;
  final String imagePath;
  final ColorFilter? colorFilter;
  const ImageContainer({Key? key, required this.child, this.colorFilter, this.imagePath = ImageAssets.introImage,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.fill,
          colorFilter: colorFilter,
          alignment: Alignment.bottomLeft,
        ),
      ),
      child: child,
    );
  }
}
