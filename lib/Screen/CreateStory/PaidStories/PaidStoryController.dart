// import 'package:amoremio/Resources/colors/colors.dart';
// import 'package:amoremio/Screen/CreateStory/SelectVideoTypes/SelectVideoType.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';
// import 'dart:io';
//
// import 'package:video_player/video_player.dart';
//
// class PaidStoryController extends GetxController {
//   Rx<CroppedFile?> imageFile = Rx<CroppedFile?>(null);
//
//   Future<void> imagePick() async {
//     final picker = ImagePicker();
//     XFile? pickedImage = await picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//     );
//     if (pickedImage != null) {
//       await cropImage(pickedImage.path);
//     }
//   }
//
//   Future<void> cropImage(String imagePath) async {
//     CroppedFile? croppedFile = await ImageCropper().cropImage(
//       sourcePath: imagePath,
//       maxWidth: 1800,
//       maxHeight: 1800,
//       cropStyle: CropStyle.rectangle,
//       uiSettings: [
//         AndroidUiSettings(
//           initAspectRatio: CropAspectRatioPreset.ratio4x3,
//           toolbarTitle: 'Upload',
//           toolbarColor: AppColor.primaryColor,
//           backgroundColor: AppColor.secondaryColor,
//           showCropGrid: false,
//           toolbarWidgetColor: Colors.white,
//           hideBottomControls: true,
//           lockAspectRatio: false,
//         ),
//         IOSUiSettings(
//           showActivitySheetOnDone: false,
//           resetAspectRatioEnabled: false,
//           title: 'Cropper',
//           hidesNavigationBar: true,
//         ),
//       ],
//     );
//
//     if (croppedFile != null) {
//       imageFile.value = croppedFile;
//     }
//   }
// }
