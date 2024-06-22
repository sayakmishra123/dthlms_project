// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';
import 'dart:ui';

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/android/videoPage/studyVideos.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/url/api_url.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

//abhoymallik
class PackageDashboardMobile extends StatefulWidget {
  final String token;
  const PackageDashboardMobile(this.token, {super.key});

  @override
  State<PackageDashboardMobile> createState() => _PackageDashboardMobileState();
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

class _PackageDashboardMobileState extends State<PackageDashboardMobile> {
  late double screenwidth = MediaQuery.of(context).size.width;
  Getx getxController = Get.put(Getx());

  List<AllPackage> package = [];
  List<AllPackage> filteredPackage = [];
  Map<String, List<PackageFind>> nestedData = {};

  TextEditingController searchController = TextEditingController();

  Future<void> fnfindallpackage(String token) async {
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
      filteredPackage = List.from(package);
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
      // ignore: avoid_print
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
    fnfindallpackage(widget.token);
    super.initState();
    searchController.addListener(_filterPackages);
  }

  void _filterPackages() {
    setState(() {
      filteredPackage = package
          .where((p) =>
              p.packageName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              p.packageDisplayName
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPage.appbarcolor,
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
          ],
        ),
        backgroundColor: ColorPage.bgcolor,
        body: Container(
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                   Container(
                                        
                                        decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(25)), boxShadow: [
                                          BoxShadow(color: ColorPage.appbarcolor.withOpacity(0.3),blurRadius: 12,spreadRadius: 5)
                                        ]),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        height: 55,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          // onChanged: (value) {
                                          //   setFilterData();
                                          // },
                                          controller: searchController,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                color: ColorPage.appbarcolor,
                                                fontSize:
                                                    ClsFontsize.ExtraSmall - 1),
                                            hintText: 'Search',
                                            fillColor: Color.fromARGB(255, 255, 255, 255),
                                            filled: true,
                                            suffixIcon: const Icon(
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
                  SizedBox(height: 10),
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
                            'All Package',
                            style: FontFamily.font,
                          )),
                      ButtonBarEntry(
                          onTap: () {
                            getxController.packageshow.value = false;
                          },
                          child: Text(
                            'My Package',
                            style: FontFamily.font,
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  getxController.packageshow.value
                      ? filteredPackage.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredPackage.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: ColorPage.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: ExpansionTile(
                                    shape:
                                        Border.all(color: Colors.transparent),
                                    title: Text(
                                      filteredPackage[index].packageName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onExpansionChanged: (value) {
                                      if (value &&
                                          !nestedData.containsKey(
                                              filteredPackage[index]
                                                  .packageId)) {
                                        fnfindpackage(widget.token,
                                            filteredPackage[index].packageId);
                                      }
                                    },
                                    children: [
                                      nestedData.containsKey(
                                              filteredPackage[index].packageId)
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: 1,
                                              itemBuilder: (context, subIndex) {
                                                var subItem = nestedData[
                                                    filteredPackage[index]
                                                        .packageId]![subIndex];
                                                return ExpansionTile(
                                                  shape: Border.all(
                                                      color:
                                                          Colors.transparent),
                                                  title:
                                                      Text(subItem.courseName),
                                                  subtitle:
                                                      Text(subItem.termName),
                                                  onExpansionChanged: (value) {
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

                                                            //  nestedData[
                                                            //         subItem
                                                            //             .packageId]!
                                                            //     .length,
                                                            itemBuilder: (context,
                                                                subSubIndex) {
                                                              var subSubItem =
                                                                  nestedData[subItem
                                                                          .packageId]![
                                                                      subSubIndex];
                                                              return InkWell(
                                                                onTap: (){
                                                                  Get.to(()=>Studyvidos());
                                                                },
                                                                child: ListTile(
                                                                  title: Text(subItem
                                                                      .termName),
                                                                  subtitle: Text(
                                                                      subSubItem
                                                                          .packageDisplayName),
                                                                ),
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
                                  ),
                                );
                              },
                            )
                          : Center(
                              child:
                                  Image.asset('assets/android/nodatafound.png'))
                      : CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void showFullImageDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
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
                  margin: EdgeInsets.symmetric(vertical: 150),
                  width: MediaQuery.of(context).size.width-20,
                  height: MediaQuery.of(context).size.width-40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Center(
                    child: ClipOval(
                      child:Image.asset("assets/sorojda.png", fit: BoxFit.cover,),
                      // child: Image.network(
                      //   MyUrl.fullurl + MyUrl.imageurl + user.Image,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
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
