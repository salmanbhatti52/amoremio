import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Utills/AppUrls.dart';
import 'BlockedUser.dart';
import 'package:get/get.dart';
import 'ExploreUserAbout.dart';
import 'package:flutter/material.dart';
import '../../Widgets/RoundedButton.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../../Widgets/background_Image_container.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ExploreVideoView extends StatefulWidget {
  final String userid;
  const ExploreVideoView({Key? key, required this.userid}) : super(key: key);

  @override
  State<ExploreVideoView> createState() => _ExploreVideoViewState();
}

class _ExploreVideoViewState extends State<ExploreVideoView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animateController = AnimationController(
      duration: const Duration(milliseconds: 200), vsync: this, value: 1.0);
  bool isButtonClicked = false;

  void handleButtonTap() {
    setState(() {
      isButtonClicked = !isButtonClicked;
    });
  }

  void handleRoundedButtonTap() {
    setState(() {
      isButtonClicked = !isButtonClicked;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animateController.dispose();
  }

  final List<String> imgList = [
    ImageAssets.exploreImage,
    ImageAssets.image1,
    ImageAssets.image2,
    ImageAssets.image3,
    ImageAssets.introImage,
  ];
  List<dynamic> imgListavators = [];
  List<dynamic> userDataList = [];
  String address = '';
  var username = '';
  var dateofbirth;
  int _current = 0;
  bool isLoading = true;

  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  void loaddata() async {
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
        // print(userdetail);
        getavators();
        setState(() {});
        username = userdetail['data']['username'];
        dateofbirth = userdetail['data']['date_of_birth'];
        address = userdetail['data']['location'];
        fetchuserliked();
      } else {
        // print(userdetail['status']);
        var errormsg = userdetail['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error123456: $e');
    }
  }

  getavators() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    // setState(() {
    //   isLoading = true; // Show loader
    // });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
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
        print('avatoes::::: ${response.body}');
        // imgurl = baseUrlImage + data['data']['image'];
        imgListavators = data['data'];
        setState(() {
          Navigator.of(context).pop();
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
        userDataList = data['data'];
        for (var i = 0; i < userDataList.length; i++) {
          if (userDataList[i]['liked_user']['users_customers_id'] ==
              widget.userid) {
            setState(() {
              isButtonClicked = !isButtonClicked;
            });
          }
        }
        // print(userDataList);
        // images = baseUrlImage + data['data']['image'];
      } else {
        print(data['status']);
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
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
      "status": "Blocked"
    };
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(showdata));
    print(showdata);
    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      print('success');
      Navigator.of(context).pop();
      var msg = userdetail['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      setState(() {});
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
      "liked_id": widget.userid,
      "likers_id": userId,
      "status": "Like"
    };
    var showdata2 = {
      "liked_id": widget.userid,
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
      var msg = userdetail['message'];
      print('userdetail $userdetail');
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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

  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders = [];
    for (int index = 0; index < imgListavators.length; index++) {
      imageSliders.add(Image.network(
        baseUrlImage + imgListavators[index]['image'],
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        fit: BoxFit.fill,
      )
          // ImageContainer(
          //   imagePath: imgList[index],
          //   child: const SizedBox(),
          // ),
          );
    }

    return Scaffold(
      body: Stack(
        children: [
          // if (isLoading)
          //   Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // ImageContainer(
          //   child: Image.asset(image1 ? image2 ? ImageAssets.image2 : ImageAssets.introImage : ImageAssets.introImage),
          // ),
          imgListavators.isNotEmpty
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
              : ImageContainer(
                  child: Image.asset(ImageAssets.introImage),
                ),
          Positioned(
            bottom: Get.height * 0.315,
            left: Get.width * 0.405,
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
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.355,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: image1 ?  AppColor.whiteColor : Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.395,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: image2 ?  AppColor.whiteColor : Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.43,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.47,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.51,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: Colors.white30,
          //   ),
          // ),
          // Positioned(
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.55,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: Colors.white30,
          //   ),
          // ),
          Positioned(
            bottom: Get.height * 0.23,
            left: Get.width * 0.06,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.introImage,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.23,
            left: Get.width * 0.24,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.image2,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.23,
            left: Get.width * 0.43,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.introImage,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.23,
            right: Get.width * 0.24,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.image3,
            ),
          ),
          Positioned(
            bottom: Get.height * 0.23,
            right: Get.width * 0.06,
            child: RoundedImage(
              onTap: () {},
              width: Get.width * 0.15,
              height: Get.height * 0.07,
              containerColor: AppColor.whiteColor,
              icon: ImageAssets.exploreImage,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              // width: 172,
              height: Get.height * 0.22,
              decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(27),
                  topRight: Radius.circular(27),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      // if (exploreController.isButtonClicked.value) {
                      aboutExploreUser(context);
                      // }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.28),
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
                      bottom: Get.height * 0.01,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: "$username, ${calculateAge(dateofbirth)}",
                          fontSize: 18,
                          color: AppColor.blackColor,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              ImageAssets.createStory1,
                              color: AppColor.secondaryColor,
                            ),
                            const MyText(
                              text: "0",
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
                        left: Get.width * 0.06, bottom: Get.height * 0.02),
                    child: Row(
                      children: [
                        // SvgPicture.asset(ImageAssets.locationWhite, color: AppColor.secondaryColor,),
                        const Icon(
                          Icons.location_on,
                          color: AppColor.secondaryColor,
                          size: 17,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        MyText(
                          text: "$address, ${'2.5 Km'}",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: const Color(0xFF3B3B3B),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(ImageAssets.explore2)),
                      RoundedButton(
                        onTap: () {
                          blockuser();
                          // Get.to(
                          //   () => BlockedUser(),
                          //   duration: const Duration(milliseconds: 350),
                          //   transition: Transition.downToUp,
                          // );
                        },
                        icon: ImageAssets.block,
                      ),
                      ScaleTransition(
                        scale: Tween(begin: 0.5, end: 1.0).animate(
                            CurvedAnimation(
                                parent: _animateController,
                                curve: Curves.easeOut)),
                        child: RoundedButton(
                          onTap: () {
                            // handleButtonTap();
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
                          containerColor: isButtonClicked
                              ? Colors.red
                              : AppColor.whiteColor,
                        ),
                      ),
                      SvgPicture.asset(ImageAssets.share),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int calculateAge(String? dateOfBirth) {
    if (dateOfBirth == null) {
      // Handle the case when dateOfBirth is null
      return 0; // or any default value
    }

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
