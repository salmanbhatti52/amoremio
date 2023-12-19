import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Widgets/AppBar.dart';
import 'package:flutter_svg/svg.dart';
import '../../Widgets/TextFields.dart';
import 'package:flutter/material.dart';
import '../../Widgets/large_Button.dart';
import '../../Widgets/TextFieldLabel.dart';
import '../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';

class WithdrawCoins extends StatelessWidget {
   WithdrawCoins({super.key});

  List<String> genderType = ["Master Card", "Visa", "PayPal"];
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Wallet Amount",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                width: Get.width * 0.87,
                height: Get.height * 0.42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(ImageAssets.yourCoins),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const MyText(
                      text: "Total Coins",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.hintTextColor,
                    ),
                    const MyText(
                      text: "10,000",
                      fontSize: 58,
                      fontWeight: FontWeight.w600,
                      color: AppColor.secondaryColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 137,
                          height: 60,
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(-0.06, -1.00),
                              end: Alignment(0.06, 1),
                              colors: [Color(0xFFDA9228), Color(0xFFEE4433)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.59),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                text: "01 Coins",
                                fontSize: 18,
                              ),
                              MyText(
                                text: "100 Dollars",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 137,
                          height: 60,
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(-0.06, -1.00),
                              end: Alignment(0.06, 1),
                              colors: [Color(0xFFDA9228), Color(0xFFEE4433)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.59),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                text: "01 Coins",
                                fontSize: 18,
                              ),
                              MyText(
                                text: "100 Dollars",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const MyText(
                      text: "Min Withdraw Must be 10 Dollars!",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const MyText(
                text: "Set Withdrawl Coins",
                fontSize: 18,
              ),
              const SizedBox(
                height: 25,
              ),
              const MyText(
                text: "20,000",
                fontSize: 94,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              LargeButton(
                text: "Withdraw Now",
                onTap: () {
                  showDialog(
                      context: context,
                      barrierColor: Colors.grey.withOpacity(0.9),
                      barrierDismissible: true,
                      builder: (BuildContext context) =>
                          withdrawCoinsDilaoge()
                  );
                },
                containerColor: AppColor.whiteColor,
                gradientColor1: AppColor.whiteColor,
                gradientColor2: AppColor.whiteColor,
                borderColor: AppColor.whiteColor,
                textColor: AppColor.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget withdrawCoinsDilaoge() {
    return FadeInDownBig(
      child: Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width * 0.9,
              height: Get.height * 0.5,
              // width: 342,
              // height: 315,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(text: "djksfdgfrgfk", fontSize: 5, fontWeight: FontWeight.w100, color: AppColor.whiteColor,),
                        const MyText(text: "Withdraw Amount", fontSize: 18, color: AppColor.blackColor,),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.clear,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LabelField(
                          text: 'Select Payment Method',
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
                                iconSize: 0,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 10.0), // Adjust the padding as needed
                                    child: SvgPicture.asset(
                                      ImageAssets.dropDown,
                                      color: AppColor.hintTextColor,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                      ImageAssets.payoneer,
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
                                  hintText: 'Payoneer',
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
                          text: 'Withdraw Amount',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextFormField(
                          controller: TextEditingController(text: ""),
                          hintText: "1,000 \$",
                          prefixImage: ImageAssets.moneyFill,
                          keyboardType: TextInputType.text,
                          validator: null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.07,
                  ),
                  LargeButton(
                    text: "Withdraw Now",
                    onTap: () {},
                    width: Get.width * 0.6,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
