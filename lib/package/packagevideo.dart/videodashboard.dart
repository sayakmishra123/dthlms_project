// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VideoDashboard extends StatefulWidget {
  String token;
  VideoDashboard(this.token, {super.key});

  @override
  State<VideoDashboard> createState() => _VideoDashboardState(token);
}

class _VideoDashboardState extends State<VideoDashboard> {
  String token;
  _VideoDashboardState(this.token);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callapi().whenComplete(() => null);
    });
    // TODO: implement initState
    super.initState();
  }

  Future callapi() async {
    fngetvideoApi().whenComplete(() => fngetVideodetailsApi());
  }

  List x1 = [];
  var data1;
  // List x2 = [];
  var data2;

  Future fngetvideoApi() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    var res = await http.post(
        Uri.https(
          'dthclass.com',
          'api/AuthDataGet/ExecuteJson/sptblEncryptionHistory/3',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "tblEncryptionHistory": {"PackageId": 1, "VideoType": "Video"}
        }));
    var jsondata = jsonDecode(res.body);
    print(jsondata);
    var data = jsonDecode(jsondata['result']);
    // data = data1[0]['VideoName'];
    for (int i = 0; i < data.length; i++) {
      data1 = data[i]['VideoName'];

      x1.add(data1);
    }
    setState(() {});
    Get.back();
  }

  Future fngetVideodetailsApi() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    var res = await http.post(
        Uri.https(
          'dthclass.com',
          'api/AuthDataGet/ExecuteJson/spTblVideoDetails/4',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "TblVideoDetails": {"VideoId": 11, "Category": "PDF"}
        }));
    var jsondata = jsonDecode(res.body);
    setState(() {
      data2 = jsonDecode(jsondata['result']);
    });

    print(jsondata);
    // data = data1[0]['VideoName'];

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(x1.toString())],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(data2.toString())],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
