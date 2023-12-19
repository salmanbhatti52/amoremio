import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height * 0.9,
      decoration:  BoxDecoration(
        color: Colors.white.withOpacity(0.9 ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 12),
                  child: MyText(
                    text: "Comments",
                    color: AppColor.blackColor,
                    fontSize: 18,
                  ),
                ),
            ),
            SizedBox(
          height: Get.height * 0.42,
          child: ListView.builder(
            itemCount: 6,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return SizedBox(
                height: Get.height * 0.1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 22,),
                    Image.asset(ImageAssets.mediumImage, width: 30, height: 30,),
                    const SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyText(text: "Luna Mizamae", fontSize: 14, fontWeight: FontWeight.w500, color: AppColor.blackColor,),
                        const MyText(text: "The product is awesome", fontSize: 12, fontWeight: FontWeight.w500, color: AppColor.hintTextColor,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageAssets.favorite,width: 25, height: 25 , color: AppColor.hintTextColor,),
                          const SizedBox(width: 15,),
                          const Icon(Icons.reply, color: AppColor.hintTextColor, size: 20,),
                        ],
                      )
                      ],
                    ),
                    SizedBox(width: Get.width * 0.3,),
                    const MyText(text: "5min", fontSize: 10, fontWeight: FontWeight.w400, color: AppColor.hintTextColor,),
                  ],
                ),
              );
            },
          ),
        ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColor.hintTextColor,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  enabledBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.hintContainerColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.hintContainerColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  errorStyle: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColor.redColor,
                    fontWeight: FontWeight.bold,
                  ),
                  errorBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.redColor,),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedErrorBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.redColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                    contentPadding:  EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: 10),
                    prefixIcon:  IconButton( icon: const Icon(Icons.emoji_emotions_outlined, color: AppColor.brownColor,), onPressed: (){},),
                  hintText: "Add Comment......",
                  hintStyle:  GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColor.hintTextColor,
                  fontWeight: FontWeight.w400,
                ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
