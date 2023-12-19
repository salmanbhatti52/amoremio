import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class ResetPasswordController extends GetxController{

  RxBool isPasswordVisible= true.obs;
  RxBool isConfirmPasswordVisible= true.obs;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  passwordTap(){
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  confirmPasswordTap(){
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

}