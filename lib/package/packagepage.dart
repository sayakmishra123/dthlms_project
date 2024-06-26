// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/package/packagescreen.dart';
import 'package:dthlms/url/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class PackagePage extends StatefulWidget {
  String courseName = '';
  String packageId = '';
  String token = '';
  PackagePage(this.courseName, this.packageId, this.token, {super.key});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  List<AllPackage> package = [];
   Getx getx_obj = Get.put(Getx());

  Future fnfindallpackage(String token, BuildContext context) async {
    Map data = {
      "tblPackage": {"PackageId": widget.packageId}
    };
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator.adaptive());
        });

    final response = await http.post(
      Uri.https(ClsUrlApi.mainurl, ClsUrlApi.allpackage),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var jsondata = json.decode(response.body);
    print(response.headers);
    print(jsondata);
    if (response.statusCode == 200 && jsondata['isSuccess'] == true) {
      // print(jsonEncode(jsondata['result'][0].toString()));
      var jsonData = json.decode(jsondata['result']);
      print(jsondata);
      final data = AllPackage(
        courseId: jsonData['CourseId'].toString(),
        courseName: jsonData['CourseName'].toString(),
        termId: jsonData['TermId'].toString(),
        termName: jsonData['TermName'].toString(),
        packageId: jsonData['PackageId'].toString(),
        isActive: jsonData['IsActive'].toString(),
        packageName: jsonData['PackageName'].toString(),
        packageDisplayName: jsonData['PackageDisplayName'].toString(),
        srNo: jsonData['SrNo'].toString(),
        sortedOrder: jsonData['SortedOrder'].toString(),
      );
      package.add(data);

      setState(() {
        show = true;
      });
    }

    Get.back();
    // return package;
  }

  bool show = false;
  Future fnpackagedetails(String token, BuildContext context) async {
    Map data = {
      "tblPackageDeatils": [
        {
          "PackageId": widget.packageId,
          "Category": "Structure"
          // / "Attribute" / "Details"// Structure
        }
      ]
    };
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator.adaptive());
        });

    final response = await http.post(
      Uri.https(ClsUrlApi.mainurl, ClsUrlApi.packagedetails),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var jsondata = json.decode(response.body);
    print(response.headers);
    print(jsondata);
    if (response.statusCode == 200 && jsondata['isSuccess'] == true) {
      Get.back();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog.adaptive(
              title: Text('Details'),
              content: Column(
                children: [Text(jsondata['result'])],
              ),
            );
          });

           

      // print(jsonEncode(jsondata['result'][0].toString()));
      // var jsonData = json.decode(jsondata['result']);
      // print(jsondata);
      // final data = Package(
      //   courseId: jsonData['CourseId'].toString(),
      //   courseName: jsonData['CourseName'].toString(),
      //   termId: jsonData['TermId'].toString(),
      //   termName: jsonData['TermName'].toString(),
      //   packageId: jsonData['PackageId'].toString(),
      //   isActive: jsonData['IsActive'].toString(),
      //   packageName: jsonData['PackageName'].toString(),
      //   packageDisplayName: jsonData['PackageDisplayName'].toString(),
      //   srNo: jsonData['SrNo'].toString(),
      //   sortedOrder: jsonData['SortedOrder'].toString(),
      // );
      // package.add(data);

      // setState(() {
      //   show = true;
      // });
    }

    // return package;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPage.appbarcolor,
          actions: [
            ElevatedButton(
                onPressed: () async {
                  await fnfindallpackage(widget.token, context)
                      .whenComplete(() => null);
                },
                child: Text('Click'))
          ],
          title: Text('Package'),
        ),
        body: show
            ? ListView.builder(
                itemCount: package.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(package[index].courseName),
                    trailing: Text(package[index].packageId),
                    onTap: () async {
                      await fnpackagedetails(widget.token, context);
                    },
                  );
                },
              )
            : Container());
  }
}
