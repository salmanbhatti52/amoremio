import 'CardAdd.dart';
import 'package:get/get.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Widgets/AppBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../Widgets/large_Button.dart';
import '../../Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';

class CoinsShop extends StatelessWidget {
  const CoinsShop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Shop",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Image.asset(ImageAssets.yourCoins),
              ),
              const SizedBox(
                height: 10,
              ),
              const MyText(
                text: "The bigger the package, the cheaper the coins.",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: Get.height * 0.69,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const MyText(
                      text: "Coin Packages",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: Get.height * 0.45,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                          ),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                      () => const CardAdd(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 300),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 149,
                                    height: 154,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFEDEDED),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 31,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                color: AppColor.secondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const MyText(
                                                text: "+150",
                                                fontSize: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const MyText(
                                          text: "Big 750",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.secondaryColor,
                                        ),
                                        SvgPicture.asset(
                                          ImageAssets.buyCoins,
                                          color: const Color(0xffFC9C07),
                                          width: 50,
                                          height: 50,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8.0),
                                          child: MyText(
                                            text: "300 Coins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                        LargeButton(
                                          text: "\$ 10.999",
                                          onTap: () {},
                                          width: Get.width * 0.34,
                                          height: Get.height * 0.03,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
