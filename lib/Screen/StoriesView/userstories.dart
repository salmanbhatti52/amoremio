import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class userstories extends StatefulWidget {
  const userstories({Key? key}) : super(key: key);

  @override
  State<userstories> createState() => _userstoriesState();
}

class _userstoriesState extends State<userstories> {
  late PageController _pageController;
  late List<VideoPlayerController> _videoControllers;
  final List<String> videos = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _videoControllers = videos.map((url) {
      var controller = VideoPlayerController.network(url);
      // print(
      //     "Initializing controller for $url: ${controller.value.isInitialized}");
      return controller;
    }).toList();
  }

  @override
  void dispose() {
    print("Disposing userstories widget");
    _pageController.dispose();
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: videos.isNotEmpty
          ? PageView.builder(
              controller: _pageController,
              scrollDirection:
                  Axis.vertical, // Set the scroll direction to vertical
              itemCount: videos.length,
              itemBuilder: (BuildContext context, int index) {
                return FutureBuilder(
                  future: _videoControllers[index].initialize(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      _videoControllers[index].setLooping(true);
                      _videoControllers[index].play();
                      return Video(
                        key: Key(index.toString()),
                        videoController: _videoControllers[index],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              },
            )
          : Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
    );
  }
}

class Video extends StatelessWidget {
  final Key key;
  final VideoPlayerController videoController;

  Video({required this.key, required this.videoController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: videoController.value.aspectRatio,
      child: VideoPlayer(videoController),
    );
  }
}
