import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utills/AppUrls.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/TextFields.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Widgets/large_Button.dart';
import '../../../Widgets/TextFieldLabel.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import '../../../Widgets/ProfileContainer.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';
import 'package:http/http.dart' as http;

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool isCurrentPasswordVisible = true;
  bool isNewPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  currentPasswordTap() {
    setState(() {
      isCurrentPasswordVisible = !isCurrentPasswordVisible;
    });
  }

  newPasswordTap() {
    setState(() {
      isNewPasswordVisible = !isNewPasswordVisible;
    });
  }

  confirmPasswordTap() {
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  void changepass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = changePassword;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
              "old_password": currentPasswordController.text,
              "password": newPasswordController.text,
              "confirm_password": confirmPasswordController.text
            },
          ));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        var msg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
        Get.back();
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

  /// deactivate ////
  @override
  void deactivate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = deactivateUser;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
            },
          ));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        var msg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
        Get.back();
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

  /// deleteaccount ////
  void deleteaccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = deleteUser;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
            },
          ));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        var msg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(msg)));
        Get.back();
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
      appBar: Appbar(
        title2: "Account Settings",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            FadeInLeft(
              animate: true,
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 600),
              child: ProfileContainer(
                text: 'Change Password',
                icon: ImageAssets.password,
                imageColor: const Color(0xff04B4FF),
                onTap: () {
                  showDialog(
                      context: context,
                      barrierColor: Colors.grey.withOpacity(0.9),
                      barrierDismissible: true,
                      builder: (BuildContext context) =>
                          passwordChangeDilaoge());
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            FadeInDown(
              animate: true,
              child: ProfileContainer(
                text: 'De-Activate Account',
                icon: ImageAssets.disable,
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.grey.withOpacity(0.9),
                    barrierDismissible: true,
                    builder: (BuildContext context) =>
                        deactivateAccountDialog(),
                  );
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            FadeInRight(
              animate: true,
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 600),
              child: ProfileContainer(
                text: 'Delete Account ',
                icon: ImageAssets.deleteAc,
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.grey.withOpacity(0.9),
                    barrierDismissible: true,
                    builder: (BuildContext context) => deleteAccountDialog(),
                  );
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordChangeDilaoge() {
    return FadeInUpBig(
      child: Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width * 0.9,
                height: Get.height * 0.65,
                // width: 342,
                // height: 315,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MyText(
                            text: "djksfdgfrg",
                            fontSize: 5,
                            fontWeight: FontWeight.w100,
                            color: AppColor.whiteColor,
                          ),
                          const MyText(
                            text: "Change Password",
                            fontSize: 18,
                            color: AppColor.blackColor,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.clear,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelField(
                            text: 'Current Password',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            controller: currentPasswordController,
                            hintText: "********",
                            maxLine: isCurrentPasswordVisible ? 1 : null,
                            // focusNode: focus2,
                            prefixImage: ImageAssets.password,
                            textInputAction: TextInputAction.done,
                            suffixImage: isCurrentPasswordVisible
                                ? ImageAssets.eyeOffImage
                                : ImageAssets.eyeOnImage,
                            suffixImageColor: isCurrentPasswordVisible
                                ? null
                                : AppColor.primaryColor,
                            suffixTap: () {
                              currentPasswordTap();
                            },
                            obscureText: isCurrentPasswordVisible,
                            validator: null,
                            // validator: validatePassword,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const LabelField(
                            text: 'New Password',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            controller: newPasswordController,
                            hintText: "********",
                            maxLine: isNewPasswordVisible ? 1 : null,
                            // focusNode: focus2,
                            prefixImage: ImageAssets.password,
                            textInputAction: TextInputAction.done,
                            suffixImage: isNewPasswordVisible
                                ? ImageAssets.eyeOffImage
                                : ImageAssets.eyeOnImage,
                            suffixImageColor: isNewPasswordVisible
                                ? null
                                : AppColor.primaryColor,
                            suffixTap: () {
                              newPasswordTap();
                            },
                            obscureText: isNewPasswordVisible,
                            validator: null,
                            // validator: validatePassword,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const LabelField(
                            text: 'Confirm New Password',
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            controller: confirmPasswordController,
                            hintText: "********",
                            maxLine: isConfirmPasswordVisible ? 1 : null,
                            // focusNode: focus2,
                            prefixImage: ImageAssets.password,
                            textInputAction: TextInputAction.done,
                            suffixImage: isConfirmPasswordVisible
                                ? ImageAssets.eyeOffImage
                                : ImageAssets.eyeOnImage,
                            suffixImageColor: isConfirmPasswordVisible
                                ? null
                                : AppColor.primaryColor,
                            suffixTap: () {
                              confirmPasswordTap();
                            },
                            obscureText: isConfirmPasswordVisible,
                            validator: null,
                            // validator: validatePassword,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.07,
                    ),
                    LargeButton(
                      text: "Save",
                      onTap: () {
                        changepass();
                      },
                      width: Get.width * 0.6,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget deactivateAccountDialog() {
    return FadeInUpBig(
      child: Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width * 0.9,
              height: Get.height * 0.35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(
                          text: "djksfdgfrg",
                          fontSize: 5,
                          fontWeight: FontWeight.w100,
                          color: AppColor.whiteColor,
                        ),
                        const MyText(
                          text: "Deactivate Account",
                          fontSize: 18,
                          color: AppColor.blackColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.clear,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  const MyText(
                      text: 'Are you sure you want to deactivate your account?',
                      fontSize: 18,
                      color: AppColor.blackColor),
                  const SizedBox(height: 20.0),
                  LargeButton(
                    text: "Deactivate",
                    onTap: () {
                      deactivate();
                    },
                    width: Get.width * 0.6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteAccountDialog() {
    return FadeInUpBig(
      child: Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width * 0.9,
              height: Get.height * 0.35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(
                          text: "djksfdgfrg",
                          fontSize: 5,
                          fontWeight: FontWeight.w100,
                          color: AppColor.whiteColor,
                        ),
                        const MyText(
                          text: "Delete Account",
                          fontSize: 18,
                          color: AppColor.blackColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.clear,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  const MyText(
                      text: 'Are you sure you want to delete your account?',
                      fontSize: 18,
                      color: AppColor.blackColor),
                  const SizedBox(height: 20.0),
                  LargeButton(
                    text: "Delete",
                    onTap: () {
                      deleteaccount();
                    },
                    width: Get.width * 0.6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
