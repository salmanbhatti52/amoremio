import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/TextFields.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Widgets/large_Button.dart';
import 'package:animate_do/animate_do.dart';
import '../../../Widgets/TextFieldLabel.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:amoremio/Screen/Authentication/LoginPage/login_page.dart';

// ignore: must_be_immutable
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible= true;
  bool isConfirmPasswordVisible= true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  passwordTap(){
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  confirmPasswordTap(){
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focus1 = FocusNode();
    FocusNode focus2 = FocusNode();
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
                        text: "Reset Password",
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
                    text: "Enter your new password to get started\nwith us!",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInLeft(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 600),
                          child: const LabelField(
                            text: 'New Password',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 700),
                          child: CustomTextFormField(
                              controller: passwordController,
                                  maxLine: isPasswordVisible ? 1 : null,
                                  suffixImageColor: isPasswordVisible ? null : AppColor.primaryColor,
                                  hintText: "********",
                              prefixImage: ImageAssets.password,
                              focusNode: focus1,
                                  onFieldSubmitted: (v){
                                    FocusScope.of(context).requestFocus(focus2);
                                  },
                                  suffixImage: isPasswordVisible
                                      ? ImageAssets.eyeOffImage
                                      : ImageAssets.eyeOnImage,
                                  suffixTap: () {
                                passwordTap();
                              },
                              obscureText: isPasswordVisible,
                            ),
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 700),
                          duration: const Duration(milliseconds: 800),
                          child: const LabelField(
                            text: 'Confirm New Password',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInLeft(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 900),
                          child: CustomTextFormField(
                              controller: confirmPasswordController,
                                  maxLine: isConfirmPasswordVisible ? 1 : null,
                                  hintText: "********",
                              prefixImage: ImageAssets.password,
                              focusNode: focus2,
                              textInputAction: TextInputAction.done,
                              suffixImage: isConfirmPasswordVisible
                                  ? ImageAssets.eyeOffImage
                                  : ImageAssets.eyeOnImage,
                                  suffixImageColor: isConfirmPasswordVisible ? null : AppColor.primaryColor,
                                  suffixTap: () {
                                confirmPasswordTap();
                              },
                              obscureText: isConfirmPasswordVisible,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.15,
                ),
                FadeInLeft(
                  delay: const Duration(milliseconds: 900),
                  duration: const Duration(milliseconds: 1000),
                  child: LargeButton(
                    width: Get.width * 0.84,
                    height: Get.height * 0.065,
                    text: "Reset",
                    onTap: () {
                      Get.to(
                            () => const LoginPage(),
                        duration: const Duration(milliseconds: 350),
                        transition: Transition.upToDown,
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