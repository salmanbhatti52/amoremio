import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../../Resources/assets/assets.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

class ReferralsPage extends StatefulWidget {
   const ReferralsPage({super.key});

  @override
  State<ReferralsPage> createState() => _ReferralsPageState();
}

class _ReferralsPageState extends State<ReferralsPage> {

  String referralLink = "https://appname.com/@referral_9099";
  bool isTrue = false;

  listShow(){
    setState(() {
      isTrue = !isTrue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title2: "Referrals",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.03,
            ),
            Container(
              width: Get.width * 0.9,
              height: Get.height * 0.13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: MyText(
                          text: "Referral Income",
                          fontSize: 18,
                          color: AppColor.blackColor,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 18, right: 5),
                            child: Row(
                              children: [
                                const MyText(
                                  text: "This Month",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.brownColor,
                                ),
                                SvgPicture.asset(
                                  ImageAssets.dropBlack,
                                  color: AppColor.brownColor,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10.0,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageAssets.healthicons),
                                const SizedBox(
                                  width: 5,
                                ),
                                const MyText(
                                  text: "20 / \$123",
                                  fontSize: 18,
                                  color: AppColor.blackColor,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const MyText(
              text:
                  "Refer your friends to platform to get 10% of\nwhat they will pay",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              width: Get.width * 0.9,
              height: 62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.whiteColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyText(
                      text: "Your Referral Link",
                      fontSize: 14,
                      color: AppColor.blackColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         MyText(
                          text: referralLink,
                          fontSize: 14,
                          color: Color(0xFF1877F2),
                          fontWeight: FontWeight.w500,
                        ),
                        GestureDetector(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text: referralLink)).then((_){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: MyText(
                                text: "Referral Link copied",
                                color: AppColor.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ), backgroundColor: AppColor.whiteColor,),);
                            });
                          },
                          child: SvgPicture.asset(
                            ImageAssets.copy,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              width: Get.width * 0.9,
              height: Get.height * 0.38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0, bottom: 5),
                    child: MyText(
                      text: "Referral List",
                      fontSize: 18,
                      color: AppColor.blackColor,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyText(
                        text: "Name",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      MyText(
                        text: "This Month",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      MyText(
                        text: "Total",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      MyText(
                        text: "Active Since",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(ImageAssets.smallPic),
                      const MyText(
                        text: "Luna Mizamae",
                        color: AppColor.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      const MyText(
                        text: "20",
                        color: AppColor.primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      const MyText(
                        text: "120",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      const MyText(
                        text: "12 Days",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                          onTap: (){
                            listShow();
                          },
                          child: Icon(
                            isTrue ? Icons.arrow_drop_up_rounded:   Icons.arrow_drop_down_rounded,
                            color: AppColor.brownColor,
                            size: 30,
                          ),
                      ),
                    ],
                  ),
                   isTrue
                        ?  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(ImageAssets.smallPic),
                          const MyText(
                            text: "Luna Mizamae",
                            color: AppColor.blackColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          const MyText(
                            text: "20",
                            color: AppColor.primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          const MyText(
                            text: "120",
                            color: AppColor.brownColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                          const MyText(
                            text: "12 Days",
                            color: AppColor.brownColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    )
                        : const SizedBox(),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(ImageAssets.smallPic),
                      const MyText(
                        text: "Luna Mizamae",
                        color: AppColor.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      const MyText(
                        text: "20",
                        color: AppColor.primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      const MyText(
                        text: "120",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      const MyText(
                        text: "12 Days",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                          onTap: (){},
                          child: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppColor.brownColor,
                            size: 30,
                          ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Image.asset(ImageAssets.smallPic),
                  //       const MyText(
                  //         text: "Luna Mizamae",
                  //         color: AppColor.blackColor,
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //       const MyText(
                  //         text: "20",
                  //         color: AppColor.primaryColor,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //       const MyText(
                  //         text: "120",
                  //         color: AppColor.brownColor,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //       const MyText(
                  //         text: "12 Days",
                  //         color: AppColor.brownColor,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(ImageAssets.smallPic),
                      const MyText(
                        text: "Luna Mizamae",
                        color: AppColor.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      const MyText(
                        text: "20",
                        color: AppColor.primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      const MyText(
                        text: "120",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      const MyText(
                        text: "12 Days",
                        color: AppColor.brownColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      GestureDetector(
                          onTap: (){
                            // setState(() {
                            //   isTrue = !isTrue;
                            // });
                          },
                          child: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppColor.brownColor,
                            size: 30,
                          )),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Image.asset(ImageAssets.smallPic),
                  //       const MyText(
                  //         text: "Luna Mizamae",
                  //         color: AppColor.blackColor,
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //       const MyText(
                  //         text: "20",
                  //         color: AppColor.primaryColor,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //       const MyText(
                  //         text: "120",
                  //         color: AppColor.brownColor,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //       const MyText(
                  //         text: "12 Days",
                  //         color: AppColor.brownColor,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // CommentList(comments: [
                  //   Comment('Luna Mizamae', ImageAssets.smallPic, "20", "120", "12 Days",  replies: [
                  //     Comment('Luna Mizamae', ImageAssets.smallPic, "20", "120", "12 Days",),
                  //     Comment('Luna Mizamae', ImageAssets.smallPic, "20", "120", "12 Days",),
                  //   ]),
                  //   Comment('Luna Mizamae', ImageAssets.smallPic, "20", "120", "12 Days",),
                  //   Comment('Luna Mizamae', ImageAssets.smallPic, "20", "120", "12 Days", replies: [
                  //     Comment('Luna Mizamae', ImageAssets.smallPic, "20", "120", "12 Days",),
                  //   ],
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Comment {
//   String text;
//   String text1;
//   String text2;
//   String text3;
//   String image;
//   List<Comment> replies;
//
//   Comment(this.text, this.image, this.text1, this.text2, this.text3,  {this.replies = const []});
// }
//
// class CommentList extends StatelessWidget {
// final List<Comment> comments;
//
// CommentList({required this.comments});
//
// Widget _buildComment(Comment comment) {
//   return ExpansionTile(
//     title: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Image.asset(comment.image),
//         MyText(text: comment.text, color: AppColor.blackColor, fontSize: 12, fontWeight: FontWeight.w500,),
//         MyText(text: comment.text1, color: AppColor.primaryColor, fontSize: 10, fontWeight: FontWeight.w400,),
//         MyText(text: comment.text2, color: AppColor.brownColor, fontSize: 10, fontWeight: FontWeight.w400,),
//         MyText(text: comment.text3, color: AppColor.brownColor, fontSize: 10, fontWeight: FontWeight.w400,),
//       ],
//     ),
//     children: comment.replies.isNotEmpty
//         ? comment.replies.map((reply) => _buildComment(reply)).toList()
//         : [],
//   );
// }
//
// @override
// Widget build(BuildContext context) {
//   return SizedBox(
//     height: 250,
//     child: ListView.builder(
//       itemCount: comments.length,
//       itemBuilder: (context, index) {
//         return _buildComment(comments[index]);
//       },
//     ),
//   );
// }
// }
