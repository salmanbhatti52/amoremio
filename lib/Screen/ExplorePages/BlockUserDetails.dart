import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utills/AppUrls.dart';
import '../../Widgets/RoundedButton.dart';
import '../../Resources/assets/assets.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Resources/colors/colors.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../Widgets/background_Image_container.dart';
import '../BottomNavigationBar/BottomNavigationBar.dart';
import 'package:http/http.dart' as http;

class BlockUserDetails extends StatefulWidget {
  final String userid;
  const BlockUserDetails({super.key, required this.userid});

  @override
  State<BlockUserDetails> createState() => _BlockUserDetailsState();
}

class _BlockUserDetailsState extends State<BlockUserDetails> {
  final List<String> imgList = [
    ImageAssets.exploreImage,
    ImageAssets.image1,
    ImageAssets.image2,
    ImageAssets.image3,
    ImageAssets.introImage,
  ];

  String address = '';
  var username = '';
  var dateofbirth;
  int _current = 0;
  List<dynamic> imgListavators = [];
  bool isLoading = true;
  final CarouselController _controller = CarouselController();

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
      } else {
        print(userdetail['status']);
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

  unblockuser() async {
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
      "status": "Unblocked"
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

      setState(() {
        Get.to(
          () => MyBottomNavigationBar(),
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

  @override
  Widget build(BuildContext context) {
    // List<Widget> imageSliders = [];
    // for (int index = 0; index < imgList.length; index++) {
    //   imageSliders.add(
    //     ImageContainer(
    //       imagePath: imgList[index],
    //       child: SizedBox(),
    //     ),
    //   );
    // }
    List<Widget> imageSliders = [];
    for (int index = 0; index < imgListavators.length; index++) {
      imageSliders.add(Image.network(
        baseUrlImage + imgListavators[index]['image'],
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        fit: BoxFit.fill,
      ));
    }
    return Scaffold(
      body: Stack(
        children: [
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
                  child: Image.network(
                    ImageAssets.dummyImage,
                    fit: BoxFit.fill,
                  ),
                ),
          Positioned(
            bottom: Get.height * 0.315,
            left: Get.width * 0.355,
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
              icon: ImageAssets.image1,
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
              icon: ImageAssets.image2,
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
              icon: ImageAssets.mediumImage,
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
                          color: Color(0xFF3B3B3B),
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
                            Get.to(
                              MyBottomNavigationBar(),
                              duration: const Duration(milliseconds: 350),
                              transition: Transition.downToUp,
                            );
                          },
                          child: SvgPicture.asset(ImageAssets.explore2)),
                      LargeButton(
                        text: "Unblock",
                        onTap: () {
                          // Get.back();
                          unblockuser();
                        },
                        width: Get.width * 0.65,
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
