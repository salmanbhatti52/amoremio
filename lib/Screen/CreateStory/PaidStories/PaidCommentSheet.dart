import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentSheet extends StatefulWidget {
  final String storyId;
  const CommentSheet({super.key, required this.storyId});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {

  final GlobalKey<FormState> sendMessageFormKey = GlobalKey<FormState>();
  final TextEditingController sendMessageController = TextEditingController();
  List comments = [];

  void sendComment(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('users_customers_id');
    print("userId $userId");

    String apiUrl = "https://mio.eigix.net/apis/services/users_stories_comments";

    final response = await http.post(Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            "users_stories_id": widget.storyId,
            "commenter_id": userId,
            "comment": text,
          },
        ));
    var userdetail = jsonDecode(response.body);
    if (userdetail['status'] == 'success') {
      print(userdetail);
      setState(() {
        getComments();
        sendMessageController.clear();
        // Close the keyboard
        FocusScope.of(context).unfocus();
      });
    } else {
      print(userdetail['status']);
      var errormsg = userdetail['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errormsg)));
    }
  }

  void getComments() async {
    String apiUrl = "https://mio.eigix.net/apis/services/get_users_stories_comments";
    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              "users_stories_id": widget.storyId,
            },
          ));
      debugPrint(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        setState(() {});
        comments = data['data']["data"];
        debugPrint(data['status']);
      } else {
        debugPrint("status ${data['status']}");
        var errormsg = data['message'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errormsg)));
      }
    } catch (e) {
      debugPrint('errorss $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('storyId ${widget.storyId}');
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: Get.height * 0.9,
        decoration:  BoxDecoration(
          color: Colors.white.withOpacity(0.9 ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 12),
                  child: MyText(
                    text: "Comments",
                    color: AppColor.blackColor,
                    fontSize: 18,
                  ),
                ),
            ),
            SizedBox(
            height: Get.height * 0.4,
            child: ListView.builder(
            itemCount: comments.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var comment = comments[index];
              var commenterData = comment['commenter_data'];
              return SizedBox(
                height: Get.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 22,),
                        // Image.asset(ImageAssets.mediumImage, width: 30, height: 30,),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, bottom: 0, right: 5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (commenterData != null && commenterData['image'] != null && commenterData['image'].isNotEmpty)
                                  ? 'https://mio.eigix.net/${commenterData['image']}'
                                  : 'https://mio.eigix.net/uploads/placeholder.jpg',
                            ),
                            radius: 14,
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: commenterData != null && commenterData['username'] != null && commenterData['username'].isNotEmpty
                                  ? commenterData['username']
                                  : "Username",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackColor,
                            ),
                            MyText(
                              text: comment != null && comment['comments'] != null && comment['comments'].isNotEmpty
                                  ? comment["comments"]
                                  : "Comment",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.hintTextColor,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            SvgPicture.asset(ImageAssets.favorite,width: 25, height: 25 , color: AppColor.hintTextColor,),
                            // const SizedBox(width: 15,),
                            // const Icon(Icons.reply, color: AppColor.hintTextColor, size: 20,),
                            // ],
                            // )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: MyText(
                        text: comment != null && comment['date_added'] != null && comment['date_added'].isNotEmpty
                            ? formatTimestamp(comment['date_added'])
                            : "Comment",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColor.hintTextColor,
                      ),
                    ),
                  ],
                )
              );
            },
          ),
        ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: sendMessageTextFields(
                        key: sendMessageFormKey,
                        controller: sendMessageController,
                        onSendMessage: sendComment,
                        closekeyboard: () {},
                        context: context,
                        scrollController: null,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(31),
                      ),
                      child: FloatingActionButton(
                        onPressed: () async {
                          sendComment(sendMessageController.text);
                        },
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: const Icon(
                          Icons.send,
                          size: 25,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
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

Widget sendMessageTextFields({
  required Key key,
  required TextEditingController controller,
  required void Function(String text) onSendMessage,
  void Function()? closekeyboard,
  required BuildContext context,
  ScrollController? scrollController,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColor.whiteColor,
      borderRadius: BorderRadius.circular(31),
    ),
    child: TextField(
      onTap: closekeyboard,
      textAlign: TextAlign.left,
      controller: controller,
      onEditingComplete: () {
        onSendMessage(controller.text ?? "");
        controller.clear();
        FocusScope.of(context).unfocus();

        // Scroll to the bottom
        scrollController?.animateTo(
          scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 10, bottom: 3),
        hintText: "Type a message",
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xFFA3A3A3),
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
      ),
    ),
  );
}

String formatTimestamp(String timestamp) {
  DateTime commentTime = DateTime.parse(timestamp);
  Duration difference = DateTime.now().difference(commentTime);
  if (difference.inMinutes < 1) {
    return 'now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}min';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h';
  } else {
    // If you want to show the date instead of just "X days ago"
    return DateFormat('yyyy-MM-dd').format(commentTime);
  }
}
