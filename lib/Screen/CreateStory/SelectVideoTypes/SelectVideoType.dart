import 'dart:io';
import 'package:get/get.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:amoremio/Screen/CreateStory/SelectVideoTypes/FreeVideo.dart';
import 'package:amoremio/Screen/CreateStory/SelectVideoTypes/PaidVideo.dart';
import 'package:amoremio/Screen/ExplorePages/ExploreBackgroundContainer.dart';

class SelectVideoType extends StatefulWidget {
  final File videoFile;
  SelectVideoType({super.key, required this.videoFile});

  @override
  State<SelectVideoType> createState() => _SelectVideoTypeState();
}

class _SelectVideoTypeState extends State<SelectVideoType> with SingleTickerProviderStateMixin  {
  VideoPlayerController? playerController;
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // if (widget.videoFile.existsSync()) {
    //   playerController = VideoPlayerController.file(widget.videoFile)
    //     ..addListener(() => setState(() {}))
    //     ..setLooping(true)
    //     ..initialize().then((_) => playerController?.play());
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: Column(
          children: [
            Appbar(
              onTap: () {
                Get.back();
              },
              title2: "Upload",
            ),
            playerController != null && playerController!.value.isInitialized
                ? Container(
                    // height: 391,
                    height: Get.height * 0.5,
                    // width: 259,
                    width: Get.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // child: AspectRatio(
                    //   aspectRatio: playerController!.value.aspectRatio,
                    //   child: VideoPlayer(playerController!),
                    // ),
                  )
                : SizedBox(
                    height: Get.height * 0.5,
                  ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: MyText(
                    text: "Select Your Video Type",
                    fontSize: 18,
                  ),
                ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: Get.width * 0.55,
              height: Get.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white.withOpacity(0.5),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColor.secondaryColor,
                unselectedLabelColor: AppColor.whiteColor,
                labelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                indicatorColor: AppColor.primaryColor,
                dividerColor: AppColor.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                tabs: const [
                  Tab(
                    text: "Free",
                  ),
                  Tab(
                    text: "Paid ",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children:  [
                    FreeVideo(height: Get.height * 0.3),
                    PaidVideo(height: Get.height * 0.3),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
