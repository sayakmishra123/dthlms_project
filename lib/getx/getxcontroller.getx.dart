import 'dart:async' show StreamSubscription;
import 'dart:io' show Platform;
import 'package:connectivity_plus/connectivity_plus.dart'
    show Connectivity, ConnectivityResult;
import 'package:dthlms/db/copydbfun.dart' show copyDatabase;
import 'package:dthlms/db/dbfunction/dbfunction.dart' show DbHandler;
import 'package:dthlms/package/packagescreen.dart' show AllPackage, PackageFind;
import 'package:flutter/material.dart'
    show Colors, Icon, Icons, Text, TextButton, TextStyle;
import 'package:get/get.dart';
import 'package:simnumber/siminfo.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show databaseFactory, databaseFactoryFfi, sqfliteFfiInit;

import '../login/loginmodel.dart' show DthloginUserDetails;

class Getx extends GetxController {
  RxBool show = false.obs;
  RxInt ButtonControllerIndex = 0.obs;
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
  RxBool isSignup = true.obs;
  RxBool isMypackages = false.obs;
  RxBool passvisibility = false.obs;
  RxBool videoplaylock = false.obs;
  RxBool isPaperSubmit = false.obs;

  RxList name = [].obs; //chat
  RxString email = ''.obs;
  //chat

  RxList<SimCard> simCardinfo = <SimCard>[].obs;
  RxList<AllPackage> package = <AllPackage>[].obs;
  RxList<PackageFind> packagefind = <PackageFind>[].obs;
  RxBool packageshow = true.obs;
  RxBool forgetpasswordemailcode = false.obs;
  RxBool forgetpageshow = false.obs;
  RxBool loading = true.obs;

  @override
  void onInit() {
    // ignore: unused_local_variable
    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      networkcheckingsnakbar(result);

      // Received changes in available connectivity types!
    });
    databasecopy();
    super.onInit();
  }

  Future networkcheckingsnakbar(List<ConnectivityResult> result) async {
    print(result);
    String connection = result.last.toString();

    if (connection == ConnectivityResult.none.toString()) {
      Get.showSnackbar(GetSnackBar(
          shouldIconPulse: true,
          icon: const Icon(
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
            child: const Text(
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
