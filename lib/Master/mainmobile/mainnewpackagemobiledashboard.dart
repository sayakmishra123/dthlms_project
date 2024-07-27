// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';
import 'dart:ui';

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/android/Videodashboard/mobileVideoDashboard.dart';
import 'package:dthlms/android/videoPage/studyVideos.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/package/packagevideo.dart/videodashboard.dart';
import 'package:dthlms/url/api_url.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:popup_menu_plus/popup_menu_plus.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

//abhoymallik
class MainNewPackageDashboardMobile extends StatefulWidget {
  const MainNewPackageDashboardMobile({super.key});

  @override
  State<MainNewPackageDashboardMobile> createState() =>
      MainNewPackageDashboardMobileState();
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

class MainNewPackageDashboardMobileState
    extends State<MainNewPackageDashboardMobile> {
  late double screenwidth = MediaQuery.of(context).size.width;
  Getx getxController = Get.put(Getx());
  final token = Get.arguments['token'];

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
      setState(() {
        getxController.loading.value = false;
      });
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
    fnfindallpackage(token);
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

  RxBool isSearchExpanded = false.obs;
  // final TextEditingController searchController = TextEditingController();
final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          key: _key,
          appBar: AppBar(
            backgroundColor: ColorPage.appbarcolor,
            iconTheme: IconThemeData(color: ColorPage.white),
            automaticallyImplyLeading: false,
            title: AnimatedContainer(
              alignment: FractionalOffset.centerLeft,
              duration: Duration(milliseconds: 150),
              width: MediaQuery.of(context).size.width,
              child: isSearchExpanded.value
                  ? 
                  TextField(
                    autofocus: true,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: ColorPage.white),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: ColorPage.white),
                cursorColor: ColorPage.white,
              )
                  : IconButton(
                      icon: Icon(Icons.search_outlined),
                      onPressed: () {
                        
                          isSearchExpanded.value = true;
                      
                      },
                    ),
            ),
            actions: isSearchExpanded.value
                ? [IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                    
                            isSearchExpanded.value = false;
                        
                          searchController.clear();
                        },
                      )]
                : [
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
                      padding: const EdgeInsets.only(right: 15.0),
                      child: InkWell(
                        onTap: () {
                          showFullImageDialogtest();
                        },
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(230, 255, 255, 255),
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
          
          floatingActionButton: FloatingActionButton(onPressed: (){
         _showMyDialog();
          },
          child: Icon(Icons.date_range_outlined),
          ),
          backgroundColor: ColorPage.bgcolor,
          body: Skeletonizer(
            enabled: getxController.loading.value,
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(height: 20),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.all(Radius.circular(25)),
                    //       boxShadow: [
                    //         BoxShadow(
                    //             color: ColorPage.appbarcolor.withOpacity(0.3),
                    //             blurRadius: 12,
                    //             spreadRadius: 5)
                    //       ]),
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //   height: 55,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: TextFormField(
                    //     // onChanged: (value) {
                    //     //   setFilterData();
                    //     // },
                    //     controller: searchController,
                    //     decoration: InputDecoration(
                    //       hintStyle: TextStyle(
                    //           color: ColorPage.appbarcolor,
                    //           fontSize: ClsFontsize.ExtraSmall - 1),
                    //       hintText: 'Search',
                    //       fillColor: Color.fromARGB(255, 255, 255, 255),
                    //       filled: true,
                    //       suffixIcon: Icon(
                    //         Icons.search,
                    //         color: ColorPage.appbarcolor,
                    //       ),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //           borderSide: BorderSide.none),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 10),
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
                              style: FontFamily.mobilefont,
                            )),
                        // ButtonBarEntry(
                        //     onTap: () {
                        //       getxController.packageshow.value = false;
                        //     },
                        //     child: Text(
                        //       'My Package',
                        //       style: FontFamily.mobilefont,
                        //     )),
                      ],
                    ),
                    SizedBox(height: 20),
                    getxController.packageshow.value
                        ? filteredPackage.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredPackage.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 4,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                        255, 225, 214, 214)
                                                    .withOpacity(0.2),
                                                offset: Offset(-10, -10),
                                                blurRadius: 10,
                                                spreadRadius: -5),
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                        255, 225, 214, 214)
                                                    .withOpacity(0.2),
                                                offset: Offset(-10, -10),
                                                blurRadius: 10,
                                                spreadRadius: -5),
                                            BoxShadow(
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                offset: Offset(-10, -10),
                                                blurRadius: 10,
                                                spreadRadius: 5),
                                          ],
                                          color: ColorPage.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.folder,
                                          color: Colors.deepOrange,
                                        ),
                                        shape: Border.all(
                                            color: Colors.transparent),
                                        title: Text(
                                          filteredPackage[index].packageName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () {
                                          Get.toNamed("/Mobilevideodashboard",
                                              arguments: {
                                                'token': token,
                                              });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Image.asset(
                                    'assets/android/nodatafound.png'))
                        : CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _showMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Calenderwidget();
      },
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
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Center(
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showFullImageDialogtest() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Center(
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
              ),
            ),
          ),
        );
      },
    );
  }
  Widget Calenderwidget(){
  return   Expanded(
                      child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorPage.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 192, 191, 191),
                            offset: Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: SfCalendar(
                      viewHeaderHeight: 50,
                      viewHeaderStyle: ViewHeaderStyle(dayTextStyle:FontFamily.font6 ),

                      // allowDragAndDrop: false,
                      // allowViewNavigation: true,
                      // backgroundColor: ColorPage.colorgrey,
                      headerStyle: CalendarHeaderStyle(
                          backgroundColor: ColorPage.blue,
                          textAlign: TextAlign.center,
                          textStyle: FontFamily.font3),
                      // showTodayButton: true,
                      view: CalendarView.month,
                      monthViewSettings: MonthViewSettings(
                        agendaStyle: AgendaStyle(
                            dateTextStyle: FontFamily.font3,
                            placeholderTextStyle: TextStyle(color: Colors.red)),
                        showAgenda: true,
                      ),
                    ),
                  ));
}
}


























