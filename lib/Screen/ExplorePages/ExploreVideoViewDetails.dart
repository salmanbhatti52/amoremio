import 'dart:convert';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Screen/CreateStory/PaidStories/PaidCommentSheet.dart';
import 'package:amoremio/Utills/AppUrls.dart';
import 'package:amoremio/Widgets/ImagewithText.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    debugPrint(userId);
    String apiUrl = userExploreStories;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": widget.usersCustomersId,
              "likers_id": userId,
            },
          ));
      debugPrint(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {});
        videos = data['data'];
        _pageController = PageController();
        _videoControllers = videos.map((videoData) {
          String url = 'https://amoremio.lared.lat/' + videoData['media'];
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
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

  likeduser(usersstories) async {
    var storyid = usersstories['users_stories_id'];
    var Like = usersstories['stats']['liked'];
    var oldTotalLike = usersstories['stats']['total_likes'].toString();
    debugPrint('like $Like');
    debugPrint('totalLike $oldTotalLike');
    showDialog(context: context, builder: (context) {
      return const Center(child: CircularProgressIndicator());
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = usersstorieslikes;
    var showData = {
      "users_stories_id": storyid,
      "likers_id": userId,
      "status": "Like"
    };
    var showData2 = {
      "users_stories_id": storyid,
      "likers_id": userId,
      "status": "Unlike"
    };

    debugPrint("showData $showData");
    debugPrint("showData2 $showData2");
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Like == 'Yes' ? showData2 : showData));

    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      var newTotalLikes = userdetail['data']['total_likes'];
      debugPrint('Total likes: $newTotalLikes');
      Navigator.of(context).pop();
      debugPrint('userdetail $userdetail');
      setState(() {
        usersstories['stats']['liked'] = Like == 'Yes' ? 'No' : 'Yes';
        usersstories['stats']['total_likes'] = newTotalLikes;
      });
    } else {
      var errormsg = userdetail['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errormsg)));
    }
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
                          'https://amoremio.lared.lat/${videos[index]['media']}', // Adjust based on your URL
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
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                    ),
                  ),
                  Positioned(
                    bottom: 200,
                    right: 10,
                    child: Column(
                      children: [
                        Padding(
                    padding: const EdgeInsets.only(bottom: 25.0, right: 5),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  likeduser(videos[_currentPage]);
                                },
                                child: SvgPicture.asset(
                                  width: 30,
                                  height: 30,
                                  videos[_currentPage]["stats"]['liked'] == "Yes"
                                      ? ImageAssets.createStory2
                                      : ImageAssets.createStory1,
                                ),
                              ),
                              Text(
                                videos[_currentPage]['stats']['total_likes'].toString(),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ImageWithText(
                                width: 30,
                                height: 30,
                                color: Colors.white,
                                imagePath: ImageAssets.chat1,
                                text: videos[_currentPage]['stats']['total_comments'].toString(),
                                onTap: (){
                                  Get.bottomSheet(
                                    CommentSheet(
                                        storyId: videos[_currentPage]["users_stories_id"],
                                      onCommentAdded: () {
                                        var currentVideo = videos[_currentPage];
                                        currentVideo['stats']['total_comments'] = ((currentVideo['stats']['total_comments']) + 1);
                                        setState(() {});
                                      },
                                    ),
                                    barrierColor: Colors.black.withOpacity(0.5),
                                    backgroundColor: Colors.transparent,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ImageWithText(
                                width: 20,
                                height: 20,
                                color: Colors.white,
                                imagePath: ImageAssets.share,
                                text: "Share",
                                onTap: () async {
                                  await shareBook(videos[_currentPage]);
                                },
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
                    bottom: 100,
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
                                ? 'https://amoremio.lared.lat/uploads/male-placeholder.jpg'
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

  Future<void> shareBook(Map<String, dynamic> videoData) async {
    String videoUrl = 'https://amoremio.lared.lat/${videoData['media']}';
    try {
      await Share.share(videoUrl);
    } catch (e) {
      debugPrint('Error sharing file: $e');
    }
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
