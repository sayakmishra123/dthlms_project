import 'package:dthlms/login/dth_login.dart';
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
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGaXJzdE5hbWUiOiJTb3VyYXYiLCJMYXN0TmFtZSI6Ik5hdGgiLCJuYW1laWQiOiI2NTg0YWUzNC00NjMwLTRhNjMtYjI3MC1kNjUwNjdmNTNmZDIiLCJGcmFuY2hpc2VJZCI6IjEiLCJNb2JpbGUiOiI5ODMxODExOTIzIiwiZW1haWwiOiJpc3NzYnN0MjAxNkBnbWFpbC5jb20iLCJyb2xlIjoiVGVzdGVyIiwibmJmIjoxNzE3ODMwNjE3LCJleHAiOjE3MTc4MzQyMTcsImlhdCI6MTcxNzgzMDYxN30.1yL0XDnyCDKVFvSnE5Oocz_ABHiBBBbAJTjr_VSIauQ";
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
        home: DthLmsLogin());
  }
}
