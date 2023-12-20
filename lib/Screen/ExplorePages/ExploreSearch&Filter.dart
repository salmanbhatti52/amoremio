import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:amoremio/Screen/ExplorePages/BlockedUser.dart';

// ignore: must_be_immutable
class ExploreSearch extends StatefulWidget {
  ExploreSearch({Key? key}) : super(key: key);

  @override
  State<ExploreSearch> createState() => _ExploreSearchState();
}

class _ExploreSearchState extends State<ExploreSearch> {

  final TextEditingController searchController = TextEditingController();
  List<String> genderType = ["Male", "Female", "Other"];
  String? selectedGender;
  double value = 50.0;

  void slider(double newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Get.width * 0.75,
          height: Get.height * 0.055,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.whiteColor,
          ),
          child: Center(
            child: TextField(
              autofocus: false,
              cursorColor: AppColor.hintTextColor,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColor.hintTextColor,
                fontWeight: FontWeight.w400,
              ),
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.03, vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.hintContainerColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColor.hintContainerColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 25,
                    color: AppColor.hintTextColor,
                  ),
                ),
                hintText: "Search",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColor.hintTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 5,),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              // barrierDismissible: false,
              builder: (BuildContext context) => FadeInDown(
                child: Dialog(
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    width: Get.width,
                    height: Get.height * 0.38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.03),
                        Container(
                          width: Get.width * 0.7,
                          height: Get.height * 0.055,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                icon: SvgPicture.asset(
                                  ImageAssets.edit,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      ImageAssets.gender,
                                      color: AppColor.blackColor,
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
                                      horizontal: 10, vertical: 10),
                                  hintText: 'Select Gender',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  errorStyle: const TextStyle(
                                    color: AppColor.redColor,
                                    fontSize: 10,
                                    fontFamily: 'Inter-Bold',
                                  ),
                                ),
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
                        SizedBox(height: Get.height * 0.03),
                        Container(
                          width: Get.width * 0.7,
                          height: Get.height * 0.055,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon: SvgPicture.asset(
                                  ImageAssets.locationBrown,
                                  color: AppColor.blackColor,
                                ),
                                onPressed: () {},
                              ),
                              suffixIcon: IconButton(
                                icon: SvgPicture.asset(
                                  ImageAssets.edit,
                                ),
                                onPressed: () {},
                              ),
                              hintText: "Location",
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
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
                              errorStyle: const TextStyle(
                                color: AppColor.redColor,
                                fontSize: 10,
                                fontFamily: 'Inter-Bold',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: MyText(
                                text: "Select Range",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.blackColor,
                              ),
                            ),
                            SfSlider(
                                min: 0.0,
                                max: 1000.0,
                                value: value, // Access the value with .value
                                interval: 50,
                                enableTooltip: true,
                                // shouldAlwaysShowTooltip: true,
                                inactiveColor: const Color(0xFFD9D9D9),
                                activeColor: AppColor.primaryColor,
                                minorTicksPerInterval: 1,
                                onChanged: (dynamic value) {
                                  slider(value);
                                },
                              ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                    text: "50 Km",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.blackColor,
                                  ),
                                  MyText(
                                    text: "1000 Km",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.blackColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.01),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              Get.to(()=> BlockedUser(), duration: Duration(milliseconds: 300), transition: Transition.leftToRight,);
                            },
                            child: const MyText(
                              text: "Blocked Users",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.secondaryColor,
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: Container(
            height: Get.height * 0.052,
            width: Get.width * 0.12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.27),
              color: AppColor.whiteColor,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1C000000),
                  blurRadius: 3.09,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Center(child: SvgPicture.asset(ImageAssets.filter)),
          ),
        ),
      ],
    );
  }
}
