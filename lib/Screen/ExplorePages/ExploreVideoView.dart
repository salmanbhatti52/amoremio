import 'BlockedUser.dart';
import 'package:get/get.dart';
import 'ExploreUserAbout.dart';
import 'ExploreController.dart';
import 'package:flutter/material.dart';
import '../../Widgets/RoundedButton.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../../Widgets/background_Image_container.dart';
import 'package:amoremio/Resources/assets/assets.dart';

class ExploreVideoView extends StatefulWidget {
  const ExploreVideoView({Key? key}) : super(key: key);

  @override
  State<ExploreVideoView> createState() => _ExploreVideoViewState();
}

class _ExploreVideoViewState extends State<ExploreVideoView> with SingleTickerProviderStateMixin {

  late final AnimationController _animateController =
  AnimationController(duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);
  ExploreController exploreController = Get.put(ExploreController());

  @override
  void dispose() {
    super.dispose();
    _animateController.dispose();
  }

  final List<String> imgList = [
    ImageAssets.exploreImage,
    ImageAssets.image1,
    ImageAssets.image2,
    ImageAssets.image3,
    ImageAssets.introImage,
  ];

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {

    List<Widget> imageSliders = [];
    for (int index = 0; index < imgList.length; index++) {

      imageSliders.add(
        ImageContainer(
          imagePath: imgList[index],
          child: SizedBox(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // ImageContainer(
          //   child: Image.asset(image1 ? image2 ? ImageAssets.image2 : ImageAssets.introImage : ImageAssets.introImage),
          // ),
          CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: false,
                scrollPhysics: const ScrollPhysics(),
                disableCenter: false,
                enlargeCenterPage: false,
                viewportFraction: 0.999,
                aspectRatio: 2,
                animateToClosest: false,
                enableInfiniteScroll: false,
                height: double.infinity,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Positioned(
              bottom: Get.height * 0.315,
              left: Get.width * 0.355,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? AppColor.whiteColor
                          : Colors.white30,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.355,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: image1 ?  AppColor.whiteColor : Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.395,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: image2 ?  AppColor.whiteColor : Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.43,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.47,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.51,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.55,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: Colors.white30,
          //   ),
          // ),
          Positioned(
            bottom: Get.height * 0.23,
            left: Get.width * 0.06,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.introImage,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.23,
            left: Get.width * 0.24,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.image2,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.23,
            left: Get.width * 0.43,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.introImage,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.23,
            right: Get.width * 0.24,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.image3,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.23,
            right: Get.width * 0.06,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.exploreImage,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              // width: 172,
              height: Get.height * 0.22,
              decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(27),
                  topRight: Radius.circular(27),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      // if (exploreController.isButtonClicked.value) {
                        aboutExploreUser(context);
                      // }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.28),
                      child: Container(
                        height: 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xFFFFC3C3),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Get.width * 0.06,
                      top: Get.height * 0.02,
                      right: Get.width * 0.06,
                      bottom: Get.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(
                          text: "Lady Samurai, 21",
                          fontSize: 18,
                          color: AppColor.blackColor,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              ImageAssets.createStory1,
                              color: AppColor.secondaryColor,
                            ),
                            const MyText(
                              text: "2745",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColor.secondaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.06, bottom: Get.height * 0.02),
                    child: const Row(
                      children: [
                        // SvgPicture.asset(ImageAssets.locationWhite, color: AppColor.secondaryColor,),
                        Icon(
                          Icons.location_on,
                          color: AppColor.secondaryColor,
                          size: 17,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        MyText(
                          text: "Tokyo 2.5 Km",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xFF3B3B3B),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector( onTap : (){ Get.back(); },child: SvgPicture.asset(ImageAssets.explore2)),
                      RoundedButton(
                        onTap: () {
                          Get.to( () => BlockedUser(),
                            duration: const Duration(milliseconds: 350),
                            transition: Transition.downToUp,
                          );
                        },
                        icon: ImageAssets.block,
                      ),
                      Obx(
                        () => ScaleTransition(
                          scale: Tween(begin: 0.5, end: 1.0).animate(
                              CurvedAnimation(parent: _animateController, curve: Curves.easeOut)),
                          child: RoundedButton(
                            onTap: () {
                              exploreController.handleButtonTap();
                              _animateController
                                  .reverse()
                                  .then((value) => _animateController.forward());
                            },
                            icon: exploreController.isButtonClicked.value
                                ? ImageAssets.favorite
                                : ImageAssets.favorite,
                            imageColor: exploreController.isButtonClicked.value
                                ? AppColor.whiteColor
                                : AppColor.hintTextColor,
                            containerColor:
                                exploreController.isButtonClicked.value
                                    ? Colors.red
                                    : AppColor.whiteColor,
                          ),
                        ),
                      ),
                      SvgPicture.asset(ImageAssets.share),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
