import 'package:get/get.dart';
import '../../Widgets/AppBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

class UpgradeAccount extends StatefulWidget {
  const UpgradeAccount({super.key});

  @override
  State<UpgradeAccount> createState() => _UpgradeAccountState();
}

class _UpgradeAccountState extends State<UpgradeAccount> {

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {

    List<Widget> imageSliders = [];
    for (int index = 0; index < imgList.length; index++) {
      bool isCurrent = _current == index;
      imageSliders.add(
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 167,
              height: 224,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.21),
                color: AppColor.whiteColor,
                border: Border.all(
                  width: isCurrent ? 4 : 0,
                  color: const Color(0xFF00A3FF),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const MyText(
                    text: "Featured 7",
                    color: AppColor.secondaryColor,
                    fontSize: 12,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 136.70,
                    height: 40.79,
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
                          text: "400 Coins",
                          fontSize: 18,
                        ),
                        MyText(
                          text: "For 7 Days",
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 5),
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor.blackColor,
                          ),
                        ),
                      ),
                      const MyText(
                        text: "Enhanced profile visibility",
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 5, top: 4),
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor.blackColor,
                          ),
                        ),
                      ),
                      const MyText(
                        text: "Stories with advanced\nvisibilitys",
                        color: AppColor.blackColor,
                        align: TextAlign.left,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 5, top: 4),
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor.blackColor,
                          ),
                        ),
                      ),
                      const MyText(
                        text: "Top placement in Chat\nTab",
                        color: AppColor.blackColor,
                        align: TextAlign.left,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -45.0,
              left: 0.0,
              right: 0.0,
              child: SvgPicture.asset(
                ImageAssets.orangeStar,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: Appbar(
        title2: "Upgrade",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 15,
            ),
            const MyText(
              text:
                  "Your Profile are seen 10x more than other profiles\nin every part of app!",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                ImageAssets.upgradeAc,
              ),
            ),
            SizedBox(
              height: Get.height * 0.08,
            ),
            CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: false,
                  reverse: false,
                  // enableInfiniteScroll: false,
                  viewportFraction: 0.5,
                  aspectRatio: 2,
                  enlargeCenterPage: false,
                  animateToClosest: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? AppColor.whiteColor
                          : Colors.white.withOpacity(0.23999999463558197),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: Get.height * 0.08,
            ),
            LargeButton(
              text: "Upgrade Now",
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
