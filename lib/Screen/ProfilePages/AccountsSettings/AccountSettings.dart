import 'package:get/get.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'AccountsSettingController.dart';
import '../../../Widgets/TextFields.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Widgets/large_Button.dart';
import '../../../Widgets/TextFieldLabel.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import '../../../Widgets/ProfileContainer.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

class AccountSettings extends StatelessWidget {
   AccountSettings({super.key});

   final AccountsSettingController settingController = Get.put(AccountsSettingController());

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
                        Obx(
                              () => CustomTextFormField(
                            controller: settingController.currentPasswordController,
                            hintText: "********",
                            maxLine: settingController.isCurrentPasswordVisible.value ? 1 : null,
                            // focusNode: focus2,
                            prefixImage: ImageAssets.password,
                            textInputAction: TextInputAction.done,
                            suffixImage: settingController.isCurrentPasswordVisible.value
                                ? ImageAssets.eyeOffImage
                                : ImageAssets.eyeOnImage,
                            suffixImageColor: settingController.isCurrentPasswordVisible.value ? null : AppColor.primaryColor,
                            suffixTap: () {
                              settingController.currentPasswordTap();
                            },
                            obscureText: settingController.isCurrentPasswordVisible.value,
                            validator: null,
                            // validator: validatePassword,
                          ),
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
                        Obx(
                              () => CustomTextFormField(
                            controller: settingController.newPasswordController,
                            hintText: "********",
                            maxLine: settingController.isNewPasswordVisible.value ? 1 : null,
                            // focusNode: focus2,
                            prefixImage: ImageAssets.password,
                            textInputAction: TextInputAction.done,
                            suffixImage: settingController.isNewPasswordVisible.value
                                ? ImageAssets.eyeOffImage
                                : ImageAssets.eyeOnImage,
                            suffixImageColor: settingController.isNewPasswordVisible.value ? null : AppColor.primaryColor,
                            suffixTap: () {
                              settingController.newPasswordTap();
                            },
                            obscureText: settingController.isNewPasswordVisible.value,
                            validator: null,
                            // validator: validatePassword,
                          ),
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
                        Obx(
                              () => CustomTextFormField(
                            controller: settingController.confirmPasswordController,
                            hintText: "********",
                            maxLine: settingController.isConfirmPasswordVisible.value ? 1 : null,
                            // focusNode: focus2,
                            prefixImage: ImageAssets.password,
                            textInputAction: TextInputAction.done,
                            suffixImage: settingController.isConfirmPasswordVisible.value
                                ? ImageAssets.eyeOffImage
                                : ImageAssets.eyeOnImage,
                            suffixImageColor: settingController.isConfirmPasswordVisible.value ? null : AppColor.primaryColor,
                            suffixTap: () {
                              settingController.confirmPasswordTap();
                            },
                            obscureText: settingController.isConfirmPasswordVisible.value,
                            validator: null,
                            // validator: validatePassword,
                          ),
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
