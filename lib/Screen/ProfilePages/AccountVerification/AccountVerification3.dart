import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'AccountVerifyBox.dart';
import 'AccountVerification4.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/large_Button.dart';
import 'dart:io';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

class AccountVerification3 extends StatefulWidget {
  final String imgUrl;
  const AccountVerification3({Key? key, required this.imgUrl,}) : super(key: key);

  @override
  State<AccountVerification3> createState() => _AccountVerification3State();
}

class _AccountVerification3State extends State<AccountVerification3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Appbar(
                title2: "ID verification",
                onTap: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const AccountVerifyBox(
                icon2: Icons.check,
                color1: Colors.transparent,
                color2: Colors.white,
                color3: Colors.transparent,
                color4: Colors.transparent,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              GestureDetector(
                onTap: () => _imagePick(),
                child: Container(
                  width: Get.width * 0.9,
                  height: Get.height * 0.29,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: _imageFile == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageAssets.imagePick),
                      const MyText(
                        text: "Drop Your File Here",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF232323),
                      ),
                    ],
                  )
                      : Stack(
                    children: [
                      Container(
                        width: Get.width * 0.9,
                        height: Get.height * 0.29,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF5F5F5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(_imageFile!.path),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: AppColor.whiteColor,),
                          onPressed: () => _clearImage(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const MyText(
                text: "Upload Your Back ID Image\nfor verification",
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              SizedBox(
                height: Get.height * 0.2,
              ),
              LargeButton(
                text: "Next",
                width: Get.width * 0.84,
                height: Get.height * 0.065,
                containerColor: AppColor.whiteColor,
                textColor: AppColor.secondaryColor,
                gradientColor1: AppColor.whiteColor,
                gradientColor2: AppColor.whiteColor,
                onTap: () {
                  if (base64Image != null && base64Image!.isNotEmpty) {
                    Get.to(
                          () => AccountVerification4(imgUrl: widget.imgUrl, imgUrl2: base64Image.toString(),),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 300),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please Upload Your Back ID Image"),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  CroppedFile? _imageFile;
  String? base64Image;
  Future<void> _imagePick() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedImage != null) {
      await _cropImage(pickedImage.path);
    }
  }

  Future<void> _cropImage(String imagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      maxWidth: 1800,
      maxHeight: 1800,
      cropStyle: CropStyle.rectangle,
      uiSettings: [
        AndroidUiSettings(
          initAspectRatio: CropAspectRatioPreset.ratio4x3,
          toolbarTitle: 'Upload',
          toolbarColor: AppColor.primaryColor,
          backgroundColor: AppColor.secondaryColor,
          showCropGrid: false,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          showActivitySheetOnDone: false,
          resetAspectRatioEnabled: false,
          title: 'Cropper',
          hidesNavigationBar: true,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _imageFile = croppedFile;
      });
      base64Image = await convertImageToBase64(_imageFile!.path);
      debugPrint("base64Image $base64Image");
    }
  }

  Future<String> convertImageToBase64(String imagePath) async {
    List<int> imageBytes = await File(imagePath).readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  void _clearImage() {
    setState(() {
      _imageFile = null;
      base64Image = null;
    });
  }

}
