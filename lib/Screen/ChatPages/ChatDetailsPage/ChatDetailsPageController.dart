import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

class ChatDetailsPageController extends GetxController{

  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  final sendMessageController = TextEditingController();

  RxInt selectedIndex = RxInt(-1);

  void selectContainer(int index) {
    selectedIndex.value = index;
  }
}