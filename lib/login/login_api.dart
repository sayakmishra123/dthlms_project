// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dthlms/configaration/device/device_info.dart';
import 'package:dthlms/errormsg/errorhandling.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:dthlms/login/loginmodel.dart';
import 'package:dthlms/map/apiobject.dart';
import 'package:dthlms/package/packagedashboard/packagedashboard.dart';
import 'package:dthlms/routes/router.dart';

import 'package:dthlms/url/api_url.dart';
import 'package:dthlms/utils/loader.dart';
import 'package:dthlms/android/packagemobile/packages.dart';

import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

Future loginApi(
  BuildContext context,
  String loginemail,
  String password,
  String otp,
) async {
  var logindata;
  final getObj = Get.put(Getx());
  loader(context);
  var deviceinfo;

  if (Platform.isAndroid) {
    deviceinfo = await ClsDeviceInfo.androidInfo(context);
  } else if (Platform.isWindows) {
    deviceinfo = await ClsDeviceInfo.windowsInfo();
  } else if (Platform.isIOS) {
    deviceinfo = await ClsDeviceInfo.androidInfo(context);
  } else if (Platform.isMacOS) {
    deviceinfo = await ClsDeviceInfo.windowsInfo();
  }
  if (Platform.isAndroid) {
    logindata = ClsMap().objLoginApi(loginemail, password, otp, deviceinfo);
  } else if (Platform.isWindows) {
    logindata = ClsMap().objLoginApi(loginemail, password, otp, deviceinfo);
  }
<<<<<<< HEAD
  print(jsonEncode(logindata));
  Get.back();
=======
  print(deviceinfo);
>>>>>>> 836e8592a044d452502349ddc14ae22a1f16a149
  final res =
      await http.post(Uri.https(ClsUrlApi.mainurl, ClsUrlApi.loginEndpoint),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json.encode(logindata));

  var jsondata = json.decode(res.body);
  print(jsondata);
  if (res.statusCode == 200 && jsondata['isSuccess'] == true) {
    print(jsondata);
    final userdata = DthloginUserDetails(
        email: jsondata['result']['email'],
        phoneNumber: jsondata['result']['phoneNumber'],
        token: jsondata['result']['token']);
    getObj.loginuserdata.add(userdata);
    // ignore: unused_local_variable
    List dbdata = [];

    // await DbHandler()
    //     .insertLoginData(userdata.email, userdata.phoneNumber, userdata.token);
    // await DbHandler().createMyPackagetable();
    //  await insertMyPackageData();
    // dbdata = await DbHandler().readData();
// String tk=jsondata['result']['token'];
    Get.back();

    Platform.isWindows
        ? Get.toNamed('/package',
            arguments: {'token': jsondata['result']['token']})
<<<<<<< HEAD
        : Get.toNamed("/Mobilevideodashboard",arguments:{'token': jsondata['result']['token']} );

  // showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //           actions: [
  //             ElevatedButton(
  //                 onPressed: () {
  //                   Get.to(() => Platform.isWindows
  //                       ? Dashboard()
  //                       : const MobileHomepage());
  //                 },
  //                 child: const Text('Ok'))
  //           ],
  //           title: const Text('Data'),
  //           content: Text(
  //             dbdata.toString(),
  //           ));
  //     });
=======
        : Get.to(() => PackageDashboardMobile(jsondata['result']['token']));
>>>>>>> 836e8592a044d452502349ddc14ae22a1f16a149
  } else {
    Get.back();
    ClsErrorMsg.fnErrorDialog(context, 'Login', jsondata['errorMessages'], res);
  }
}

Future signupApi(
    BuildContext context,
    String signupuser,
    String signupfirstname,
    String signuplastname,
    signupemail,
    signuppassword,
    signupphno,
    key,
    otp) async {
  // try {
  final getObj = Get.put(Getx());
  print(getObj);
  loader(context);
  var deviceinfo;
  if (Platform.isAndroid) {
    deviceinfo = await ClsDeviceInfo.androidInfo(context);
    print(deviceinfo);
  } else if (Platform.isWindows) {
    deviceinfo = await ClsDeviceInfo.windowsInfo();
  } else if (Platform.isIOS) {
    deviceinfo = ClsDeviceInfo.androidInfo(context);
  } else if (Platform.isMacOS) {
    deviceinfo = await ClsDeviceInfo.windowsInfo();
  }

  var signupdata = ClsMap().objSignupApi(
      signupuser,
      signupfirstname,
      signuplastname,
      signupemail,
      signuppassword,
      signupphno,
      key,
      otp,
      deviceinfo);

  final http.Response res = await http.post(
      Uri.https(ClsUrlApi.mainurl, '${ClsUrlApi.signupEndpoint}$key'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(signupdata));

  var jsondata = json.decode(res.body);
  print(jsondata);
  if (res.statusCode == 200 &&
      jsondata['statusCode'] == 200 &&
      jsondata['isSuccess'] == true) {
    Get.back();
    await FlutterPlatformAlert.playAlertSound();

    final result = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: 'Login',
      text: 'Registration Sucessfull',
      positiveButtonTitle: "Ok",
    );
    Getx getxController = Get.put(Getx());
    if (CustomButton.positiveButton == result) {
      getxController.show.value = false;
      Get.to(() => const DthLmsLogin());
    } else {}
  } else {
    Get.back();

    print(res.statusCode);

    ClsErrorMsg.fnErrorDialog(
        context, 'Sign up', jsondata['errorMessages'], res);
  }
  // } catch (e) {
  //   Get.back();
  //   ClsErrorMsg.fnErrorDialog(context, e, e);
  // }
}

Future signupcodegenerate(
    String signupphno, String signupemail, BuildContext context) async {
  // try {
  Getx getObj = Get.put(Getx());
  loader(context);
  var response = await http.get(
      Uri.https(ClsUrlApi.mainurl, ClsUrlApi.getUserConfirmationTypeEndpoint));

  var json = jsonDecode(response.body);
  print('mishra');
  print(response.request);

  if (response.statusCode == 200 && json['isSuccess'] == true) {
    var datacode = ClsMap().objSignupconfirmation(
      signupphno,
      signupemail,
    );
    print(datacode);
    var responsecode = await http.post(
        Uri.https(ClsUrlApi.mainurl, ClsUrlApi.generateCodeEndpoint),
        headers: <String, String>{
          'accept': 'text/plain',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(datacode));
    print('sayak mishra');
    print(responsecode.body);
    var json = jsonDecode(responsecode.body);

    if (responsecode.statusCode == 200 && json['isSuccess'] == true) {
      String key = json['result'];
      getObj.otplineshow.value = true;
      Get.back();

      return key;
    } else {
      // print(responsecode.body);

      Get.back();
      ClsErrorMsg.fnErrorDialog(
          context, 'Sign up', json['errorMessages'], responsecode);

      return 'error';
    }
  } else {
    Get.back();
    ClsErrorMsg.fnErrorDialog(
        context, 'Sign up', json['errorMessages'], response);
  }
  // } catch (e) {
  //   print(e);
  //   Get.back();
  //   ClsErrorMsg.fnErrorDialog(context, e, e);
  //   return 'error';
  // }
}
