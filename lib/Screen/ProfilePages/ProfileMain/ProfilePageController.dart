import 'package:get/get.dart';

class ProfilePageController extends GetxController{

  RxBool status = false.obs;

  void toggleSwitch(bool newValue) {
    status.value = newValue;
  }

}