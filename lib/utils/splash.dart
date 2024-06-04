// ignore_for_file: avoid_print

import 'package:dthlms/configaration/device/device_info.dart';
import 'package:dthlms/db/copydbfun.dart';
import 'package:dthlms/db/dbfunction/dbfunction.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List info = [];

  @override
  void initState() {
    fninfo();
    super.initState();
  }

  Future fninfo() async {
    try {
      info = await ClsDeviceInfo.windowsInfo();
      print(info);
      print('ksdbnkjsf');
      bool databaseexist = await DbHandler().doesDatabaseExist('sayakdb.db');
      if (databaseexist == true) {
        print('object');
        // await DbHandler().insertData('username', 'password');
        List logintablerow = await DbHandler().readData();
        print(logintablerow);
        // if (logintablerow.isNotEmpty) {
        Get.back();
        Get.to(() =>const  DthLmsLogin());
        // }
      } else {
        await copyDatabase('assets/copydb/databases/sayakdb.db', 'sayakdb.db');
        Get.back();
        Get.to(() =>const  DthLmsLogin());
      }
    } catch (e) {
      print(e);
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Loading.....')],
          )
        ],
      ),
    );
  }
}
