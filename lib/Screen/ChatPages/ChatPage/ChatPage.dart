import 'package:get/get.dart';
import 'ChatPageController.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ChatDetailsPage/ChatDetailsPage.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  ChatPageController chatPageController = Get.put(ChatPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ExploreAppbar(title: "LOGO", title2: "Chat"),
              Padding(padding: EdgeInsets.symmetric(
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
                      controller: chatPageController.searchController,
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
              SizedBox(height: Get.height * 0.02,),
              Padding(
                padding:  EdgeInsets.only(left: Get.width* 0.06),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: double.infinity,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 7.0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        width: 2,
                                        color: AppColor.whiteColor,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Image.asset(ImageAssets.mediumImage),
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration:
                                             BoxDecoration(color: const Color(0xFF48FF08), borderRadius: BorderRadius.circular(30),),
                                      ),
                                  ),
                                ],
                              ),
                              const MyText(
                                text: "Anna",
                                color: Color(0xFFFFD6D6),
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
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width* 0.06,),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.58,
                  width: double.infinity,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){
                            Get.to(()=>  ChatDetailsPage(), duration: const Duration(milliseconds: 300), transition:Transition.rightToLeft);
                          },
                          child: FadeInUp(
                            child: Padding(
                              padding:  const EdgeInsets.only(bottom: 10.0),
                              child: Container(
                                width: Get.width * 0.1,
                                height: Get.height * 0.08,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF6F6),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(ImageAssets.mediumImage),
                                          SizedBox(width:  Get.width * 0.02,),
                                          const Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                text: "Anna",
                                                color: AppColor.blackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              MyText(
                                                text: "Sent a sticker!",
                                                color: Color(0xFF727171),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const MyText(
                                            text: "5min",
                                            color: Color(0xFF727171),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(height:  Get.height * 0.01,),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration:
                                            BoxDecoration(color: const Color(0xFF48FF08), borderRadius: BorderRadius.circular(30),),
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
