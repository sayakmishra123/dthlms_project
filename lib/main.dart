import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/firebase_options.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:media_kit/media_kit.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

//sayak mishra mm
void main(List<String> args) async {
// ...
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await WindowsSingleInstance.ensureSingleInstance(args, "custom_identifier",
      bringWindowToFront: true, onSecondWindow: (args) {
    print(args);
  });
  print(args);
  MediaKit.ensureInitialized();
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
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // enableLog: true,

      debugShowCheckedModeBanner: false,
      title: 'DTH LMS',
      // theme: ThemeProvider.themeOf(context).data,
      // home: ThemePage(),

      home: AnimatedSplashScreen(
        splash: "assets/splash6.gif",
        splashIconSize: 6000,
        centered: true,
        nextScreen: DthLmsLogin(),
        backgroundColor: ColorPage.bgcolor,
        splashTransition: SplashTransition.scaleTransition,
        duration: 3500,
      ),
    );
  }
}
