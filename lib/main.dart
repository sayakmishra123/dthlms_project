import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart'
    show AnimatedSplashScreen, SplashTransition;
import 'package:camera/camera.dart';
import 'package:dthlms/Testing/cameratesting.dart';
import 'package:dthlms/ThemeData/color/color.dart' show ColorPage;
import 'package:dthlms/TheoryExam/theoryexampage.dart';
import 'package:dthlms/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:dthlms/login/dth_login.dart' show DthLmsLogin;
import 'package:dthlms/mcq/mockTestmcqPage.dart';
import 'package:dthlms/routes/router.dart' show pageRouter;
import 'package:dthlms/utctime.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart'
    show
        BuildContext,
        MaterialPageRoute,
        State,
        StatefulWidget,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:get/get_navigation/src/root/get_material_app.dart'
    show GetMaterialApp;
import 'package:media_kit/media_kit.dart' show MediaKit;
import 'package:sqlcipher_library_windows/sqlcipher_library_windows.dart';
import 'package:sqlite3/open.dart';
// import 'package:sqlcipher_library_windows/sqlcipher_library_windows.dart';
// import 'package:sqlite3/open.dart';
import 'package:windows_single_instance/windows_single_instance.dart'
    show WindowsSingleInstance;

//sayak mishra
void main(List<String> args) async {
  open.overrideFor(OperatingSystem.windows, openSQLCipherOnWindows);
  print(UtcTime().utctime());
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    cameras = await availableCameras();
  }
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
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
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  pageRouter router = pageRouter();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: router.Route,
      debugShowCheckedModeBanner: false,
      title: 'DTH LMS',
      home: AnimatedSplashScreen(
        splash: "assets/splash6.gif",
        splashIconSize: 6000,
        centered: true,
        nextScreen: Platform.isAndroid ? DthLmsLogin() :TheoryExamPage(),
        backgroundColor: ColorPage.bgcolor,
        splashTransition: SplashTransition.scaleTransition,
        duration: 3500,
      ),
    );
  }
}
