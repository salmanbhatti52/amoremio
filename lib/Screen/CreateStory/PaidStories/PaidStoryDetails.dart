import 'package:get/get.dart';
import 'PaidCommentSheet.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Widgets/ImagewithText.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:amoremio/Widgets/large_Button.dart';


class PaidStoryDetails extends StatefulWidget {
  const PaidStoryDetails({super.key});

  @override
  State<PaidStoryDetails> createState() => _PaidStoryDetailsState();
}

class _PaidStoryDetailsState extends State<PaidStoryDetails> {
  late VideoPlayerController _videoPlayerController;
  late bool _isPlaying;

  @override
  void initState() {
    super.initState();
    // _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
    //     "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"))
    //   ..addListener(() => setState(() {}))..setLooping(true)
    //   ..initialize().then((_) => _videoPlayerController.play());
    // _isPlaying = true; // Auto-play the video
  }

  // @override
  // void dispose() {
  //   _videoPlayerController.dispose();
  //   super.dispose();
  // }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(ImageAssets.introImage, fit: BoxFit.cover, width: double.infinity),
          // _videoPlayerController.value.isInitialized
          // ? AspectRatio(
          //   aspectRatio: _videoPlayerController.value.aspectRatio,
          //   child: VideoPlayer(_videoPlayerController),)
          // : const Center(child: CircularProgressIndicator(),),
           Positioned(
            right: 30,
            top: 50,
            child: GestureDetector(
              onTap: (){
                Get.back();
              },
              child: const Icon(
                Icons.clear_rounded,
                color: AppColor.whiteColor,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 30,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return deleteDialoge();
                  },
                );
              },
              child: Row(
                children: [
                  const MyText(
                    text: "10 Coins",
                    fontSize: 18,
                  ),
                  SvgPicture.asset(
                    ImageAssets.dropBlack,
                    color: AppColor.whiteColor,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.44,
            left: Get.width * 0.42,
            child: GestureDetector(
              onTap: _togglePlayPause,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0x51D9D9D9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SvgPicture.asset(
                  ImageAssets.videoPlay,
                  // width: 30,
                  // height: 30,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: Get.height * 0.4,
            right: 20,
            child: Column(
              children: [
                const Column(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: AppColor.whiteColor,
                      size: 30,
                    ),
                    MyText(
                      text: "500",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ImageWithText(
                  onTap: () {},
                  width: 30,
                  height: 30,
                  color: Colors.white,
                  imagePath: ImageAssets.createStory1,
                  text: "249",
                ),
                const SizedBox(
                  height: 20,
                ),
                ImageWithText(
                  width: 30,
                  height: 30,
                  color: Colors.white,
                  imagePath: ImageAssets.chat1,
                  text: "113",
                  onTap: (){
                    Get.bottomSheet(
                      const CommentSheet(),
                      barrierColor: Colors.black.withOpacity(0.5),
                      backgroundColor: Colors.transparent,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const ImageWithText(
                  width: 25,
                  height: 25,
                  color: Colors.white,
                  imagePath: ImageAssets.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget deleteDialoge() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding:
            EdgeInsets.only(top: Get.height * 0.07, left: Get.width * 0.08),
        child: GestureDetector(
          onTap: (){
            showDialog(
                context: context,
                barrierColor: Colors.white60,
                barrierDismissible: true,
                builder: (BuildContext context) =>
                    deleteDg()
            );
          },
          child: Container(
            // width: Get.width * 0.27,
            // height: Get.height * 0.17,
            width: 112,
            height: 30,
            padding: const EdgeInsets.only(top: 6, left: 3, right: 6, bottom: 6),
            color: AppColor.whiteColor,
            child: Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.delete,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 3,
                ),
                const MyText(
                  text: "Delete",
                  color: AppColor.blackColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteDg(){
    return FadeInLeftBig(
      delay: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 400),
      child: Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width * 0.8,
              height: Get.height * 0.4,
              // width: 342,
              // height: 315,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 15.0, top: 15),
                        child: Icon(
                          Icons.clear,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                  ),
                  SvgPicture.asset(ImageAssets.delete),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                    child: Text(
                      "Are You Sure ?",
                      style: GoogleFonts.poppins(
                        color: AppColor.secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Are you sure about deleting this story? Retrieval won't be possible once it's gone.",
                      style: GoogleFonts.poppins(
                        color: AppColor.brownColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  LargeButton(text: "Yes", onTap: (){Get.back();}, width: Get.width * 0.7,),
                  const SizedBox(
                    height: 10,
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
