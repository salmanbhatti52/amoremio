import 'dart:convert';
import 'dart:math';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Resources/assets/assets.dart';
import '../../Utills/AppUrls.dart';
import 'ExploreVideoView.dart';
import '../../Widgets/AppBar.dart';
import 'ExploreSearch&Filter.dart';
import 'ExploreVideoViewButton.dart';
import 'package:flutter/material.dart';
import 'ExploreBackgroundContainer.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Widgets/Small_Button.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:http/http.dart' as http;
import 'package:auto_animated/auto_animated.dart';

import 'UserMatchShowPage.dart';

// ignore: must_be_immutable
class ExplorePage extends StatefulWidget {
  ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool status = false;
  bool selectedIndex1 = true;
  bool selectedIndex2 = false;
  bool selectedIndex3 = false;
  bool selectedIndex4 = false;

  bool isloading = false;
  final options = const LiveOptions(
    // Start animation after (default zero)
    delay: Duration(seconds: 0),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 200),

    // Animation duration (default 250)
    showItemDuration: Duration(milliseconds: 500),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );

  List<dynamic> mainImages = [
    ImageAssets.exploreImage,
    ImageAssets.image1,
    ImageAssets.image2,
    ImageAssets.image3,
    ImageAssets.introImage,
    // Add more image assets as needed
  ];
  List<dynamic> originalUserDataList = [];
  List<dynamic> userDataList = [];
  List<dynamic> userDatasearch = [];

  List<dynamic> imgListavators = [];

  String searchTerm = '';

  void toggleSwitch(bool newValue) {
    setState(() {
      status = newValue;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchuserDiscover();
  }

  void fetchuserDiscover() async {
    originalUserDataList = [];
    isloading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = userDiscover;
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
        originalUserDataList = data['data'];
        userDataList = originalUserDataList;
        isloading = false;
        print('userDataList $userDataList');
        // images = baseUrlImage + data['data']['image'];
      } else {
        isloading = false;
        print(data['status']);
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      isloading = false;
      print('error user discover $e');
    }
  }

  /// liked users/////
  void fetchuserliked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = getuserliked;
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
        originalUserDataList = data['data'];
        userDataList = originalUserDataList;

        // images = baseUrlImage + data['data']['image'];
      } else {
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error :$e');
    }
  }

  /// //////////////

  /// Matches/////
  fetchusermatches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = getusermatch;
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
        originalUserDataList = data['data'];
        userDataList = originalUserDataList;

        // images = baseUrlImage + data['data']['image'];
      } else {
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error :$e');
    }
  }

  /// //////////////

  /// liked users/////
  void fetchuserlikedme() async {
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
        setState(() {
          originalUserDataList = data['data'];
          userDataList = originalUserDataList;
        });
      } else {
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error :$e');
    }
  }

  /// //////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ExploreAppbar(title: "LOGO", title2: "Explore"),
              SizedBox(height: Get.height * 0.02),
              ExploreSearch(onSearch: (searchText) {
                // Handle the search text here
                print('Received search text in ExplorePage: $searchText');

                if (searchText.isEmpty) {
                  // If empty, show the complete data or specific results
                  setState(() {
                    userDataList =
                        originalUserDataList; // Restore the original data
                  });
                } else {
                  // If not empty, filter the original data based on the search text
                  List searchResults = originalUserDataList
                      .where((user) =>
                          user['username'] != null &&
                          user['username']
                              .toLowerCase()
                              .contains(searchText.toLowerCase()))
                      .toList();

                  setState(() {
                    userDataList = searchResults;
                  });
                  // Print the search results
                  print(searchResults);
                }
              }, onGenderSelect: (gender) {
                // Handle the selected gender here
                print('Selected gender: $gender');
              }),

              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.04,
                  top: Get.height * 0.033,
                  bottom: Get.height * 0.025,
                ),
                child: const Row(
                  children: [
                    MyText(
                      text: "Categories",
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     left: Get.width * 0.06,
              //     right: Get.width * 0.06,
              //     top: Get.height * 0.035,
              //     bottom: Get.height * 0.025,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const MyText(
              //         text: "Categories",
              //         fontSize: 18,
              //       ),
              //       Obx(
              //         () => FlutterSwitch(
              //           width: 52.0,
              //           height: 28.0,
              //           toggleSize: 21.0,
              //           activeColor: AppColor.whiteColor,
              //           value: exploreController.status.value,
              //           borderRadius: 16.42,
              //           inactiveColor: const Color(0x87FFAEAE),
              //           activeToggleColor: AppColor.secondaryColor,
              //           // ignore: deprecated_member_use
              //           activeIcon: SvgPicture.asset(ImageAssets.video, color: AppColor.whiteColor,),
              //           // ignore: deprecated_member_use
              //           inactiveIcon: SvgPicture.asset(ImageAssets.video,  color: const Color(0xFF8B8B8B),),
              //           showOnOff: false,
              //           onToggle: (val) {
              //             exploreController.toggleSwitch(val);
              //             if (val == true) {
              //               // e.g., notificationPermissionApiYes();
              //             } else if (val == false) {
              //               // e.g., notificationPermissionApiNo();
              //             } else {
              //             }
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.01, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmallButton(
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      textColor: selectedIndex1 == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      text: "Discover ",
                      onTap: () {
                        selectedIndex1 = true;
                        selectedIndex2 = false;
                        selectedIndex3 = false;
                        selectedIndex4 = false;
                        userDataList = [];
                        fetchuserDiscover();
                        setState(() {});
                        // showDialog(
                        //     context: context,
                        //     barrierColor: Colors.white60,
                        //     barrierDismissible: true,
                        //     builder: (BuildContext context) =>
                        //          CustomDialog(
                        //            width: Get.width * 0.8,
                        //            height: Get.height * 0.25,
                        //            text: 'Opps!',
                        //            text2: 'Only for Premium members!',
                        //            text3: 'Buy Premium',
                        //            color: AppColor.whiteColor,
                        //          ),
                        // );
                      },
                    ),
                    SmallButton(
                      text: "Matches ",
                      textColor: selectedIndex2 == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      onTap: () {
                        selectedIndex1 = false;
                        selectedIndex2 = true;
                        selectedIndex3 = false;
                        selectedIndex4 = false;
                        userDataList = [];
                        fetchusermatches();
                        setState(() {});
                        // Get.to(
                        //   () => const UserMatchesPage(),
                        //   duration: const Duration(milliseconds: 350),
                        //   transition: Transition.rightToLeft,
                        // );
                      },
                    ),
                    SmallButton(
                      text: "Liked ",
                      textColor: selectedIndex3 == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      onTap: () {
                        selectedIndex1 = false;
                        selectedIndex2 = false;
                        selectedIndex3 = true;
                        selectedIndex4 = false;
                        userDataList = [];
                        fetchuserliked();
                        setState(() {});
                      },
                    ),
                    SmallButton(
                      text: "Liked You ",
                      textColor: selectedIndex4 == true
                          ? const Color(0xFFEE4433)
                          : AppColor.hintTextColor,
                      width: Get.width * 0.22,
                      height: Get.height * 0.033,
                      onTap: () {
                        selectedIndex1 = false;
                        selectedIndex2 = false;
                        selectedIndex3 = false;
                        selectedIndex4 = true;
                        userDataList = [];
                        fetchuserlikedme();
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              // ExploreVideoContainer(
              //   height: MediaQuery.of(context).size.height * 0.61,
              //   onTap: () {
              //     Get.to(
              //       () => const ExploreVideoView(),
              //       duration: const Duration(seconds: 1),
              //       transition: Transition.native,
              //     );
              //   },
              //   value: status,
              // ),
              /////userdiscover////
              selectedIndex1 == true
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.57,
                      child: isloading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : LiveGrid.options(
                              options: options,
                              itemCount: userDataList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.1,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                              ),
                              itemBuilder: (
                                BuildContext context,
                                int index,
                                Animation<double> animation,
                              ) {
                                // String randomMainImage =
                                //     mainImages[Random().nextInt(mainImages.length)];
                                Map<String, dynamic> currentUserData =
                                    userDataList[index];
                                return FadeTransition(
                                  opacity: Tween<double>(
                                    begin: 0,
                                    end: 1,
                                  ).animate(animation),
                                  // And slide transition
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, -0.1),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    // Paste you Widget
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => ExploreVideoView(
                                              userid: currentUserData[
                                                  'users_customers_id'],
                                              match: 'no'),
                                          duration: const Duration(seconds: 1),
                                          transition: Transition.native,
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: 160,
                                                height: 160,
                                                decoration: ShapeDecoration(
                                                  image: DecorationImage(
                                                    image: (currentUserData[
                                                                    'avatars'] ==
                                                                null ||
                                                            currentUserData[
                                                                    'avatars']
                                                                .isEmpty)
                                                        ? currentUserData[
                                                                    'genders_id'] ==
                                                                "1"
                                                            ? const NetworkImage(
                                                                ImageAssets
                                                                    .dummyImage) // First image for genderId == 1
                                                            : currentUserData[
                                                                        'genders_id'] ==
                                                                    "2"
                                                                ? const NetworkImage(
                                                                    ImageAssets
                                                                        .dummyImage1) // Second image for genderId == 2
                                                                : const NetworkImage(
                                                                    ImageAssets
                                                                        .dummyImage2) // Third image for any other case
                                                        : NetworkImage(
                                                            'https://mio.eigix.net/${currentUserData['avatars'][0]['image']}'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 5,
                                                top: 5,
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(ImageAssets
                                                        .locationWhite),
                                                    const MyText(
                                                      text: "1.4 Km",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 25,
                                                  height: 25,
                                                  decoration: ShapeDecoration(
                                                    image: DecorationImage(
                                                      image: currentUserData[
                                                                  'image'] ==
                                                              null
                                                          ? currentUserData[
                                                                      'genders_id'] ==
                                                                  "1"
                                                              ? const NetworkImage(
                                                                  ImageAssets
                                                                      .dummyImage) // First image for genderId == 1
                                                              : currentUserData[
                                                                          'genders_id'] ==
                                                                      "2"
                                                                  ? const NetworkImage(
                                                                      ImageAssets
                                                                          .dummyImage1) // Second image for genderId == 2
                                                                  : const NetworkImage(
                                                                      ImageAssets
                                                                          .dummyImage2)
                                                          : NetworkImage(
                                                              'https://mio.eigix.net/${currentUserData['image']}',
                                                            ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                MyText(
                                                  text:
                                                      "${currentUserData['username']}, ${calculateAge(currentUserData['date_of_birth'])}",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    )
                  : const SizedBox(),
              /////usermatch//////
              selectedIndex2 == true
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.61,
                      child: LiveGrid.options(
                        options: options,
                        itemCount: userDataList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.1,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                        ),
                        itemBuilder: (
                          BuildContext context,
                          int index,
                          Animation<double> animation,
                        ) {
                          // String randomMainImage =
                          //     mainImages[Random().nextInt(mainImages.length)];
                          Map<String, dynamic> currentUserData =
                              userDataList[index];
                          return FadeTransition(
                            opacity: Tween<double>(
                              begin: 0,
                              end: 1,
                            ).animate(animation),
                            // And slide transition
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.1),
                                end: Offset.zero,
                              ).animate(animation),
                              // Paste you Widget
                              child: GestureDetector(
                                onTap: () {
                                  // Get.to(
                                  //   () => ExploreVideoView(
                                  //       userid: currentUserData[
                                  //           'users_customers_id'],
                                  //       match: 'yes'),
                                  //   duration: const Duration(seconds: 1),
                                  //   transition: Transition.native,
                                  // );
                                  Get.to(
                                    () => UserMatchesPage(
                                      userid:
                                          currentUserData['users_customers_id'],
                                    ),
                                    duration: const Duration(milliseconds: 350),
                                    transition: Transition.rightToLeft,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 160,
                                          height: 160,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: (currentUserData[
                                                              'avatars'] ==
                                                          null ||
                                                      currentUserData['avatars']
                                                          .isEmpty)
                                                  ? currentUserData[
                                                              'genders_id'] ==
                                                          "1"
                                                      ? const NetworkImage(
                                                          ImageAssets
                                                              .dummyImage) // First image for genderId == 1
                                                      : currentUserData[
                                                                  'genders_id'] ==
                                                              "2"
                                                          ? const NetworkImage(
                                                              ImageAssets
                                                                  .dummyImage1) // Second image for genderId == 2
                                                          : const NetworkImage(
                                                              ImageAssets
                                                                  .dummyImage2) // Third image for any other case
                                                  : NetworkImage(
                                                      'https://mio.eigix.net/${currentUserData['avatars'][0]['image']}'),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  ImageAssets.locationWhite),
                                              const MyText(
                                                text: "1.4 Km",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 25,
                                            height: 25,
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: currentUserData[
                                                            'image'] ==
                                                        null
                                                    ? currentUserData[
                                                                'genders_id'] ==
                                                            "1"
                                                        ? const NetworkImage(
                                                            ImageAssets
                                                                .dummyImage) // First image for genderId == 1
                                                        : currentUserData[
                                                                    'genders_id'] ==
                                                                "2"
                                                            ? const NetworkImage(
                                                                ImageAssets
                                                                    .dummyImage1) // Second image for genderId == 2
                                                            : const NetworkImage(
                                                                ImageAssets
                                                                    .dummyImage2)
                                                    : NetworkImage(
                                                        'https://mio.eigix.net/${currentUserData['image']}',
                                                      ),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            text:
                                                "${currentUserData['username']}, ${calculateAge(currentUserData['date_of_birth'])}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
              // userliked/////
              selectedIndex3 == true
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.61,
                      child: LiveGrid.options(
                        options: options,
                        itemCount: userDataList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.1,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                        ),
                        itemBuilder: (
                          BuildContext context,
                          int index,
                          Animation<double> animation,
                        ) {
                          // String randomMainImage =
                          //     mainImages[Random().nextInt(mainImages.length)];
                          Map<String, dynamic> currentUserData =
                              userDataList[index];
                          return FadeTransition(
                            opacity: Tween<double>(
                              begin: 0,
                              end: 1,
                            ).animate(animation),
                            // And slide transition
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.1),
                                end: Offset.zero,
                              ).animate(animation),
                              // Paste you Widget
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ExploreVideoView(
                                        userid: currentUserData[
                                            'users_customers_id'],
                                        match: 'no'),
                                    duration: const Duration(seconds: 1),
                                    transition: Transition.native,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 160,
                                          height: 160,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: (currentUserData[
                                                              'avatars'] ==
                                                          null ||
                                                      currentUserData['avatars']
                                                          .isEmpty)
                                                  ? currentUserData[
                                                              'genders_id'] ==
                                                          "1"
                                                      ? const NetworkImage(
                                                          ImageAssets
                                                              .dummyImage) // First image for genderId == 1
                                                      : currentUserData[
                                                                  'genders_id'] ==
                                                              "2"
                                                          ? const NetworkImage(
                                                              ImageAssets
                                                                  .dummyImage1) // Second image for genderId == 2
                                                          : const NetworkImage(
                                                              ImageAssets
                                                                  .dummyImage2) // Third image for any other case
                                                  : NetworkImage(
                                                      'https://mio.eigix.net/${currentUserData['avatars'][0]['image']}'),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  ImageAssets.locationWhite),
                                              const MyText(
                                                text: "1.4 Km",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 25,
                                            height: 25,
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: currentUserData[
                                                            'image'] ==
                                                        null
                                                    ? currentUserData[
                                                                'genders_id'] ==
                                                            "1"
                                                        ? const NetworkImage(
                                                            ImageAssets
                                                                .dummyImage) // First image for genderId == 1
                                                        : currentUserData[
                                                                    'genders_id'] ==
                                                                "2"
                                                            ? const NetworkImage(
                                                                ImageAssets
                                                                    .dummyImage1) // Second image for genderId == 2
                                                            : const NetworkImage(
                                                                ImageAssets
                                                                    .dummyImage2)
                                                    : NetworkImage(
                                                        'https://mio.eigix.net/${currentUserData['image']}',
                                                      ),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            text:
                                                "${currentUserData['username']}, ${calculateAge(currentUserData['date_of_birth'])}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),

              //userlikedby/////
              selectedIndex4 == true
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.57,
                      child: LiveGrid.options(
                        options: options,
                        itemCount: userDataList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.1,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                        ),
                        itemBuilder: (
                          BuildContext context,
                          int index,
                          Animation<double> animation,
                        ) {
                          // String randomMainImage =
                          //     mainImages[Random().nextInt(mainImages.length)];
                          Map<String, dynamic> currentUserData =
                              userDataList[index];
                          return FadeTransition(
                            opacity: Tween<double>(
                              begin: 0,
                              end: 1,
                            ).animate(animation),
                            // And slide transition
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.1),
                                end: Offset.zero,
                              ).animate(animation),
                              // Paste you Widget
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ExploreVideoView(
                                        userid: currentUserData[
                                            'users_customers_id'],
                                        match: 'no'),
                                    duration: const Duration(seconds: 1),
                                    transition: Transition.native,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 160,
                                          height: 160,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: (currentUserData[
                                                              'avatars'] ==
                                                          null ||
                                                      currentUserData['avatars']
                                                          .isEmpty)
                                                  ? currentUserData[
                                                              'genders_id'] ==
                                                          "1"
                                                      ? const NetworkImage(
                                                          ImageAssets
                                                              .dummyImage) // First image for genderId == 1
                                                      : currentUserData[
                                                                  'genders_id'] ==
                                                              "2"
                                                          ? const NetworkImage(
                                                              ImageAssets
                                                                  .dummyImage1) // Second image for genderId == 2
                                                          : const NetworkImage(
                                                              ImageAssets
                                                                  .dummyImage2) // Third image for any other case
                                                  : NetworkImage(
                                                      'https://mio.eigix.net/${currentUserData['avatars'][0]['image']}'),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  ImageAssets.locationWhite),
                                              const MyText(
                                                text: "1.4 Km",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 25,
                                            height: 25,
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: currentUserData[
                                                            'image'] ==
                                                        null
                                                    ? currentUserData[
                                                                'genders_id'] ==
                                                            "1"
                                                        ? const NetworkImage(
                                                            ImageAssets
                                                                .dummyImage) // First image for genderId == 1
                                                        : currentUserData[
                                                                    'genders_id'] ==
                                                                "2"
                                                            ? const NetworkImage(
                                                                ImageAssets
                                                                    .dummyImage1) // Second image for genderId == 2
                                                            : const NetworkImage(
                                                                ImageAssets
                                                                    .dummyImage2)
                                                    : NetworkImage(
                                                        'https://mio.eigix.net/${currentUserData['image']}',
                                                      ),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                            text:
                                                "${currentUserData['username']}, ${calculateAge(currentUserData['date_of_birth'])}",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
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
}
