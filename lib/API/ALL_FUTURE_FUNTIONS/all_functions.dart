import 'dart:convert';
import 'dart:io';
import 'package:dthlms/API/ERROR_MASSEGE/errorhandling.dart';
import 'package:dthlms/API/MAP_DATA/apiobject.dart';
import 'package:dthlms/API/url/api_url.dart';
import 'package:dthlms/GLOBAL_WIDGET/loader.dart';
import 'package:dthlms/PC/LOGIN/login.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';

import 'package:dthlms/GLOBAL_WIDGET/confirmActivationCode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

Getx getx = Get.put(Getx());
Future forgetgenerateCode(
    BuildContext context, String signupphno, String signupemail) async {
  loader(context);
  Map body = ClsMap().objSignupconfirmation(signupphno, signupemail);
  var res = await http.post(
      Uri.https(ClsUrlApi.mainurl, ClsUrlApi.generateCodeEndpoint),
      headers: {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body));
  var jsondata = jsonDecode(res.body);
  print(jsondata);
  print('object');
  Get.back();
  if (jsondata['statusCode'] == 201 && jsondata['isSuccess'] == true) {
    getx.forgetpasswordemailcode.value = true;
    return jsondata['result'].toString();
  } else {
    return 'jhsbjknbfkjnkajnasd';
  }

  // forgetPassword(context, signupemail, jsondata['result']);
}

Future forgetPassword(BuildContext context, String signupemail, String key,
    String otpcode) async {
  // try {
  loader(context);

  print('forgetpassword');
  Map body = ClsMap().objforgetPassword(signupemail, otpcode);
  final client = HttpClient();

  final request = await client
      .postUrl(Uri.https(ClsUrlApi.mainurl, '${ClsUrlApi.forgetpassword}$key'));
  request.followRedirects = false;
  request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');

  final jsondata = jsonEncode(body);
  request.add(utf8.encode(jsondata));
  final response = await request.close();
  var responseBody = await response.transform(utf8.decoder).join();
  var json = jsonDecode(responseBody);
  print(json);
  print('forgot pass res');
  if (json['isSuccess'] == true && json['statusCode'] == 303) {
    print(json['isSuccess']);

    Get.back();
    getx.forgetpageshow.value = true;

    return json['result']['token'];
  } else {
    Get.back();
    ClsErrorMsg.fnErrorDialog(
        context, 'Forget Password', json['errorMessages'], responseBody);
  }
}

Future resetPassword(BuildContext context, String email, String ph, String pass,
    String confirmpass, String code) async {
  print(code);
  loader(context);
  Map body = ClsMap().objresetPassword(email, ph, pass, confirmpass);

  final client = HttpClient();
  final request = await client
      .postUrl(Uri.https(ClsUrlApi.mainurl, '${ClsUrlApi.resetPassword}$code'));
  request.followRedirects = false;
  request.headers.set(
    HttpHeaders.contentTypeHeader,
    'application/json',
  );

  final jsondata = jsonEncode(body);
  request.add(utf8.encode(jsondata));
  final response = await request.close();
  var responseBody = await response.transform(utf8.decoder).join();
  // print(responseBody);
  var json = jsonDecode(responseBody);
  print(json);
  if (json['statusCode'] == 100 && json['isSuccess'] == true) {
    Get.back();

    ClsErrorMsg.fnErrorDialog(
        context, 'Password reset', 'Password reset successfully', responseBody);
    Get.to(() => DthLmsLogin());
  }
  {
    Get.back();
    ClsErrorMsg.fnErrorDialog(
        context, 'Password reset', json['errorMessages'], responseBody);
  }
}

Future studentWatchtime(BuildContext context) async {
  loader(context);
  Map body = ClsMap().objStudentWatchTime(1, 300, 5);
  var res = await http.post(
      Uri.https(ClsUrlApi.mainurl, ClsUrlApi.generateCodeEndpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body));
  var jsondata = jsonDecode(res.body);
  print(jsondata);
  print('object');
  Get.back();
  if (jsondata['statusCode'] == 200 && jsondata['isSuccess'] == true) {
    return jsondata['result'].toString();
  } else {
    return 'kmlfmkzmfkdk';
  }
}

Future packactivationKey(
    BuildContext context, packageactivationkey, token) async {
  loader(context);
  Map data = {
    "sbAppApi": {"ActivationKey": packageactivationkey}
  };
 
  var res = await http.post(
      Uri.https(ClsUrlApi.mainurl, ClsUrlApi.studentActivationkey),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data));
  print(res.body);

  if (res.statusCode == 200) {
    Get.back();
    await confirmActivationCode(context, res.body);
  }
    }




    
  Future tableEncryptionHistory(
    BuildContext context,token) async {
  loader(context);
 
  Map data={

  };

  // print(token);
  var responce = await http.post(
    Uri.https(ClsUrlApi.mainurl,'/api/AuthDataGet/ExecuteJson/sptblEncryptionHistory/8'),
    //  Uri.parse("/api/AuthDataGet/ExecuteJson/sptblEncryptionHistory/8"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data));
  print(responce.statusCode.toString()+"hello");

  if (responce.statusCode == 200) {
  
    print(responce.body.toString());
  }  Get.back();
}
