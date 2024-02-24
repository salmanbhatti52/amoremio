import 'dart:convert';
import 'package:amoremio/Screen/BottomNavigationBar/BottomNavigationBar.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AccountVerifyBox.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../../../Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

class AccountVerification5 extends StatefulWidget {
  final String imgUrl3;
  final String imgUrl2;
  final String imgUrl;
  const AccountVerification5({
    Key? key,
    required this.imgUrl3,
    required this.imgUrl2,
    required this.imgUrl,
  }) : super(key: key);

  @override
  State<AccountVerification5> createState() => _AccountVerification5State();
}

class _AccountVerification5State extends State<AccountVerification5> {

  bool isLoading = false;
  Future<void> sendApiRequest() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('users_customers_id');
    String apiUrl = 'https://mio.eigix.net/apis/services/verify_profile';

    Map<String, dynamic> requestBody = {
      "users_customers_id": userId,
      "id_front": widget.imgUrl,
      "id_back": widget.imgUrl2,
      "selfie": widget.imgUrl3,
      "selfie_with_written": base64Image.toString(),
    };

    debugPrint(requestBody.toString());

    String encodedBody = jsonEncode(requestBody);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: encodedBody,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        debugPrint(jsonResponse['message']);
        showSuccessMessage();
        setState(() {
          isLoading = false;
        });
        Future.delayed(const Duration(seconds: 2), () {
          Get.to(
                () => const MyBottomNavigationBar(initialIndex: 4),
            duration: const Duration(milliseconds: 300),
            transition: Transition.downToUp,
          );
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      debugPrint('API request failed with status code ${response.statusCode}');
      debugPrint('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                icon4: Icons.check,
                color1: Colors.transparent,
                color4: Colors.white,
                color3: Colors.transparent,
                color2: Colors.transparent,
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
                                icon: const Icon(
                                  Icons.close,
                                  color: AppColor.whiteColor,
                                ),
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
                text: "Upload Your Selfie With Written Image\nfor verification",
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              SizedBox(
                height: Get.height * 0.2,
              ),
              LargeButton(
                text: "Verify Now",
                width: Get.width * 0.84,
                height: Get.height * 0.065,
                containerColor: AppColor.whiteColor,
                textColor: AppColor.secondaryColor,
                gradientColor1: AppColor.whiteColor,
                gradientColor2: AppColor.whiteColor,
                onTap: () {
                  if (base64Image != null && base64Image!.isNotEmpty) {
                    sendApiRequest();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please Upload Your Selfie With Written Image"),
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

  void showSuccessMessage() {
    showDialog(
      context: context,
      barrierColor: Colors.grey.withOpacity(0.9),
      barrierDismissible: true,
      builder: (BuildContext context) => FadeInUp(
        child: Dialog(
          backgroundColor: Colors.transparent,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width * 0.8,
                height: Get.height * 0.27,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 15.0, top: 15),
                          child: Icon(
                            Icons.clear,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                    SvgPicture.asset(ImageAssets.accountVerified),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                      child: Text(
                        "Your Account will be verified in\n24 hours Successfully!",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF008D7D),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
