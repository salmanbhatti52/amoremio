import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AccountsSettingController extends GetxController {

  RxBool isCurrentPasswordVisible= true.obs;
  RxBool isNewPasswordVisible= true.obs;
  RxBool isConfirmPasswordVisible= true.obs;

  final  currentPasswordController = TextEditingController();
  final  newPasswordController     = TextEditingController();
  final  confirmPasswordController = TextEditingController();

  currentPasswordTap(){
    isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  }

  newPasswordTap(){
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  confirmPasswordTap(){
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

}