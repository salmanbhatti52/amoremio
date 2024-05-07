import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utills/AppUrls.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ChatDetailsPage/ChatDetailsPage.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController searchController = TextEditingController();
  List<dynamic> userschat = [];
  bool ishown = false;
  String errormsg = '';

  List<dynamic> userDataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchusermatches();
    loaddata();
  }

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
        userDataList = data['data'];
      } else {
        var errormsg = data['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error :$e');
    }
  }

  void loaddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = getChats;
    // try {
    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {"users_customers_id": userId},
        ));
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      print(data);
      userschat = data['data'];
      if (mounted) {
        ishown = false;
        setState(() {});
      }
    } else {
      print(data['status']);

      if (mounted) {
        errormsg = data['message'];
        ishown = true;
        setState(() {});
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(errormsg)));
      }
    }
    // } catch (e) {
    //   print('error123456');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ExploreAppbar(title: "LOGO", title2: "Chat"),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.06,
                  vertical: Get.height * 0.02,
                ),
                child: Container(
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
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.06),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: userDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var user = userDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 7.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: ShapeDecoration(
                                    color: Colors.red,
                                    image: DecorationImage(
                                      image: user['image'] == null
                                          ? user['genders_id'] == "1"
                                              ? const NetworkImage(
                                                  ImageAssets.dummyImage,
                                                )
                                              : user['genders_id'] == "2"
                                                  ? const NetworkImage(
                                                      ImageAssets.dummyImage1,
                                                    )
                                                  : const NetworkImage(
                                                      ImageAssets.dummyImage2,
                                                    )
                                          : NetworkImage(
                                              'https://amoremio.lared.lat/${user['image']}',
                                            ),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: const BorderSide(
                                            color: Colors.white, width: 2.5)),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF48FF08),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            MyText(
                              text: user['username'],
                              color: const Color(0xFFFFD6D6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              ishown == true
                  ? Center(
                      child: Container(
                        child: MyText(
                          text: errormsg,
                          fontSize: 20,
                          align: TextAlign.center,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.58,
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: userschat.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> chats = userschat[index];
                            var image = (chats['user_data']['image'] == null ||
                                chats['user_data']['image'].isEmpty);
                            DateTime receivedTime = DateTime.parse(
                                chats['user_data']['last_message']
                                    ['created_at']);
                            String timeAgo = timeago.format(receivedTime,
                                locale: 'en_short');
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => ChatDetailsPage(
                                        userId: chats['user_data']
                                            ['users_customers_id']),
                                    duration: const Duration(milliseconds: 300),
                                    transition: Transition.rightToLeft);
                              },
                              child: FadeInUp(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    width: Get.width * 0.1,
                                    height: Get.height * 0.08,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF6F6),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.02),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: ShapeDecoration(
                                                  image: DecorationImage(
                                                    image: image
                                                        ? const NetworkImage(
                                                                ImageAssets.dummyImage) as ImageProvider<Object>
                                                        : NetworkImage(
                                                            baseUrlImage + chats['user_data']['image']),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  shape: const OvalBorder(),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.02,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  MyText(
                                                    text: chats['user_data']['username'],
                                                    color: AppColor.blackColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  if (chats['user_data']['last_message']['attachment_type'] == null)
                                                    MyText(
                                                      text: chats['user_data']['last_message']['message'],
                                                      color: const Color(0xFF727171),
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  if (chats['user_data']['last_message']['attachment_type'] == 'voice')
                                                    const MyText(
                                                        text: 'voice',
                                                        color: Color(0xFF727171),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                    ),
                                                  if (chats['user_data']['last_message']['attachment_type'] == 'image')
                                                    const MyText(
                                                        text: 'image',
                                                        color: Color(0xFF727171),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w400,
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                text: timeAgo,
                                                color: const Color(0xFF727171),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF48FF08),
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
