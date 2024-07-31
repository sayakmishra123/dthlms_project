import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/package/packagedashboard/dynamicpage.dart';
import 'package:dthlms/widget/calenderWidget.dart';

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

class Homepagedashboard extends StatefulWidget {
  const Homepagedashboard({super.key});

  @override
  State<Homepagedashboard> createState() => _HomepagedashboardState();
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

class _HomepagedashboardState extends State<Homepagedashboard> {
  List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.pink,
    Colors.lightBlue,
    Colors.orange,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.green,
  ];
  List content = [3, 7, 5, 6, 4, 3, 7, 2, 6];
  int itemlength = 0;
  Getx getxController = Get.put(Getx());
  List datacontent = ['abc', 'def', 'ghi', 'jkl', 'lmo'];
  final token = Get.arguments['token'];
  TextEditingController searchController = TextEditingController();

  List<AllPackage> allpackage = [];
  Map<String, List<PackageFind>> allnestedData = {};

  List<MyPackageDetails> mypackage = [];
  List<AllPackage> filteredPackage = [];

  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  final List<Map<String, String>> notificationlist = [
    {
      "id": "1",
      "title":
          'Shubha-1ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc'
    },
    {"id": "2", "title": 'Shubha-2dddddddddddddddddddddddddddddddddddddddddd'},
    {"id": "3", "title": 'Shubha-dddddddddddddddddddddddddddddddddddddddd'},
    {"id": "4", "title": 'Shubha-4dddddddddddddddddddddddddddddddddddddddddd'},
    {"id": "5", "title": 'Shubha-5dddddddddddddddddddddddddddddddddddddddddd'},
  ];

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
      print(allpackage.length.toString() + "abhoy");
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

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ColorPage.bgcolor,

        appBar: AppBar(
          surfaceTintColor: ColorPage.appbarcolor,
          shadowColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 3,
          backgroundColor: ColorPage.appbarcolor,

          // flexibleSpace: Container(decoration: BoxDecoration(boxShadow: [
          //   BoxShadow(offset: Offset(1, 1),spreadRadius: 0,blurRadius: 0,color: ColorPage.blue)
          // ]),),

          // backgroundColor: ,
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
          // scrolledUnderElevation: 20,

          iconTheme: IconThemeData(color: ColorPage.white),
          automaticallyImplyLeading: false,
          //  leading: Row(children: [Padding(
          //    padding: const EdgeInsets.only(left: 30.0),
          //    child: Icon(Icons.person,color: ColorPage.white,),
          //  )],),

          title: Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 20),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 2.2,
              child: TextFormField(
                onChanged: (value) {
                  setFilterData();
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: ColorPage.brownshade300,
                      fontSize: ClsFontsize.ExtraSmall - 3),
                  hintText: 'Search',
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.search),
                    ),
                    onPressed: () {
                      setFilterData();
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                ),
                style: TextStyle(color: ColorPage.colorblack),
              ),
            ),
          ),
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
                    style: FontFamily.font4.copyWith(
                        fontWeight: FontWeight.bold, color: ColorPage.white),
                  ),
                  Text(
                    "Sayakmishra@gmail.com",
                    style: FontFamily.font4
                        .copyWith(fontSize: 12, color: ColorPage.white),
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
                                    height: 10,
                                  ),
                                  Container(
                                    height: 55,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 7,
                                              color: Color.fromARGB(
                                                  255, 200, 196, 196))
                                        ],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: ColorPage.white),
                                  )

                                  //  Container(
                                  //   height: 50,

                                  //    child: Stack(children: [
                                  //      InkWell(
                                  //        child: CarouselSlider(

                                  //          items: notificationlist
                                  //              .map(
                                  //                (item) => Container(

                                  //                  margin: const EdgeInsets.symmetric(
                                  //                      horizontal: 5),
                                  //                  decoration: BoxDecoration(
                                  //                      borderRadius:
                                  //                          BorderRadius.circular(20),
                                  //                    color: const Color.fromARGB(255, 211, 49, 49),
                                  //                      border: Border.all(
                                  //                          color: ColorPage.appbarcolor,
                                  //                          width: 2)),
                                  //                          child: Row(
                                  //                            children: [
                                  //                              Text(item['title'].toString()),
                                  //                            ],
                                  //                          ),
                                  //                ),
                                  //              )
                                  //              .toList(),
                                  //          carouselController: carouselController,
                                  //          options: CarouselOptions(
                                  //            scrollPhysics: const BouncingScrollPhysics(),
                                  //            autoPlay: true,
                                  //            aspectRatio: 2,
                                  //            viewportFraction: 1,
                                  //            onPageChanged: (index, reason) {
                                  //              setState(() {
                                  //                currentIndex = index;
                                  //              });
                                  //            },
                                  //          ),
                                  //        ),
                                  //      ),
                                  //      Positioned(
                                  //        bottom: 5,
                                  //        left: 0,
                                  //        right: 0,
                                  //        child: Row(
                                  //          mainAxisAlignment: MainAxisAlignment.center,
                                  //          children: notificationlist.asMap().entries.map((entry) {
                                  //            return GestureDetector(
                                  //              onTap: () => carouselController
                                  //                  .animateToPage(entry.key),
                                  //              child: Container(
                                  //                width: currentIndex == entry.key ? 20 : 10,
                                  //                height: 10,
                                  //                margin: const EdgeInsets.symmetric(
                                  //                    horizontal: 3.0),
                                  //                decoration: BoxDecoration(
                                  //                    borderRadius: BorderRadius.circular(10),
                                  //                    color: currentIndex == entry.key
                                  //                        ? ColorPage.appbarcolor
                                  //                        : ColorPage.white),
                                  //              ),
                                  //            );
                                  //          }).toList(),
                                  //        ),
                                  //      ),
                                  //    ]),
                                  //  ),
                                  ,
                                  // AnimatedButtonBar(
                                  //   controller: AnimatedButtonController()
                                  //     ..setIndex(0),
                                  //   radius: 8.0,
                                  //   padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                  //   backgroundColor: ColorPage.bluegrey800,
                                  //   foregroundColor: ColorPage.blue,
                                  //   // foregroundColor:  Color.fromARGB(255, 37, 233, 135),
                                  //   // backgroundColor:Color.fromARGB(255, 97, 228, 162),
                                  //   elevation: 5,
                                  //   curve: Curves.bounceIn,
                                  //   borderColor: ColorPage.white,
                                  //   innerVerticalPadding: 10,
                                  //   children: [
                                  //     ButtonBarEntry(
                                  //         onTap: () {
                                  //           getxController.packageshow.value =
                                  //               false;
                                  //           fnfindallpackage(token);
                                  //         },
                                  //         child: Text(
                                  //           'My Package',
                                  //           style: FontFamily.font2,
                                  //         )),
                                  //   ],
                                  // ),
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
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                        ),
                                                        child: ListTile(
                                                          subtitle: Text(
                                                              'No. of folder content ${content[index]}'),
                                                          onTap: () {
                                                            Get.to(() => DynamicFolder(
                                                                content:
                                                                    content[
                                                                        index],
                                                                token: token,
                                                                datacontent:
                                                                    datacontent,
                                                                count: 0));
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
                                                      'assets/android/nodatafound.png'))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ClaenderWidget(),
                ],
              ),
              GlobalDialog(token)
            ],
          ),
        ),
      ),
    );
  }

// Widget Calenderwidget(){
//   return   Expanded(
//                       child: Container(
//                     margin: EdgeInsets.all(20),
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: ColorPage.white,
//                       boxShadow: [
//                         BoxShadow(
//                             blurRadius: 3,
//                             color: Color.fromARGB(255, 192, 191, 191),
//                             offset: Offset(0, 0))
//                       ],
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                     ),
//                     child: SfCalendar(
//                       cellBorderColor:ColorPage.colorblack ,

//                       viewHeaderHeight: 50,
//                       viewHeaderStyle: ViewHeaderStyle(dayTextStyle:FontFamily.font6 ),

//                       // allowDragAndDrop: false,
//                       // allowViewNavigation: true,
//                       backgroundColor: Color.fromARGB(255, 230, 235, 249),
//                       headerStyle: CalendarHeaderStyle(
//                           backgroundColor: ColorPage.blue,
//                           textAlign: TextAlign.center,
//                           textStyle: FontFamily.font3),
//                       // showTodayButton: true,
//                       view: CalendarView.month,
//                       monthViewSettings: MonthViewSettings(
//                         // agendaItemHeight: 20,
//                         agendaViewHeight: 80,
//                         agendaStyle: AgendaStyle(
//                             dateTextStyle: FontFamily.font3,
//                             placeholderTextStyle: TextStyle(color: Colors.red)),
//                         showAgenda: true,
//                       ),
//                     ),
//                   ));
// }
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
