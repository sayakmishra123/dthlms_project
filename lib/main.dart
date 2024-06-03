import 'dart:io';
import 'package:dthlms/db/copydbfun.dart';
import 'package:dthlms/db/dbfunction/dbfunction.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:dthlms/utils/networkContrller.dart';
// import 'package:dthlms/utils/dependency_injection.dart';
// import 'package:dthlms/utils/dependency_injection.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//SAYAK
import 'connectivity_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  // dependencyInjection.init();
  // await Firebase.initializeApp();
// ...

  if (Platform.isWindows) {
    sqfliteFfiInit();

    databaseFactory = databaseFactoryFfi;
  }
  
  String path = "assets/copydb/databases/sayakdb.db";
  if (!await DbHandler().doesDatabaseExist('sayakdb.db')) {
    await copyDatabase(path, 'sayakdb.db');
  }

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
  // String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGaXJzdE5hbWUiOiJTb3VyYXYiLCJMYXN0TmFtZSI6Ik5hdGgiLCJuYW1laWQiOiI2NTg0YWUzNC00NjMwLTRhNjMtYjI3MC1kNjUwNjdmNTNmZDIiLCJGcmFuY2hpc2VJZCI6IjEiLCJNb2JpbGUiOiI5ODMxODExOTIzIiwiZW1haWwiOiJpc3NzYnN0MjAxNkBnbWFpbC5jb20iLCJyb2xlIjoiVGVzdGVyIiwibmJmIjoxNzE3MTMwODEzLCJleHAiOjE3MTcxMzQ0MTMsImlhdCI6MTcxNzEzMDgxM30.lEf3NEg-WMdfhdwCQS5-ZtsLuLIBu0AKp2Tq4PeKxnY";

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
