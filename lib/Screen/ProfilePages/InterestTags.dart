import 'dart:convert';

import 'package:get/get.dart';
import '../../Utills/AppUrls.dart';
import '../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';
import 'package:http/http.dart' as http;

import 'ProfileScreen.dart';

class InterestTags extends StatefulWidget {
  final List<dynamic> interestList;
  InterestTags({super.key, required this.interestList});

  @override
  State<InterestTags> createState() => _InterestTagsState();
}

class _InterestTagsState extends State<InterestTags> {
  bool isTrue = false;
  List interestsData = [];
  List selectedList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinterestTags();
    print("Interest List in initState: ${widget.interestList}");
  }

  void selectItem(item) {
    setState(() {
      // If the item is already selected, remove it; otherwise, add it to the selected list
      if (selectedList.contains(item)) {
        selectedList.remove(item);
      } else {
        selectedList.add(item);
        print('dasdasds: $selectedList');
      }
    });
  }

  Future<List> getinterestTags() async {
    String apiUrl = getInterests;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      final responseString = response.body;
      var data = jsonDecode(responseString);
      String status = data['status'];
      if (status == 'success') {
        // print('$data[data]');
        setState(() {
          interestsData = data['data'];
          print('list: $interestsData');
        });
      }
    } catch (e) {
      print('Error: $e');
      print('Failed to connect to the server.');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar2(
        title2: "Interests",
        title: "Done",
        onTap1: () {
          Get.back();
        },
        onTap2: () {
          Get.back(result: selectedList);
        },
      ),
      resizeToAvoidBottomInset: false,
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.06,
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
                      controller: TextEditingController(text: ""),
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
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: Get.height * 0.8,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 6 / 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  itemCount: interestsData.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Check if the current interest is in widget.interestList
                    bool isInterestSelected = widget.interestList.any(
                        (selectedInterest) =>
                            selectedInterest['interests_tags_id'] ==
                            interestsData[index]['interests_tags_id']);
                    return GestureDetector(
                      onTap: () {
                        selectItem(interestsData.elementAt(index));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 77,
                          height: 30,
                          decoration: BoxDecoration(
                              color: selectedList
                                          .contains(interestsData[index]) ||
                                      isInterestSelected
                                  ? Colors
                                      .white // Change the background color for selected and common interests
                                  : Color(0x54E2E2E2),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: MyText(
                              text: interestsData[index]['name'],
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: selectedList.contains(interestsData[index])
                                  ? Color(0xFFEE4433)
                                  : (isInterestSelected
                                      ? Color(0xFFEE4433)
                                      : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
