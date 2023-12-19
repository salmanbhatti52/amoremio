import 'dart:math';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Resources/assets/assets.dart';
import 'package:auto_animated/auto_animated.dart';

// ignore: must_be_immutable
class ExploreVideoContainer extends StatelessWidget {
  final double height;
  final Function onTap;
  bool value = false;
  ExploreVideoContainer({Key? key, required this.height, required this.onTap, required this.value}) : super(key: key);

  final options = const LiveOptions(
    // Start animation after (default zero)
    delay: Duration(seconds: 0),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 200),

    // Animation duration (default 250)
    showItemDuration: Duration(milliseconds: 500),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );

  List<String> mainImages = [
    ImageAssets.exploreImage,
    ImageAssets.image1,
    ImageAssets.image2,
    ImageAssets.image3,
    ImageAssets.introImage,
    // Add more image assets as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LiveGrid.options(
        options: options,
        itemCount: 18,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.1,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        ),
        itemBuilder: (BuildContext context, int index, Animation<double> animation,) {
          String randomMainImage = mainImages[Random().nextInt(mainImages.length)];
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            // And slide transition
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              // Paste you Widget
              child: GestureDetector(
                onTap: (){
                  onTap();
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage(randomMainImage),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: Row(
                            children: [
                              SvgPicture.asset(ImageAssets.locationWhite),
                              const MyText(
                                text: "1.4 Km",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        // Positioned(
                        //   left: Get.width * 0.13,
                        //   top: Get.height * 0.09,
                        //   child: GestureDetector(
                        //     onTap: (){
                        //       onTap();
                        //     },
                        //     child: Container(
                        //       width: 36,
                        //       height: 36,
                        //       decoration: BoxDecoration(
                        //         color: const Color(0x51D9D9D9),
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //       child: const Icon(
                        //         Icons.play_arrow,
                        //         color: AppColor.whiteColor,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // if (value == true)
                        //   Positioned(
                        //     left: 5,
                        //     top: 5,
                        //     child: Row(
                        //       children: [
                        //         SvgPicture.asset(ImageAssets.live),
                        //         const SizedBox(
                        //           width: 3,
                        //         ),
                        //         const MyText(
                        //           text: "LIVE",
                        //           fontSize: 10,
                        //           color: AppColor.secondaryColor,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Image.asset(ImageAssets.smallPic),
                          const SizedBox(
                            width: 5,
                          ),
                          const MyText(
                            text: "Stephanie, 23",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

