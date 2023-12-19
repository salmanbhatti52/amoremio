import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../Resources/colors/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/assets/assets.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  // final VoidCallback onEditingComplete;
  final FocusNode? focusNode;
  final String hintText;
  final TextInputType keyboardType;
  final String prefixImage;
  final String suffixImage;
  final Color? suffixImageColor;
  final int? maxLine;
  final Function(String)? onChanged;
  final double? width;
  final double? height;
  final Function(String)? onFieldSubmitted;
  final dynamic Function()? suffixTap;
  final bool obscureText;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.suffixImageColor,
    this.maxLine,
    this.textInputAction = TextInputAction.next,
    // this.onEditingComplete = _onEditingComplete,
    required this.hintText,
    this.obscureText = false,
    this.height,
    this.width,
    this.keyboardType = TextInputType.text,
    this.prefixImage = ImageAssets.email,
    this.suffixImage = ImageAssets.whiteImage,
    this.onChanged,
    this.focusNode,
    this.onFieldSubmitted,
    this.suffixTap,
    this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        style: GoogleFonts.poppins(
        fontSize: 14,
        color: AppColor.hintTextColor,
        fontWeight: FontWeight.w400,
      ),
        obscureText: obscureText,
        maxLines: maxLine,
        textAlign: TextAlign.left,
        textInputAction: textInputAction,
        validator: validator,
        cursorColor: AppColor.hintTextColor,
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          fillColor: AppColor.whiteColor,
          filled: true,
          contentPadding:  EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: 10),
          hintText: hintText,
          prefixIcon:  IconButton( icon: SvgPicture.asset(prefixImage), onPressed: (){},),
          suffixIcon: IconButton(onPressed: suffixTap, icon: SvgPicture.asset(suffixImage, color: suffixImageColor, width: 25,)),
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColor.hintTextColor,
            fontWeight: FontWeight.w400,
          ),
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
        ),
      ),
    );
  }
}