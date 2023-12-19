import 'package:get/get.dart';

class ReferralsController extends GetxController{

  RxBool isTrue = false.obs;

  listShow(){
    isTrue.value = !isTrue.value;
  }

}