import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../Utills/AppUrls.dart';

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
          // Initialize the video controller
          _controller =
              VideoPlayerController.network(""); // Provide an initial empty URL
          _initializeVideoController();
        });
      } else {
        setState(() {
          ishown = false;
          print(data['status']);
          errormsg = data['message'];
        });

        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(errormsg)));
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
        maxWidth: 128, // specify the width of the thumbnail
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

                return Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
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
                                            vertical: 20),
                                        child: Row(
                                          children: [
                                            Material(
                                              color: Colors.transparent,
                                              child: IconButton(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
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
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Uint8List?> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7.9),
                                          child: Image.memory(
                                            snapshot.data!,
                                            width: 108,
                                            height: 125,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      } else {
                                        return Image.asset(
                                          'path/to/default/image', // Default image path
                                          width: 108,
                                          height: 136,
                                        );
                                      }
                                    } else {
                                      return const SizedBox(); // Loading indicator
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
