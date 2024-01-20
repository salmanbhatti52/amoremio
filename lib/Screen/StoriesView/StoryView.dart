import 'package:get/get.dart';
import '../ExplorePages/BlockedUser.dart';
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
import 'package:video_player/video_player.dart';

class StoryView extends StatefulWidget {
  const StoryView({Key? key}) : super(key: key);

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  bool image1 = false;
  bool isButtonClicked = false;
  bool selectedIndex1 = true;
  bool selectedIndex2 = false;
  bool selectedIndex3 = false;

  late PageController _pageController;
  late List<VideoPlayerController> _videoControllers;
  final List<String> videos = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        'https://mio.eigix.net/uploads/stories/1704432707-testingvideo.mp4',
    'https://mio.eigix.net/uploads/stories/1704433425-testingvideo7.mp4',
  ];

  @override
  void initState() {
    _pageController = PageController();
    _videoControllers = videos.map((url) {
      var controller = VideoPlayerController.network(url);
      // Print statement for debugging
      // print(
      //     "Initializing controller for $url: ${controller.value.isInitialized}");
      return controller;
    }).toList();

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _videoControllers) {
      controller.pause().whenComplete(() {
        controller.seekTo(Duration.zero);
        controller.setVolume(0.0);
        controller.dispose();
      });
    }
    super.dispose();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dispose Method Called'),
          content: Text('The dispose method is called when leaving the page.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void handleButtonTap() {
    setState(() {
      isButtonClicked = !isButtonClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: videos.isNotEmpty
          ? Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FutureBuilder(
                      future: _videoControllers[index].initialize(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          _videoControllers[index].setLooping(true);
                          _videoControllers[index].play();
                          return Video(
                            key: Key(index.toString()),
                            videoController: _videoControllers[index],
                            onVideoPause: (bool) {},
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    );
                  },
                ),
                // Your overlay content
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Center(
                      //   child: GestureDetector(
                      //     onTap: () {},
                      //     child: Container(
                      //       padding: const EdgeInsets.all(5),
                      //       decoration: BoxDecoration(
                      //         color: const Color(0x51D9D9D9),
                      //         borderRadius: BorderRadius.circular(30),
                      //       ),
                      //       child: SvgPicture.asset(
                      //         ImageAssets.videoPlay,
                      //         fit: BoxFit.contain,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          children: [
                            ImageWithText(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BlockedUser()),
                                );
                              },
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
                            GestureDetector(
                                onTap: () {
                                  handleButtonTap();
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
                                        color: isButtonClicked
                                            ? Colors.red
                                            : AppColor.whiteColor,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          ImageAssets.favorite,
                                          color: isButtonClicked
                                              ? AppColor.whiteColor
                                              : AppColor.hintTextColor,
                                        ),
                                      ),
                                    ),
                                    MyText(
                                      text: isButtonClicked ? "Liked" : "Like",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 22.0, bottom: 10, right: 5),
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
                                  return buildBottomSheet();
                                },
                              );
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
              ],
            )
          : Center(
              // Display a placeholder or alternative content
              child: Text("No videos available"),
            ),
    );
  }
}

class Video extends StatefulWidget {
  final Key key;
  final VideoPlayerController videoController;
  final Function(bool) onVideoPause;

  Video({
    required this.key,
    required this.videoController,
    required this.onVideoPause,
  }) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.videoController.value.isPlaying) {
          widget.videoController.pause();
          widget.onVideoPause(true);
        } else {
          widget.videoController.play();
          widget.onVideoPause(false);
        }
      },
      child: AspectRatio(
        aspectRatio: widget.videoController.value.aspectRatio,
        child: VideoPlayer(widget.videoController),
      ),
    );
  }

  @override
  void dispose() {
    widget.videoController.dispose();
    super.dispose();
  }
}

// ImageContainer(
//   imagePath: image1 ? ImageAssets.exploreImage : ImageAssets.introImage,
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.end,
//     crossAxisAlignment: CrossAxisAlignment.end,
//     children: [
//       Center(
//         child: GestureDetector(
//           onTap: () {},
//           child: Container(
//             padding: const EdgeInsets.all(5),
//             decoration: BoxDecoration(
//               color: const Color(0x51D9D9D9),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: SvgPicture.asset(
//               ImageAssets.videoPlay,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(right: 8.0),
//         child: Column(
//           children: [
//             ImageWithText(
//               onTap: () {},
//               width: 30,
//               height: 30,
//               color: Colors.white,
//               imagePath: ImageAssets.createStory1,
//               text: "249",
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const ImageWithText(
//               width: 30,
//               height: 30,
//               color: Colors.white,
//               imagePath: ImageAssets.chat1,
//               text: "113",
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const ImageWithText(
//               width: 25,
//               height: 25,
//               color: Colors.white,
//               imagePath: ImageAssets.share,
//               text: "Share",
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             // Obx( () =>
//             //     ImageWithText(
//             //   onTap: (){
//             //     storyController.handleButtonTap();
//             //   },
//             //   width: 30,
//             //   height: 30,
//             //       color: storyController.isButtonClicked.value ? Colors.red : AppColor.hintTextColor,
//             //   imagePath: storyController.isButtonClicked.value ? ImageAssets.favorite : ImageAssets.favorite,
//             //   text: storyController.isButtonClicked.value ? "Liked" : "Like",
//             // ),
//             // ),
//             GestureDetector(
//                 onTap: () {
//                   handleButtonTap();
//                 },
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 35,
//                       height: 35,
//                       margin: const EdgeInsets.only(bottom: 3),
//                       padding: const EdgeInsets.all(5),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                         color: isButtonClicked
//                             ? Colors.red
//                             : AppColor.whiteColor,
//                       ),
//                       child: Center(
//                         child: SvgPicture.asset(
//                           ImageAssets.favorite,
//                           color: isButtonClicked
//                               ? AppColor.whiteColor
//                               : AppColor.hintTextColor,
//                         ),
//                       ),
//                     ),
//                     MyText(
//                       text: isButtonClicked ? "Liked" : "Like",
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     )
//                   ],
//                 )),
//             // Obx(
//             //       () => RoundedButton(
//             //         width: 35,
//             //     height: 35,
//             //     onTap: () {
//             //       storyController.handleButtonTap();
//             //     },
//             //     icon: storyController.isButtonClicked.value
//             //         ? ImageAssets.favorite
//             //         : ImageAssets.favorite,
//             //     imageColor: storyController.isButtonClicked.value
//             //         ? AppColor.whiteColor
//             //         : AppColor.hintTextColor,
//             //     containerColor:
//             //     storyController.isButtonClicked.value
//             //         ? Colors.red
//             //         : AppColor.whiteColor,
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//       Row(
//         children: [
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 22.0, bottom: 10, right: 5),
//                 child: RoundedImage(
//                   onTap: () {},
//                   width: 37,
//                   height: 37,
//                   borderSize: 0,
//                   containerColor: Colors.transparent,
//                   borderColor: Colors.transparent,
//                   icon: ImageAssets.smallPic,
//                 ),
//               ),
//               const MyText(
//                 text: "Anna, 24",
//                 fontWeight: FontWeight.w500,
//                 fontSize: 14,
//               ),
//             ],
//           ),
//           SizedBox(width: Get.width * 0.1),
//           StoryDiscover(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 barrierDismissible: true,
//                 barrierColor: Colors.transparent,
//                 builder: (BuildContext context) {
//                   return buildBottomSheet();
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           RoundedImage(
//             onTap: () {},
//             icon: ImageAssets.introImage,
//           ),
//           RoundedImage(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => const BuyStoryDialog(),
//               );
//             },
//             icon: ImageAssets.image2,
//           ),
//           RoundedImage(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => const BuyStory2Dialog(),
//               );
//             },
//             icon: ImageAssets.image3,
//           ),
//           RoundedImage(
//             onTap: () {
//               setState(() {
//                 image1 = !image1;
//               });
//             },
//             icon: ImageAssets.image1,
//           ),
//           RoundedImage(
//             onTap: () {},
//             icon: ImageAssets.mediumImage,
//           ),
//         ],
//       ),
//       SizedBox(
//         height: Get.height * 0.03,
//       ),
//     ],
//   ),
// ),
