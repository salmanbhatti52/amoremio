import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';


class ExploreController extends GetxController{

  RxBool status = false.obs;
  RxBool isButtonClicked = false.obs;
  RxBool showRoundedButton = false.obs;
  RxBool selectedIndex1 = true.obs;
  RxBool selectedIndex2 = false.obs;
  RxBool selectedIndex3 = false.obs;
  RxBool selectedIndex4 = false.obs;
  RxDouble value = 50.0.obs;
  TextEditingController currentAddress = TextEditingController();

  void toggleSwitch(bool newValue) {
    status.value = newValue;
  }

  void handleButtonTap() {
    isButtonClicked.value = !isButtonClicked.value;
    }
    void handleRoundedButtonTap() {
    isButtonClicked.value = !isButtonClicked.value;
    }

  void slider(double newValue) {
    value.value = newValue;
  }


}