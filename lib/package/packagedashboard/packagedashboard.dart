// ignore_for_file: prefer_const_constructors, dead_code, unnecessary_import, avoid_print, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:ui';

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/package/packagevideo.dart/videodashboard.dart';
import 'package:dthlms/url/api_url.dart';
import 'package:dthlms/utils/enebelActivationcode.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:showcaseview/showcaseview.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
  String activationDate;
  String validityDate;
  int validityDays;
  bool isActive;
  bool isBlocked;
  String createdOn;
  String createdBy;
  String modifiedOn;
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

class _PackageDashboardState extends State<PackageDashboard>
    with TickerProviderStateMixin {
  Getx getxController = Get.put(Getx());
  TextEditingController searchController = TextEditingController();

  List<AllPackage> allpackage = [];
  Map<String, List<PackageFind>> allnestedData = {};

  List<MyPackageDetails> mypackage = [];
  List<AllPackage> filteredPackage = [];

  // Map<String, List<MyPackage>> mynestedData = {};

  Future fnusermypackage(String token) async {
    Future.delayed(Duration(seconds: 5), () async {
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
        print(jsonData[0].toString());
        for (int i = 0; i < jsonData.length; i++) {
          final data = MyPackageDetails(
              studentPackageID: jsonData[i]['StudentPackageID'],
              userID: jsonData[i]['UserID'],
              activationDate: jsonData[i]['ActivationDate'],
              createdBy: jsonData[i]['CreatedBy'],
              createdIP: jsonData[i]['CreatedIP'],
              createdOn: jsonData[i]['CreatedOn'],
              isActive: jsonData[i]['IsActive'],
              validityDate: jsonData[i]['ValidityDate'],
              isBlocked: jsonData[i]['IsBlocked'],
              modifiedBy: jsonData[i]['ModifiedBy'],
              modifiedIP: jsonData[i]['ModifiedIP'],
              modifiedOn: jsonData[i]['ModifiedOn'],
              packageID: jsonData[i]['PackageID'],
              validityDays: jsonData[i]['ValidityDays']);
          mypackage.add(data);
        }
        setState(() {
          getxController.loading.value = false;
        });
      }
    });
  }

  Future<void> fnfindallpackage(String token) async {
    // loader(context);
    Future.delayed(Duration(seconds: 3), () async {
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
        filteredPackage = List.from(allpackage);
        setState(() {
          getxController.packageshow.value = false;
          getxController.loading.value = false;
        });
        print(getxController.loading.value);
      }
    });
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

  void setFilterData() {
    filteredPackage = allpackage
        .where((p) =>
            p.packageName
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            p.packageDisplayName
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    // fnusermypackage(widget.token);
    // fnusermypackage(widget.token);
    fnfindallpackage(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(

        
        appBar: AppBar(
          backgroundColor: getxController.themecolor.value,
          iconTheme: IconThemeData(color: ColorPage.white),
          automaticallyImplyLeading: false,
          //  leading: Row(children: [Padding(
          //    padding: const EdgeInsets.only(left: 30.0),
          //    child: Icon(Icons.person,color: ColorPage.white,),
          //  )],),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sayak Mishra",
                    style: FontFamily.font9,
                  ),
                  Text(
                    "Sayakmishra@gmail.com",
                    style: FontFamily.font9,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: InkWell(
                onTap: () {
                  showFullImageDialog();
                },
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(230, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/sorojda.png"),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                tooltip: 'Theme',
                onPressed: () {
                  themePage() async {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return BottomSheet(
                              elevation: 20,
                              enableDrag: true,
                              animationController:
                                  AnimationController(vsync: this),
                              onClosing: () {},
                              builder: (context) {
                                return Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // border: Border.all(
                                        //   width: 5,
                                        //   color: ColorPage.blue,
                                        // ),
                                        color: Colors.black),
                                    // decoration: ,
                                    // height: 400,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    child: Column(
                                      children: [
                                        AppBar(
                                          backgroundColor: Colors.black,
                                          title: Text(
                                            'App Theme',
                                            style: FontFamily.font3,
                                            textScaler: TextScaler.linear(1),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                getxController.textColor.value=ColorPage.colorblack;
                                                getxController.backgroundColor.value=ColorPage.white;
                                                 getxController.listviewtext.value=ColorPage.white;


                                              },
                                              child: Image.asset(
                                                'assets/sun.png',
                                                width: 50,
                                              ),
                                            ),
                                            SizedBox(width: 50),
                                            InkWell(
                                              onTap: () {
 getxController.listviewtext.value=ColorPage.colorblack;

                                                  getxController.textColor.value=ColorPage.white;
                                                getxController.backgroundColor.value=ColorPage.colorblack;
                                              },
                                              child: Image.asset(
                                                'assets/themes.png',
                                                width: 50,
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Primary Color',
                                                style: FontFamily.font3,
                                                textScaler:
                                                    TextScaler.linear(1),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  0])),
                                                  onPressed: () {
                                                    getxController.toogleButtontextColor.value=false;
                                                    getxController.activationbuttoncolor.value= ColorPage
                                                            .themeColors[0];
                                                    getxController
                                                            .themecolor.value =
                                                        ColorPage
                                                            .themeColors[0];
                                                    getxController
                                                            .buttoncolor.value =
                                                        ColorPage
                                                            .themeColors[0];
                                                    getxController
                                                            .tooglebuttonBGcolor =
                                                        ColorPage
                                                            .toogleBGButtonColor[0];
                                                    getxController
                                                            .tooglebuttonFGcolor =
                                                        ColorPage
                                                            .toogleFGButtonColor[0];
                                                            getxController.activationbuttoncolor.value=ColorPage.themeColors[0];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  1])),
                                                  onPressed: () {
                                                    getxController.activationbuttoncolor.value=ColorPage.themeColors[1];
                                                    getxController.toogleButtontextColor.value=true;
                                                    getxController
                                                            .themecolor.value =
                                                        ColorPage
                                                            .themeColors[1];
                                                    getxController
                                                            .buttoncolor.value =
                                                        ColorPage
                                                            .themeColors[1];
                                                    getxController
                                                            .tooglebuttonBGcolor =
                                                        ColorPage
                                                            .toogleBGButtonColor[1];
                                                    getxController
                                                            .tooglebuttonFGcolor =
                                                        ColorPage
                                                            .toogleFGButtonColor[1];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  2])),
                                                  onPressed: () {
                                                    getxController.toogleButtontextColor.value=true;
                                                    getxController.activationbuttoncolor.value=ColorPage.themeColors[2];
                                                    getxController.themecolor.value=ColorPage.themeColors[2];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[2];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[2];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[2];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  3])),
                                                  onPressed: () {
                                                    getxController.toogleButtontextColor.value=true;
                                                    getxController.activationbuttoncolor.value=ColorPage.themeColors[3];
                                                   getxController.themecolor.value=ColorPage.themeColors[3];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[3];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[3];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[3];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  4])),
                                                  onPressed: () {
                                                    int i=4;
                                                    getxController.toogleButtontextColor.value=true;
                                                    getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                    ColorPage.themeColors[5],
                                                  )),
                                                  onPressed: () {
                                                    getxController.toogleButtontextColor.value=false;
                                                       int i=5;
                                                       getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  6])),
                                                  onPressed: () {
                                                        int i=6;
                                                        getxController.toogleButtontextColor.value=false;
                                                        getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  7])),
                                                  onPressed: () {
                                                    getxController.toogleButtontextColor.value=false;
                                                      int i=7;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                   getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  8])),
                                                  onPressed: () {
                                                        int i=8;getxController.toogleButtontextColor.value=false;
                                                        getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  9])),
                                                  onPressed: () {
                                                        int i=9;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                   getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  10])),
                                                  onPressed: () {
                                                       int i=10;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                   getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                    ColorPage.themeColors[11],
                                                  )),
                                                  onPressed: () {
                                                      int i=11;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  12])),
                                                  onPressed: () {
                                                    int i=12;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                   getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  13])),
                                                  onPressed: () {
                                                        int i=13;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                   getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                              IconButton.filled(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage
                                                                      .themeColors[
                                                                  14])),
                                                  onPressed: () {
                                                       int i=14;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                  },
                                                  icon: Text('')),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton.filled(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            ColorPage
                                                                    .themeColors[
                                                                15])),
                                                onPressed: () {
                                                      int i=15;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i]

                                                     ;
                                                     getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                },
                                                icon: Text('')),
                                            IconButton.filled(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            ColorPage
                                                                    .themeColors[
                                                                16])),
                                                onPressed: () {
                                                     int i=16;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                   getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                },
                                                icon: Text('')),
                                            IconButton.filled(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            ColorPage
                                                                    .themeColors[
                                                                17])),
                                                onPressed: () {
                                                     int i=17;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                   getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                },
                                                icon: Text('')),
                                            IconButton.filled(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            ColorPage
                                                                    .themeColors[
                                                                18])),
                                                onPressed: () {
                                                      int i=18;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                   getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                },
                                                icon: Text('')),
                                            IconButton.filled(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            ColorPage
                                                                    .themeColors[
                                                                19])),
                                                onPressed: () {
                                                     int i=19;getxController.toogleButtontextColor.value=false;
                                                   getxController.themecolor.value=ColorPage.themeColors[i];
                                                   getxController.activationbuttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.buttoncolor.value=ColorPage.themeColors[i];
                                                     getxController.tooglebuttonBGcolor=ColorPage.toogleBGButtonColor[i];
                                                     getxController.tooglebuttonFGcolor=ColorPage.toogleFGButtonColor[i];
                                                },
                                                icon: Text('')),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage.blue),
                                                      shape: MaterialStatePropertyAll(
                                                          ContinuousRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0)))),
                                                  onPressed: () {},
                                                  child: Text(
                                                    'Ok',
                                                    style: FontFamily.font3,
                                                  )),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              ColorPage.red),
                                                      shape: MaterialStatePropertyAll(
                                                          ContinuousRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0)))),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: FontFamily.font3,
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        });
                  }

                  themePage();
                },
                icon: Icon(Icons.theater_comedy))
          ],
        ),
        backgroundColor: getxController.backgroundColor.value,
        body: Skeletonizer(
          enabled: getxController.loading.value,
          child: Stack(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    child: Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: ColorPage.appbarcolor
                                                  .withOpacity(0.3),
                                              blurRadius: 12,
                                              spreadRadius: 5)
                                        ]),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    height: 55,
                                    width: MediaQuery.of(context).size.width,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setFilterData();
                                      },
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: ColorPage.appbarcolor,
                                            fontSize:
                                                ClsFontsize.ExtraSmall - 1),
                                        hintText: 'Search',
                                        fillColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        filled: true,
                                        suffixIcon: Icon(
                                          Icons.search,
                                          color: ColorPage.appbarcolor,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                  ),
                                  AnimatedButtonBar(
                                    controller: AnimatedButtonController()
                                      ..setIndex(1),
                                    radius: 32.0,
                                    padding: const EdgeInsets.all(16.0),
                                    backgroundColor:
                                        getxController.tooglebuttonBGcolor,
                                    foregroundColor:
                                        getxController.tooglebuttonFGcolor,
                                    // foregroundColor:  Color.fromARGB(255, 37, 233, 135),
                                    // backgroundColor:Color.fromARGB(255, 97, 228, 162),
                                    elevation: 24,
                                    curve: Curves.bounceIn,
                                    borderColor: ColorPage.white,
                                    borderWidth: 2,
                                    innerVerticalPadding: 16,
                                    children: [
                                      ButtonBarEntry(
                                          onTap: () {
                                            getxController.packageshow.value =
                                                true;
                                          },
                                          child: Text(
                                            'My Package',
                                            style: getxController.toogleButtontextColor.value?FontFamily.fontWhite:FontFamily.font,
                                          )),
                                      ButtonBarEntry(
                                          onTap: () {
                                            getxController.packageshow.value =
                                                false;
                                            fnfindallpackage(widget.token);
                                          },
                                          child: Text(
                                            'All Package',
                                            style: getxController.toogleButtontextColor.value?FontFamily.fontWhite:FontFamily.font,
                                          )),
                                    ],
                                  ),
                                  getxController.packageshow.value
                                      ? Expanded(
                                          child: ListView.builder(
                                          shrinkWrap: true,
                                          // itemCount: 5,
                                          itemCount: mypackage.length == 0
                                              ? 10
                                              : mypackage.length,
                                          itemBuilder: (context, index) {
                                            return ExpansionTile(
                                              // shape:
                                              //     Border.all(color: Colors.transparent),
                                              // trailing: ,
                                              leading: Text(mypackage.isEmpty
                                                  ? '1234'
                                                  : mypackage[index].userID),
                                              title: Text(
                                                mypackage.isEmpty
                                                    ? '123455454541351'
                                                    : mypackage[index]
                                                        .packageID,
                                                style:  TextStyle(
                                                  color: getxController.textColor.value,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                // allnestedData.containsKey(
                                                //         allpackage[index]
                                                //             .packageId)
                                                //     ? ListView.builder(
                                                //         shrinkWrap: true,
                                                //         itemCount: 1,
                                                //         itemBuilder:
                                                //             (context,
                                                //                 subIndex) {
                                                //           var subItem =
                                                //               allnestedData[
                                                //                       allpackage[index]
                                                //                           .packageId]![
                                                //                   subIndex];
                                                //           return ExpansionTile(
                                                //             leading: Text(
                                                //                 subItem
                                                //                     .courseId),
                                                //             title: Text(subItem
                                                //                 .courseName),
                                                //             subtitle: Text(
                                                //                 subItem
                                                //                     .termName),
                                                //             onExpansionChanged:
                                                //                 (value) {
                                                //               if (value &&
                                                //                   !allnestedData
                                                //                       .containsKey(
                                                //                           subItem.packageId)) {
                                                //                 fnfindpackage(
                                                //                     widget
                                                //                         .token,
                                                //                     subItem
                                                //                         .packageId);
                                                //               }
                                                //             },
                                                //             children: [
                                                //               allnestedData.containsKey(
                                                //                       subItem
                                                //                           .packageId)
                                                //                   ? ListView
                                                //                       .builder(
                                                //                       shrinkWrap:
                                                //                           true,
                                                //                       itemCount:
                                                //                           1,
                                                //                       itemBuilder:
                                                //                           (context, subSubIndex) {
                                                //                         var subSubItem =
                                                //                             allnestedData[subItem.packageId]![subSubIndex];
                                                //                         return ListTile(
                                                //                           leading: Text(subSubItem.courseId),
                                                //                           title: Text(subItem.termName),
                                                //                           subtitle: Text(subSubItem.packageDisplayName),
                                                //                         );
                                                //                       },
                                                //                     )
                                                //                   : CircularProgressIndicator(),
                                                //             ],
                                                //           );
                                                //         },
                                                //       )
                                                //     : CircularProgressIndicator()
                                              ],
                                            );
                                          },
                                        ))
                                      : Expanded(
                                          child: filteredPackage.isNotEmpty
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  // itemCount: 5,
                                                  itemCount:
                                                      filteredPackage.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                        color: getxController.backgroundColor.value,
                                                      ),
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: ExpansionTile(
                                                        shape: Border.all(
                                                            color: Colors
                                                                .transparent),
                                                        // leading: Text(
                                                        //     filteredPackage[index]
                                                        //         .packageId),
                                                        title: Text(
                                                          filteredPackage[index]
                                                              .packageName,
                                                          style: TextStyle(
                                                              color:
                                                                  getxController
                                                                      .textColor
                                                                      .value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        onExpansionChanged:
                                                            (value) {
                                                          if (value &&
                                                              !allnestedData.containsKey(
                                                                  filteredPackage[
                                                                          index]
                                                                      .packageId)) {
                                                            fnfindpackage(
                                                                widget.token,
                                                                filteredPackage[
                                                                        index]
                                                                    .packageId);
                                                          }
                                                        },
                                                        children: [
                                                          allnestedData.containsKey(
                                                                  filteredPackage[
                                                                          index]
                                                                      .packageId)
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemCount: 1,
                                                                  itemBuilder:
                                                                      (context,
                                                                          subIndex) {
                                                                    var subItem =
                                                                        allnestedData[filteredPackage[index].packageId]![
                                                                            subIndex];
                                                                    return Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border(
                                                                          top: BorderSide(
                                                                              color: getxController.textColor.value,
                                                                              width: 1),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          ExpansionTile(
                                                                        iconColor: getxController
                                                                            .textColor
                                                                            .value,
                                                                        shape: Border.all(
                                                                            color:
                                                                                Colors.transparent),
                                                                        // leading: Text(
                                                                        //     subItem
                                                                        //         .courseId),
                                                                        title:
                                                                            Text(
                                                                          subItem
                                                                              .courseName,
                                                                          style:
                                                                              TextStyle(color: getxController.textColor.value),
                                                                        ),
                                                                        subtitle:
                                                                            Text(
                                                                          subItem
                                                                              .termName,
                                                                          style:
                                                                              TextStyle(color: getxController.textColor.value),
                                                                        ),

                                                                        onExpansionChanged:
                                                                            (value) {
                                                                          if (value &&
                                                                              !allnestedData.containsKey(subItem.packageId)) {
                                                                            fnfindpackage(widget.token,
                                                                                subItem.packageId);
                                                                          }
                                                                        },
                                                                        children: [
                                                                          allnestedData.containsKey(subItem.packageId)
                                                                              ? ListView.builder(
                                                                                  shrinkWrap: true,
                                                                                  itemCount: 1,
                                                                                  itemBuilder: (context, subSubIndex) {
                                                                                    var subSubItem = allnestedData[subItem.packageId]![subSubIndex];
                                                                                    return Container(
                                                                                      decoration: BoxDecoration(border: Border(top: BorderSide(color: getxController.textColor.value))),
                                                                                      child: ListTile(
                                                                                        onTap: () {},
                                                                                        title: Text(subItem.termName,style: TextStyle(color: getxController.textColor.value),),
                                                                                        trailing: ElevatedButton(
                                                                                          child: Text(
                                                                                            "Show",
                                                                                            style: TextStyle(fontSize: ClsFontsize.DoubleExtraSmall,color: getxController.listviewtext.value),
                                                                                          ),
                                                                                          style: ElevatedButton.styleFrom(
                                                                                            backgroundColor: getxController.textColor.value,
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.all(
                                                                                                Radius.circular(10),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            Get.to(() => ShowCaseWidget(builder: (BuildContext context) => VideoDashboard(widget.token)));
                                                                                          },
                                                                                        ),
                                                                                        subtitle: Text(subSubItem.packageDisplayName,style: TextStyle(color: getxController.textColor.value),),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                )
                                                                              : CircularProgressIndicator(),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              : Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Center(
                                                  child: Image.asset(
                                                      'assets/android/nodatafound.png'))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          color: Colors.black,
                          child: Column(
                            children: [
                              Flexible(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Stack(children: [
                                        Image.asset(
                                          fit: BoxFit.fitHeight,
                                          'assets/wallpaperflare.com_wallpaper.jpg',
                                          height:
                                              MediaQuery.sizeOf(context).height,
                                        ),
                                        Positioned(
                                          bottom: 500,
                                          left: 300,
                                          child: TypeWriter.text(
                                            'lorem ipsum dolot sit amet ...',
                                            style: FontFamily.font2,
                                            repeat: true,
                                            duration: const Duration(
                                                milliseconds: 50),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )))
                ],
              ),
              GlobalDialog()
            ],
          ),
        ),
      ),
    );
  }

  void showFullImageDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(color: ColorPage.white),
                    elevation: 0,
                  ),
                ),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 80),
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/sorojda.png",
                      fit: BoxFit.cover,
                    ),
                    // child: Image.network(
                    //   MyUrl.fullurl + MyUrl.imageurl + user.Image,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
