import 'package:get/get.dart';
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

class AccountSettings extends StatefulWidget {
   AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

  bool isCurrentPasswordVisible= true;
  bool isNewPasswordVisible= true;
  bool isConfirmPasswordVisible= true;

  final  currentPasswordController = TextEditingController();
  final  newPasswordController     = TextEditingController();
  final  confirmPasswordController = TextEditingController();

  currentPasswordTap(){
    setState(() {
      isCurrentPasswordVisible = !isCurrentPasswordVisible;
    });
  }

  newPasswordTap(){
    setState(() {
      isNewPasswordVisible = !isNewPasswordVisible;
    });
  }

  confirmPasswordTap(){
    setState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
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
                          passwordChangeDilaoge()
                  );
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
                onTap: () {},
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
                onTap: () {},
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width * 0.9,
              height: Get.height * 0.58,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(text: "djksfdgfrgfk", fontSize: 5, fontWeight: FontWeight.w100, color: AppColor.whiteColor,),
                        const MyText(text: "Change Password", fontSize: 18, color: AppColor.blackColor,),
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
                            suffixImageColor: isCurrentPasswordVisible ? null : AppColor.primaryColor,
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
                            suffixImageColor: isNewPasswordVisible ? null : AppColor.primaryColor,
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
                            suffixImageColor: isConfirmPasswordVisible ? null : AppColor.primaryColor,
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
                      Get.back();
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
    );
  }
}
