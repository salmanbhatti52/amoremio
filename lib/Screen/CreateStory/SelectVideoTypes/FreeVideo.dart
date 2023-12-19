import 'package:flutter/cupertino.dart';
import '../../../Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/colors/colors.dart';

class FreeVideo extends StatelessWidget {
  final double height;
  const FreeVideo({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const MyText(text: "Your story is set to be free for everyone,  and you\ncan alter or retract it even after uploading.", fontSize: 14, fontWeight: FontWeight.w400,),
          LargeButton(
            text: "Upload",
            onTap: () {
              // _showBottomSheet();
            },
            containerColor: AppColor.whiteColor,
            gradientColor1: AppColor.whiteColor,
            gradientColor2: AppColor.whiteColor,
            borderColor: AppColor.whiteColor,
            textColor: AppColor.secondaryColor,
          ),
        ],
      ),
    );
  }
}
