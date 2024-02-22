import 'package:get/get.dart';
import 'AccountVerifyBox.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

class AccountVerification5 extends StatelessWidget {
  const AccountVerification5({Key? key}) : super(key: key);

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
                icon4: Icons.check,
                color1: Colors.transparent,
                color4: Colors.white,
                color3: Colors.transparent,
                color2: Colors.transparent,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              Container(
                width: Get.width * 0.9,
                height: Get.height * 0.29,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF5F5F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
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
                  showDialog(
                    context: context,
                    barrierColor: Colors.grey.withOpacity(0.9),
                    barrierDismissible: true,
                    builder: (BuildContext context) =>
                        FadeInUp(
                          child: Dialog(
                            backgroundColor: Colors.transparent,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: Get.width * 0.8,
                                  height: Get.height * 0.27,
                                  // width: 342,
                                  // height: 315,
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
                                            Get.back();
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
                  // Get.to(
                  //       () => const AccountVerification4(),
                  //   transition: Transition.rightToLeft,
                  //   duration: const Duration(milliseconds: 300),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
