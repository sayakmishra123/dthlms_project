import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dthlms/Testing/cameratesting.dart';
import 'package:dthlms/ThemeData/color/color.dart' show ColorPage;
import 'package:dthlms/TheoryExam/theoryexampage.dart';
import 'package:dthlms/android/MCQ/mcqCondition.dart';
import 'package:dthlms/android/MCQ/mockTestRank.dart';
import 'package:dthlms/android/MCQ/mockTestMcq.dart';
import 'package:dthlms/android/login/dth_mob_login.dart';
import 'package:dthlms/android/theoryexam/TheoryExamPageMobile.dart';
import 'package:dthlms/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:dthlms/login/dth_login.dart' show DthLmsLogin;
import 'package:dthlms/mcq/macterm&conditionpage.dart';
import 'package:dthlms/mcq/mockTestmcqPage.dart';
import 'package:dthlms/routes/router.dart' show pageRouter;
import 'package:dthlms/utctime.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart'
    show AppBarTheme, BuildContext, MaterialPageRoute, State, StatefulWidget, ThemeData, Widget, WidgetsFlutterBinding, runApp;
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
      theme:ThemeData(
        appBarTheme: AppBarTheme(color: ColorPage.appbarcolor,elevation: 4),
      ) ,
      getPages: router.Route,
      debugShowCheckedModeBanner: false,
      title: 'DTH LMS',
      home: Platform.isAndroid ? Mobilelogin() : DthLmsLogin(),
    );
  }
}
