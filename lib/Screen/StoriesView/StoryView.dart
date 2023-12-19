import 'StoryController.dart';
import 'package:get/get.dart';
import 'StoryBuyDialouge.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Resources/assets/assets.dart';
import '../../Resources/colors/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amoremio/Widgets/ImagewithText.dart';
import 'package:amoremio/Widgets/RoundedButton.dart';
import 'package:amoremio/Screen/StoriesView/StoryDiscover.dart';
import 'package:amoremio/Widgets/background_Image_container.dart';

class StoryView extends StatefulWidget {
  const StoryView({Key? key}) : super(key: key);

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  StoryController storyController = Get.put(StoryController());

  bool image1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageContainer(
        imagePath: image1 ? ImageAssets.exploreImage : ImageAssets.introImage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0x51D9D9D9),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SvgPicture.asset(
                    ImageAssets.videoPlay,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                children: [
                  ImageWithText(
                    onTap: () {},
                    width: 30,
                    height: 30,
                    color: Colors.white,
                    imagePath: ImageAssets.createStory1,
                    text: "249",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ImageWithText(
                    width: 30,
                    height: 30,
                    color: Colors.white,
                    imagePath: ImageAssets.chat1,
                    text: "113",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ImageWithText(
                    width: 25,
                    height: 25,
                    color: Colors.white,
                    imagePath: ImageAssets.share,
                    text: "Share",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Obx( () =>
                  //     ImageWithText(
                  //   onTap: (){
                  //     storyController.handleButtonTap();
                  //   },
                  //   width: 30,
                  //   height: 30,
                  //       color: storyController.isButtonClicked.value ? Colors.red : AppColor.hintTextColor,
                  //   imagePath: storyController.isButtonClicked.value ? ImageAssets.favorite : ImageAssets.favorite,
                  //   text: storyController.isButtonClicked.value ? "Liked" : "Like",
                  // ),
                  // ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        storyController.handleButtonTap();
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            margin: const EdgeInsets.only(bottom: 3),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: storyController.isButtonClicked.value
                                  ? Colors.red
                                  : AppColor.whiteColor,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                ImageAssets.favorite,
                                color: storyController.isButtonClicked.value
                                    ? AppColor.whiteColor
                                    : AppColor.hintTextColor,
                              ),
                            ),
                          ),
                          MyText(text: storyController.isButtonClicked.value ? "Liked" : "Like", fontSize: 12, fontWeight: FontWeight.w500, )
                        ],
                      )
                    ),
                  ),
                  // Obx(
                  //       () => RoundedButton(
                  //         width: 35,
                  //     height: 35,
                  //     onTap: () {
                  //       storyController.handleButtonTap();
                  //     },
                  //     icon: storyController.isButtonClicked.value
                  //         ? ImageAssets.favorite
                  //         : ImageAssets.favorite,
                  //     imageColor: storyController.isButtonClicked.value
                  //         ? AppColor.whiteColor
                  //         : AppColor.hintTextColor,
                  //     containerColor:
                  //     storyController.isButtonClicked.value
                  //         ? Colors.red
                  //         : AppColor.whiteColor,
                  //   ),
                  // ),
                ],
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, bottom: 10, right: 5),
                      child: RoundedImage(
                        onTap: () {},
                        width: 37,
                        height: 37,
                        borderSize: 0,
                        containerColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        icon: ImageAssets.smallPic,
                      ),
                    ),
                    const MyText(
                      text: "Anna, 24",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ],
                ),
                SizedBox(width: Get.width * 0.1),
                StoryDiscover(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        // return Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: Container(
                        //     width: Get.width * 0.27,
                        //     height: Get.height * 0.17,
                        //     padding: const EdgeInsets.only(left: 3),
                        //     clipBehavior: Clip.antiAlias,
                        //     decoration: const ShapeDecoration(
                        //       color: Colors.white,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.only(
                        //           topLeft: Radius.circular(13),
                        //           bottomLeft: Radius.circular(13),
                        //           bottomRight: Radius.circular(13),
                        //         ),
                        //       ),
                        //     ),
                        //     // Customize the dialog background color
                        //     child: Column(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(top: 12),
                        //           child: Row(
                        //             children: [
                        //               SvgPicture.asset(ImageAssets.discover,),
                        //               const SizedBox(
                        //                 width: 6,
                        //               ),
                        //               const MyText(
                        //                 text: "Discover",
                        //                 color: AppColor.blackColor,
                        //                 fontSize: 8,
                        //                 fontWeight: FontWeight.w400,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                        return buildBottomSheet();
                      },
                    );
                    // Get.bottomSheet(
                    //   buildBottomSheet(),
                    //   barrierColor: Colors.black.withOpacity(0.5),
                    //   backgroundColor: Colors.white.withOpacity(0.7),
                    // );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedImage(
                  onTap: () {},
                  icon: ImageAssets.introImage,
                ),
                RoundedImage(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const BuyStoryDialog(),
                    );
                  },
                  icon: ImageAssets.image2,
                ),
                RoundedImage(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const BuyStory2Dialog(),
                    );
                  },
                  icon: ImageAssets.image3,
                ),
                RoundedImage(
                  onTap: () {
                    setState(() {
                      image1 = !image1;
                    });
                  },
                  icon: ImageAssets.image1,
                ),
                RoundedImage(
                  onTap: () {},
                  icon: ImageAssets.mediumImage,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
