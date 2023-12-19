import 'package:get/get.dart';

class PaymentMethodController extends GetxController{

  RxBool status = true.obs;
  RxBool status2 = true.obs;

  void toggleSwitch(bool newValue) {
    status.value = newValue;
  }

  void toggleSwitch2(bool newValue) {
    status2.value = newValue;
  }

}