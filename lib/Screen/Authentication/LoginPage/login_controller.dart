import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class LoginController extends GetxController{

  RxBool isPasswordVisible= true.obs;
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();


  passwordTap(){
    isPasswordVisible.value = !isPasswordVisible.value;
  }

}