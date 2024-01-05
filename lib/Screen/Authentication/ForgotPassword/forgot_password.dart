import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../Utills/AppUrls.dart';
import '../../../Widgets/TextFields.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Widgets/large_Button.dart';
import 'package:animate_do/animate_do.dart';
import '../../../Widgets/TextFieldLabel.dart';
import '../../../Resources/colors/colors.dart';
import '../EmailVerification/email_verification.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  void forgot() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    String apiUrl = forgotpass;

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {"email": emailController.text.toString()},
          ));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        Navigator.of(context).pop();
        Get.to(
          () => EmailVerify(),
          arguments: [
            {"email": emailController.text.toString()},
          ],
          duration: const Duration(milliseconds: 350),
          transition: Transition.rightToLeft,
        );
      } else {
        print(data['status']);
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
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
                        text: "Forgot Password",
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
                    text: "Enter your email for verification!",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.brownColor,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.1,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.08,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInLeft(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 600),
                          child: const LabelField(
                            text: 'Email',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 700),
                          child: CustomTextFormField(
                            controller: emailController,
                            hintText: "username@gmail.com",
                            keyboardType: TextInputType.emailAddress,
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
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 800),
                  child: LargeButton(
                    width: Get.width * 0.84,
                    height: Get.height * 0.065,
                    text: "Next",
                    onTap: () {
                      forgot();
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
