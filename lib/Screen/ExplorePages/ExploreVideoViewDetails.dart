import 'dart:convert';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Utills/AppUrls.dart';
import 'package:amoremio/Widgets/ImagewithText.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;

class ExploreVideoViewDetails extends StatefulWidget {
  final String? usersStoriesId;
  final String? usersCustomersId;
  final String? userName;
  final String? usersImage;
  const ExploreVideoViewDetails(
      {super.key,
      this.usersStoriesId,
      this.usersCustomersId,
      this.userName,
      this.usersImage});

  @override
  State<ExploreVideoViewDetails> createState() =>
      _ExploreVideoViewDetailsState();
}

class _ExploreVideoViewDetailsState extends State<ExploreVideoViewDetails> {
  List<dynamic> videos = [];
  int _currentPage = 0;
  late PageController _pageController;
  late List<VideoPlayerController> _videoControllers;

  void loadStories() async {
    String apiUrl = userExploreStories;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": widget.usersCustomersId,
              "users_stories_id": widget.usersStoriesId,
            },
          ));
      debugPrint(response.body);
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
              controller.play();
            }
            setState(() {});
          });
          return controller;
        }).toList();
      } else {
        debugPrint(data['status']);
        var errorMsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } catch (e) {
      debugPrint('error user discover $e');
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint('userStoriesID ${widget.usersStoriesId}');
    debugPrint('userStoriesID ${widget.usersCustomersId}');
    loadStories();
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

  likedUser(usersStories) async {
    var storyId = usersStories['users_stories_id'];
    var like = usersStories['liked'];
    debugPrint('like $like');
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
      "users_stories_id": storyId,
      "likers_id": userId,
      "status": "Like"
    };
    var showdata2 = {
      "users_stories_id": storyId,
      "likers_id": userId,
      "status": "Unlike"
    };

    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(like == 'Yes' ? showdata2 : showdata));

    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      Navigator.of(context).pop();
      var msg = userdetail['message'];
      print('userdetail $userdetail');
      setState(() {
        if (like == 'Yes') {
          setState(() {
            usersStories['liked'] = 'No';
          });
        } else {
          setState(() {
            usersStories['liked'] = 'Yes';
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
      body: Scaffold(
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
                  Positioned(
                    top: 50,
                    left: 10,
                    child: GestureDetector(
                        onTap: () {
                          // _pageController.dispose();
                          Get.back();
                          },
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 10,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 8.0, bottom: 40.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  likedUser(videos[_currentPage]);
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 10,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 8.0, bottom: 40.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  likedUser(videos[_currentPage]);
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, bottom: 0, right: 5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.usersImage !=
                                        null &&
                                    widget.usersImage!.isNotEmpty
                                ? 'https://mio.eigix.net/uploads/male-placeholder.jpg'
                                : widget.usersImage.toString()),
                            radius: 18.5,
                          ),
                        ),
                        MyText(
                          text: "${widget.userName}, ${25}",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

Future<Uint8List?> generateThumbnail(String videoUrl) async {
  try {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 64, // specify the width of the thumbnail
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
