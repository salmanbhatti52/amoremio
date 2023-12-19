import 'PaidStory.dart';
import 'package:get/get.dart';
import 'PaidStoryDetails.dart';
import 'PaidStoryController.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:amoremio/Widgets/large_Button.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

class PaidStories extends StatelessWidget {
  PaidStories({super.key});

  final PaidStoryController controller = Get.put(PaidStoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: Column(
          children: [
            PaidStory(
              height: MediaQuery.of(context).size.height * 0.63,
              onTap: () {
                Get.to(()=> const PaidStoryDetails(), transition: Transition.native,
                  duration: const Duration(seconds: 1),);
              },
            ),
            LargeButton(
              text: "Create Story",
              onTap: () {
                _showBottomSheet();
              },
              containerColor: AppColor.whiteColor,
              gradientColor1: AppColor.whiteColor,
              gradientColor2: AppColor.whiteColor,
              borderColor: AppColor.whiteColor,
              textColor: AppColor.secondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    Get.bottomSheet(
      FadeIn(
        duration: const Duration(milliseconds: 600),
        animate: true,
        child: Container(
          height: Get.height * 0.25,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: ListTile(
                  title: MyText(
                    text: "Create",
                    fontSize: 18,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
               GestureDetector(
                 onTap: (){
                   controller.imagePick();
                 },
                 child: const Padding(
                   padding: EdgeInsets.only(left: 15.0,bottom: 25, top: 10),
                   child:  Row(
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: AppColor.blackColor,
                      ),
                      SizedBox(width: 10,),
                      MyText(
                        text: "Upload an Image",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                    ],
                  ),
                 ),
               ),
              GestureDetector(
                onTap: (){
                  // Get.to( ()=>
                      controller.videoPick();
                  // );
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 15.0,),
                  child:  Row(
                    children: [
                      Icon(
                        Icons.video_settings_outlined,
                        color: AppColor.blackColor,
                      ),
                      SizedBox(width: 10,),
                      MyText(
                        text: "Upload a Video",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
