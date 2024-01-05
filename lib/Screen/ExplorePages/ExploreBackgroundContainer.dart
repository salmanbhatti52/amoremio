import 'package:flutter/material.dart';
import '../../Resources/colors/colors.dart';

class ExploreContainer extends StatelessWidget {
  final Widget child;
  final Color gradientColor1;
  final Color gradientColor2;
  const ExploreContainer({
    Key? key,
    required this.child,
    this.gradientColor1 = AppColor.primaryColor,
    this.gradientColor2 = AppColor.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(gradientColor1.value),
            Color(gradientColor2.value),
          ],
          begin: const Alignment(0.85, -0.53),
          end: const Alignment(-0.85, 0.53),
        ),
      ),
      child: child,
    );
  }
}
