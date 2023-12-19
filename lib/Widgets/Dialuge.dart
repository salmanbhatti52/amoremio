import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../Resources/assets/assets.dart';
import '../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
  final String image;
  final String image2;
  final double width;
  final double height;
  final String text;
  final String text2;
  final String text3;
  final Color color;
  const CustomDialog({Key? key,
    this.width = 350,
    this.height = 321,
    required this.text,
    required this.text2,
    required this.text3,
    this.color = Colors.white,
    this.image = ImageAssets.premium,
    this.image2 = ImageAssets.diamond,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    SvgPicture.asset(image),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 5.0, bottom: 20),
                        child: Icon(
                          Icons.clear,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                      color: AppColor.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  text2,
                  style: GoogleFonts.poppins(
                    color: AppColor.brownColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: Get.width * 0.64,
                  height: Get.height * 0.065,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        AppColor.primaryColor,
                        AppColor.secondaryColor,
                      ],
                      begin: Alignment(0.20, -0.98),
                      end: Alignment(-0.2, 0.98),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        image2,
                        width: 30,
                        height: 30,
                        color: color,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        text3,
                        style: GoogleFonts.poppins(
                          color: AppColor.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
