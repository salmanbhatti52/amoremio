import 'package:get/get.dart';

class StoryController extends GetxController{

  RxBool isButtonClicked = false.obs;
  RxBool selectedIndex1 = true.obs;
  RxBool selectedIndex2 = false.obs;
  RxBool selectedIndex3 = false.obs;

  void handleButtonTap() {
    isButtonClicked.value = !isButtonClicked.value;
  }

}