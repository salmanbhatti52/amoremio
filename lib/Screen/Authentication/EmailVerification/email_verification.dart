import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'email_verification_controller.dart';
import '../../../Widgets/large_Button.dart';
import 'package:animate_do/animate_do.dart';
import '../ResetPassword/ResetPassword.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerify extends StatelessWidget {
   EmailVerify({Key? key}) : super(key: key);

   final EmailVerifyController verifyController = Get.put(EmailVerifyController());
   final formKey = GlobalKey<FormState>();

  final defaultPinTheme = PinTheme(
    width: 52,
    height: 46,
    textStyle: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColor.hintTextColor,
      fontWeight: FontWeight.w400,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: AppColor.whiteColor,
      boxShadow: const [
        BoxShadow(
          color: Color(0x19000000),
          blurRadius: 24,
          offset: Offset(0, 0),
          spreadRadius: 0,
        ),
      ]
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.07,
                ),
                FadeInLeft(
                  delay: const Duration(milliseconds: 300),
                  duration: const Duration(milliseconds: 400),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Get.width * 0.05,
                          right: Get.width * 0.15,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                      const MyText(
                        text: "Email Verification",
                        color: AppColor.blackColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                FadeInLeft(
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 500),
                  child: const MyText(
                    text: "Enter a 4 digit verification code we have\nsent on your email!",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.brownColor,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.18),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInLeft(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 600),
                          child: Pinput(
                            length: 4,
                            keyboardType: TextInputType.number,
                            closeKeyboardWhenCompleted: true,
                            controller: verifyController.pinController.value,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: defaultPinTheme,
                            submittedPinTheme: defaultPinTheme,
                            textInputAction: TextInputAction.done,
                            showCursor: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                FadeInLeft(
                  delay: const Duration(milliseconds: 600),
                  duration: const Duration(milliseconds: 700),
                  child: LargeButton(
                    width: Get.width * 0.84,
                    height: Get.height * 0.065,
                    text: "Verify",
                    onTap: () {
                      Get.to(
                            () => ResetPassword(),
                        duration: const Duration(milliseconds: 350),
                        transition: Transition.rightToLeft,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}