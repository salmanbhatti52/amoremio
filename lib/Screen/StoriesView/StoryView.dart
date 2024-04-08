import 'dart:convert';
import 'dart:typed_data';

import 'package:amoremio/Screen/StoriesView/StoryBuyDialouge.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../Utills/AppUrls.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Resources/assets/assets.dart';
import '../../Resources/colors/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amoremio/Widgets/ImagewithText.dart';
import 'package:amoremio/Screen/StoriesView/StoryDiscover.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../CreateStory/PaidStories/PaidCommentSheet.dart';

class StoryView extends StatefulWidget {
  final String? usersStoriesId;
  final String? usersCustomersId;
  const StoryView({Key? key, this.usersStoriesId, this.usersCustomersId}) : super(key: key);

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {

  late PageController _pageController;
  int _currentPage = 0;
  late List<VideoPlayerController> _videoControllers;
  List<dynamic> videos = [];
  bool isThumbnailClicked = false;
  String selectedImageUrl = '';
  String _selectedValue = 'discover';

  @override
  void initState() {
    super.initState();
    loadstories();
  }

  void loadstories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    debugPrint(userId);
    String apiUrl = getstories;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
              "category": _selectedValue
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
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      debugPrint('error user discover $e');
    }
  }

  void onThumbnailClicked(dynamic index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    for (var controller in _videoControllers) {
      controller.pause();
    }
    if (videos[index]['media_type'] == 'Video') {
      _videoControllers[index].play(); // Play the selected video
    }
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

  likeduser(usersstories) async {
    var storyid = usersstories['users_stories_id'];
    var Like = usersstories['liked'];
    var totalLike = usersstories['stats']['total_likes'];
    debugPrint('likeeee $Like');
    debugPrint('totalLike $totalLike');
    showDialog(context: context, builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = usersstorieslikes;
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
      var totalLikes = userdetail['data'][0]['total_likes'];
      debugPrint('Total likes: $totalLikes');
      Navigator.of(context).pop();
      var msg = userdetail['message'];
      debugPrint('userdetail $userdetail');
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
        if(totalLike == totalLikes){
          setState(() {
            usersstories = usersstories['stats']['total_likes'];
          });
        } else {
          usersstories = totalLikes;
        }
      });
    } else {
      var errormsg = userdetail['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errormsg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: videos.isNotEmpty
          ? Stack(
              children: [
                Visibility(
                  visible: isThumbnailClicked,
                  child: GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        print('Swiped downward - Hello');
                        setState(() {
                          isThumbnailClicked = false;
                        });
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
                      } else if (details.primaryVelocity! < 0) {
                        setState(() {
                          isThumbnailClicked = false;
                        });
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
                        print('Swiped upward - Hello');
                      }
                    },
                    child: SizedBox(
                      height: Get.height,
                      child: selectedImageUrl.isNotEmpty
                          ? Image.network(
                        selectedImageUrl,
                        fit: BoxFit.fill,
                      ) : Video2(
                        videoController: _videoControllers[_currentPage],
                        isPlaying: true,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !isThumbnailClicked,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: videos.length,
                    onPageChanged: (index) {
                      for (var controller in _videoControllers) {
                        controller.pause();
                      }
                      if (videos[index]['media_type'] == 'Video') {
                        _videoControllers[index].play();
                      }
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (videos[index]['media_type'] == 'Video') {
                        return Video(
                          videoController: _videoControllers[index],
                          isPlaying: index == _currentPage,
                        );
                      } else {
                        return Image.network(
                          'https://mio.eigix.net/${videos[index]['media']}',
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              videos[_currentPage]['liked'] == "Yes"
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
                            text: videos[_currentPage]['stats']
                                    ['total_comments']
                                .toString(),
                            onTap: (){
                              Get.bottomSheet(
                                 CommentSheet(storyId: videos[_currentPage]["users_stories_id"]),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, bottom: 0, right: 5),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    videos[_currentPage]['user_data']['image'] != null
                                        && videos[_currentPage]['user_data']['image'].isNotEmpty
                                        ? 'https://mio.eigix.net/${videos[_currentPage]['user_data']['image']}'
                                        : videos[_currentPage]['user_data']['genders_id'] == 1
                                            ? 'https://mio.eigix.net/uploads/male-placeholder.jpg'
                                            : videos[_currentPage]['user_data']['genders_id'] == 2
                                                ? 'https://mio.eigix.net/uploads/female-placeholder.jpg'
                                                : 'https://mio.eigix.net/uploads/placeholder.jpg',
                                  ),
                                  radius: 18.5,
                                ),
                              ),
                              MyText(
                                text: videos[_currentPage]['user_data'] != null
                                  ? "${videos[_currentPage]['user_data']['username']}, ${calculateAge(videos[_currentPage]['user_data']['date_of_birth'])}"
                                  : "UserName",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ],
                          ),
                          SizedBox(width: Get.width * 0.1),
                          StoryDiscover(
                            selectedValue: _selectedValue,
                            onChanged: (String? newValue) {
                              if(newValue != null) {
                                setState(() {
                                  _selectedValue = newValue;
                                  loadstories();
                                  print("_selectedValue $_selectedValue");
                                });
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
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
                              var userStoriesId = story["users_stories_id"];
                              var storyType = story["story_type"];
                              var coinsView = story["coins_per_view"];
                              if (videoPath['media_type'] == 'Video') {
                                return FutureBuilder<Uint8List?>(
                                  future: generateThumbnail(baseUrlImage + story['media']),
                                  builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 0.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(top: 10, left: 14),
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  border: Border.all(width: 2, color: AppColor.whiteColor,
                                                  ),
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(30),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if(storyType == "Paid"){
                                                        showDialog(
                                                          context: context,
                                                          barrierColor: Colors.grey.withOpacity(0.9),
                                                          barrierDismissible: false,
                                                          builder: (BuildContext context) => BuyStoryDialog(coinView: coinsView, storyId: userStoriesId),
                                                        );
                                                      } else {
                                                        print('Thumbnail clicked');
                                                        setState(() {
                                                          isThumbnailClicked = true;
                                                          selectedImageUrl = '';
                                                          print("selectedImageUrl $selectedImageUrl");
                                                        });
                                                        _videoControllers[_currentPage].pause();
                                                        print('New video controller created');
                                                        _videoControllers[_currentPage] = VideoPlayerController.network(baseUrlImage + story['media']);
                                                        _videoControllers[_currentPage].initialize().then((_) {
                                                          print('Video controller initialized');
                                                          _videoControllers[_currentPage].play();
                                                          setState(() {});
                                                        });
                                                        // onThumbnailClicked(index);
                                                      }
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
                                      );
                                    }
                                  },
                                );
                              } else {
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      isThumbnailClicked = true;
                                      selectedImageUrl = 'https://mio.eigix.net/${story['media']}';
                                      print("selectedImageUrl $selectedImageUrl");
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    margin: const EdgeInsets.all(5),
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
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> shareBook(Map<String, dynamic> videoData) async {
    String videoUrl = 'https://mio.eigix.net/${videoData['media']}';
    try {
      await Share.share(videoUrl);
    } catch (e) {
      debugPrint('Error sharing file: $e');
    }
  }

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
    debugPrint(e.toString());
    return null;
  }
}

class Video extends StatefulWidget {
  final VideoPlayerController videoController;
  final bool isPlaying;

  const Video(
      {Key? key,
      required this.videoController,
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
          } else {
            widget.videoController.play();
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

class Video2 extends StatefulWidget {
  final VideoPlayerController videoController;
  final bool isPlaying;

   const Video2(
      {Key? key,
        required this.videoController,
        required this.isPlaying})
      : super(key: key);

  @override
  _VideoState2 createState() => _VideoState2();
}

class _VideoState2 extends State<Video2> {
  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          if (widget.videoController.value.isPlaying) {
            widget.videoController.pause();
          } else {
            widget.videoController.play();
          }
        },
        child: AspectRatio(
          aspectRatio: widget.videoController.value.aspectRatio,
          child: VideoPlayer(widget.videoController),
        ),
      );
  }
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
