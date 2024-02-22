import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';


// required void Function() onCameraIconClick
Widget sendMessageTextFields(Key key, TextEditingController controller,
    {required void Function(String text) onSendMessage,
    required void Function() closekeyboard,
    required BuildContext context,
    required ScrollController scrollController,
    required void Function() onCameraIconClick,
    required GlobalKey<AnimatedListState> listKey,
    required bool isEmojiVisible,
    required void Function() toggleEmojiPicker,
    required void Function() pickWordOrPdfFile}) {
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
              onTap: toggleEmojiPicker,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SvgPicture.asset(ImageAssets.emoji),
              ),
            ),
            Expanded(
              child: TextField(
                onTap: closekeyboard,
                textAlign: TextAlign.left,
                controller: controller,
                onEditingComplete: () {
                  onSendMessage(controller.text ?? "");
                  controller.clear();
                  FocusScope.of(context).unfocus();
                  // This function will be called when the keyboard submit button is pressed

                  // Scroll to the bottom
                  scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
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
            GestureDetector(
              onTap: pickWordOrPdfFile,
              child: const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.attach_file_rounded,
                  color: Color(0xff706D6D),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5),
              child: GestureDetector(
                onTap: onCameraIconClick,
                child: const Icon(
                  Icons.photo_camera,
                  color: Color(0xff706D6D),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
