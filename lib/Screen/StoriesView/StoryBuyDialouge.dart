import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:amoremio/Widgets/Text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:amoremio/Resources/assets/assets.dart';

class BuyStoryDialog extends StatelessWidget {
  const BuyStoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.85, -0.53),
                  end: Alignment(-0.85, 0.53),
                  colors: [Colors.white, Color(0xFFFFBFBF)],
                ),
                shape: OvalBorder(),
              ),
              child: SvgPicture.asset(
                'assets/icons/lock.svg',
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(height: 40),
            const MyText(
              align: TextAlign.center,
              text: "20 Coins to Unlock Anna's Exclusive \n Story & Support",
              fontSize: 18,
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: Colors.white, width: 1),
                  color: Colors.transparent,
                ),
                child: const Center(
                  child: Text(
                    'Buy Story',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyStory2Dialog extends StatelessWidget {
  const BuyStory2Dialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.85, -0.53),
                end: Alignment(-0.85, 0.53),
                colors: [Colors.white, Color(0xFFFFBFBF)],
              ),
              shape: OvalBorder(),
            ),
            child: SvgPicture.asset(
              'assets/icons/lock.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(height: 40),
          const MyText(
            align: TextAlign.center,
            text: "20 Coins to Unlock Anna's Exclusive \n Story & Support",
            fontSize: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(ImageAssets.videoPlay, width: 15,),
              const SizedBox(width: 2),
              const MyText(
                align: TextAlign.center,
                text: "  2:00",
                fontSize: 18,
              ),
            ],
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Colors.white, width: 1),
                color: Colors.transparent,
              ),
              child: const Center(
                child: Text(
                  'Buy Story',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


