import 'package:amoremio/Resources/colors/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'Screen/SplashScreen/SplashScreen.dart';
import 'package:device_preview/device_preview.dart';

void main() => runApp(
  // DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) =>
    const MyApp(), // Wrap your app
  // ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AmoreMio',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
