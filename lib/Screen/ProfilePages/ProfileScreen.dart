import 'InterestTags.dart';
import 'package:get/get.dart';
import 'EditAvatorProfile.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Widgets/AppBar.dart';
import '../../Widgets/TextFields.dart';
import 'package:flutter/material.dart';
import '../../Widgets/Small_Button.dart';
import '../../Widgets/TextFieldLabel.dart';
import '../../Resources/assets/assets.dart';
import '../../Resources/colors/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  List<String> genderType = ["Male", "Female", "Other"];
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Profile",
        onTap: () {
          Get.back();
        },
      ),
      // resizeToAvoidBottomInset: false,
      body: ExploreContainer(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: Get.height * 0.09,
                    backgroundImage: Image.asset(ImageAssets.mediumImage).image,
                  ),
                  Positioned(
                    bottom: Get.height * 0.01,
                    right: 5,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(),
                      ),
                      child: Center(
                        child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const EditAvatorProfile(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 300),
                              );
                            },
                            child: SvgPicture.asset(ImageAssets.iconEdit)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const MyText(
                text: "Lubana Antique",
                fontSize: 22,
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageAssets.locationBrown,
                    color: AppColor.whiteColor,
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const MyText(
                    textDecoration: TextDecoration.underline,
                    text: "Sector 8, Los Angeles",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
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
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.08,
                  vertical: Get.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelField(
                      text: 'Bio',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      height: Get.height * 0.08,
                      maxLine: 2,
                      controller: TextEditingController(text: ""),
                      hintText:
                          "Sed ut perspiciatis unde omnis iste natus error sit volu accusantium",
                      prefixImage: ImageAssets.newspaper,
                      keyboardType: TextInputType.text,
                      validator: null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'User Name',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: TextEditingController(text: ""),
                      hintText: "Lubana Antique",
                      prefixImage: ImageAssets.user,
                      keyboardType: TextInputType.text,
                      validator: null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'Email',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: TextEditingController(text: ""),
                      hintText: "lubanaantique@gmail.com",
                      prefixImage: ImageAssets.email,
                      keyboardType: TextInputType.text,
                      validator: null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'Date of birth',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: TextEditingController(text: ""),
                      hintText: "Date of birth",
                      // focusNode: focus5,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      prefixImage: ImageAssets.birthDate,
                      suffixImage: ImageAssets.calendar,
                      suffixTap: () {
                        // _selectDate(context);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'Gender',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: Get.width * 0.84,
                      height: Get.height * 0.055,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 24,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            // icon: SvgPicture.asset(
                            //   ImageAssets.dropDown,
                            // ),
                            iconSize: 0,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(left: 10.0), // Adjust the padding as needed
                                child: SvgPicture.asset(
                                  ImageAssets.dropDown,
                                  // fit: BoxFit.fill,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  ImageAssets.gender,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColor.whiteColor,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide(
                                  color: AppColor.redColor,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              hintText: 'Select Gender',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColor.hintTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                              errorStyle: const TextStyle(
                                color: AppColor.redColor,
                                fontSize: 10,
                                fontFamily: 'Inter-Bold',
                              ),
                            ),
                            padding: const EdgeInsets.only(right: 5),
                            borderRadius: BorderRadius.circular(12),
                            items: genderType
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    onTap: selectedGender = null,
                                    child: Text(
                                      item,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: selectedGender != null
                                            ? AppColor.hintTextColor
                                            : AppColor.blackColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: selectedGender,
                            onChanged: (value) {
                              selectedGender = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LabelField(
                      text: 'Education',
                      color: AppColor.whiteColor,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomTextFormField(
                      controller: TextEditingController(text: ""),
                      hintText: "Graphic Designing",
                      prefixImage: ImageAssets.education,
                      keyboardType: TextInputType.text,
                      validator: null,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText(
                      text: "Interests",
                      fontSize: 18,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                              () => InterestTags(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: SvgPicture.asset(
                        ImageAssets.iconEdit,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallButton(
                      width: Get.width * 0.25,
                      height: Get.height * 0.033,
                      textColor: const Color(0xFFEE4433),
                      text: "Photography",
                      onTap: () {},
                    ),
                    SmallButton(
                      width: Get.width * 0.25,
                      height: Get.height * 0.033,
                      textColor: const Color(0xFFEE4433),
                      text: "Film Making",
                      onTap: () {},
                    ),
                    SmallButton(
                      width: Get.width * 0.25,
                      height: Get.height * 0.033,
                      textColor: const Color(0xFFEE4433),
                      text: "Video editing",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              LargeButton(
                text: "Save Changes",
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
