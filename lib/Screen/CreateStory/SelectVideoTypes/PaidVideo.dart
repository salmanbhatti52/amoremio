import 'dart:convert';

import 'package:amoremio/Screen/BottomNavigationBar/BottomNavigationBar.dart';
import 'package:amoremio/Utills/AppUrls.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../../Widgets/large_Button.dart';
import '../../../Resources/assets/assets.dart';
import 'package:http/http.dart' as http;
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PaidVideo extends StatefulWidget {
  final double height;
  final String base64Image;
  final String sourceType;
  final VoidCallback onPauseVideo;
   PaidVideo({super.key,
     required this.height,
     required this.base64Image,
     required this.sourceType,
     required this.onPauseVideo});

  @override
  State<PaidVideo> createState() => _PaidVideoState();
}

class _PaidVideoState extends State<PaidVideo> {
  List<String> priceSet = ["5 coins", "10 coins", "15 coins"];
  String? setPrice;
  VideoPlayerController? playerController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    playerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const MyText(text: "Your story is set to be Paid for everyone,  and you\ncan alter or retract it even after uploading.", fontSize: 14, fontWeight: FontWeight.w400,),
          Container(
            width: Get.width * 0.8,
            height: Get.height * 0.06,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: AppColor.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 24,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.hintTextColor,),
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        ImageAssets.healthicons,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColor.whiteColor,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      borderSide: BorderSide(
                        color: AppColor.redColor,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    hintText: 'Set Price',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColor.hintTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    errorStyle: const TextStyle(
                      color: AppColor.redColor,
                      fontSize: 10,
                      fontFamily: 'Inter-Bold',
                    ),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  items: priceSet
                      .map(
                        (item) => DropdownMenuItem<String>(
                      value: item,
                      // onTap: setPrice = null,
                      child: Text(
                        item,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: setPrice != null
                              ? AppColor.hintTextColor
                              : AppColor.blackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  value: setPrice,
                  onChanged: (value) {
                    setState(() {
                      setPrice = value;
                    });
                    print("setPrice $setPrice");
                  },
                ),
              ),
            ),
          ),
          LargeButton(
            text: "Upload",
            onTap: () {
              uploadstory(widget.base64Image, widget.sourceType);
              // _showBottomSheet();
            },
            containerColor: AppColor.whiteColor,
            gradientColor1: AppColor.whiteColor,
            gradientColor2: AppColor.whiteColor,
            borderColor: AppColor.whiteColor,
            textColor: AppColor.secondaryColor,
          ),
        ],
      ),
    );
  }

  void uploadstory(base64Image, sourceType) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print(userId);
    String apiUrl = createStories;
    try {
      var showdata = {
        "users_customers_id": userId,
        "coins_per_view": setPrice,
        "story_type": "Paid",
        "media_type": "Image",
        "media": base64Image
      };
      var showdata2 = {
        "users_customers_id": userId,
        "coins_per_view": setPrice,
        "story_type": "Paid",
        "media_type": "Video",
        "media": base64Image
      };
      print("showdata $showdata");
      print("showdata2 $showdata2");
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(sourceType == 'Video' ? showdata2 : showdata));
      print(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        Navigator.of(context).pop();
        widget.onPauseVideo();
        Get.to(
              () => const MyBottomNavigationBar(),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
      } else {
        print(data['status']);
        var errormsg = data['message'];
      }
    } catch (e) {
      print('error user discover $e');
    }
  }
}
