import 'dart:io';
import 'package:dthlms/db/copydbfun.dart';
import 'package:dthlms/db/dbfunction/dbfunction.dart';
import 'package:dthlms/forgotpassword/forgetscreen.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:dthlms/pages/dashboard.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

//sayak mishra hhh
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
        home: const DthLmsLogin());
  }
}
