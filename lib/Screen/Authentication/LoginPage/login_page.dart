import 'dart:convert';

import 'package:amoremio/Utills/AppUrls.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:animate_do/animate_do.dart';
import '../SocialLogin/SocialLoginPage.dart';
import '../../../Widgets/TextFieldLabel.dart';
import '../ForgotPassword/forgot_password.dart';
import 'package:amoremio/Widgets/TextFields.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Social_Button.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import '../../BottomNavigationBar/BottomNavigationBar.dart';
import 'package:amoremio/Screen/Authentication/SignupPage/SignUpPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  passwordTap() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void login() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    String apiUrl = logIn;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "email": emailController.text.toString(),
              "password": passwordController.text.toString()
            },
          ));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        Navigator.of(context).pop();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('users_data', data);
        prefs.setString('user', response.body);
        await prefs.setString(
            'users_customers_id', data['data']['users_customers_id']);
        if (formKey.currentState!.validate()) {
          Get.offAll(
            () => const MyBottomNavigationBar(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.rightToLeft,
          );
        }
      } else {
        Navigator.of(context).pop();
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      Navigator.of(context).pop();
      print('error');
    }
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
                FadeInDown(
                  delay: const Duration(milliseconds: 400),
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * 0.07,
                      bottom: Get.height * 0.02,
                    ),
                    child: const MyText(
                      text: "Login",
                      color: AppColor.blackColor,
                    ),
                  ),
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 500),
                  duration: const Duration(milliseconds: 600),
                  child: const MyText(
                    text: "Hello, Login to your account",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.brownColor,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.065,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.08,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInDown(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 700),
                          child: const LabelField(
                            text: 'Email',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 700),
                          duration: const Duration(milliseconds: 800),
                          child: CustomTextFormField(
                            controller: emailController,
                            hintText: "username@gmail.com",
                            keyboardType: TextInputType.emailAddress,
                            focusNode: focus1,
                            validator: null,
                            // validator: validateEmail,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus2);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 900),
                          child: const LabelField(
                            text: 'Password',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 900),
                          duration: const Duration(milliseconds: 1000),
                          child: CustomTextFormField(
                            controller: passwordController,
                            hintText: "********",
                            maxLine: isPasswordVisible ? 1 : null,
                            focusNode: focus2,
                            prefixImage: ImageAssets.password,
                            textInputAction: TextInputAction.done,
                            suffixImage: isPasswordVisible
                                ? ImageAssets.eyeOffImage
                                : ImageAssets.eyeOnImage,
                            suffixImageColor: isPasswordVisible
                                ? null
                                : AppColor.primaryColor,
                            suffixTap: () {
                              passwordTap();
                            },
                            obscureText: isPasswordVisible,
                            validator: null,
                            // validator: validatePassword,
                          ),
                        ),
                        FadeInDown(
                          delay: const Duration(milliseconds: 1000),
                          duration: const Duration(milliseconds: 1100),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Get.height * 0.02,
                                bottom: Get.height * 0.08),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const ForgotPassword(),
                                  duration: const Duration(milliseconds: 350),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: const Row(
                                children: [
                                  LabelField(
                                    text: 'Forgot Password?',
                                  ),
                                  LabelField(
                                    text: ' Reset',
                                    color: AppColor.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 1100),
                  duration: const Duration(milliseconds: 1200),
                  child: LargeButton(
                    width: Get.width * 0.84,
                    height: Get.height * 0.065,
                    text: "Login",
                    onTap: () {
                      login();
                    },
                  ),
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 1200),
                  duration: const Duration(milliseconds: 1300),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * 0.04,
                      bottom: Get.height * 0.035,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.28,
                          child: Container(
                            width: 146,
                            // width:  Get.width * 0.4,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: AppColor.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const MyText(
                          text: " OR  ",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.hintTextColor,
                        ),
                        Opacity(
                          opacity: 0.28,
                          child: Container(
                            width: 146,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: AppColor.hintTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 1300),
                  duration: const Duration(milliseconds: 1400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        text: "Google",
                        width: Get.width * 0.4,
                        height: Get.height * 0.045,
                        onTap: () {
                          Get.to(
                            () => const SocialLoginPage(),
                            duration: const Duration(milliseconds: 350),
                            transition: Transition.rightToLeft,
                          );
                        },
                        borderColor: AppColor.primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SocialButton(
                        text: "Facebook",
                        textColor: AppColor.facebookColor,
                        icon: ImageAssets.facebook,
                        width: Get.width * 0.4,
                        height: Get.height * 0.045,
                        onTap: () {
                          Get.to(
                            () => const SocialLoginPage(),
                            duration: const Duration(milliseconds: 350),
                            transition: Transition.rightToLeft,
                          );
                        },
                        borderColor: AppColor.facebookColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.07,
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 1400),
                  duration: const Duration(milliseconds: 1500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LabelField(
                        text: 'Don’t have an account?',
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => const SignUpPage(),
                            duration: const Duration(milliseconds: 350),
                            transition: Transition.downToUp,
                          );
                        },
                        child: const LabelField(
                          text: ' Sign Up',
                          color: AppColor.secondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
