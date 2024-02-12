import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../Utills/AppUrls.dart';
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
import 'package:http/http.dart' as http;
import 'package:video_thumbnail/video_thumbnail.dart';

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
  int _currentPage = 0;
  late List<VideoPlayerController> _videoControllers;
  List<dynamic> videos = [];

  @override
  void initState() {
    super.initState();

    loadstories();
  }

  void loadstories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = getstories;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
            },
          ));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {});
        videos = data['data'];
        _pageController = PageController();
        _videoControllers = videos.map((videoData) {
          String url = 'https://mio.eigix.net/' + videoData['media'];
          var controller = VideoPlayerController.network(url);

          controller.initialize().then((_) {
            if (_videoControllers.indexOf(controller) == 0) {
              // Check if it's the first video controller
              controller.play(); // Play the first video
            }
            setState(() {}); // This call to setState will rebuild the widget
          });

          return controller;
        }).toList();
      } else {
        print(data['status']);
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error user discover $e');
    }
  }

  void onThumbnailClicked(dynamic index) {
    // Change the current page of the PageView.builder
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // Play the selected video
    for (var controller in _videoControllers) {
      controller.pause(); // Pause all other videos
    }
    if (videos[index]['media_type'] == 'Video') {
      _videoControllers[index].play(); // Play the selected video
    }

    // Update the current page state
    setState(() {
      _currentPage = index;
    });
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
  }

  void handleButtonTap() {
    setState(() {
      isButtonClicked = !isButtonClicked;
    });
  }

  likeduser(usersstories) async {
    var storyid = usersstories['users_stories_id'];
    var Like = usersstories['liked'];
    print('likeeee $Like');
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = usersstorieslikes;
    // try {
    var showdata = {
      "users_stories_id": storyid,
      "likers_id": userId,
      "status": "Like"
    };
    var showdata2 = {
      "users_stories_id": storyid,
      "likers_id": userId,
      "status": "Unlike"
    };

    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Like == 'Yes' ? showdata2 : showdata));

    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      Navigator.of(context).pop();
      var msg = userdetail['message'];
      print('userdetail $userdetail');
      setState(() {
        if (Like == 'Yes') {
          setState(() {
            usersstories['liked'] = 'No';
          });
        } else {
          setState(() {
            usersstories['liked'] = 'Yes';
          });
        }
      });
    } else {
      // print(userdetail['status']);
      var errormsg = userdetail['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errormsg)));
    }
    // }
    // catch (e) {
    //   print('error123456:$e');
    // }
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
                  onPageChanged: (index) {
                    for (var controller in _videoControllers) {
                      controller.pause(); // Pause all other videos
                    }
                    if (videos[index]['media_type'] == 'Video') {
                      _videoControllers[index]
                          .play(); // Play the video of the current page
                    }
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    if (videos[index]['media_type'] == 'Video') {
                      // Show Video widget
                      return Video(
                        videoController: _videoControllers[index],
                        isPlaying: index == _currentPage,
                      );
                    } else {
                      // Show Image widget
                      return Image.network(
                        'https://mio.eigix.net/${videos[index]['media']}', // Adjust based on your URL
                        fit: BoxFit.cover,
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 8.0, bottom: 40.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                likeduser(videos[_currentPage]);
                              },
                              child: SvgPicture.asset(
                                width: 30,
                                height: 30,
                                videos[_currentPage]['liked'] == "Yes"
                                    ? ImageAssets.createStory2
                                    : ImageAssets.createStory1,
                              ),
                            ),
                            Text(
                              videos[_currentPage]['stats']['total_likes']
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            // ImageWithText(
                            //   onTap: () {
                            //     likeduser(videos[_currentPage]);
                            //   },
                            //   width: 30,
                            //   height: 30,
                            //   color: Colors.white,
                            //   imagePath: videos[_currentPage]['liked'] == "Yes"
                            //       ? ImageAssets.createStory2
                            //       : ImageAssets.createStory1,
                            //   text: videos[_currentPage]['stats']['total_likes']
                            //       .toString(),
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            ImageWithText(
                              width: 30,
                              height: 30,
                              color: Colors.white,
                              imagePath: ImageAssets.chat1,
                              text: videos[_currentPage]['stats']
                                      ['total_comments']
                                  .toString(),
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
                            // GestureDetector(
                            //     onTap: () {
                            //       // handleButtonTap();
                            //       likeduser(videos[_currentPage]);
                            //     },
                            //     child: Column(
                            //       children: [
                            //         Container(
                            //           width: 35,
                            //           height: 35,
                            //           margin: const EdgeInsets.only(bottom: 3),
                            //           padding: const EdgeInsets.all(5),
                            //           decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(25),
                            //             color: videos[_currentPage]['liked'] ==
                            //                     'Yes'
                            //                 ? Colors.red
                            //                 : AppColor.whiteColor,
                            //           ),
                            //           child: Center(
                            //             child: SvgPicture.asset(
                            //               ImageAssets.favorite,
                            //               color: videos[_currentPage]
                            //                           ['liked'] ==
                            //                       'Yes'
                            //                   ? AppColor.whiteColor
                            //                   : AppColor.hintTextColor,
                            //             ),
                            //           ),
                            //         ),
                            //         MyText(
                            //           text:
                            //               videos[_currentPage]['liked'] == 'Yes'
                            //                   ? "Liked"
                            //                   : "Like",
                            //           fontSize: 12,
                            //           fontWeight: FontWeight.w500,
                            //         )
                            //       ],
                            //     )),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, bottom: 0, right: 5),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    videos[_currentPage]['user_data']
                                                    ['image'] !=
                                                null &&
                                            videos[_currentPage]['user_data']
                                                    ['image']
                                                .isNotEmpty
                                        ? 'https://mio.eigix.net/${videos[_currentPage]['user_data']['image']}'
                                        : videos[_currentPage]['user_data']
                                                    ['genders_id'] ==
                                                1
                                            ? 'https://mio.eigix.net/uploads/male-placeholder.jpg' // URL for genderId == 1
                                            : videos[_currentPage]['user_data']
                                                        ['genders_id'] ==
                                                    2
                                                ? 'https://mio.eigix.net/uploads/female-placeholder.jpg' // URL for genderId == 2
                                                : 'https://mio.eigix.net/uploads/placeholder.jpg', // URL for any other case or default image
                                  ),
                                  radius: 18.5,
                                ),
                              ),
                              MyText(
                                text:
                                    "${videos[_currentPage]['user_data']['username']}, ${calculateAge(videos[_currentPage]['user_data']['date_of_birth'])}",
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
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: videos[_currentPage]['user_data']['users_stories'].length,
                              itemBuilder: (BuildContext context, int index) {
                                var story = videos[_currentPage]['user_data']['users_stories'][index];
                                var videoPath = story;
                                if (videoPath['media_type'] == 'Video') {
                                  return FutureBuilder<Uint8List?>(
                                    future: generateThumbnail(
                                        baseUrlImage + story['media']),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Uint8List?> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 0.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10, left: 14),
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                      width: 2,
                                                      color:
                                                          AppColor.whiteColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        onThumbnailClicked(
                                                            index);
                                                      },
                                                      child: Image.memory(
                                                        snapshot.data!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return const CircularProgressIndicator(); // Or some other placeholder
                                        }
                                      } else {
                                        return SizedBox(
                                          width: 65,
                                          height: 65,
                                          child: Center(
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  border: Border.all(width: 2, color: Colors.white,),
                                                ),
                                                margin: const EdgeInsets.all(5),
                                              ),
                                          ),
                                        ); // Loading indicator while the thumbnail is being generated
                                      }
                                    },
                                  );
                                } else {
                                  return Container(
                                    width: 60,
                                    height: 60,
                                    margin: EdgeInsets.all(5),
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://mio.eigix.net/${story['media']}'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: const CircleBorder(
                                        side: BorderSide(
                                            width: 2, color: Colors.white),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(
              // Display a placeholder or alternative content
              child: CircularProgressIndicator(),
            ),
    );
  }
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

class Video extends StatefulWidget {
  final VideoPlayerController videoController;
  // final Function(bool) onVideoPause;
  final bool isPlaying;

  const Video(
      {Key? key,
      required this.videoController,
      // required this.onVideoPause,
      required this.isPlaying})
      : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    if (widget.videoController.value.isInitialized) {
      return GestureDetector(
        onTap: () {
          if (widget.videoController.value.isPlaying) {
            widget.videoController.pause();
            // widget.onVideoPause(true);
          } else {
            widget.videoController.play();
            // widget.onVideoPause(false);
          }
        },
        child: AspectRatio(
          aspectRatio: widget.videoController.value.aspectRatio,
          child: VideoPlayer(widget.videoController),
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

int calculateAge(String dateOfBirth) {
  DateTime today = DateTime.now();
  DateTime birthDate = DateTime.parse(dateOfBirth);
  int age = today.year - birthDate.year;

  // Adjust age if the birthday hasn't occurred yet this year
  if (today.month < birthDate.month ||
      (today.month == birthDate.month && today.day < birthDate.day)) {
    age--;
  }

  return age;
}
