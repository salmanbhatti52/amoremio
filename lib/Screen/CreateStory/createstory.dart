import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Screen/CreateStory/FreeStories/FreeStories.dart';
import 'package:amoremio/Screen/CreateStory/OwnedStories/OwnedStories.dart';
import 'package:amoremio/Screen/CreateStory/PaidStories/PaidStories.dart';
import 'package:amoremio/Screen/CreateStory/StatsStories/StatsStories.dart';
import 'package:amoremio/Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ExplorePages/ExploreBackgroundContainer.dart';

class CreateStory extends StatefulWidget {
  const CreateStory({super.key});

  @override
  State<CreateStory> createState() => _CreateStoryState();
}

class _CreateStoryState extends State<CreateStory>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExploreContainer(
        child: Column(
          children: [
            const CreateStoryAppbar(
              title2: "Stories",
              title3: "Sort By",
              icon: ImageAssets.sort,
            ),
            Container(
              width: Get.width * 0.9,
              height: Get.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white.withOpacity(0.5),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColor.secondaryColor,
                unselectedLabelColor: AppColor.whiteColor,
                labelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                indicatorColor: AppColor.primaryColor,
                dividerColor: AppColor.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                tabs: const [
                  Tab(
                    text: "Owned",
                  ),
                  Tab(
                    text: "Paid ",
                  ),
                  Tab(
                    text: "Free ",
                  ),
                  Tab(
                    text: "Stats ",
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                OwnedStories(),
                PaidStories(),
                FreeStories(),
                StatusStories(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
