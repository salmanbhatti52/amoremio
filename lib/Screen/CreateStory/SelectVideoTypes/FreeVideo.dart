import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utills/AppUrls.dart';
import '../../../Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/colors/colors.dart';
import 'package:http/http.dart' as http;

import '../../BottomNavigationBar/BottomNavigationBar.dart';
import 'package:video_player/video_player.dart';

class FreeVideo extends StatefulWidget {
  final double height;
  final String base64Image;
  final String sourceType;
  final VoidCallback onPauseVideo;
  const FreeVideo(
      {super.key,
      required this.height,
      required this.base64Image,
      required this.sourceType,
      required this.onPauseVideo});

  @override
  State<FreeVideo> createState() => _FreeVideoState();
}

class _FreeVideoState extends State<FreeVideo> {
  VideoPlayerController? playerController;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const MyText(
            text:
                "Your story is set to be free for everyone,  and you\ncan alter or retract it even after uploading.",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          LargeButton(
            text: "Upload",
            onTap: () {
              uploadstory(widget.base64Image, widget.sourceType);
              // print('base64image $base64Image');
              // print('Source Type $sourceType');
            },
            containerColor: AppColor.whiteColor,
            gradientColor1: AppColor.whiteColor,
            gradientColor2: AppColor.whiteColor,
            borderColor: AppColor.whiteColor,
            textColor: AppColor.secondaryColor,
          ),
        ],
      ),
    );
  }

  void uploadstory(base64Image, sourceType) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = createStories;
    try {
      var showdata = {
        "users_customers_id": userId,
        "coins_per_view": "0.00",
        "story_type": "Free",
        "media_type": "Image",
        "media": base64Image
      };
      var showdata2 = {
        "users_customers_id": userId,
        "coins_per_view": "0.00",
        "story_type": "Free",
        "media_type": "Video",
        "media": base64Image
      };
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(sourceType == 'Video' ? showdata2 : showdata));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        Navigator.of(context).pop();
        widget.onPauseVideo();
        Get.to(
          () => const MyBottomNavigationBar(),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
      } else {
        print(data['status']);
        var errormsg = data['message'];
      }
    } catch (e) {
      print('error user discover $e');
    }
  }
}
