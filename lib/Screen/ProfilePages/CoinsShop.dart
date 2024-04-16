import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'CardAdd.dart';
import 'package:get/get.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:http/http.dart' as http;
import '../../Widgets/AppBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../Widgets/large_Button.dart';
import '../../Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';

class CoinsShop extends StatefulWidget {
  const CoinsShop({super.key});

  @override
  State<CoinsShop> createState() => _CoinsShopState();
}

class _CoinsShopState extends State<CoinsShop> {

  bool isLoading = false;
  String message = "";
  List getPackages = [];

  getPackage() async {
    setState(() {
      isLoading = true;
    });
    const apiUrl = 'https://mio.eigix.net/apis/services/packages';
    http.Response response = await http.post(Uri.parse(apiUrl),);
    if (mounted) {
      setState(() {
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['data'] != null &&
              jsonResponse['data'] is List<dynamic>) {
            getPackages = jsonResponse['data'];
            // parentMessage = jsonResponse['status'];
            debugPrint("getPDiaries: $getPackages");
            isLoading = false;
          } else {
            message = jsonResponse['status'];
            debugPrint("parentMessage: $message");
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getPackage();
  }

  Future<void> buyPackages(String packageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    String apiUrl = "https://mio.eigix.net/apis/services/buy_packages";
    try {
      var data1 = {
        "users_customers_id": userId,
        "packages_id": packageId
      };
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data1));
      var userdetail = jsonDecode(response.body);
      print(userdetail);
      if (userdetail['status'] == 'success') {
        setState(() {
          Navigator.of(context).pop();
          var errormsg = userdetail['message'];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MyText(
            text: "$errormsg",
            color: AppColor.primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ), backgroundColor: AppColor.whiteColor,),);
        });
      } else {
        Navigator.of(context).pop();
        print(userdetail['status']);
        var errormsg = userdetail['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      print('error123456 $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Shop",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Image.asset(ImageAssets.yourCoins),
              ),
              const SizedBox(
                height: 10,
              ),
              const MyText(
                text: "The bigger the package, the cheaper the coins.",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: Get.height * 0.69,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const MyText(
                      text: "Coin Packages",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: Get.height * 0.45,
                      child: isLoading
                          ? Center(child: CircularProgressIndicator()) : message != "success"
                          ? GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                          ),
                          itemCount: getPackages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                // Get.to(
                                //       () => const CardAdd(),
                                //   transition: Transition.rightToLeft,
                                //   duration: const Duration(milliseconds: 300),
                                // );
                                setState(() {
                                  String packageId = getPackages[index]["packages_id"];
                                  print(packageId);
                                  buyPackages(packageId);
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 149,
                                    height: 154,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFEDEDED),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 31,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                color: AppColor.secondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child:  MyText(
                                                text: getPackages[index]["extra_coins"] ?? "0",
                                                fontSize: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                         MyText(
                                          text: getPackages[index]["name"],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.secondaryColor,
                                        ),
                                        SvgPicture.asset(
                                          ImageAssets.buyCoins,
                                          color: const Color(0xffFC9C07),
                                          width: 50,
                                          height: 50,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: MyText(
                                            text: "${getPackages[index]["coins"]} Coins",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                        LargeButton(
                                          text: "\$ ${getPackages[index]["price"]}",
                                          onTap: () {},
                                          width: Get.width * 0.34,
                                          height: Get.height * 0.03,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                      )
                          : Center(child: MyText(text: "No Coins Packages", color: AppColor.blackColor,)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
