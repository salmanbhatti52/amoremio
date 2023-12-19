import 'package:get/get.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Widgets/AppBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../Widgets/large_Button.dart';
import '../../Resources/colors/colors.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';

class EditAvatorProfile extends StatelessWidget {
  const EditAvatorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Edit Avatar",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(ImageAssets.exploreImage, width: 200, height: 200,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                    EdgeInsets.only(left: 25.0, top: 20, bottom: 10),
                    child: MyText(
                      text: "Album Photos (9)",
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(ImageAssets.image2),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(2),
                                decoration: const ShapeDecoration(
                                  color: AppColor.blackColor,
                                  shape: OvalBorder(),
                                ),
                                child: Center(child: SvgPicture.asset(ImageAssets.deleteAc),),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 3,),
                        Stack(
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(ImageAssets.image3),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(2),
                                decoration: const ShapeDecoration(
                                  color: AppColor.blackColor,
                                  shape: OvalBorder(),
                                ),
                                child: Center(child: SvgPicture.asset(ImageAssets.deleteAc),),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 3,),
                        Stack(
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(ImageAssets.image1),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(2),
                                decoration: const ShapeDecoration(
                                  color: AppColor.blackColor,
                                  shape: OvalBorder(),
                                ),
                                child: Center(child: SvgPicture.asset(ImageAssets.deleteAc),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: AppColor.hintTextColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 3,),
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: AppColor.hintTextColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 3,),
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: AppColor.hintTextColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: AppColor.hintTextColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 3,),
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: AppColor.hintTextColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 3,),
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: AppColor.hintTextColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              LargeButton(
                text: "Save",
                onTap: () {},
                containerColor: AppColor.whiteColor,
                gradientColor1: AppColor.whiteColor,
                gradientColor2: AppColor.whiteColor,
                borderColor: AppColor.whiteColor,
                textColor: AppColor.secondaryColor,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
