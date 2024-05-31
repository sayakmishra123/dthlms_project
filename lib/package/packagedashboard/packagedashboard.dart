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

class _PackageDashboardState extends State<PackageDashboard> {
  Getx getxController = Get.put(Getx());

  List<AllPackage> package = [];
  Map<String, List<PackageFind>> nestedData = {};

  Future mypackage(String token) async {
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
    if (response.statusCode == 200 && jsondata['isSuccess'] == true) {
      var jsonData = json.decode(jsondata['result']);
      print(jsonData);
      package.clear();
      for (int i = 0; i < jsonData.length; i++) {
        // final data = AllPackage(
        //   courseId: jsonData[i]['CourseId'].toString(),
        //   courseName: jsonData[i]['CourseName'].toString(),
        //   termId: jsonData[i]['TermId'].toString(),
        //   termName: jsonData[i]['TermName'].toString(),
        //   packageId: jsonData[i]['PackageId'].toString(),
        //   isActive: jsonData[i]['IsActive'].toString(),
        //   packageName: jsonData[i]['PackageName'].toString(),
        //   packageDisplayName: jsonData[i]['PackageDisplayName'].toString(),
        //   srNo: jsonData[i]['SrNo'].toString(),
        //   sortedOrder: jsonData[i]['SortedOrder'].toString(),
        // );
        // package.add(data);
      }
      setState(() {});
    }
  }

  // Future<void> fnfindallpackage(String token) async {
  //   // loader(context);
  //   Map data = {
  //     "tblPackage": {"PackageId": "0"}
  //   };

  //   final response = await http.post(
  //     Uri.https(ClsUrlApi.mainurl, ClsUrlApi.allpackage),
  //     body: json.encode(data),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   var jsondata = json.decode(response.body);
  //   print(jsondata);
  //   if (response.statusCode == 200 && jsondata['isSuccess'] == true) {
  //     var jsonData = json.decode(jsondata['result']);
  //     package.clear();
  //     for (int i = 0; i < jsonData.length; i++) {
  //       final data = AllPackage(
  //         courseId: jsonData[i]['CourseId'].toString(),
  //         courseName: jsonData[i]['CourseName'].toString(),
  //         termId: jsonData[i]['TermId'].toString(),
  //         termName: jsonData[i]['TermName'].toString(),
  //         packageId: jsonData[i]['PackageId'].toString(),
  //         isActive: jsonData[i]['IsActive'].toString(),
  //         packageName: jsonData[i]['PackageName'].toString(),
  //         packageDisplayName: jsonData[i]['PackageDisplayName'].toString(),
  //         srNo: jsonData[i]['SrNo'].toString(),
  //         sortedOrder: jsonData[i]['SortedOrder'].toString(),
  //       );
  //       package.add(data);
  //     }
  //     setState(() {});
  //   }
  // }

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
  void initState() {
    mypackage(widget.token);
    // fnfindallpackage(widget.token);
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
                                },
                                child: Text(
                                  'All Package',
                                  style: FontFamily.font,
                                )),
                          ],
                        ),
                        getxController.packageshow.value
                            ? Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  // itemCount: 5,
                                  itemCount: package.length,
                                  itemBuilder: (context, index) {
                                    return ExpansionTile(
                                      // shape:
                                      //     Border.all(color: Colors.transparent),
                                      // trailing: ,
                                      leading: Text(package[index].packageId),
                                      title: Text(
                                        package[index].packageName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onExpansionChanged: (value) {
                                        if (value &&
                                            !nestedData.containsKey(
                                                package[index].packageId)) {
                                          fnfindpackage(widget.token,
                                              package[index].packageId);
                                        }
                                      },
                                      children: [
                                        nestedData.containsKey(
                                                package[index].packageId)
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                itemBuilder:
                                                    (context, subIndex) {
                                                  var subItem = nestedData[
                                                          package[index]
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
                                                          !nestedData.containsKey(
                                                              subItem
                                                                  .packageId)) {
                                                        fnfindpackage(
                                                            widget.token,
                                                            subItem.packageId);
                                                      }
                                                    },
                                                    children: [
                                                      nestedData.containsKey(
                                                              subItem.packageId)
                                                          ? ListView.builder(
                                                              shrinkWrap: true,
                                                              itemCount: 1,
                                                              itemBuilder: (context,
                                                                  subSubIndex) {
                                                                var subSubItem =
                                                                    nestedData[subItem
                                                                            .packageId]![
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
                              )
                            : CircularProgressIndicator(),
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
