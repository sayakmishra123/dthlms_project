import 'dart:convert';

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.dart';
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
              p.packageName.toLowerCase().contains(searchController.text.toLowerCase()) ||
              p.packageDisplayName.toLowerCase().contains(searchController.text.toLowerCase()))
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert_rounded, color: Colors.white, size: 30),
              ),
            )
          ],
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: ColorPage.appbarcolor,
          title: Text("Package Dashboard", style: FontFamily.font7),
        ),
        backgroundColor: ColorPage.bgcolor,
        body: Container(
          child: Expanded(
            child: Container(
              child: Column(
                children: [
                  Flexible(
                    child: Obx(
                      () => Column(
                        children: [
                          SizedBox(height: 20),
                          Container(
                            height: 60,
                            width: screenwidth - 30,
                            child: TextFormField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: ColorPage.brownshade300,
                                    fontSize: ClsFontsize.ExtraSmall - 1),
                                hintText: 'Search',
                                fillColor: ColorPage.white,
                                filled: true,
                                suffixIcon: const Icon(
                                  Icons.search,
                                  color: ColorPage.blue,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
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
                              ? Expanded(
                                  child: filteredPackage.isNotEmpty
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: filteredPackage.length,
                                          itemBuilder: (context, index) {
                                            return ExpansionTile(
                                              leading: Text(filteredPackage[index].packageId),
                                              title: Text(
                                                filteredPackage[index].packageName,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              onExpansionChanged: (value) {
                                                if (value &&
                                                    !nestedData.containsKey(
                                                        filteredPackage[index].packageId)) {
                                                  fnfindpackage(widget.token,
                                                      filteredPackage[index].packageId);
                                                }
                                              },
                                              children: [
                                                nestedData.containsKey(
                                                        filteredPackage[index].packageId)
                                                    ? ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: nestedData[
                                                                filteredPackage[index]
                                                                    .packageId]!
                                                            .length,
                                                        itemBuilder: (context, subIndex) {
                                                          var subItem = nestedData[
                                                                  filteredPackage[index]
                                                                      .packageId]![
                                                              subIndex];
                                                          return ExpansionTile(
                                                            leading: Text(subItem.courseId),
                                                            title: Text(subItem.courseName),
                                                            subtitle: Text(subItem.termName),
                                                            onExpansionChanged: (value) {
                                                              if (value &&
                                                                  !nestedData.containsKey(
                                                                      subItem.packageId)) {
                                                                fnfindpackage(widget.token,
                                                                    subItem.packageId);
                                                              }
                                                            },
                                                            children: [
                                                              nestedData.containsKey(
                                                                      subItem.packageId)
                                                                  ? ListView.builder(
                                                                      shrinkWrap: true,
                                                                      itemCount: nestedData[
                                                                              subItem
                                                                                  .packageId]!
                                                                          .length,
                                                                      itemBuilder: (context,
                                                                          subSubIndex) {
                                                                        var subSubItem =
                                                                            nestedData[
                                                                                    subItem
                                                                                        .packageId]![
                                                                                subSubIndex];
                                                                        return ListTile(
                                                                          leading: Text(subSubItem
                                                                              .courseId),
                                                                          title: Text(subItem
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
                                        )
                                      : Center(
                                          child: Image.asset('assets/android/nodatafound.png')
                                        ),
                                )
                              : CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
