import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dthlms/db/copydbfun.dart';
import 'package:dthlms/db/dbfunction/dbfunction.dart';
import 'package:dthlms/package/packagescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simnumber/siminfo.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../login/loginmodel.dart';

class Getx extends GetxController {
  RxBool show = false.obs;
  RxBool hide = true.obs;
  // ignore: non_constant_identifier_names
  RxInt page_index = 0.obs;
  RxBool buttonfocuscolor = false.obs;
  RxBool dropbuttonvalueshow = true.obs;

  RxList<DthloginUserDetails> loginuserdata = <DthloginUserDetails>[].obs;
  RxBool otplineshow = false.obs;
  // RxBool otpshow = false.obs;
  RxBool loginpasswordshow = false.obs;
  RxBool signuppasswordshow = false.obs;
  RxString signupotp = ''.obs;
  RxBool forgetpassword1 = false.obs;
  RxBool forgetpassword2 = false.obs;
  RxBool pdfview = true.obs;
  RxBool videoplayer = true.obs;
  RxBool isSelectXXL = false.obs;

  RxBool isSelectXL = false.obs;
  RxBool isSelectL = false.obs;
  RxBool isSelectS = false.obs;
  RxBool isSelectXS = false.obs;
  RxBool isSelectXXS = false.obs;
  RxBool isMypackages = false.obs;

  RxList<SimCard> simCardinfo = <SimCard>[].obs;
  RxList<AllPackage> package = <AllPackage>[].obs;
  RxList<PackageFind> packagefind = <PackageFind>[].obs;
  RxBool packageshow = true.obs;

  @override
  void onInit() {
    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      networkcheckingsnakbar(result);

      // Received changes in available connectivity types!
    });
    databasecopy();
    super.onInit();
  }

  networkcheckingsnakbar(result) {
    if (result == ConnectivityResult.none) {
      Get.showSnackbar(GetSnackBar(
          shouldIconPulse: true,
          icon: Icon(
            Icons.wifi_off,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP,
          title: 'You are not connected to internet.',
          message: 'Please check your connection',
          mainButton: TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ),
          )));
    }
  }

  databasecopy() async {
    if (Platform.isWindows) {
      sqfliteFfiInit();

      databaseFactory = databaseFactoryFfi;
    }
    String path = "assets/copydb/databases/sayakdb.db";
    if (!await DbHandler().doesDatabaseExist('sayakdb.db')) {
      await copyDatabase(path, 'sayakdb.db');
    }
  }
}
  

