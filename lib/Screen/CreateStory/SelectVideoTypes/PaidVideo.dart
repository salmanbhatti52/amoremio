import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Widgets/large_Button.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PaidVideo extends StatelessWidget {
  final double height;
   PaidVideo({super.key, required this.height});

  List<String> priceSet = ["5 coins", "10 coins", "15 coins"];
  String? setPrice;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const MyText(text: "Your story is set to be Paid for everyone,  and you\ncan alter or retract it even after uploading.", fontSize: 14, fontWeight: FontWeight.w400,),
          Container(
            width: Get.width * 0.8,
            height: Get.height * 0.06,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: AppColor.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 24,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.hintTextColor,),
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        ImageAssets.healthicons,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColor.whiteColor,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        color: AppColor.redColor,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    hintText: 'Set Price',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColor.hintTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    errorStyle: const TextStyle(
                      color: AppColor.redColor,
                      fontSize: 10,
                      fontFamily: 'Inter-Bold',
                    ),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  items: priceSet
                      .map(
                        (item) => DropdownMenuItem<String>(
                      value: item,
                      onTap: setPrice = null,
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: setPrice != null
                              ? AppColor.hintTextColor
                              : AppColor.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  value: setPrice,
                  onChanged: (value) {
                    setPrice = value;
                  },
                ),
              ),
            ),
          ),
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
