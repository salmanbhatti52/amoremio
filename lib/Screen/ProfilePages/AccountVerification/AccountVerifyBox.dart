import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/colors/colors.dart';

class AccountVerifyBox extends StatelessWidget {
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final IconData icon4;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;
  const AccountVerifyBox({Key? key,
    this.icon1 = Icons.circle_outlined,
    this.icon2 = Icons.circle_outlined,
    this.icon3 = Icons.circle_outlined,
    this.icon4= Icons.circle_outlined,
    this.color1 = AppColor.whiteColor,
    this.color2 = AppColor.whiteColor,
    this.color3 = AppColor.whiteColor,
    this.color4 = AppColor.whiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              clipBehavior: Clip.antiAlias,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 0.80, color: Colors.white),
                ),
              ),
              child:  Center(
                child: Icon(
                  icon1,
                  color: color1,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: Get.width * 0.16,
              height: 1,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Container(
              width: 20,
              height: 20,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 0.80, color: Colors.white),
                ),
              ),
              child:  Center(
                child: Icon(
                  icon2,
                  color: color2,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: Get.width * 0.16,
              height: 1,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Container(
              width: 20,
              height: 20,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 0.80, color: Colors.white),
                ),
              ),
              child:  Center(
                child: Icon(
                  icon3,
                  color: color3,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: Get.width * 0.16,
              height: 1,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Container(
              width: 20,
              height: 20,
              decoration: const ShapeDecoration(
                shape: OvalBorder(
                  side: BorderSide(width: 0.80, color: Colors.white),
                ),
              ),
              child:  Center(
                child: Icon(
                  icon4,
                  color:color4,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          children: [
            SizedBox(width: Get.width * 0.11,),
            const MyText(text: "ID Front", fontSize: 7,),
            SizedBox(width: Get.width * 0.15,),
            const MyText(text: "ID Back", fontSize: 7,),
            SizedBox(width: Get.width * 0.15,),
            const MyText(text: "Selfie Pose", fontSize: 7,),
            SizedBox(width: Get.width * 0.1,),
            const MyText(text: "Selfie With Written", fontSize: 7,),
          ],
        ),
      ],
    );
  }
}

Widget buildIconContainer() {
  return Container(
    width: 20,
    height: 20,
    clipBehavior: Clip.antiAlias,
    decoration: const ShapeDecoration(
      shape: OvalBorder(
        side: BorderSide(width: 0.80, color: Colors.white),
      ),
    ),
    child: const Center(
      child: Icon(
        Icons.check,
        color: AppColor.whiteColor,
        size: 15,
      ),
    ),
  );
}