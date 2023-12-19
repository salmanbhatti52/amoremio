import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';

class PaidStory extends StatelessWidget {
  final double height;
  final Function onTap;
   const PaidStory({super.key,
     required this.height,
     required this.onTap,
   });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 1 / 1.3,
        ),
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              onTap();
            },
            child: Stack(
              children: [
                Image.asset(
                  ImageAssets.exploreImage,
                  width: 107.53,
                  height: 138,
                ),
                Positioned(
                  right: 1,
                  top: 7,
                  child: Container(
                    width: Get.width * 0.11,
                    height: 13,
                    decoration: ShapeDecoration(
                      color: AppColor.whiteColor.withOpacity(0.4),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6.50),
                          bottomLeft: Radius.circular(2),
                        ),
                      ),
                    ),
                    child:  const Row(
                      children: [
                        Icon(
                          Icons.watch_later,
                          size: 10,
                          color: AppColor.whiteColor,
                        ),
                        MyText(
                          text: " 1h ago",
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 7,
                  child: Container(
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor.withOpacity(0.4),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Column(
                        children: [
                          Icon(Icons.remove_red_eye, color: AppColor.whiteColor, size: 10,),
                          MyText(text: "500", fontSize: 5.12, fontWeight: FontWeight.w500, )
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                              width: 10,
                              height: 10,
                              color: Colors.white,
                              ImageAssets.createStory1,
                          ),
                          const MyText(text: "200", fontSize: 5.12, fontWeight: FontWeight.w500, )
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            width: 10,
                            height: 10,
                            color: Colors.white,
                            ImageAssets.share,
                          ),
                          const MyText(text: "700", fontSize: 5.12, fontWeight: FontWeight.w500, )
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            width: 10,
                            height: 10,
                            color: Colors.white,
                            ImageAssets.healthicons,
                          ),
                          const MyText(text: "10K", fontSize: 5.12, fontWeight: FontWeight.w500, )
                        ],
                      ),
                    ],
                  ),
                ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
