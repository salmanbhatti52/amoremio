import 'package:flutter/material.dart';

import '../../../Resources/colors/colors.dart';
import '../../../Widgets/large_Button.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';
import 'StatsStory.dart';

class StatusStories extends StatelessWidget {
  const StatusStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: Column(
          children: [
            StatsStory(
              height: MediaQuery.of(context).size.height * 0.63,
              onTap: (){},
            ),
            LargeButton(
              text: "Create Story",
              onTap: (){},
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
}
