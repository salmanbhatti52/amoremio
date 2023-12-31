import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Resources/assets/assets.dart';
import '../../Utills/AppUrls.dart';
import '../../Widgets/Text.dart';
import 'BlockUserDetails.dart';
import '../../Widgets/AppBar.dart';
import 'ExploreVideoViewButton.dart';
import 'package:flutter/material.dart';
import 'ExploreBackgroundContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../BottomNavigationBar/BottomNavigationBar.dart';
import 'package:http/http.dart' as http;
// Future blockedUser(BuildContext context) {
//   return showFlexibleBottomSheet(
//     minHeight: 0,
//     initHeight: 0.65,
//     maxHeight: 0.65,
//     context: context,
//     bottomSheetBorderRadius: const BorderRadius.only(
//       topLeft: Radius.circular(30),
//       topRight: Radius.circular(30),
//     ),
//     builder: _buildBottomSheet,
//     isExpand: false,
//   );
// }
//
// Widget _buildBottomSheet(
//   BuildContext context,
//   ScrollController scrollController,
//   double bottomSheetOffset,
// ) {
//   return Material(
//     child: ListView(
//       controller: scrollController,
//       shrinkWrap: true,
//       children: [
//         const SizedBox(
//           height: 10,
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: Get.width * 0.28),
//           child: Container(
//             height: 7,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               color: const Color(0xFFFFC3C3),
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: Get.height * 0.035),
//           child: const MyText(
//             text: "Blocked Users",
//             fontSize: 18,
//             color: AppColor.blackColor,
//           ),
//         ),
//         Container(
//           color: Colors.white.withOpacity(0.800000011920929),
//           height: Get.height * 0.61, //300,
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             itemCount: 12,
//             itemBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: Get.width * 0.03, vertical: Get.height * 0.011),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                             backgroundColor: Colors.transparent,
//                             backgroundImage:
//                                 Image.asset(ImageAssets.smallPic).image),
//                         const SizedBox(
//                           width: 13,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const MyText(
//                               text: "Lady Samurai, 21",
//                               color: AppColor.blackColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             Row(
//                               children: [
//                                 Row(
//                                   children: [
//                                     SvgPicture.asset(
//                                       ImageAssets.locationWhite,
//                                       color: AppColor.secondaryColor,
//                                     ),
//                                     const MyText(
//                                       text: "Tokyo 2.5 Km",
//                                       color: Color(0xFF3B3B3B),
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SmallButton(
//                       text: "Unblock",
//                       textColor: AppColor.secondaryColor,
//                       onTap: () {},
//                       containerColor: Colors.transparent,
//                       borderColor: const Color(0xFFD5D5D5),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }

class BlockedUser extends StatefulWidget {
  const BlockedUser({Key? key}) : super(key: key);

  @override
  State<BlockedUser> createState() => _BlockedUserState();
}

class _BlockedUserState extends State<BlockedUser> {
  final TextEditingController searchController = TextEditingController();
  bool status = false;

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

  void toggleSwitch(bool newValue) {
    setState(() {
      status = newValue;
    });
  }

  List<dynamic> userDataList = [];
  List<dynamic> mainImages = [
    ImageAssets.exploreImage,
    ImageAssets.image1,
    ImageAssets.image2,
    ImageAssets.image3,
    ImageAssets.introImage,
    // Add more image assets as needed
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchuserBlocked();
  }

  void fetchuserBlocked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = getuserblocked;
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
      // print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {});
        userDataList = data['data']['data'];
        print(userDataList);
        // images = baseUrlImage + data['data']['image'];
      } else {
        print(data['status']);
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error:: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Blocked Users",
        onTap: () {
          Get.to(() => MyBottomNavigationBar());
        },
      ),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              Container(
                width: Get.width * 0.9,
                height: Get.height * 0.055,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.whiteColor,
                ),
                child: Center(
                  child: TextField(
                    autofocus: false,
                    cursorColor: AppColor.hintTextColor,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColor.hintTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.03, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColor.hintContainerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: AppColor.hintContainerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          size: 25,
                          color: AppColor.hintTextColor,
                        ),
                      ),
                      hintText: "Search",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColor.hintTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              // ExploreVideoContainer(
              //   height: MediaQuery.of(context).size.height * 0.8,
              //   onTap: () {
              //     Get.to(
              //       () => const BlockUserDetails(),
              //       duration: const Duration(seconds: 1),
              //       transition: Transition.native,
              //     );
              //   },
              //   value: status,
              // ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: LiveGrid.options(
                  options: options,
                  itemCount: userDataList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    Map<String, dynamic> currentUserData = userDataList[index];
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
                              () => BlockUserDetails(
                                  userid: currentUserData['blocked_user']
                                      ['users_customers_id']),
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
                                        image: currentUserData['blocked_user']
                                                    ['image'] ==
                                                null
                                            ? AssetImage(ImageAssets.image1)
                                                as ImageProvider<Object>
                                            : NetworkImage(
                                                'https://mio.eigix.net/${currentUserData['blocked_user']['image']}',
                                              ),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
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
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: currentUserData['blocked_user']
                                                      ['image'] ==
                                                  null
                                              ? AssetImage(ImageAssets.image1)
                                                  as ImageProvider<Object>
                                              : NetworkImage(
                                                  'https://mio.eigix.net/${currentUserData['blocked_user']['image']}',
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
                                          "${currentUserData['blocked_user']['username']}, ${calculateAge(currentUserData['blocked_user']['date_of_birth'])}",
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
