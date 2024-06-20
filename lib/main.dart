import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:dthlms/utils/activationcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

//sayak mishra mm
void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DTH LMS',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          splash: "assets/splash6.gif",
          splashIconSize: 6000,
          centered: true,
          
          nextScreen:  DthLmsLogin(),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.907),
          duration: 3500,
        ));
  }
}
