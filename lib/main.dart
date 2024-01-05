import 'package:amoremio/Resources/colors/colors.dart';
import 'package:amoremio/Screen/Authentication/ResetPassword/ResetPassword.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/BottomNavigationBar/BottomNavigationBar.dart';
import 'Screen/SplashScreen/SplashScreen.dart';
import 'package:device_preview/device_preview.dart';

// void main() => runApp(
//       // DevicePreview(
//       //   enabled: !kReleaseMode,
//       //   builder: (context) =>
//       const MyApp(), // Wrap your app
//       // ),
//     );
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'AmoreMio',
//       useInheritedMediaQuery: true,
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
//         useMaterial3: true,
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('users_customers_id');

  runApp(
    MyApp(userId: userId), // Pass userId to MyApp
  );
}

class MyApp extends StatelessWidget {
  final String? userId; // Add this property

  const MyApp({Key? key, required this.userId}) : super(key: key);

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
      // Use a conditional expression to decide the initial route based on userId
      initialRoute: userId != null ? '/home' : '/splash',
      routes: {
        '/home': (context) =>
            MyBottomNavigationBar(), // Replace HomeScreen with your actual home screen
        '/splash': (context) =>
            SplashScreen(), // Replace LoginScreen with your actual login screen
      },
    );
  }
}
