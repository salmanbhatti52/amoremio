import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'StatsChart.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:http/http.dart' as http;
class StatsStory extends StatefulWidget {
  final double height;
  final Function onTap;
  const StatsStory({
    super.key,
    required this.height,
    required this.onTap,
  });

  @override
  State<StatsStory> createState() => _StatsStoryState();
}

class _StatsStoryState extends State<StatsStory> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStats();
  }

  Map<String, dynamic> stats = {};
  var userName = "";
  void getStats() async {
    String apiUrl =
        "https://amoremio.lared.lat/apis/services/get_user_stories_stats";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('users_customers_id');
    var userName1 = prefs.getString('username');
    setState(() {
      userName = userName1.toString();
    });
    debugPrint("userName $userName");
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_customers_id": userId,
            },
          ),
      );
      debugPrint(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {});
        stats = data['data'];
      } else {
        debugPrint("status ${data['status']}");
        var errorMsg = data['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } catch (e) {
      debugPrint('e $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Container(
            width: Get.width * 0.9,
            height: Get.height * 0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.whiteColor,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyText(
                    text: userName,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset(
                        width: 25,
                        height: 25,
                        color: AppColor.primaryColor,
                        ImageAssets.createStory2,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      MyText(
                        text: stats.isNotEmpty ? stats['user_likes'].toString() : "0",
                        color: AppColor.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
                ]),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Container(
            height: Get.height * 0.5,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColor.whiteColor,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 18, right: 18, top: 15, bottom: Get.height * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        text: "Analysis",
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      Row(
                        children: [
                          const MyText(
                            text: "Weekly",
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          SvgPicture.asset(ImageAssets.dropBlack),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 18,
                            height: 8,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE43552),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const MyText(
                            text: "Hot Likes",
                            color: AppColor.primaryColor,
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 18,
                            height: 8,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFE0CF36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const MyText(
                            text: "Coins",
                            color: Color(0xFFFA9114),
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 18,
                            height: 8,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFA9114),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const MyText(
                            text: "Views",
                            color: Color(0xFFC6B625),
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.20,
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: const StatsChart(),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.04,),
                Divider(
                  color: const Color(0xFFBCBCBC).withOpacity(0.5),
                  height: 1,
                  indent: 20,
                  endIndent: 40,
                ),
                SizedBox(height: Get.height * 0.04,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFE43552),
                              shape: OvalBorder(),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const MyText(
                            text: "Hot Likes",
                            color: AppColor.primaryColor,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFFA9114),
                              shape: OvalBorder(),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const MyText(
                            text: "Coins",
                            color: Color(0xFFFA9114),
                            fontSize: 14,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFC6B625),
                              shape: OvalBorder(),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const MyText(
                            text: "Views",
                            color: Color(0xFFC6B625),
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: stats.isNotEmpty ? stats["stories_likes"].toString() : "",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF393939),
                        align: TextAlign.center,
                      ),
                      MyText(
                        text: stats.isNotEmpty ? stats["user_coins"] : "",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF393939),
                      ),
                      MyText(
                        text: stats.isNotEmpty ? stats["stories_views"].toString() : "",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF393939),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
