import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

//sayak mishra mm
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await WindowsSingleInstance.ensureSingleInstance(args, "custom_identifier",
      bringWindowToFront: true, onSecondWindow: (args) {
    print(args);
  });
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
