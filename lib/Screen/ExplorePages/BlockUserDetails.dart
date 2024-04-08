import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../Utills/AppUrls.dart';
import '../../Resources/assets/assets.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../Resources/colors/colors.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../BottomNavigationBar/BottomNavigationBar.dart';
import 'package:http/http.dart' as http;

class BlockUserDetails extends StatefulWidget {
  final String userid;
  const BlockUserDetails({super.key, required this.userid});

  @override
  State<BlockUserDetails> createState() => _BlockUserDetailsState();
}

class _BlockUserDetailsState extends State<BlockUserDetails> {

  String address = '';
  var username = '';
  var dateofbirth;
  int _current = 0;
  List<dynamic> imgListavators = [];
  List<dynamic> uservideos = [];
  bool isLoading = false;
  bool isStoryLoading = false;
  final CarouselController _controller = CarouselController();
  Map<String, Uint8List?> thumbnails = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(' widget.userid ${ widget.userid}');
    loaddata();
  }

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
        print("userdetail $userdetail");
        getavators();
        setState(() {
          if (userdetail['data'] != null) {
            username = userdetail['data']['username'] ?? ''; // Assign default value if username is null
            dateofbirth = userdetail['data']['date_of_birth'] ?? ''; // Assign default value if date_of_birth is null
            address = userdetail['data']['location'] ?? ''; // Assign default value if location is null
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

  // userstories() async {
  //   setState(() {
  //     isStoryLoading = true;
  //   });
  //   String apiUrl = getuserallstories;
  //   try {
  //     final response = await http.post(Uri.parse(apiUrl),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode(
  //           {
  //             "users_customers_id": widget.userid,
  //           },
  //         ));
  //
  //     var data = jsonDecode(response.body);
  //     if (data['status'] == 'success') {
  //       print('user stories::::: ${response.body}');
  //       // imgurl = baseUrlImage + data['data']['image'];
  //       uservideos = data['data'];
  //       await generateAllThumbnails(uservideos);
  //       setState(() {
  //         isStoryLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isStoryLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isStoryLoading = false;
  //     });
  //     print('errorfound $e');
  //   }
  // }

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
      setState(
          () {}); // Only call setState if at least one thumbnail was updated
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
        // userstories();
        setState(() {
          isLoading = false;
        });
      } else {
        print('errorfoundgetavatarssssss');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('errorfoundgetavatar $e');
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
              : Container(color: Colors.grey),
          // : ImageContainer(
          //     child: Image.network(
          //       ImageAssets.dummyImage,
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          Positioned(
            bottom: Get.height * 0.25,
            // left: Get.width * 0.355,
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
          //   bottom: Get.height * 0.324,
          //   left: Get.width * 0.55,
          //   child: RoundedContainer(
          //     onTap: () {},
          //     containerColor: Colors.white30,
          //   ),
          // ),

          ////round image
          // Positioned(
          //   bottom: Get.height * 0.23,
          //   right: Get.width * 0.06,
          //   child: RoundedImage(
          //     onTap: () {},
          //     width: Get.width * 0.15,
          //     height: Get.height * 0.07,
          //     containerColor: AppColor.whiteColor,
          //     icon: ImageAssets.mediumImage,
          //   ),
          // ),
          // Positioned(
          //   bottom: 160,
          //   left: 0,
          //   right: 0,
          //   child: isStoryLoading
          //       ? const Center(child: Padding(
          //     padding: EdgeInsets.only(bottom: 32.0),
          //     child: CircularProgressIndicator(),
          //   ),
          //   )
          //       : SizedBox(
          //           height: MediaQuery.of(context).size.height * 0.10,
          //           width: MediaQuery.of(context).size.width,
          //           child: ListView.builder(
          //             shrinkWrap: true,
          //             scrollDirection: Axis.horizontal,
          //             itemCount: uservideos.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               var story = uservideos[index];
          //               var videoPath = story;
          //               if (videoPath['media_type'] == 'Video' &&
          //                   thumbnails.containsKey(story['media'])) {
          //                 return Padding(
          //                   padding: const EdgeInsets.only(right: 0.0),
          //                   child: Column(
          //                     children: [
          //                       Container(
          //                         margin: const EdgeInsets.only(
          //                             top: 1, left: 13, right: 1),
          //                         width: 60,
          //                         height: 60,
          //                         decoration: BoxDecoration(
          //                           color: Colors.transparent,
          //                           border: Border.all(
          //                             width: 2,
          //                             color: AppColor.whiteColor,
          //                           ),
          //                           borderRadius: BorderRadius.circular(30),
          //                         ),
          //                         child: ClipRRect(
          //                           borderRadius: BorderRadius.circular(30),
          //                           child: GestureDetector(
          //                             onTap: () {},
          //                             child: Image.memory(
          //                               thumbnails[story['media']]!,
          //                               fit: BoxFit.cover,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 );
          //               } else {
          //                 return Container(
          //                   margin: const EdgeInsets.only(
          //                     bottom: 12,
          //                     left: 10,
          //                   ),
          //                   width: 60,
          //                   height: 60,
          //                   decoration: ShapeDecoration(
          //                     image: DecorationImage(
          //                       image: NetworkImage(
          //                           'https://mio.eigix.net/${story['media']}'),
          //                       fit: BoxFit.fill,
          //                     ),
          //                     shape: const CircleBorder(
          //                       side: BorderSide(width: 2, color: Colors.white),
          //                     ),
          //                   ),
          //                 );
          //               }
          //             },
          //           ),
          //         ),
          // ),

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
                      bottom: Get.height * 0.00,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: "$username, ${calculateAge(dateofbirth)}",
                          fontSize: 18,
                          color: AppColor.blackColor,
                        ),
                        // Row(
                        //   children: [
                        //     SvgPicture.asset(
                        //       ImageAssets.createStory1,
                        //       color: AppColor.secondaryColor,
                        //     ),
                        //     const MyText(
                        //       text: "0",
                        //       fontWeight: FontWeight.w500,
                        //       fontSize: 14,
                        //       color: AppColor.secondaryColor,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.width * 0.05, bottom: Get.height * 0.02),
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
                        Expanded(
                          child: MyText(
                              text: "$address, ${'2.5 Km'}",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: const Color(0xFF3B3B3B),
                              align: TextAlign.left),
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
                              const MyBottomNavigationBar(),
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
                      GestureDetector(
                        onTap: (){
                          shareUserProfile();
                        },
                        child: SvgPicture.asset(ImageAssets.share),
                      ),
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

  bool isLoadings = false;
  Map<String, dynamic> shareProfile = {};

  shareUserProfile() async {
    setState(() {
      isLoadings = true;
    });
    String apiUrl = 'https://mio.eigix.net/apis/services/users_profile_shares';
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
            debugPrint("shareProfile ${jsonResponse["data"]}");
            Clipboard.setData(ClipboardData(text: shareProfile["data"])).then((_){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: MyText(
                text: "Linked copied successfully!",
                color: AppColor.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ), backgroundColor: AppColor.whiteColor,),);
            });
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
}
