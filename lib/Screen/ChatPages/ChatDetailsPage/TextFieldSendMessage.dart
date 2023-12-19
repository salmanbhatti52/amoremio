import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget sendMessageTextFields(Key key, TextEditingController controller, ) {

  return Form(
    key: key,
    child: Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(31),
        ),
        child: Row(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SvgPicture.asset(ImageAssets.emoji),
              ),
            ),
            Expanded(
              child: TextField(
                textAlign: TextAlign.left,
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 10, bottom: 3),
                  hintText: "Type a message",
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFFA3A3A3),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  fillColor: const Color(0xFFA3A3A3),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.attach_file_rounded,
                color: Color(0xff706D6D),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, right: 5),
              child: Icon(
                Icons.photo_camera,
                color: Color(0xff706D6D),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}