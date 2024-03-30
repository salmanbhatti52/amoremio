import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Screen/ExplorePages/ExploreBackgroundContainer.dart';
import 'package:amoremio/Widgets/AppBar.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Monetize extends StatefulWidget {
  const Monetize({super.key});

  @override
  State<Monetize> createState() => _MonetizeState();
}

class _MonetizeState extends State<Monetize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Monetizations",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(ImageAssets.yourCoins),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    const MyText(
                      text: "Earn money will interacting other users.",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.hintTextColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText(
                      text: "Monetize Chat",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    Container(
                      width: Get.width * 0.1,
                      height: Get.height * 0.05,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: Get.width * 0.95,
                  height: Get.height * 0.3,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          width: Get.width * 0.9,
                          height: Get.height * 0.1,
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                          child:  Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText(text: "General Messages", color: AppColor.blackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                                    MyText(text: "(Messages)", color: AppColor.blackColor, fontSize: 12, fontWeight: FontWeight.w400,),
                                  ],
                                ),
                                MyText(text: "10 Coins", color: AppColor.primaryColor, fontSize: 12, fontWeight: FontWeight.w400,),
                                LargeButton(text: "Active", onTap: (){}, width: Get.width * 0.2, height: Get.height * 0.04,)
                              ],
                            ),
                          ),
                        );
                      },
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText(
                      text: "Monetize Call",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    Container(
                      width: Get.width * 0.1,
                      height: Get.height * 0.05,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: Get.width * 0.95,
                  height: Get.height * 0.3,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        width: Get.width * 0.9,
                        height: Get.height * 0.1,
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                        child:  Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText(text: "General Messages", color: AppColor.blackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                                  MyText(text: "(Messages)", color: AppColor.blackColor, fontSize: 12, fontWeight: FontWeight.w400,),
                                ],
                              ),
                              MyText(text: "10 Coins", color: AppColor.primaryColor, fontSize: 12, fontWeight: FontWeight.w400,),
                              LargeButton(text: "Active", onTap: (){}, width: Get.width * 0.2, height: Get.height * 0.04,)
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
