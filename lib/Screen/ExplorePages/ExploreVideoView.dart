import 'dart:convert';
import 'dart:typed_data';

import 'package:amoremio/Screen/ExplorePages/ExploreVideoViewDetails.dart';
import 'package:amoremio/Screen/StoriesView/StoryBuyDialouge.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../Utills/AppUrls.dart';
import '../BottomNavigationBar/BottomNavigationBar.dart';
import 'package:get/get.dart';
import 'ExploreUserAbout.dart';
import 'package:flutter/material.dart';
import '../../Widgets/RoundedButton.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:http/http.dart' as http;

class ExploreVideoView extends StatefulWidget {
  final String userid;
  final String match;
  const ExploreVideoView({Key? key, required this.userid, required this.match})
      : super(key: key);

  @override
  State<ExploreVideoView> createState() => _ExploreVideoViewState();
}

class _ExploreVideoViewState extends State<ExploreVideoView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animateController = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);
  bool isButtonClicked = false;

  @override
  void dispose() {
    super.dispose();
    _animateController.dispose();
  }

  List<dynamic> imgListavators = [];
  List<dynamic> userDataList = [];
  List<dynamic> uservideos = [];
  int _current = 0;
  bool isLoading = false;
  bool isStoryLoading = false;
  String userStoriesID = "";
  String usersCustomersId = "";

  final CarouselController _controller = CarouselController();
  double sheetTopPosition = 0;
  Map<String, Uint8List?> thumbnails = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getavators();
    loaddata();
    fetchuserliked();
  }

  Map<String, dynamic> userData = {};

  loaddata() async {
    String apiUrl = getusersProfile;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {"users_customers_id": widget.userid},
          ));
      var userdetail = jsonDecode(response.body);
      if (userdetail['status'] == 'success') {
        print(userdetail);
        setState(() {
          if (userdetail['data'] != null) {
            userData = userdetail["data"];
            print("userData $userData");
          }
        });
      } else {
        var errormsg = userdetail['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error123456: $e');
    }
  }

  getavators() async {
    setState(() {
      isLoading = true;
    });
    String apiUrl = getusersavatars;
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": widget.userid,
            },
          ));

      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        imgListavators = data['data'];
        userstories();
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('errorfound $e');
    }
  }

  userstories() async {
    setState(() {
      isStoryLoading = true;
    });
    String apiUrl = getuserallstories;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print("userID $userId");
    print("otherUserID ${widget.userid}");
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
              "others_users_customers_id": widget.userid,
            },
          ));

      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        print('user stories::::: ${response.body}');
        // imgurl = baseUrlImage + data['data']['image'];
        uservideos = data['data'];
        await generateAllThumbnails(uservideos);
        setState(() {
          isStoryLoading = false;
        });
      } else {
        setState(() {
          isStoryLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isStoryLoading = false;
      });
      print('errorfound $e');
    }
  }

  Future<void> generateAllThumbnails(List<dynamic> videos) async {
    bool shouldUpdate = false;
    for (var video in videos) {
      if (video['media_type'] == 'Video') {
        var thumbnail = await generateThumbnail(baseUrlImage + video['media']);
        if (thumbnail != null) {
          thumbnails[video['media']] = thumbnail;
          shouldUpdate = true;
        }
      }
    }
    if (shouldUpdate) {
      setState(() {});
    }
  }

  void fetchuserliked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = getuserlikedme;
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
        userDataList = data['data'];
        for (var i = 0; i < userDataList.length; i++) {
          if (userDataList[i]['users_customers_id'] == widget.userid) {
            setState(() {
              isButtonClicked = true;
            });
          }
        }
        // print(userDataList);
        // images = baseUrlImage + data['data']['image'];
      } else {
        print(data['status']);
      }
    } catch (e) {
      print('error :$e');
    }
  }

  blockuser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = userblockedunblocked;
    // try {
    var showdata = {
      "users_customers_id": userId,
      "blocked_id": widget.userid,
      "status": "Block"
    };
    debugPrint("showdata $showdata");
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(showdata));
    print(showdata);
    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      Navigator.of(context).pop();
      setState(() {
        Get.to(
          () => const MyBottomNavigationBar(),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
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

  likeduser() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = userliked;
    // try {
    var showdata = {
      "users_customers_id": widget.userid,
      "likers_id": userId,
      "status": "Like"
    };
    var showdata2 = {
      "users_customers_id": widget.userid,
      "likers_id": userId,
      "status": "Unlike"
    };

    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(isButtonClicked ? showdata2 : showdata));

    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      Navigator.of(context).pop();
      loaddata();
      var msg = userdetail['message'];
      print('userdetail $userdetail');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg.toString())));
      setState(() {
        isButtonClicked = !isButtonClicked;
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

  bool isLoadings = false;
  Map<String, dynamic> shareProfile = {};

  shareUserProfile() async {
    setState(() {
      isLoadings = true;
    });
    String apiUrl = 'https://amoremio.lared.lat/apis/services/users_profile_shares';
    http.Response response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "users_customers_id": widget.userid,
          },
        ));
    if (mounted) {
      setState(() {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['status'] == "success") {
            shareProfile = jsonResponse['data'];
            debugPrint("shareProfile: $shareProfile");
            debugPrint("link ${shareProfile["link"]}");
            shareBook(shareProfile["link"]);
            // Clipboard.setData(ClipboardData(text: shareProfile["link"])).then((_){
            //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: MyText(
            //     text: "Linked copied successfully!",
            //     color: AppColor.primaryColor,
            //     fontSize: 12,
            //     fontWeight: FontWeight.w500,
            //   ), backgroundColor: AppColor.whiteColor,),);
            // });
            isLoadings = false;
          } else {
            debugPrint("parentMessage");
            isLoadings = false;
          }
        } else {
          debugPrint("Response Bode::${response.body}");
          isLoadings = false;
        }
      });
    }
  }

  Future<void> shareBook(String link) async {
    String url = link;
    try {
      await Share.share(url);
    } catch (e) {
      debugPrint('Error sharing file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders = [];
    for (int index = 0; index < imgListavators.length; index++) {
      imageSliders.add(Image.network(
        baseUrlImage + imgListavators[index]['image'],
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          }
        },
      )
          );
    }

    return Scaffold(
      body: Stack(
        children: [
          isLoading ? const Center(
            child: SpinKitPouringHourGlassRefined(
              color: AppColor.primaryColor,
              size: 80,
              strokeWidth: 3,
              duration: Duration(seconds: 1),
            ),
          ) : imgListavators.isNotEmpty
              ? CarouselSlider(
                  items: imageSliders,
                  carouselController: _controller,
                  options: CarouselOptions(
                      autoPlay: false,
                      scrollPhysics: const ScrollPhysics(),
                      disableCenter: false,
                      enlargeCenterPage: false,
                      viewportFraction: 0.999,
                      aspectRatio: 2,
                      animateToClosest: false,
                      enableInfiniteScroll: false,
                      height: double.infinity,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                )
              : const SizedBox(),
          // Center(
          //         child: Container(
          //           child: CircularProgressIndicator(),
          //           // child: Image.asset(
          //           //   ImageAssets.dummystory,
          //           //   fit: BoxFit.fitWidth,
          //           //   width: MediaQuery.sizeOf(context).width,
          //           //   height: MediaQuery.sizeOf(context).height,
          //           // ),
          //         ),
          //       ),
          Positioned(
            bottom: Get.height * 0.325,
            // left: Get.width * 0.405,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(maxWidth: Get.width * 0.99),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgListavators.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key
                              ? AppColor.whiteColor
                              : Colors.white30,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     // width: 172,
          //     height: Get.height * 0.22,
          //     decoration: const BoxDecoration(
          //       color: AppColor.whiteColor,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(27),
          //         topRight: Radius.circular(27),
          //       ),
          //     ),
          //     child: Column(
          //       children: [
          //         const SizedBox(
          //           height: 5,
          //         ),
          //         GestureDetector(
          //           onTap: () {
          //             // if (exploreController.isButtonClicked.value) {
          //             aboutExploreUser(context);
          //             // }
          //           },
          //           child: Padding(
          //             padding:
          //                 EdgeInsets.symmetric(horizontal: Get.width * 0.28),
          //             child: Container(
          //               height: 7,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(12),
          //                 color: const Color(0xFFFFC3C3),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.only(
          //             left: Get.width * 0.06,
          //             top: Get.height * 0.02,
          //             right: Get.width * 0.06,
          //             bottom: Get.height * 0.01,
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               MyText(
          //                 text: "$username, ${calculateAge(dateofbirth)}",
          //                 fontSize: 18,
          //                 color: AppColor.blackColor,
          //               ),
          //               Row(
          //                 children: [
          //                   SvgPicture.asset(
          //                     ImageAssets.createStory1,
          //                     color: AppColor.secondaryColor,
          //                   ),
          //                   const MyText(
          //                     text: "0",
          //                     fontWeight: FontWeight.w500,
          //                     fontSize: 14,
          //                     color: AppColor.secondaryColor,
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.only(
          //               left: Get.width * 0.06, bottom: Get.height * 0.02),
          //           child: Row(
          //             children: [
          //               // SvgPicture.asset(ImageAssets.locationWhite, color: AppColor.secondaryColor,),
          //               const Icon(
          //                 Icons.location_on,
          //                 color: AppColor.secondaryColor,
          //                 size: 17,
          //               ),
          //               const SizedBox(
          //                 width: 3,
          //               ),
          //               MyText(
          //                 text: "$address, ${'2.5 Km'}",
          //                 fontWeight: FontWeight.w500,
          //                 fontSize: 12,
          //                 color: const Color(0xFF3B3B3B),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             GestureDetector(
          //                 onTap: () {
          //                   Get.back();
          //                 },
          //                 child: SvgPicture.asset(ImageAssets.explore2)),
          //             RoundedButton(
          //               onTap: () {
          //                 blockuser();
          //                 // Get.to(
          //                 //   () => BlockedUser(),
          //                 //   duration: const Duration(milliseconds: 350),
          //                 //   transition: Transition.downToUp,
          //                 // );
          //               },
          //               icon: ImageAssets.block,
          //             ),
          //             ScaleTransition(
          //               scale: Tween(begin: 0.5, end: 1.0).animate(
          //                   CurvedAnimation(
          //                       parent: _animateController,
          //                       curve: Curves.easeOut)),
          //               child: RoundedButton(
          //                 onTap: () {
          //                   // handleButtonTap();
          //                   likeduser();
          //                   _animateController
          //                       .reverse()
          //                       .then((value) => _animateController.forward());
          //                 },
          //                 icon: isButtonClicked
          //                     ? ImageAssets.favorite
          //                     : ImageAssets.favorite,
          //                 imageColor: isButtonClicked
          //                     ? AppColor.whiteColor
          //                     : AppColor.hintTextColor,
          //                 containerColor: isButtonClicked
          //                     ? Colors.red
          //                     : AppColor.whiteColor,
          //               ),
          //             ),
          //             SvgPicture.asset(ImageAssets.share),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 175,
            left: 0,
            right: 0,
            child: isStoryLoading
                ? const Center(child: Padding(
                  padding: EdgeInsets.only(bottom: 32.0),
                  child: CircularProgressIndicator(),
                ))
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: uservideos.length,
                      itemBuilder: (BuildContext context, int index) {
                        var story = uservideos[index];
                        var videoPath = story;
                        var storyId = videoPath['users_stories_id'];
                        var storyType = videoPath['story_type'];
                        var coinsView = videoPath['coins_per_view'];
                        var owned = videoPath['stats']["owned"];
                        if (videoPath['media_type'] == 'Video' &&
                            thumbnails.containsKey(story['media'])) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 13, right: 1),
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      width: 2,
                                      color: AppColor.whiteColor,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: GestureDetector(
                                      onTap: () {
                                        if(storyType == "Paid" && owned == "No"){
                                          showDialog(
                                            context: context,
                                            barrierColor: Colors.grey.withOpacity(0.9),
                                            barrierDismissible: false,
                                            builder: (BuildContext context) => BuyStoryDialog(coinView: coinsView, storyId: storyId),
                                          );
                                        } else {
                                          print('users_stories_id ::::: ${story["users_stories_id"]}');
                                          print('users_customers_id ::::: ${story["users_customers_id"]}');
                                          setState(() {
                                            userStoriesID = story["users_stories_id"];
                                            usersCustomersId = story["users_customers_id"];
                                            print('userStoriesID $userStoriesID');
                                            print('users_customers_id $usersCustomersId');
                                          });
                                          Get.to(
                                                () => ExploreVideoViewDetails(userName: userData["username"], usersImage: baseUrlImage + userData["image"], usersStoriesId: userStoriesID, usersCustomersId: usersCustomersId,),
                                            duration: const Duration(seconds: 1),
                                            transition: Transition.native,
                                          );
                                        }
                                      },
                                      child: Image.memory(
                                        thumbnails[story['media']]!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: (){
                              // print('users_stories_id ::::: ${story["users_stories_id"]}');
                              // print('users_customers_id ::::: ${story["users_customers_id"]}');
                              // setState(() {
                              //   userStoriesID = story["users_stories_id"];
                              //   usersCustomersId = story["users_customers_id"];
                              //   print('userStoriesID $userStoriesID');
                              //   print('users_customers_id $usersCustomersId');
                              // });
                              // Get.to(
                              //       () => ExploreVideoViewDetails(userName: username, usersImage: baseUrlImage + userImage, usersStoriesId: userStoriesID, usersCustomersId: usersCustomersId,),
                              //   duration: const Duration(seconds: 1),
                              //   transition: Transition.native,
                              // );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 12,
                                left: 10,
                              ),
                              width: 60,
                              height: 60,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://amoremio.lared.lat/${story['media']}'),
                                  fit: BoxFit.fill,
                                ),
                                shape: const CircleBorder(
                                  side: BorderSide(width: 2, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
          ),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              if (notification.extent < 1.0) {
                setState(() {
                  sheetTopPosition = notification.extent;
                });
              }
              return true;
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.22, // Initial height of the sheet
              minChildSize: 0.22, // Minimum height when dragged down
              maxChildSize: 0.7, // Maximum height when fully expanded
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    height: Get.height * (0.22 + 0.78 * sheetTopPosition),
                    decoration: const BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(27),
                        topRight: Radius.circular(27),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            // aboutExploreUser(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.28),
                            child: Container(
                              height: 7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xFFFFC3C3),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.06,
                            top: Get.height * 0.02,
                            right: Get.width * 0.06,
                            bottom: Get.height * 0.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: userData != null && userData.isNotEmpty ? "${userData["username"]}, ${calculateAge(userData["date_of_birth"])}" : "",
                                fontSize: 18,
                                color: AppColor.blackColor,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageAssets.createStory1,
                                    color: AppColor.secondaryColor,
                                  ),
                                  MyText(
                                    text:userData != null && userData.isNotEmpty ? userData["total_likes"].toString() : "",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: AppColor.secondaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.width * 0.05,
                              bottom: Get.height * 0.02),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColor.secondaryColor,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: MyText(
                                    text: userData != null && userData.isNotEmpty ? "${userData["location"]}, ${'2.5 Km'}" : "",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: const Color(0xFF3B3B3B),
                                    align: TextAlign.left),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: sheetTopPosition >
                              0.3, // Adjust the threshold as needed
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width * 0.06,
                                bottom: Get.height * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const MyText(
                                  text: 'About me',
                                  fontSize: 14,
                                  color: AppColor.blackColor,
                                ),
                                MyText(
                                  text: userData != null && userData.isNotEmpty ? userData["summary"].toString() : "",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: const Color(0xFF646464),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.back();
                    Get.to(
                      () => const MyBottomNavigationBar(),
                      duration: const Duration(milliseconds: 300),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: SvgPicture.asset(ImageAssets.explore2),
                ),
                RoundedButton(
                  onTap: () {
                    blockuser();
                  },
                  icon: ImageAssets.block,
                ),
                ScaleTransition(
                  scale: Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
                    parent: _animateController,
                    curve: Curves.easeOut,
                  )),
                  child: RoundedButton(
                    onTap: () {
                      likeduser();
                      _animateController
                          .reverse()
                          .then((value) => _animateController.forward());
                    },
                    icon: isButtonClicked
                        ? ImageAssets.favorite
                        : ImageAssets.favorite,
                    imageColor: isButtonClicked
                        ? AppColor.whiteColor
                        : AppColor.hintTextColor,
                    containerColor:
                        isButtonClicked ? Colors.red : AppColor.whiteColor,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    shareUserProfile();
                  },
                    child: SvgPicture.asset(ImageAssets.share),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int calculateAge(String? dateOfBirth) {
    if (dateOfBirth == null) {
      return 0;
    }
    DateTime today = DateTime.now();
    DateTime birthDate = DateTime.parse(dateOfBirth);
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  Future<Uint8List?> generateThumbnail(String videoUrl) async {
    try {
      final unit8list = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.PNG,
        maxWidth: 64,
        quality: 25,
        timeMs: 1
      );
      return unit8list;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
