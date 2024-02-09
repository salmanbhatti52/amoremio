import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import 'package:amoremio/Screen/ExplorePages/ExploreBackgroundContainer.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../../Widgets/large_Button.dart';
import 'SelectVideoType.dart';

class Trimvideo extends StatefulWidget {
  final File videoFile;
  const Trimvideo({Key? key, required this.videoFile}) : super(key: key);

  @override
  State<Trimvideo> createState() => _TrimvideoState();
}

class _TrimvideoState extends State<Trimvideo>
    with SingleTickerProviderStateMixin {
  final Trimmer _trimmer = Trimmer();
  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;
  dynamic videotrimpath;
  VideoPlayerController? playerController;

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.videoFile);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVideo();
  }

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    final Completer<String?> completer = Completer<String?>();

    // Assuming saveTrimmedVideo does not return a value but uses the onSave callback.
    _trimmer.saveTrimmedVideo(
      startValue: _startValue,
      endValue: _endValue,
      onSave: (String? outputPath) {
        if (!completer.isCompleted) {
          completer.complete(
              outputPath); // Complete the completer with the output path.
        }
      },
    );

    completer.future.then((value) {
      // This will be executed once the completer is completed in onSave callback.
      setState(() {
        _progressVisibility = false;
      });
    }).catchError((error) {
      // Handle any errors here
      setState(() {
        _progressVisibility = false;
      });
    });

    return completer
        .future; // This will eventually return the output path or null.
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    const MyText(
                      text: "Upload",
                    ),
                    GestureDetector(
                      onTap: () {
                        savetrimvideo();
                      },
                      child: const Icon(
                        Icons.check,
                        color: AppColor.whiteColor,
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _progressVisibility,
                child: const LinearProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: AspectRatio(
                  aspectRatio: 20 / 9,
                  child: VideoViewer(trimmer: _trimmer),
                ),
              ),
              Center(
                child: TrimViewer(
                  trimmer: _trimmer,
                  viewerHeight: 50.0,
                  viewerWidth: MediaQuery.of(context).size.width,
                  maxVideoLength: Duration(
                      seconds: _trimmer
                          .videoPlayerController!.value.duration.inSeconds),
                  onChangeStart: (value) => _startValue = value,
                  onChangeEnd: (value) => _endValue = value,
                  onChangePlaybackState: (value) =>
                      setState(() => _isPlaying = value),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      seekBackward();
                    },
                    child: SvgPicture.asset('assets/icons/backward10.svg'),
                  ),
                  TextButton(
                    child: _isPlaying
                        ? const Icon(
                            Icons.pause,
                            size: 35.0,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            size: 35.0,
                            color: Colors.white,
                          ),
                    onPressed: () async {
                      bool playbackState = await _trimmer.videoPlaybackControl(
                        startValue: _startValue,
                        endValue: _endValue,
                      );
                      setState(() {
                        _isPlaying = playbackState;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      seekForward();
                    },
                    child: SvgPicture.asset('assets/icons/forward10.svg'),
                  )
                ],
              ),
              const SizedBox(height: 10),
              LargeButton(
                text: "Next",
                onTap: () {
                  Get.to(
                    () => SelectVideoType(
                        fileType: videotrimpath ?? widget.videoFile,
                        sourceType: 'Video'),
                  );
                },
                containerColor: AppColor.whiteColor,
                gradientColor1: AppColor.whiteColor,
                gradientColor2: AppColor.whiteColor,
                borderColor: AppColor.whiteColor,
                textColor: AppColor.secondaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  savetrimvideo() {
    if (_progressVisibility) {
    } else {
      _saveVideo().then((outputPath) {
        print('OUTPUT PATH: $outputPath');
        videotrimpath = File(outputPath!);
        // convertVideoFileToBase64(outputPath!).then((base64String) {
        //   // You can now use the base64String for your needs
        //   print(base64String);
        // }).catchError((error) {
        //   // Handle errors
        //   print("Error converting video to base64: $error");
        // });
        final snackBar =
            const SnackBar(content: Text('Video Saved successfully'));
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      });
    }
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

  void seekForward() {
    final controller = _trimmer.videoPlayerController;
    if (controller != null && controller.value.isInitialized) {
      final currentPosition = controller.value.position;
      final duration = controller.value.duration;
      final seekPosition = currentPosition + const Duration(seconds: 10);

      controller.seekTo(seekPosition < duration ? seekPosition : duration);
    }
  }

  void seekBackward() {
    final controller = _trimmer.videoPlayerController;
    if (controller != null && controller.value.isInitialized) {
      final currentPosition = controller.value.position;
      final seekPosition = currentPosition - const Duration(seconds: 10);

      controller
          .seekTo(seekPosition > Duration.zero ? seekPosition : Duration.zero);
    }
  }
}
