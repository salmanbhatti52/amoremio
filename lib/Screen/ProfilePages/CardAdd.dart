import 'package:get/get.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Widgets/AppBar.dart';
import '../../Widgets/TextFields.dart';
import 'package:flutter/material.dart';
import '../../Widgets/large_Button.dart';
import '../../Widgets/TextFieldLabel.dart';
import '../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';

class CardAdd extends StatelessWidget {
  const CardAdd({super.key});

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Appbar(
        title2: "Checkout",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              const Positioned(
                top: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: MyText(
                      text: "Payments Method",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 32,
                        padding: const EdgeInsets.all(4),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Image.asset(ImageAssets.visa),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 32,
                        padding: const EdgeInsets.all(4),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Image.asset(
                          ImageAssets.master,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 32,
                        padding: const EdgeInsets.all(4),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Image.asset(
                          ImageAssets.paypal,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 60,
                        height: 32,
                        padding: const EdgeInsets.all(4),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Image.asset(
                          ImageAssets.american,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child:  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.15,),
                        const MyText(text: "Add Card", fontSize: 14, color: AppColor.blackColor,),
                        const SizedBox(height:2),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColor.whiteColor,
                          ),
                          child: const Icon(Icons.add, size: 15, color: AppColor.blackColor,),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LabelField(
                                text: 'User Name',
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              CustomTextFormField(
                                controller: TextEditingController(text: ""),
                                hintText: "Akodes",
                                prefixImage: ImageAssets.user,
                                keyboardType: TextInputType.text,
                                validator: null,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const LabelField(
                                text: 'Card Number',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomTextFormField(
                                controller: TextEditingController(text: ""),
                                hintText: "1234-3212-4532-1111",
                                prefixImage: ImageAssets.cardAdd,
                                keyboardType: TextInputType.text,
                                validator: null,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const LabelField(
                                    text: 'Expiry Date',
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  CustomTextFormField(
                                    width: Get.width * 0.43,
                                    controller: TextEditingController(text: ""),
                                    hintText: "MM/YY",
                                    prefixImage: ImageAssets.calendarDate,
                                    keyboardType: TextInputType.text,
                                    validator: null,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const LabelField(
                                    text: 'Expiry Date',
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  CustomTextFormField(
                                    width: Get.width * 0.43,
                                    controller: TextEditingController(text: ""),
                                    hintText: "CVV",
                                    prefixImage: ImageAssets.cardAdd,
                                    keyboardType: TextInputType.text,
                                    validator: null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.045,
                        ),
                        LargeButton(
                          text: "Pay Now",
                          onTap: () {},
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !isKeyboardVisible,
                child: Positioned(
                  top: 130,
                  left: 20,
                  right: 20,
                  child: Container(
                    width: Get.width * 0.8,
                    height: 200,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.86, -0.51),
                        end: Alignment(-0.86, 0.51),
                        colors: [Color(0xFFFFEFEF), Color(0xFFFFAFAF)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 24,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                ImageAssets.visa,
                                width: 69,
                                height: 21,
                              ),
                              Image.asset(
                                ImageAssets.sim,
                                width: 34,
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '3598',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.puritan(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              Text(
                                '2345',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.puritan(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              Text(
                                '5685',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.puritan(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              Text(
                                '2479',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.puritan(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: "Card Holder",
                                style: FontStyle.italic,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.blackColor,
                              ),
                              MyText(
                                text: "Valid Thru",
                                style: FontStyle.italic,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColor.blackColor,
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: "AmoreMio",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColor.blackColor,
                              ),
                              MyText(
                                text: "12/28",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColor.blackColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
