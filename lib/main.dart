import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

//sayak mishra mm
void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DTH LMS',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 90, 7, 233)),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          splash: "assets/splash6.gif",
          splashIconSize: 6000,
          centered: true,
          nextScreen: DthLmsLogin(),
          backgroundColor: ColorPage.bgcolor,
          splashTransition: SplashTransition.scaleTransition,
          duration: 3500,
        ));
  }
}
