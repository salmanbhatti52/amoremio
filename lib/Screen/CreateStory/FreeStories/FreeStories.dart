import 'package:amoremio/Screen/CreateStory/SelectVideoTypes/SelectVideoType.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'FreeStory.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:animate_do/animate_do.dart';
import '../../../Resources/colors/colors.dart';
import '../PaidStories/PaidStoryController.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

class FreeStories extends StatelessWidget {
   FreeStories({super.key});

  // final PaidStoryController controller = Get.put(PaidStoryController());

   Future<void> videoPick() async {
     final picker = ImagePicker();
     final videoFile = await picker.pickVideo(
       source: ImageSource.gallery,
       maxDuration: const Duration(seconds: 30),
     );
     if (videoFile != null) {
       Get.to( ()=>
           SelectVideoType(
             videoFile : File(videoFile.path),
           ),
       );
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: Column(
          children: [
            FreeStory(
              height: MediaQuery.of(context).size.height * 0.63,
              onTap: (){},
            ),
            LargeButton(
              text: "Create Story",
              onTap: (){
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
                  // controller.imagePick();
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
                  videoPick();
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
