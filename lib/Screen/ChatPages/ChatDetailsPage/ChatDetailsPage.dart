import 'MonitizeDialog.dart';
import 'package:get/get.dart';
import 'TextFieldSendMessage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'ChatDetailsPageController.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';

// ignore: must_be_immutable
class ChatDetailsPage extends StatelessWidget {
  ChatDetailsPage({Key? key}) : super(key: key);

  ChatDetailsPageController chatDetailsPageController =
      Get.put(ChatDetailsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22), // Adjust the value as needed
            bottomRight: Radius.circular(22), // Adjust the value as needed
          ),
        ),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.whiteColor,
            ),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: Image.asset(ImageAssets.mediumImage).image,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyText(
                  text: "Lizza ans",
                  fontSize: 18,
                ),
                Row(
                  children: [
                    const MyText(
                      text: "Active Now",
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      width: 5,
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
                ),
              ],
            ),
          ],
        ),
        actions: [
          // InkWell(
          //   onTap: () {
          //     showDialog(
          //       context: context,
          //       barrierColor: Colors.grey.withOpacity(0.9),
          //       barrierDismissible: false,
          //       builder: (BuildContext context) => Dialog(
          //         backgroundColor: Colors.transparent,
          //         alignment: Alignment.center,
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Container(
          //               width: Get.width * 0.8, //350,
          //               height: Get.height * 0.47, // 321,
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               child: Column(
          //                 children: [
          //                   const SizedBox(
          //                     height: 10,
          //                   ),
          //                   Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         const SizedBox(),
          //                         GestureDetector(
          //                           onTap: () {
          //                             Get.back();
          //                           },
          //                           child: const Icon(
          //                             Icons.clear,
          //                             color: AppColor.blackColor,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   Image.asset(ImageAssets.gifts),
          //                   SizedBox(
          //                     height: Get.height * 0.02,
          //                   ),
          //                   const MyText(
          //                     text: "Congratulations!",
          //                     fontSize: 18,
          //                     color: AppColor.secondaryColor,
          //                   ),
          //                   SizedBox(
          //                     height: Get.height * 0.02,
          //                   ),
          //                   const Padding(
          //                     padding: EdgeInsets.symmetric(horizontal: 15.0),
          //                     child: MyText(
          //                       text: "Your Call duration was just 2 Mints",
          //                       fontWeight: FontWeight.w400,
          //                       fontSize: 14,
          //                       color: Color(0xFF727171),
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     height: Get.height * 0.02,
          //                   ),
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       SvgPicture.asset(ImageAssets.alarm),
          //                       const MyText(
          //                         text: " 1 Min",
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w500,
          //                         color: AppColor.blackColor,
          //                       ),
          //                       const Padding(
          //                         padding:
          //                             EdgeInsets.symmetric(horizontal: 8.0),
          //                         child: Icon(
          //                           CupertinoIcons.equal,
          //                           color: AppColor.blackColor,
          //                         ),
          //                       ),
          //                       SvgPicture.asset(ImageAssets.healthicons),
          //                       const MyText(
          //                         text: " 10 Coins ",
          //                         fontSize: 14,
          //                         fontWeight: FontWeight.w500,
          //                         color: AppColor.blackColor,
          //                       ),
          //                     ],
          //                   ),
          //                   SizedBox(
          //                     height: Get.height * 0.04,
          //                   ),
          //                   Container(
          //                     width: Get.width * 0.64,
          //                     height: Get.height * 0.065,
          //                     clipBehavior: Clip.antiAlias,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(30),
          //                       gradient: const LinearGradient(
          //                         colors: [
          //                           AppColor.primaryColor,
          //                           AppColor.secondaryColor,
          //                         ],
          //                         begin: Alignment(0.20, -0.98),
          //                         end: Alignment(-0.2, 0.98),
          //                       ),
          //                     ),
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         SvgPicture.asset(
          //                           ImageAssets.healthicons,
          //                           width: 30,
          //                           height: 30,
          //                           color: AppColor.whiteColor,
          //                         ),
          //                         const SizedBox(
          //                           width: 15,
          //                         ),
          //                         const MyText(
          //                           text: "Send 20 Coins",
          //                           fontSize: 18,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          //   child: Container(
          //     width: 27,
          //     height: 17,
          //     decoration: ShapeDecoration(
          //       color: Colors.white,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(4)),
          //     ),
          //     child: const Center(
          //       child: MyText(
          //         text: "GIFTS",
          //         fontWeight: FontWeight.w700,
          //         fontSize: 8,
          //         color: AppColor.secondaryColor,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierColor: Colors.grey.withOpacity(0.9),
                barrierDismissible: false,
                builder: (BuildContext context) => FadeInDown(
                  child: Dialog(
                    backgroundColor: Colors.transparent,
                    alignment: Alignment.center,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: Get.width * 0.8, //350,
                          height: Get.height * 0.38, // 321,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
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
                              const MyText(
                                text: "Opps!",
                                fontSize: 18,
                                color: AppColor.secondaryColor,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              SvgPicture.asset(ImageAssets.coins),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: MyText(
                                  text:
                                      "You don’t have enough coins to make a call.",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color(0xFF727171),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.025,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  showDialog(
                                    context: context,
                                    barrierColor: Colors.grey.withOpacity(0.9),
                                    barrierDismissible: false,
                                    builder: (BuildContext context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            width: Get.width * 0.8, //350,
                                            height: Get.height * 0.35, // 321,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const SizedBox(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: const Icon(
                                                          Icons.clear,
                                                          color:
                                                              AppColor.blackColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                const MyText(
                                                  text: "Call Request",
                                                  fontSize: 18,
                                                  color: AppColor.secondaryColor,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                                  child: MyText(
                                                    text:
                                                        "Do you really want to make the video call.",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Color(0xFF727171),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        ImageAssets.alarm),
                                                    const MyText(
                                                      text: " 1 Min",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.blackColor,
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0),
                                                      child: Icon(
                                                        CupertinoIcons.equal,
                                                        color:
                                                            AppColor.blackColor,
                                                      ),
                                                    ),
                                                    SvgPicture.asset(
                                                        ImageAssets.healthicons),
                                                    const MyText(
                                                      text: " 10 Coins ",
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColor.blackColor,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: Get.width * 0.6,
                                                    height: Get.height * 0.065,
                                                    clipBehavior: Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          AppColor.primaryColor,
                                                          AppColor.secondaryColor,
                                                        ],
                                                        begin: Alignment(
                                                            0.20, -0.98),
                                                        end:
                                                            Alignment(-0.2, 0.98),
                                                      ),
                                                    ),
                                                    child: const Center(
                                                      child: MyText(
                                                        text: "Yes",
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: -28,
                                            child: Image.asset(
                                              ImageAssets.mediumImage,
                                            ),
                                          ),
                                          Positioned(
                                            top: 15,
                                            left: Get.width * 0.42,
                                            child: SvgPicture.asset(
                                              ImageAssets.video,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: Get.width * 0.64,
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        ImageAssets.healthicons,
                                        width: 30,
                                        height: 30,
                                        color: AppColor.whiteColor,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const MyText(
                                        text: "Buy Coins",
                                        fontSize: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -28,
                          child: Image.asset(
                            ImageAssets.mediumImage,
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: Get.width * 0.42,
                          child: SvgPicture.asset(
                            ImageAssets.video,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              ImageAssets.video,
              color: AppColor.whiteColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 22.0, top: 50),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: Get.width * 0.27,
                        height: Get.height * 0.17,
                        padding: const EdgeInsets.only(left: 3),
                        clipBehavior: Clip.antiAlias,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              bottomLeft: Radius.circular(13),
                              bottomRight: Radius.circular(13),
                            ),
                          ),
                        ),
                        // Customize the dialog background color
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageAssets.mute, width: 20),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const MyText(
                                    text: "Mute",
                                    color: AppColor.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    barrierColor: Colors.grey.withOpacity(0.9),
                                    barrierDismissible: false,
                                    builder: (BuildContext context) =>
                                        MonitizeDialog());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.dollar,
                                        width: 20),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const MyText(
                                      text: "Monetize",
                                      color: AppColor.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageAssets.report,
                                      width: 20),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const MyText(
                                    text: "Report",
                                    color: AppColor.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                children: [
                                  SvgPicture.asset(ImageAssets.blocked,
                                      width: 20),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const MyText(
                                    text: "Block",
                                    color: AppColor.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.more_vert_rounded,
              color: AppColor.whiteColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.65,
            ),
            Align(
              alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 30),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.85, -0.53),
                        end: Alignment(-0.85, 0.53),
                        colors: [Colors.white, Color(0xFFFFBFBF)],
                      ),
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 0),
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Center(child: SvgPicture.asset(ImageAssets.gift)),
                  ),
                ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Row(
                  children: <Widget>[
                    sendMessageTextFields(
                        chatDetailsPageController.sendMessageFormKey,
                        chatDetailsPageController.sendMessageController),
                    const SizedBox(width: 05),
                    // Obx(() {return
                    Container(
                      width: 48,
                      height: 48,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(31),
                      ),
                      child: FloatingActionButton(
                        onPressed: () async {},
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: const Icon(
                          Icons.mic,
                          size: 35,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
