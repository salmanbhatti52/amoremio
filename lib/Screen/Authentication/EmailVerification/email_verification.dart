import 'dart:convert';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Widgets/large_Button.dart';
import 'package:animate_do/animate_do.dart';
import '../ResetPassword/ResetPassword.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utills/AppUrls.dart';
import 'package:http/http.dart' as http;

class EmailVerify extends StatefulWidget {
  EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  dynamic argumentData = Get.arguments;
  var email;
  final formKey = GlobalKey<FormState>();

  final TextEditingController pinController = TextEditingController();

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
        ]),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(argumentData[0]['email']);
    email = argumentData[0]['email'];
  }

  void verifyOtp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    String apiUrl = verifyCode;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {"email": email, "verify_code": pinController.text.toString()},
          ));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        Navigator.of(context).pop();
        Get.to(
          () => ResetPassword(),
          arguments: [
            {"email": email}
          ],
          duration: const Duration(milliseconds: 350),
          transition: Transition.rightToLeft,
        );
      } else {
        print(data['status']);
        var errormsg = data['message'];
        ScaffoldMessenger.of(context as BuildContext)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error');
    }
  }

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
                    text:
                        "Enter a 4 digit verification code we have\nsent on your email!",
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
                            controller: pinController,
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
                      verifyOtp();
                      // Get.to(
                      //   () => ResetPassword(),
                      //   duration: const Duration(milliseconds: 350),
                      //   transition: Transition.rightToLeft,
                      // );
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
