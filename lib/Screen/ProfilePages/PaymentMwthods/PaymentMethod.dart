import 'package:get/get.dart';
import '../../../Widgets/AppBar.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/large_Button.dart';
import 'package:amoremio/Widgets/Text.dart';
import '../../../Resources/assets/assets.dart';
import '../../../Resources/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../ExplorePages/ExploreBackgroundContainer.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  int _current = 0;
  final CarouselController _controller = CarouselController();
  bool status = true;
  bool status2 = true;

  void toggleSwitch(bool newValue) {
    setState(() {
      status = newValue;
    });
  }

  void toggleSwitch2(bool newValue) {
    setState(() {
      status2 = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> imageSliders = [];
    for (int index = 0; index < imgList.length; index++) {

      imageSliders.add(
        Container(
          width: Get.width * 0.8,
          height: 200,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.86, -0.51),
              end: Alignment(-0.86, 0.51),
              colors: [Color(0xFFFFEFEF), Color(0xFFFFAFAF)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 24,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      ImageAssets.visa,
                      width: 69,
                      height: 21,
                    ),
                    Image.asset(
                      ImageAssets.sim,
                      width: 34,
                      height: 25,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '3598',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.puritan(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Text(
                      '2345',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.puritan(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Text(
                      '5685',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.puritan(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Text(
                      '2479',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.puritan(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "Card Holder",
                      style: FontStyle.italic,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                    MyText(
                      text: "Valid Thru",
                      style: FontStyle.italic,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "AmoreMio",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor,
                    ),
                    MyText(
                      text: "12/28",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: Appbar(
        title2: "Payment Methods",
        onTap: () {
          Get.back();
        },
      ),
      body: ExploreContainer(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.025,
            ),
            CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  aspectRatio: 2,
                  clipBehavior: Clip.none,
                  disableCenter: true,
                  animateToClosest: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? AppColor.whiteColor
                          : Colors.white.withOpacity(0.23999999463558197),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: MyText(
                  text: "Settings",
                  fontSize: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: Get.width * 0.9,
                height: Get.height * 0.06,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        text: "Make this My default Card",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                  FlutterSwitch(
                      width: 36,
                      height: 19,
                      toggleSize: 12.0,
                      value: status,
                      borderRadius: 11,
                      inactiveColor: Color(0xFFC6C6C6),
                      activeColor: AppColor.secondaryColor,
                      activeToggleColor: AppColor.whiteColor,
                      inactiveToggleColor: Color(0xFFD9D9D9),
                      showOnOff: false,
                      onToggle: (val) {
                        toggleSwitch(val);
                        print("val $val");
                        if (val == true) {
                          // e.g., notificationPermissionApiYes();
                        } else if (val == false) {
                          // e.g., notificationPermissionApiNo();
                        } else {
                          print("Error ");
                        }
                      },
                    ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: Get.width * 0.9,
                height: Get.height * 0.06,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyText(
                        text: "Save this Card for Next time",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                      FlutterSwitch(
                          width: 36,
                          height: 19,
                          toggleSize: 12.0,
                          value: status2,
                          borderRadius: 11,
                          inactiveColor: Color(0xFFC6C6C6),
                          activeColor: AppColor.secondaryColor,
                          activeToggleColor: AppColor.whiteColor,
                          inactiveToggleColor: Color(0xFFD9D9D9),
                          showOnOff: false,
                          onToggle: (val) {
                            toggleSwitch2(val);
                            print("val $val");
                            if (val == true) {
                              // e.g., notificationPermissionApiYes();
                            } else if (val == false) {
                              // e.g., notificationPermissionApiNo();
                            } else {
                              print("Error ");
                            }
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.25,
            ),
            LargeButton(
              text: "Add New Card",
              onTap: () {},
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
