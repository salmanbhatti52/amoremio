import 'dart:convert';

import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Screen/ExplorePages/ExploreBackgroundContainer.dart';
import 'package:amoremio/Widgets/AppBar.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Monetize extends StatefulWidget {
  const Monetize({super.key});

  @override
  State<Monetize> createState() => _MonetizeState();
}

class _MonetizeState extends State<Monetize> {

  bool isLoading = false;
  List getMonetizeChat = [];

  getMonetizations() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = 'https://mio.eigix.net/apis/services/get_monetizations';
    http.Response response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "users_customers_id": userId,
            "monetization_type":"chat"
          },
        ));
    if (mounted) {
      setState(() {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['data'] != null &&
              jsonResponse['data'] is List<dynamic>) {
            getMonetizeChat = jsonResponse['data'];
            // parentMessage = jsonResponse['status'];
            debugPrint("getMonetize: $getMonetizeChat");
            isLoading = false;
          } else {
            isLoading = false;
          }
        } else {
          debugPrint("Response Bode::${response.body}");
          isLoading = false;
        }
      });
    }
  }

  List getMonetizeCall = [];

  getMonetizationsCall() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    String apiUrl = 'https://mio.eigix.net/apis/services/get_monetizations';
    http.Response response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "users_customers_id": userId,
            "monetization_type":"call"
          },
        ));
    if (mounted) {
      setState(() {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['data'] != null &&
              jsonResponse['data'] is List<dynamic>) {
            getMonetizeCall = jsonResponse['data'];
            debugPrint("getMonetizeCall: $getMonetizeCall");
            isLoading = false;
          } else {
            isLoading = false;
          }
        } else {
          debugPrint("Response Bode::${response.body}");
          isLoading = false;
        }
      });
    }
  }

  callFunction() async {
    await getMonetizations();
    await getMonetizationsCall();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Monetizations",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(ImageAssets.yourCoins),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                    const MyText(
                      text: "Earn money will interacting other users.",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.hintTextColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText(
                      text: "Monetize Chat",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    Container(
                      width: Get.width * 0.1,
                      height: Get.height * 0.05,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: Get.width * 0.95,
                  height: Get.height * 0.3,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: isLoading
                      ? const Center(
                    child: SpinKitPouringHourGlassRefined(
                      color: AppColor.primaryColor,
                      size: 80,
                      strokeWidth: 3,
                      duration: Duration(seconds: 1),
                    ),
                  )
                  : getMonetizeChat.isNotEmpty ?
                       ListView.builder(
                      shrinkWrap: true,
                      itemCount: getMonetizeChat.length,
                      itemBuilder: (context, index) {
                        var monetization = getMonetizeChat[index];
                        return Container(
                          width: Get.width * 0.9,
                          height: Get.height * 0.1,
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 24,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyText(text: monetization["name"],  color: AppColor.blackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                                    MyText(text: "(${monetization["package_type"]})", color: AppColor.blackColor, fontSize: 12, fontWeight: FontWeight.w400,),
                                  ],
                                ),
                                MyText(text: "${monetization["coins"]} Coins", color: AppColor.primaryColor, fontSize: 12, fontWeight: FontWeight.w400,),
                                LargeButton(text: monetization["status"],fontSize: 15, onTap: (){}, width: Get.width * 0.2, height: Get.height * 0.04,)
                              ],
                            ),
                          ),
                        );
                      },
                  )
                      : const Center(
                    child: MyText(text: "No monetization type found!", fontSize: 18, color: AppColor.primaryColor,),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyText(
                      text: "Monetize Call",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                    Container(
                      width: Get.width * 0.1,
                      height: Get.height * 0.05,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: Get.width * 0.95,
                  height: Get.height * 0.3,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: isLoading
                      ? const Center(
                    child: SpinKitPouringHourGlassRefined(
                      color: AppColor.primaryColor,
                      size: 80,
                      strokeWidth: 3,
                      duration: Duration(seconds: 1),
                    ),
                  )
                      : getMonetizeCall.isNotEmpty ?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: getMonetizeCall.length,
                    itemBuilder: (context, index) {
                      var monetizationCall = getMonetizeCall[index];
                      return Container(
                        width: Get.width * 0.9,
                        height: Get.height * 0.1,
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 24,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText(text: monetizationCall["name"],  color: AppColor.blackColor, fontSize: 14, fontWeight: FontWeight.w500,),
                                  MyText(text: "(${monetizationCall["package_type"]})", color: AppColor.blackColor, fontSize: 12, fontWeight: FontWeight.w400,),
                                ],
                              ),
                              MyText(text: "${monetizationCall["coins"]} Coins", color: AppColor.primaryColor, fontSize: 12, fontWeight: FontWeight.w400,),
                              LargeButton(text: monetizationCall["status"],fontSize: 15, onTap: (){}, width: Get.width * 0.2, height: Get.height * 0.04,)
                            ],
                          ),
                        ),
                      );
                    },
                  )
                  : const Center(
                    child: MyText(text: "No monetization type found!", fontSize: 18, color: AppColor.primaryColor,),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
