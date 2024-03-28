import 'dart:convert';
import 'dart:typed_data';

import 'package:amoremio/Screen/BottomNavigationBar/BottomNavigationBar.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../Utills/AppUrls.dart';
import '../../../Widgets/large_Button.dart';

class PaidStory extends StatefulWidget {
  final double height;
  final Function onTap;
  const PaidStory({
    super.key,
    required this.height,
    required this.onTap,
  });

  @override
  State<PaidStory> createState() => _PaidStoryState();
}

class _PaidStoryState extends State<PaidStory> {
  VideoPlayerController? _controller;
  List<dynamic> userstories = [];

  bool ishown = false;
  String errormsg = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadfreestories();
  }

  void loadfreestories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');

    try {
      String apiUrl = getPaidstories;
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
            },
          ));
      var data = jsonDecode(response.body);
      print(data);
      if (data['status'] == 'success') {
        setState(() {
          ishown = true;
          userstories = data['data'];
          print("Userstory $userstories");
          _controller = VideoPlayerController.network("");
          _initializeVideoController();
        });
      } else {
        setState(() {
          ishown = false;
          print(data['status']);
          errormsg = data['message'];
        });
      }
    } catch (e) {
      print('error123456');
    }
  }

  void _initializeVideoController() async {
    await _controller?.initialize();
    setState(() {});
  }

  Future<Uint8List?> generateThumbnail(String videoUrl) async {
    try {
      final uint8list = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 64,
        quality: 25,
      );
      return uint8list;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void dispose() {
    // Dispose of your video controller
    _controller?.dispose();
    super.dispose();
  }

  Widget deleteDg(String? userStoriesId){
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
                  LargeButton(text: "Yes", onTap: (){
                    deleteStory(userStoriesId.toString());
                  }, width: Get.width * 0.7,),
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

  String? userStoriesId;
  Future<void> deleteStory(String storyId) async {
    try {
      String deleteStoryApiUrl = 'https://mio.eigix.net/apis/services/delete_story';

      http.Response response = await http.post(
        Uri.parse(deleteStoryApiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body: jsonEncode(
          {"users_stories_id": storyId},
        ),
      );

      if (response.statusCode == 200) {
        Get.to(
              () => const MyBottomNavigationBar(initialIndex: 2),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
        print("Story deleted successfully");
        print("Response Body: ${response.body}");
      } else {
        print("Error deleting story. Response Body: ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ishown == false
          ? Center(
              child: MyText(
                text: errormsg,
                fontSize: 20,
                align: TextAlign.center,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 1 / 1.3,
              ),
              itemCount: userstories.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> Userstory = userstories[index];
                print("Userstory ${userstories[index]["users_stories_id"]}");
                return Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              userStoriesId = userstories[index]["users_stories_id"];
                              print("Userstory $userStoriesId");
                            });
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height, // Adjust the height as needed
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal : 20, vertical: 30),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                showDialog(
                                                    context: context,
                                                    barrierColor: Colors.white60,
                                                    barrierDismissible: true,
                                                    builder: (BuildContext context) =>
                                                        deleteDg(userStoriesId)
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
                                            Material(
                                              color: Colors.transparent,
                                              child: IconButton(
                                                splashColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                icon: const Icon(Icons.close),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  _controller?.pause();
                                                  _controller?.dispose();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child:
                                              Userstory['media_type'] == 'Video'
                                                  ? VideoPlayer(_controller!)
                                                  : Image.network(baseUrlImage +
                                                      Userstory['media'])),
                                    ],
                                  ),
                                );
                              },
                            );
                            if (Userstory['media_type'] == 'Video') {
                              _controller?.pause();
                              _controller = VideoPlayerController.network(
                                  baseUrlImage + userstories[index]['media'])
                                ..initialize().then((_) {
                                  _controller?.play();
                                  setState(() {});
                                });
                            } else {
                              const SizedBox();
                            }
                          },
                          child: Userstory['media_type'] == 'Video'
                              ? FutureBuilder<Uint8List?>(
                                  future: generateThumbnail(
                                      baseUrlImage + Userstory['media']),
                                  builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasData && snapshot.data != null) {
                                        return ClipRRect(
                                          borderRadius: BorderRadius.circular(7.9),
                                          child: Image.memory(
                                            snapshot.data!,
                                            width: 108,
                                            height: 125,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      } else {
                                        return Image.asset(
                                          'path/to/default/image',
                                          width: 108,
                                          height: 136,
                                        );
                                      }
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(7.9),
                                  child: Image.network(
                                    baseUrlImage + Userstory['media'],
                                    width: 108,
                                    height: 125,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: Get.width * 0.14,
                            height: 13,
                            decoration: ShapeDecoration(
                              color: AppColor.redColor.withOpacity(0.9),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(6.50),
                                  bottomLeft: Radius.circular(2),
                                ),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 0, left: 3, right: 1),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.watch_later,
                                    size: 10,
                                    color: AppColor.whiteColor,
                                  ),
                                  MyText(
                                    text: " 1h ago",
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: Get.width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(6.50),
                                bottomLeft: Radius.circular(6.50),
                              ),
                              color: AppColor.redColor.withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(
                                        Icons.remove_red_eye,
                                        color: AppColor.whiteColor,
                                        size: 10,
                                      ),
                                      MyText(
                                        text: Userstory['stats']['total_views']
                                            .toString(),
                                        fontSize: 5.12,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        width: 10,
                                        height: 10,
                                        color: Colors.white,
                                        ImageAssets.createStory1,
                                      ),
                                      MyText(
                                        text: Userstory['stats']['total_likes']
                                            .toString(),
                                        fontSize: 5.12,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        width: 10,
                                        height: 10,
                                        color: Colors.white,
                                        ImageAssets.chat1,
                                      ),
                                      MyText(
                                        text: Userstory['stats']['total_comments']
                                            .toString(),
                                        fontSize: 5.12,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        width: 10,
                                        height: 10,
                                        color: Colors.white,
                                        ImageAssets.share,
                                      ),
                                      MyText(
                                        text: Userstory['stats']['total_shares']
                                            .toString(),
                                        fontSize: 5.12,
                                        fontWeight: FontWeight.w500,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
    );
  }
}
