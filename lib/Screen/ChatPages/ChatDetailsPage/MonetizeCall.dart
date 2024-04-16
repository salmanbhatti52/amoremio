import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MonetizeCall extends StatefulWidget {
  const MonetizeCall({Key? key}) : super(key: key);

  @override
  State<MonetizeCall> createState() => _MonetizeCallState();
}

class _MonetizeCallState extends State<MonetizeCall> {

  List<String> genderType = [
    "2 coin call",
    "4 coin call",
    "6 coin call"
  ];

  String? selectedGender;
  int selectedIndex = -1;

  void selectContainer(int index) {
    setState(() {
      selectedIndex = index;
      print(selectedIndex);
    });
  }

  bool isLoading = false;

  addMonetization() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = 'https://mio.eigix.net/apis/services/add_monetizations';
    http.Response response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "users_customers_id": userId,
            "monetization_type": "call",
            "coins": selectedGender,
            "duration": selectedIndex == 0 ? "24h" : selectedIndex == 1 ? "48h" : selectedIndex == 2 ? "7d" : selectedIndex == 3 ? "Permanent" : "",
            "name": "Calling"
          },
        ));
    debugPrint("users_customers_id: $userId");
    debugPrint("coins: $selectedGender");
    debugPrint("duration: $selectedIndex");
    if (mounted) {
      setState(() {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['status'] == "success") {
            String message = jsonResponse['status'];
            debugPrint("message: $message");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Package activated successfully!")));
            isLoading = false;
            Get.back();
          } else {
            String message = jsonResponse['message'];
            debugPrint("message: $message");
            isLoading = false;
          }
        } else {
          debugPrint("Response Bode::${response.body}");
          isLoading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Dialog(
        backgroundColor: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width * 0.8, //350,
              height: Get.height * 0.61, // 321,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        const MyText(
                          text: "Monetize",
                          fontSize: 18,
                          color: AppColor.secondaryColor,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.clear,
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  SvgPicture.asset(ImageAssets.coins),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const MyText(
                    text: "Make money by calling with this user!",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF727171),
                  ),
                  const MyText(
                    text: "How does this work?",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFFFF005B),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyText(
                          text: "Duration",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF242222),
                        ),
                        SizedBox(height: Get.height * 0.013),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width * 0.015,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectContainer(0);
                              },
                              child: Container(
                                width: Get.width * 0.13,
                                height: Get.height * 0.045,
                                // width: 51,
                                // height: 38,
                                decoration: ShapeDecoration(
                                  color: selectedIndex == 0
                                      ? AppColor.secondaryColor
                                      : AppColor.whiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
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
                                child: Center(
                                  child: MyText(
                                    text: "24h",
                                    color: selectedIndex == 0
                                        ? AppColor.whiteColor
                                        : const Color(0xFF727171),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectContainer(1);
                              },
                              child: Container(
                                width: Get.width * 0.13,
                                height: Get.height * 0.045,
                                decoration: ShapeDecoration(
                                  color: selectedIndex == 1
                                      ? AppColor.secondaryColor
                                      : AppColor.whiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
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
                                child: Center(
                                  child: MyText(
                                    text: "48h",
                                    color: selectedIndex == 1
                                        ? AppColor.whiteColor
                                        : const Color(0xFF727171),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectContainer(2);
                              },
                              child: Container(
                                width: Get.width * 0.13,
                                height: Get.height * 0.045,
                                decoration: ShapeDecoration(
                                  color: selectedIndex == 2
                                      ? AppColor.secondaryColor
                                      : AppColor.whiteColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
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
                                child: Center(
                                  child: MyText(
                                    text: "7d",
                                    color: selectedIndex == 2
                                        ? AppColor.whiteColor
                                        : const Color(0xFF727171),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectContainer(3);
                              },
                              child: Container(
                                width: Get.width * 0.25,
                                height: Get.height * 0.045,
                                decoration: ShapeDecoration(
                                  color: selectedIndex == 3
                                      ? AppColor.secondaryColor
                                      : AppColor.whiteColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 24,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: MyText(
                                    text: "Permanent",
                                    color: selectedIndex == 3
                                        ? AppColor.whiteColor
                                        : const Color(0xFF727171),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MyText(
                        text: "Set Amount",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF242222),
                      ),
                      SizedBox(height: Get.height * 0.013),
                      Container(
                        width: Get.width * 0.7,
                        height: Get.height * 0.06,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
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
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColor.hintTextColor,
                              ),
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
                                hintText: 'Choose Coins',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                errorStyle: const TextStyle(
                                  color: AppColor.redColor,
                                  fontSize: 10,
                                  fontFamily: 'Inter-Bold',
                                ),
                              ),
                              borderRadius: BorderRadius.circular(12),
                              items: genderType
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                  value: item,
                                  // onTap: selectedGender = null,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: selectedGender != null
                                          ? AppColor.hintTextColor
                                          : AppColor.blackColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                              value: selectedGender,
                              onChanged: (value) {
                                selectedGender = value;
                                debugPrint("selectedGender: $selectedGender");
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.045,
                  ),
                  GestureDetector(
                    // onTap: () {
                    //   Get.back();
                    //   showDialog(
                    //     context: context,
                    //     barrierColor: Colors.grey.withOpacity(0.9),
                    //     barrierDismissible: false,
                    //     builder: (BuildContext context) => Dialog(
                    //       backgroundColor: Colors.transparent,
                    //       alignment: Alignment.center,
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Container(
                    //             width: Get.width * 0.8, //350,
                    //             height: Get.height * 0.38, // 321,
                    //             decoration: BoxDecoration(
                    //               color: Colors.white,
                    //               borderRadius: BorderRadius.circular(20),
                    //             ),
                    //             child: Column(
                    //               children: [
                    //                 const SizedBox(
                    //                   height: 10,
                    //                 ),
                    //                 Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 10.0),
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       const SizedBox(),
                    //                       const MyText(
                    //                         text: "Monetize",
                    //                         fontSize: 18,
                    //                         color: AppColor.secondaryColor,
                    //                       ),
                    //                       GestureDetector(
                    //                         onTap: () {
                    //                           Get.back();
                    //                         },
                    //                         child: const Icon(
                    //                           Icons.clear,
                    //                           color: AppColor.blackColor,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   height: Get.height * 0.025,
                    //                 ),
                    //                 SvgPicture.asset(ImageAssets.coins),
                    //                 SizedBox(
                    //                   height: Get.height * 0.025,
                    //                 ),
                    //                 const Padding(
                    //                   padding: EdgeInsets.symmetric(
                    //                       horizontal: 12.0),
                    //                   child: MyText(
                    //                     text:
                    //                         "You can charge users for messages, and they'll need to buy coins if they don't have any to send messages.",
                    //                     fontWeight: FontWeight.w400,
                    //                     fontSize: 14,
                    //                     color: Color(0xFF727171),
                    //                   ),
                    //                 ),
                    //                 SizedBox(
                    //                   height: Get.height * 0.025,
                    //                 ),
                    //                 GestureDetector(
                    //                   onTap: () {},
                    //                   child: Container(
                    //                     width: Get.width * 0.6,
                    //                     height: Get.height * 0.065,
                    //                     clipBehavior: Clip.antiAlias,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(30),
                    //                       gradient: const LinearGradient(
                    //                         colors: [
                    //                           AppColor.primaryColor,
                    //                           AppColor.secondaryColor,
                    //                         ],
                    //                         begin: Alignment(0.20, -0.98),
                    //                         end: Alignment(-0.2, 0.98),
                    //                       ),
                    //                     ),
                    //                     child: const Center(
                    //                       child: MyText(
                    //                         text: "Ok",
                    //                         fontSize: 18,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   );
                    // },
                    onTap: () {
                      print(selectedGender);
                      print(selectedIndex);
                      if(selectedGender != null && selectedIndex != -1){
                        addMonetization();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select all fields")));
                      }
                    },
                    child: Container(
                      width: Get.width * 0.6,
                      height: Get.height * 0.065,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            AppColor.primaryColor,
                            AppColor.secondaryColor,
                          ],
                          begin: Alignment(0.20, -0.98),
                          end: Alignment(-0.2, 0.98),
                        ),
                      ),
                      child: const Center(
                        child: MyText(
                          text: "Save",
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}