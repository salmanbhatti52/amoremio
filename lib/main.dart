import 'package:amoremio/Resources/colors/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/BottomNavigationBar/BottomNavigationBar.dart';
import 'Screen/SplashScreen/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('users_customers_id');
  runApp(
    MyApp(userId: userId),
  );
}

class MyApp extends StatelessWidget {
  final String? userId;
  const MyApp({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AmoreMio',
      useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
        useMaterial3: true,
      ),
      initialRoute: userId != null ? '/home' : '/splash',
      routes: {
        '/home': (context) =>
            const MyBottomNavigationBar(),
        '/splash': (context) =>
            const SplashScreen(),
      },
    );
  }
}
