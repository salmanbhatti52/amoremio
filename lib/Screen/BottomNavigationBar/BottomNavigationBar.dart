import 'package:flutter_svg/svg.dart';
import '../StoriesView/StoryView.dart';
import 'package:flutter/material.dart';
import '../ProfilePages/ProfileMain/ProfilePage.dart';
import '../ChatPages/ChatPage/ChatPage.dart';
import 'package:amoremio/Resources/assets/assets.dart';
import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Screen/ExplorePages/Explore.dart';
import 'package:amoremio/Screen/CreateStory/createstory.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int initialIndex;
  const MyBottomNavigationBar({
    this.initialIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  List pages = [
    ExplorePage(),
    const StoryView(),
    const CreateStory(),
    ChatPage(),
    ProfilePage(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.redColor,
      body: Container(
        child: pages[currentIndex],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.078,
          width: MediaQuery.of(context).size.width,
          clipBehavior: Clip.hardEdge,
          // padding: EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          ),
          child: BottomNavigationBar(
            selectedItemColor: AppColor.secondaryColor,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: AppColor.whiteColor,
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "",
                icon: currentIndex == 0
                    ? SvgPicture.asset(ImageAssets.explore2)
                    : SvgPicture.asset(ImageAssets.explore1),
              ),
              BottomNavigationBarItem(
                label: "",
                icon: currentIndex == 1
                    ? SvgPicture.asset(ImageAssets.storyView2)
                    : SvgPicture.asset(ImageAssets.storyView1),
              ),
              BottomNavigationBarItem(
                  label: "",
                  icon: currentIndex == 2
                      ? SvgPicture.asset(
                          ImageAssets.createStory1,
                          color: AppColor.secondaryColor,
                        )
                      : SvgPicture.asset(ImageAssets.createStory1)),
              BottomNavigationBarItem(
                  label: "",
                  icon: currentIndex == 3
                      ? SvgPicture.asset(ImageAssets.chat2)
                      : SvgPicture.asset(
                          ImageAssets.chat1,
                          color: Color(0xFFCBCBCB),
                          colorBlendMode: BlendMode.srcIn,
                          width: 24,
                          height: 24,
                        )),
              BottomNavigationBarItem(
                  label: "",
                  icon: currentIndex == 4
                      ? SvgPicture.asset(ImageAssets.profile2)
                      : SvgPicture.asset(ImageAssets.profile1)),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyBottomNavigationBar extends StatelessWidget {
//   final PersistentTabController _controller =
//       PersistentTabController(initialIndex: 0);
//
//   final ValueNotifier<int>? tabNotifier;
//
//   MyBottomNavigationBar({super.key, this.tabNotifier});
//
//   List<Widget> _buildScreens() {
//     return [
//       ExplorePage(),
//       StoryView(),
//       CreateStory(),
//       ChatPage(),
//       ProfilePage(),
//     ];
//   }
//
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: SvgPicture.asset(ImageAssets.explore2),
//         inactiveIcon: SvgPicture.asset(ImageAssets.explore1),
//       ),
//       PersistentBottomNavBarItem(
//         icon: SvgPicture.asset(ImageAssets.storyView2),
//         inactiveIcon: SvgPicture.asset(ImageAssets.storyView1),
//       ),
//       PersistentBottomNavBarItem(
//         icon: SvgPicture.asset(ImageAssets.createStory2),
//         inactiveIcon: SvgPicture.asset(ImageAssets.createStory1),
//       ),
//       PersistentBottomNavBarItem(
//         icon: SvgPicture.asset(ImageAssets.chat2),
//         inactiveIcon: SvgPicture.asset(
//           ImageAssets.chat2,
//           color: AppColor.hintTextColor,
//         ),
//         // inactiveIcon: SvgPicture.asset(ImageAssets.chat1, color: AppColor.hintTextColor,),
//       ),
//       PersistentBottomNavBarItem(
//         icon: SvgPicture.asset(ImageAssets.profile2),
//         inactiveIcon: SvgPicture.asset(ImageAssets.profile1),
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       onItemSelected: (index) {
//         tabNotifier?.value = index;
//         print('tabNotifier?.value $index');
//       },
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       confineInSafeArea: false,
//       backgroundColor: AppColor.whiteColor,
//       handleAndroidBackButtonPress: true,
//       resizeToAvoidBottomInset: false,
//       stateManagement: false,
//       padding: const NavBarPadding.all(10),
//       navBarStyle: NavBarStyle.simple,
//       // margin: EdgeInsets.all(10),
//       navBarHeight: kBottomNavigationBarHeight,
//       hideNavigationBarWhenKeyboardShows: true,
//       decoration: const NavBarDecoration(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//         colorBehindNavBar: Colors.transparent,
//       ),
//     );
//   }
// }

class ChatIconWithBadge extends StatelessWidget {
  final int unreadMessageCount;

  const ChatIconWithBadge(this.unreadMessageCount, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        SvgPicture.asset(ImageAssets.chat2), // Your chat icon
        if (unreadMessageCount > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red, // You can customize the color
              ),
              child: Text(
                unreadMessageCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
