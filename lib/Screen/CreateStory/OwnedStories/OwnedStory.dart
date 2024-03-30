import 'dart:convert';
import 'dart:typed_data';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Utills/AppUrls.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../Widgets/large_Button.dart';
import '../../BottomNavigationBar/BottomNavigationBar.dart';

class OwnedStory extends StatefulWidget {
  final double height;
  final Function onTap;
  const OwnedStory({
    Key? key,
    required this.height,
    required this.onTap,
  }) : super(key: key);

  @override
  State<OwnedStory> createState() => _OwnedStoryState();
}

class _OwnedStoryState extends State<OwnedStory> {
  VideoPlayerController? _controller;
  List<dynamic> userOwnedStories = [];
  bool iShown = false;
  String errorMsg = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadOwnedStories();
  }

  void loadOwnedStories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');

    try {
      String apiUrl =
          "https://mio.eigix.net/apis/services/get_users_owned_stories";
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
          iShown = true;
          userOwnedStories = data['data'];
          print("Userstory $userOwnedStories");
          _controller = VideoPlayerController.network("");
          _initializeVideoController();
        });
      } else {
        setState(() {
          iShown = false;
          print(data['status']);
          errorMsg = data['message'];
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

  // Widget deleteDg(String? userStoriesId) {
  //   return FadeInLeftBig(
  //     delay: const Duration(milliseconds: 300),
  //     duration: const Duration(milliseconds: 400),
  //     child: Dialog(
  //       backgroundColor: Colors.transparent,
  //       alignment: Alignment.center,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Container(
  //             width: Get.width * 0.8,
  //             height: Get.height * 0.4,
  //             // width: 342,
  //             // height: 315,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Column(
  //               children: [
  //                 Align(
  //                   alignment: Alignment.topRight,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       Get.back();
  //                     },
  //                     child: const Padding(
  //                       padding: EdgeInsets.only(right: 15.0, top: 15),
  //                       child: Icon(
  //                         Icons.clear,
  //                         color: AppColor.blackColor,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SvgPicture.asset(ImageAssets.delete),
  //                 Padding(
  //                   padding: const EdgeInsets.only(top: 5.0, bottom: 5),
  //                   child: Text(
  //                     "Are You Sure ?",
  //                     style: GoogleFonts.poppins(
  //                       color: AppColor.secondaryColor,
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //                   child: Text(
  //                     "Are you sure about deleting this story? Retrieval won't be possible once it's gone.",
  //                     style: GoogleFonts.poppins(
  //                       color: AppColor.brownColor,
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 LargeButton(
  //                   text: "Yes",
  //                   onTap: () {
  //                     deleteStory(userStoriesId.toString());
  //                   },
  //                   width: Get.width * 0.7,
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  String? userStoriesId;
  // Future<void> deleteStory(String storyId) async {
  //   try {
  //     String deleteStoryApiUrl =
  //         'https://mio.eigix.net/apis/services/delete_story';
  //
  //     http.Response response = await http.post(
  //       Uri.parse(deleteStoryApiUrl),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(
  //         {"users_stories_id": storyId},
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       Get.to(
  //         () => const MyBottomNavigationBar(initialIndex: 2),
  //         duration: const Duration(milliseconds: 300),
  //         transition: Transition.rightToLeft,
  //       );
  //       print("Story deleted successfully");
  //       print("Response Body: ${response.body}");
  //     } else {
  //       print("Error deleting story. Response Body: ${response.body}");
  //     }
  //   } catch (error) {
  //     print("Error: $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: iShown == false
          ? Center(
              child: MyText(
                text: errorMsg,
                fontSize: 20,
                align: TextAlign.center,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 1 / 1.5,
              ),
              itemCount: userOwnedStories.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> userStory = userOwnedStories[index];
                var userProfile = userStory["user_data"]["image"];
                var userName = userStory["user_data"]["username"];
                var birth = userStory["user_data"]["date_of_birth"];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          userStoriesId =
                              userOwnedStories[index]["users_stories_id"];
                          debugPrint("userStoriesId $userStoriesId");
                        });
                        Get.to(
                          () =>  StoryView(userStoriesId: userStoriesId.toString(), controller: _controller, userStory: userStory),
                        );
                        // showModalBottomSheet(
                        //   context: context,
                        //   isScrollControlled: true,
                        //   builder: (BuildContext context) {
                        //     return SizedBox(
                        //       height: MediaQuery.of(context).size.height,
                        //       child: Column(
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.symmetric(horizontal : 20, vertical: 30),
                        //             child: Row(
                        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 GestureDetector(
                        //                   onTap: (){
                        //                     showDialog(
                        //                         context: context,
                        //                         barrierColor: Colors.white60,
                        //                         barrierDismissible: true,
                        //                         builder: (BuildContext context) =>
                        //                             deleteDg(userStoriesId)
                        //                     );
                        //                   },
                        //                   child: Container(
                        //                    width: 112,
                        //                     height: 30,
                        //                     padding: const EdgeInsets.only(top: 6, left: 3, right: 6, bottom: 6),
                        //                     color: AppColor.whiteColor,
                        //                     child: Row(
                        //                       children: [
                        //                         SvgPicture.asset(
                        //                           ImageAssets.delete,
                        //                           width: 25,
                        //                           height: 25,
                        //                         ),
                        //                         const SizedBox(
                        //                           width: 3,
                        //                         ),
                        //                         const MyText(
                        //                           text: "Delete",
                        //                           color: AppColor.blackColor,
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.w500,
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 Material(
                        //                   color: Colors.transparent,
                        //                   child: IconButton(
                        //                     splashColor: Colors.transparent,
                        //                     highlightColor: Colors.transparent,
                        //                     icon: const Icon(Icons.close),
                        //                     onPressed: () {
                        //                       Navigator.of(context).pop();
                        //                       _controller?.pause();
                        //                       _controller?.dispose();
                        //                     },
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           Expanded(
                        //               child:
                        //               userStory['media_type'] == 'Video'
                        //                   ? VideoPlayer(_controller!)
                        //                   : Image.network(baseUrlImage + userStory['media'],
                        //               ),
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // );
                        if (userStory['media_type'] == 'Video') {
                          _controller?.pause();
                          _controller = VideoPlayerController.network(
                              baseUrlImage + userOwnedStories[index]['media'])
                            ..initialize().then((_) {
                              _controller?.play();
                              setState(() {});
                            });
                        } else {
                          const SizedBox();
                        }
                      },
                      child: Stack(
                        children: [
                          userStory['media_type'] == 'Video'
                              ? FutureBuilder<Uint8List?>(
                                  future: generateThumbnail(
                                      baseUrlImage + userStory['media']),
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
                                            height: 138,
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
                                    baseUrlImage + userStory['media'],
                                    width: 108,
                                    height: 138,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                          // Positioned(
                          //   right: 0,
                          //   top: 0,
                          //   child: Container(
                          //     width: Get.width * 0.18,
                          //     height: 13,
                          //     decoration: ShapeDecoration(
                          //       color: AppColor.whiteColor.withOpacity(0.4),
                          //       shape: const RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.only(
                          //           topRight: Radius.circular(6.50),
                          //           bottomLeft: Radius.circular(2),
                          //         ),
                          //       ),
                          //     ),
                          //     child: const Row(
                          //       children: [
                          //         Icon(
                          //           Icons.watch_later,
                          //           size: 10,
                          //           color: AppColor.whiteColor,
                          //         ),
                          //         MyText(
                          //           text: " October 2023",
                          //           fontSize: 8,
                          //           fontWeight: FontWeight.w400,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              baseUrlImage + userProfile,
                              width: 16,
                              height: 16,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: Get.width * 0.24,
                            child: MyText(
                              overflow: TextOverflow.ellipsis,
                              text: "$userName, ${calculateAge(birth)}",
                              fontSize: 12,
                              maxLines: 1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  int calculateAge(String dateOfBirth) {
    DateTime today = DateTime.now();
    DateTime birthDate = DateTime.parse(dateOfBirth);
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }
}

class StoryView extends StatefulWidget {
  final String userStoriesId;
  final VideoPlayerController? controller;
  final Map<String, dynamic> userStory;
  const StoryView({super.key, required this.userStory, required this.userStoriesId, this.controller});

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {

  Widget deleteDg(String? userStoriesId) {
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
                  LargeButton(
                    text: "Yes",
                    onTap: () {
                      deleteStory(userStoriesId.toString());
                    },
                    width: Get.width * 0.7,
                  ),
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

  Future<void> deleteStory(String storyId) async {
    try {
      String deleteStoryApiUrl =
          'https://mio.eigix.net/apis/services/delete_story';

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller?.pause();
    widget.controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.userStory['media_type'] == 'Video'
              ? VideoPlayer(widget.controller!)
              : Image.network(
            baseUrlImage + widget.userStory['media'],
            fit: BoxFit.contain,
            width: Get.width,
            height: Get.height,
          ),
          Positioned(
            top: 20,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.white60,
                        barrierDismissible: true,
                        builder: (BuildContext context) =>
                            deleteDg(widget.userStoriesId),
                      );
                    },
                    child: Container(
                      width: 112,
                      height: 30,
                      padding: const EdgeInsets.only(
                        top: 6,
                        left: 3,
                        right: 6,
                        bottom: 6,
                      ),
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
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.controller?.pause();
                  widget.controller?.dispose();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
