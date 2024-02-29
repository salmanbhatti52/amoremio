import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
  final File fileType;
  final String sourceType;

  const SelectVideoType(
      {super.key, required this.fileType, required this.sourceType});

  @override
  State<SelectVideoType> createState() => _SelectVideoTypeState();
}

class _SelectVideoTypeState extends State<SelectVideoType>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? playerController;
  TabController? _tabController;
  File? selectedIMage;
  Uint8List? _image;
  String base64string = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if (widget.sourceType == 'Video') {
      print('File type ${widget.fileType}');
      selectedIMage = widget.fileType;
      _image = selectedIMage?.readAsBytesSync();
      base64string = base64.encode(_image as List<int>);
      // print('convert base64 $base64string');
      if (widget.fileType.existsSync()) {
        playerController = VideoPlayerController.file(widget.fileType)
          ..addListener(() => setState(() {}))
          ..setLooping(true)
          ..initialize().then((_) => playerController?.play());
      }
    } else {
      print('File type source image ${widget.fileType}');
      selectedIMage = widget.fileType;
      _image = selectedIMage?.readAsBytesSync();
      base64string = base64.encode(_image as List<int>);
      // print('convert base64 $base64string');
    }
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
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                      child: AspectRatio(
                        aspectRatio: playerController!.value.aspectRatio,
                        child: VideoPlayer(playerController!),
                      ),
                    )
                  : widget.sourceType == 'Image'
                      ? SizedBox(
                          height: Get.height * 0.5,
                          child: Image.file(widget.fileType))
                      : const SizedBox(),
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
              const SizedBox(
                height: 20,
              ),
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
                child: TabBarView(controller: _tabController, children: [
                  FreeVideo(
                      height: Get.height * 0.3,
                      base64Image: base64string,
                      sourceType: widget.sourceType,
                      onPauseVideo: () {
                        playerController
                            ?.pause();
                      }),
                  PaidVideo(
                      height: Get.height * 0.3,
                      base64Image: base64string,
                      sourceType: widget.sourceType,
                      onPauseVideo: () {
                        playerController
                            ?.pause();
                      }
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<String> convertVideoFileToBase64(String filePath) async {
    // Create a File instance from the path
    final File videoFile = File(filePath);

    // Read the video file as bytes
    final List<int> videoBytes = await videoFile.readAsBytes();

    // Convert the bytes to a Base64 string
    final String base64String = base64Encode(videoBytes);

    return base64String;
  }
}
