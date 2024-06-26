// ignore_for_file: no_logic_in_create_state, prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors

import 'dart:convert';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/url/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class PackageScreen extends StatefulWidget {
  final String token;
  PackageScreen(this.token, {super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState(token);
}

class AllPackage {
  String courseId;
  String courseName;
  String termId;
  String termName;
  String packageId;
  String isActive;
  String packageName;
  String packageDisplayName;
  String srNo;
  String sortedOrder;
  AllPackage({
    required this.courseId,
    required this.courseName,
    required this.termId,
    required this.termName,
    required this.packageId,
    required this.isActive,
    required this.packageName,
    required this.packageDisplayName,
    required this.srNo,
    required this.sortedOrder,
  });
}

class PackageFind {
  String courseId;
  String courseName;
  String termId;
  String termName;
  String packageId;
  String isActive;
  String packageName;
  String packageDisplayName;
  String srNo;
  String sortedOrder;
  PackageFind({
    required this.courseId,
    required this.courseName,
    required this.termId,
    required this.termName,
    required this.packageId,
    required this.isActive,
    required this.packageName,
    required this.packageDisplayName,
    required this.srNo,
    required this.sortedOrder,
  });
}

class _PackageScreenState extends State<PackageScreen> {
  late String token;
  _PackageScreenState(this.token);

  @override
  void initState() {
    super.initState();
    fnfindallpackage(token);
  }

  List<AllPackage> package = [];
   Getx getx_obj = Get.put(Getx());
  Map<String, List<PackageFind>> nestedData = {};

  Future<void> fnfindallpackage(String token) async {
    // loader(context);
    Map data = {
      "tblPackage": {"PackageId": "0"}
    };

    final response = await http.post(
      Uri.https(ClsUrlApi.mainurl, ClsUrlApi.allpackage),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var jsondata = json.decode(response.body);
    if (response.statusCode == 200 && jsondata['isSuccess'] == true) {
      var jsonData = json.decode(jsondata['result']);
      package.clear();
      for (int i = 0; i < jsonData.length; i++) {
        final data = AllPackage(
          courseId: jsonData[i]['CourseId'].toString(),
          courseName: jsonData[i]['CourseName'].toString(),
          termId: jsonData[i]['TermId'].toString(),
          termName: jsonData[i]['TermName'].toString(),
          packageId: jsonData[i]['PackageId'].toString(),
          isActive: jsonData[i]['IsActive'].toString(),
          packageName: jsonData[i]['PackageName'].toString(),
          packageDisplayName: jsonData[i]['PackageDisplayName'].toString(),
          srNo: jsonData[i]['SrNo'].toString(),
          sortedOrder: jsonData[i]['SortedOrder'].toString(),
        );
        package.add(data);
      }
      setState(() {});
    }
  }

  Future<void> fnfindpackage(String token, String id) async {
    Map data = {
      "tblPackage": {"PackageId": id}
    };

    final response = await http.post(
      Uri.https(ClsUrlApi.mainurl, ClsUrlApi.allpackage),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var jsondata = json.decode(response.body);

    if (response.statusCode == 200 && jsondata['isSuccess'] == true) {
      var jsonData = json.decode(jsondata['result']);
      List<PackageFind> packagefind = [];
      packagefind.clear();
      print(response.body);

      for (int i = 0; i < jsonData.length; i++) {
        final data = PackageFind(
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
        packagefind.add(data);
      }
      setState(() {
        nestedData[id] = packagefind;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
    ()=> Scaffold(
        backgroundColor: ColorPage.color1,
        appBar: AppBar(
          backgroundColor: ColorPage.appbarcolor,
          centerTitle: true,
          title: Text(
            'Choose your Package',
            style: FontFamily.font2,
            textScaler: TextScaler.linear(1.5),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 200),
          decoration: BoxDecoration(
              // color: ColorPage.bgcolor,
              // border: Border.all(),
              ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                color: ColorPage.bgcolor,
                child: ListTile(
                  title: Text(
                    'My Package',
                    style: FontFamily.font,
                  ),
                ),
              ),
              Container(
                color: ColorPage.bgcolor,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: package.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      leading: Text(package[index].packageId),
                      title: Text(
                        package[index].packageName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onExpansionChanged: (value) {
                        if (value &&
                            !nestedData.containsKey(package[index].packageId)) {
                          fnfindpackage(token, package[index].packageId);
                        }
                      },
                      children: [
                        nestedData.containsKey(package[index].packageId)
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (context, subIndex) {
                                  var subItem = nestedData[
                                      package[index].packageId]![subIndex];
                                  return ExpansionTile(
                                    // leading: Text(subItem.courseId),
                                    title: Text(subItem.courseName),
                                    subtitle: Text(subItem.termName),
                                    onExpansionChanged: (value) {
                                      if (value &&
                                          !nestedData
                                              .containsKey(subItem.packageId)) {
                                        fnfindpackage(token, subItem.packageId);
                                      }
                                    },
                                    children: [
                                      nestedData.containsKey(subItem.packageId)
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: 1,
                                              itemBuilder:
                                                  (context, subSubIndex) {
                                                var subSubItem = nestedData[
                                                    subItem
                                                        .packageId]![subSubIndex];
                                                return ListTile(
                                                  // leading:
                                                  //     Text(subSubItem.courseId),
                                                  title: Text(
                                                      subSubItem.packageName),
                                                  subtitle: Text(subSubItem
                                                      .packageDisplayName),
                                                );
                                              },
                                            )
                                          : Center(
                                              child: CircularProgressIndicator()),
                                    ],
                                  );
                                },
                              )
                            : Center(child: CircularProgressIndicator()),
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100),
                color: ColorPage.bgcolor,
                child: ListTile(
                  title: Text(
                    'All Package',
                    style: FontFamily.font,
                  ),
                ),
              ),
              Container(
                color: ColorPage.bgcolor,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: package.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      leading: Text(package[index].packageId),
                      title: Text(
                        package[index].packageName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onExpansionChanged: (value) {
                        if (value &&
                            !nestedData.containsKey(package[index].packageId)) {
                          fnfindpackage(token, package[index].packageId);
                        }
                      },
                      children: [
                        nestedData.containsKey(package[index].packageId)
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (context, subIndex) {
                                  var subItem = nestedData[
                                      package[index].packageId]![subIndex];
                                  return ExpansionTile(
                                    // leading: Text(subItem.courseId),
                                    title: Text(subItem.courseName),
                                    subtitle: Text(subItem.termName),
                                    onExpansionChanged: (value) {
                                      if (value &&
                                          !nestedData
                                              .containsKey(subItem.packageId)) {
                                        fnfindpackage(token, subItem.packageId);
                                      }
                                    },
                                    children: [
                                      nestedData.containsKey(subItem.packageId)
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: 1,
                                              itemBuilder:
                                                  (context, subSubIndex) {
                                                var subSubItem = nestedData[
                                                    subItem
                                                        .packageId]![subSubIndex];
                                                return ListTile(
                                                  // leading:
                                                  //     Text(subSubItem.courseId),
                                                  title: Text(
                                                      subSubItem.packageName),
                                                  subtitle: Text(subSubItem
                                                      .packageDisplayName),
                                                );
                                              },
                                            )
                                          : Center(
                                              child: CircularProgressIndicator()),
                                    ],
                                  );
                                },
                              )
                            : Center(child: CircularProgressIndicator()),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
