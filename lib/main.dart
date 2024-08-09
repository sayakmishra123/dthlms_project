import 'dart:io';





import 'package:dthlms/MOBILE/LOGIN/loginpage_mobile.dart';
import 'package:dthlms/PC/LOGIN/login.dart';
import 'package:dthlms/firebase_options.dart';

import 'package:dthlms/routes/router.dart';

import 'package:dthlms/utctime.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:media_kit/media_kit.dart';

import 'package:sqlcipher_library_windows/sqlcipher_library_windows.dart';
import 'package:sqlite3/open.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';


void main(List<String> args) async {
  open.overrideFor(OperatingSystem.windows, openSQLCipherOnWindows);
  print(UtcTime().utctime());
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = Size(1300, 600);
      win.alignment = Alignment.topLeft;
      win.show();
    });
  } 
  firbase();
  singleInstance(args);


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
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 234, 237, 248),
          textTheme: TextTheme(
            bodyMedium: GoogleFonts.inter().copyWith(fontSize: 10),
            bodyLarge: GoogleFonts.inter().copyWith(fontSize: 12),
            bodySmall: GoogleFonts.inter().copyWith(fontSize: 9),
            displayLarge: GoogleFonts.inter().copyWith(fontSize: 12),
            displayMedium: GoogleFonts.inter().copyWith(fontSize: 10),
            displaySmall: GoogleFonts.inter().copyWith(fontSize: 9),
          ),
          appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.poppins().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black))),
      getPages: router.Route,
      debugShowCheckedModeBanner: false,
      title: 'DTH LMS',
      home: Platform.isAndroid ? Mobilelogin() : DthLmsLogin(),
    );
  }
}

firbase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

singleInstance(args) async {
  await WindowsSingleInstance.ensureSingleInstance(args, "custom_identifier",
      bringWindowToFront: true, onSecondWindow: (args) {
    print(args);
  });
  print(args);
}
