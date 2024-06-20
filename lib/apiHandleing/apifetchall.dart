import 'dart:convert';
import 'dart:io';
import 'package:dthlms/errormsg/errorhandling.dart';
import 'package:dthlms/getx/getxcontroller.dart';
import 'package:dthlms/map/apiobject.dart';
import 'package:dthlms/url/api_url.dart';
import 'package:dthlms/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

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
    Getx().forgetpasswordemailcode.value = true;
    return jsondata['result'].toString();
  } else {
    return jsondata['errorMessages'];
  }

  // forgetPassword(context, signupemail, jsondata['result']);
}

Future forgetPassword(BuildContext context, String signupemail, String key,
    String otpcode) async {
  // try {
  loader(context);
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

  if (json['isSuccess'] == true && json['statusCode'] == 303) {
    print(json['isSuccess']);
    Get.back();
    resetPassword(
        context,
        json['result']['email'],
        json['result']['phoneNumber'],
        'SayakMishra1234@',
        'SayakMishra1234@',
        json['result']['token']);
  } else {
    Get.back();
    ClsErrorMsg.fnErrorDialog(context, json['errorMessages'], responseBody);
  }
}

Future resetPassword(BuildContext context, String email, String ph, String pass,
    String confirmpass, String code) async {
  loader(context);
  Map body = ClsMap().objresetPassword(email, ph, pass, confirmpass);
  final client = HttpClient();
  final request = await client
      .postUrl(Uri.https(ClsUrlApi.mainurl, '${ClsUrlApi.resetPassword}$code'));
  request.followRedirects = false;
  request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');

  final jsondata = jsonEncode(body);
  request.add(utf8.encode(jsondata));
  print(jsondata);
  final response = await request.close();
  var responseBody = await response.transform(utf8.decoder).join();
  print(responseBody);
  var json = jsonDecode(responseBody);
  if (json['statusCode'] == 200 && json['isSuccess'] == true) {
    Get.back();
    ClsErrorMsg.fnErrorDialog(
        context, 'Password reset successfully', responseBody);
  }

  {
    Get.back();
    ClsErrorMsg.fnErrorDialog(context, json['errorMessages'], responseBody);
  }
}
