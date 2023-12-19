import 'package:flutter/material.dart';

import '../../ExplorePages/ExploreBackgroundContainer.dart';
import '../PaidStories/PaidStoryDetails.dart';
import 'OwnedStory.dart';
import 'package:get/get.dart';

class OwnedStories extends StatelessWidget {
  const OwnedStories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: Column(
          children: [
            OwnedStory(
              height: MediaQuery.of(context).size.height * 0.73,
              onTap: () {
                Get.to(
                  () => const PaidStoryDetails(),
                  transition: Transition.native,
                  duration: const Duration(seconds: 1),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
