import 'dart:ui';

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/android/packagemobile/dynamicfolder.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/package/packagedashboard/dynamicpage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert';

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:dthlms/ThemeData/FontSize/FontSize.dart';

import 'package:dthlms/url/api_url.dart';
import 'package:dthlms/utils/enebelActivationcode.dart';

import 'package:http/http.dart' as http;

import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:typewritertext/v3/typewriter.dart';

class NewPackageDashboardMobile extends StatefulWidget {
  const NewPackageDashboardMobile({super.key});

  @override
  State<NewPackageDashboardMobile> createState() => _NewPackageDashboardMobileState();
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

class _NewPackageDashboardMobileState extends State<NewPackageDashboardMobile> {
  List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.pink,
    Colors.lightBlue,
    Colors.orange,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
  ];
  List content = [3, 7, 5, 6, 4, 3, 7, 2];
  int itemlength = 0;
  Getx getxController = Get.put(Getx());
  List datacontent = ['abc', 'def', 'ghi', 'jkl', 'lmo'];
  final token = Get.arguments['token'];
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
        itemlength = filteredPackage.length;
      });
      print(getxController.loading.value);
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
    setState(() {
      itemlength = filteredPackage.length;
    });
  }

  @override
  void initState() {
    fnfindallpackage(token);

    // TODO: implement initState
    super.initState();
  }

  List x = ['avinash', 2, 3];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorPage.bgcolor,
        appBar: AppBar(
          backgroundColor: ColorPage.appbarcolor,
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: ColorPage.appbarColorgradient,
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //     ),
          //   ),
          // ),
          // elevation: 1,
          scrolledUnderElevation: 20,

          iconTheme: IconThemeData(color: ColorPage.white),
          automaticallyImplyLeading: false,
          //  leading: Row(children: [Padding(
          //    padding: const EdgeInsets.only(left: 30.0),
          //    child: Icon(Icons.person,color: ColorPage.white,),
          //  )],),
          actions: [
            IconButton(
                onPressed: () {
                  print('object');
                  debugDumpApp();
                },
                icon: Icon(Icons.add)),
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
        // backgroundColor:,
        body: Skeletonizer(
          enabled: getxController.loading.value,
          child: Stack(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //     gradient: LinearGradient( begin: , colors: [
                    //   ColorPage.bgcolor,
                    //   ColorPage.bluegrey300
                    // ])),
                    // color: Colors.,
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
                                    backgroundColor: ColorPage.bluegrey800,
                                    foregroundColor: ColorPage.bluegrey300,
                                    // foregroundColor:  Color.fromARGB(255, 37, 233, 135),
                                    // backgroundColor:Color.fromARGB(255, 97, 228, 162),
                                    elevation: 24,
                                    curve: Curves.bounceIn,
                                    borderColor: ColorPage.white,
                                    innerVerticalPadding: 16,
                                    children: [
                                      ButtonBarEntry(
                                          onTap: () {
                                            getxController.packageshow.value =
                                                true;
                                          },
                                          child: Text(
                                            'My Package',
                                            style: FontFamily.font,
                                          )),
                                      ButtonBarEntry(
                                          onTap: () {
                                            getxController.packageshow.value =
                                                false;
                                            fnfindallpackage(token);
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
                                          itemCount: mypackage.length == 0
                                              ? 10
                                              : itemlength,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              elevation: 4,
                                              // surfaceTintColor: const Color.fromARGB(255, 234, 232, 232),
                                              // shadowColor: Color.fromARGB(255, 235, 230, 230),

                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                        offset:
                                                            Offset(-10, -10),
                                                        blurRadius: 10,
                                                        spreadRadius: -5),
                                                    BoxShadow(
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                        offset:
                                                            Offset(-10, -10),
                                                        blurRadius: 10,
                                                        spreadRadius: -5),
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        offset:
                                                            Offset(-10, -10),
                                                        blurRadius: 10,
                                                        spreadRadius: 5),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  color: ColorPage.white,
                                                ),
                                                child: ListTile(
                                                  // shape:
                                                  //     Border.all(color: Colors.transparent),
                                                  // trailing: ,
                                                  leading: Text(
                                                      mypackage.isEmpty
                                                          ? '${index + 1}'
                                                              .toString()
                                                          : mypackage[index]
                                                              .userID),
                                                  title: Text(
                                                    mypackage.isEmpty
                                                        ? 'Content No. ${index + 1}'
                                                        : mypackage[index]
                                                            .packageID,
                                                    style: TextStyle(
                                                        color: ColorPage.color1,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ))
                                      : Expanded(
                                          child: filteredPackage.isNotEmpty
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  // itemCount: 5,
                                                  itemCount: itemlength,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      elevation: 4,
                                                      // surfaceTintColor: const Color.fromARGB(255, 234, 232, 232),
                                                      // shadowColor: Color.fromARGB(255, 235, 230, 230),

                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.2),
                                                                offset: Offset(
                                                                    -10, -10),
                                                                blurRadius: 10,
                                                                spreadRadius:
                                                                    -5),
                                                            BoxShadow(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.2),
                                                                offset: Offset(
                                                                    -10, -10),
                                                                blurRadius: 10,
                                                                spreadRadius:
                                                                    -5),
                                                            BoxShadow(
                                                                color: Colors
                                                                    .white,
                                                                offset: Offset(
                                                                    -10, -10),
                                                                blurRadius: 10,
                                                                spreadRadius:
                                                                    5),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          color:
                                                              ColorPage.white,
                                                        ),
                                                        child: ListTile(
                                                          subtitle: Text(
                                                              'No. of folder content ${content[index]}'),
                                                          onTap: () {
                                                            Get.to(() => DynamicFolderMobile(
                                                                content:
                                                                    content[
                                                                        index],
                                                                token: token,
                                                                datacontent:
                                                                    datacontent,
                                                                count: 3));
                                                            // Get.toNamed(
                                                            //     'Videodashboard',
                                                            //     arguments: {
                                                            //       'token': token
                                                            //     });
                                                          },
                                                          trailing: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                          ),
                                                          leading: Icon(
                                                            Icons.folder,
                                                            color:
                                                                colors[index],
                                                          ),
                                                          shape: Border.all(
                                                              color: Colors
                                                                  .transparent),
                                                          // leading: Text(
                                                          //     filteredPackage[index]
                                                          //         .packageId),
                                                          title: Text(
                                                            filteredPackage[
                                                                    index]
                                                                .packageName,
                                                            style: TextStyle(
                                                                color: ColorPage
                                                                    .colorblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Center(
                                                  child: Image.asset(
                                                      'assets/android/nodatafound.png'),
                                                ),
                                        ),
                                
                                
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //     child: SfCalendar(
                  //   // allowDragAndDrop: false,
                  //   // allowViewNavigation: true,
                  //   // backgroundColor: ColorPage.colorgrey,
                  //   headerStyle:
                  //       CalendarHeaderStyle(backgroundColor: Colors.blue),
                  //   // showTodayButton: true,
                  //   view: CalendarView.month,
                  //   monthViewSettings: MonthViewSettings(
                  //     agendaStyle: AgendaStyle(
                  //         dateTextStyle: FontFamily.font3,
                  //         placeholderTextStyle: TextStyle(color: Colors.red)),
                  //     showAgenda: true,
                  //   ),
                  // ))
                ],
              ),
              GlobalDialog(token)
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
