import 'dart:convert';

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.dart';
import 'package:dthlms/url/api_url.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:typewritertext/v3/typewriter.dart';

class PackageDashboard extends StatefulWidget {
  final String token;
  const PackageDashboard(this.token, {super.key});

  @override
  State<PackageDashboard> createState() => _PackageDashboardState();
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

class MyPackageDetails {
  int studentPackageID;
  String userID;
  String packageID;
  DateTime activationDate;
  DateTime validityDate;
  int validityDays;
  bool isActive;
  bool isBlocked;
  DateTime createdOn;
  String createdBy;
  DateTime modifiedOn;
  String modifiedBy;
  String createdIP;
  String modifiedIP;

  MyPackageDetails({
    required this.studentPackageID,
    required this.userID,
    required this.packageID,
    required this.activationDate,
    required this.validityDate,
    required this.validityDays,
    required this.isActive,
    required this.isBlocked,
    required this.createdOn,
    required this.createdBy,
    required this.modifiedOn,
    required this.modifiedBy,
    required this.createdIP,
    required this.modifiedIP,
  });
}

class _PackageDashboardState extends State<PackageDashboard> {
  Getx getxController = Get.put(Getx());

  List<AllPackage> allpackage = [];
  Map<String, List<PackageFind>> allnestedData = {};

  List<MyPackageDetails> mypackage = [];
  // Map<String, List<MyPackage>> mynestedData = {};

  Future fnusermypackage(String token) async {
    Map data = {
      "tblStudentPackage": {"UserID": "1234567890"}
    };
    final response = await http.post(
      Uri.https(ClsUrlApi.mainurl,
          '/api/AuthDataGet/ExecuteJson/sptblStudentPackage/2'),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var jsondata = json.decode(response.body);
    print(jsondata);
    print('sayak');
    if (response.statusCode == 200 && jsondata['isSuccess'] == true) {
      var jsonData = json.decode(jsondata['result']);
      print(jsonData);
      mypackage.clear();
      for (int i = 0; i < jsonData.length; i++) {
        final data = MyPackageDetails(
            studentPackageID: jsondata['result']['UserID'],
            userID: jsondata['result']['StudentPackageID'],
            activationDate: jsondata['result']['StudentPackageID'],
            createdBy: jsondata['result']['StudentPackageID'],
            createdIP: jsondata['result']['StudentPackageID'],
            createdOn: jsondata['result']['StudentPackageID'],
            isActive: jsondata['result']['StudentPackageID'],
            validityDate: jsondata['result']['StudentPackageID'],
            isBlocked: jsondata['result']['StudentPackageID'],
            modifiedBy: jsondata['result']['StudentPackageID'],
            modifiedIP: jsondata['result']['StudentPackageID'],
            modifiedOn: jsondata['result']['StudentPackageID'],
            packageID: jsondata['result']['StudentPackageID'],
            validityDays: jsondata['result']['StudentPackageID']);
        mypackage.add(data);
      }
      setState(() {});
    }
  }

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
    print(jsondata);
    if (response.statusCode == 200 && jsondata['isSuccess'] == true) {
      var jsonData = json.decode(jsondata['result']);
      allpackage.clear();
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
        allpackage.add(data);
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
        allnestedData[id] = packagefind;
      });
    }
  }

  @override
  void initState() {
    // fnusermypackage(widget.token);
    fnfindallpackage(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPage.bgcolor,
      body: Row(
        children: [
          Container(
            child: Expanded(
                child: Container(
                    child: Column(
              children: [
                Flexible(
                  child: Obx(
                    () => Column(
                      children: [
                        AnimatedButtonBar(
                          controller: AnimatedButtonController()..setIndex(0),
                          radius: 32.0,
                          padding: const EdgeInsets.all(16.0),
                          backgroundColor: ColorPage.bluegrey800,
                          foregroundColor: ColorPage.bluegrey300,
                          elevation: 24,
                          curve: Curves.bounceIn,
                          borderColor: ColorPage.white,
                          borderWidth: 2,
                          innerVerticalPadding: 16,
                          children: [
                            ButtonBarEntry(
                                onTap: () {
                                  getxController.packageshow.value = true;
                                },
                                child: Text(
                                  'My Package',
                                  style: FontFamily.font,
                                )),
                            ButtonBarEntry(
                                onTap: () {
                                  getxController.packageshow.value = false;
                                  fnfindallpackage(widget.token);
                                },
                                child: Text(
                                  'All Package',
                                  style: FontFamily.font,
                                )),
                          ],
                        ),
                        getxController.packageshow.value
                            ? Expanded(
                                child: false
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        // itemCount: 5,
                                        itemCount: allpackage.length,
                                        itemBuilder: (context, index) {
                                          return ExpansionTile(
                                            // shape:
                                            //     Border.all(color: Colors.transparent),
                                            // trailing: ,
                                            leading: Text(
                                                allpackage[index].packageId),
                                            title: Text(
                                              allpackage[index].packageName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onExpansionChanged: (value) {
                                              if (value &&
                                                  !allnestedData.containsKey(
                                                      allpackage[index]
                                                          .packageId)) {
                                                fnfindpackage(
                                                    widget.token,
                                                    allpackage[index]
                                                        .packageId);
                                              }
                                            },
                                            children: [
                                              allnestedData.containsKey(
                                                      allpackage[index]
                                                          .packageId)
                                                  ? ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          (context, subIndex) {
                                                        var subItem = allnestedData[
                                                                allpackage[
                                                                        index]
                                                                    .packageId]![
                                                            subIndex];
                                                        return ExpansionTile(
                                                          leading: Text(
                                                              subItem.courseId),
                                                          title: Text(subItem
                                                              .courseName),
                                                          subtitle: Text(
                                                              subItem.termName),
                                                          onExpansionChanged:
                                                              (value) {
                                                            if (value &&
                                                                !allnestedData
                                                                    .containsKey(
                                                                        subItem
                                                                            .packageId)) {
                                                              fnfindpackage(
                                                                  widget.token,
                                                                  subItem
                                                                      .packageId);
                                                            }
                                                          },
                                                          children: [
                                                            allnestedData
                                                                    .containsKey(
                                                                        subItem
                                                                            .packageId)
                                                                ? ListView
                                                                    .builder(
                                                                    shrinkWrap:
                                                                        true,
                                                                    itemCount:
                                                                        1,
                                                                    itemBuilder:
                                                                        (context,
                                                                            subSubIndex) {
                                                                      var subSubItem =
                                                                          allnestedData[subItem.packageId]![
                                                                              subSubIndex];
                                                                      return ListTile(
                                                                        leading:
                                                                            Text(subSubItem.courseId),
                                                                        title: Text(
                                                                            subItem.termName),
                                                                        subtitle:
                                                                            Text(subSubItem.packageDisplayName),
                                                                      );
                                                                    },
                                                                  )
                                                                : CircularProgressIndicator(),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  : CircularProgressIndicator()
                                            ],
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text('No Package'),
                                      ))
                            : Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  // itemCount: 5,
                                  itemCount: allpackage.length,
                                  itemBuilder: (context, index) {
                                    return ExpansionTile(
                                      // shape:
                                      //     Border.all(color: Colors.transparent),
                                      // trailing: ,
                                      leading:
                                          Text(allpackage[index].packageId),
                                      title: Text(
                                        allpackage[index].packageName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onExpansionChanged: (value) {
                                        if (value &&
                                            !allnestedData.containsKey(
                                                allpackage[index].packageId)) {
                                          fnfindpackage(widget.token,
                                              allpackage[index].packageId);
                                        }
                                      },
                                      children: [
                                        allnestedData.containsKey(
                                                allpackage[index].packageId)
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                itemBuilder:
                                                    (context, subIndex) {
                                                  var subItem = allnestedData[
                                                          allpackage[index]
                                                              .packageId]![
                                                      subIndex];
                                                  return ExpansionTile(
                                                    leading:
                                                        Text(subItem.courseId),
                                                    title: Text(
                                                        subItem.courseName),
                                                    subtitle:
                                                        Text(subItem.termName),
                                                    onExpansionChanged:
                                                        (value) {
                                                      if (value &&
                                                          !allnestedData
                                                              .containsKey(subItem
                                                                  .packageId)) {
                                                        fnfindpackage(
                                                            widget.token,
                                                            subItem.packageId);
                                                      }
                                                    },
                                                    children: [
                                                      allnestedData.containsKey(
                                                              subItem.packageId)
                                                          ? ListView.builder(
                                                              shrinkWrap: true,
                                                              itemCount: 1,
                                                              itemBuilder: (context,
                                                                  subSubIndex) {
                                                                var subSubItem =
                                                                    allnestedData[
                                                                            subItem.packageId]![
                                                                        subSubIndex];
                                                                return ListTile(
                                                                  leading: Text(
                                                                      subSubItem
                                                                          .courseId),
                                                                  title: Text(
                                                                      subItem
                                                                          .termName),
                                                                  subtitle: Text(
                                                                      subSubItem
                                                                          .packageDisplayName),
                                                                );
                                                              },
                                                            )
                                                          : CircularProgressIndicator(),
                                                    ],
                                                  );
                                                },
                                              )
                                            : CircularProgressIndicator()
                                      ],
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ))),
          ),
          Expanded(
              child: Container(
                  color: Colors.black,
                  child: Column(
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Stack(children: [
                              Image.asset(
                                fit: BoxFit.fitHeight,
                                'assets/wallpaperflare.com_wallpaper.jpg',
                                height: MediaQuery.sizeOf(context).height,
                              ),
                              Positioned(
                                  bottom: 500,
                                  left: 300,
                                  child: TypeWriter.text(
                                    'lorem ipsum dolot sit amet ...',
                                    style: FontFamily.font2,
                                    repeat: true,
                                    duration: const Duration(milliseconds: 50),
                                  ))
                            ]),
                          ],
                        ),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
