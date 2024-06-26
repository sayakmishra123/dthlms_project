import 'dart:async'; // Add this import
import 'dart:convert';

import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/android/Videodashboard/mobileVideoPlayer.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/package/packagedashboard/packagedashboard.dart';
import 'package:dthlms/package/packagevideo.dart/videorelatetedPage.dart';
import 'package:dthlms/url/api_url.dart';
import 'package:dthlms/utils/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:typewritertext/v3/typewriter.dart';
import 'dart:async'; // Add this import

class MobileVideoDashboard extends StatefulWidget {
  String token;
  MobileVideoDashboard(this.token, {super.key});

  @override
  State<MobileVideoDashboard> createState() =>
      _MobileVideoDashboardState(token);
}

class ClassAllVideos {
  String videoname = "";
  String chapterName;
  int videoDuration;
  String videoDescription;
  ClassAllVideos({
    required this.videoname,
    required this.chapterName,
    required this.videoDuration,
    required this.videoDescription,
  });
}

class _MobileVideoDashboardState extends State<MobileVideoDashboard>
    with TickerProviderStateMixin {
  String token;
  _MobileVideoDashboardState(this.token);

  GlobalKey showcase_one = GlobalKey();
  GlobalKey showcase_searchkey = GlobalKey();
  TextEditingController searchController = TextEditingController();
  bool subvideos = false;

  List<AllPackage> allpackage = [];
  Map<String, List<PackageFind>> allnestedData = {};

  List<MyPackageDetails> mypackage = [];
  List<AllPackage> filteredPackage = [];

  Getx getxController = Get.put(Getx());

  List<ClassAllVideos> x1 = [];
  var data1;

  var data2;

  bool _isLoading = true;

  Future fngetvideoApi(String? selectedValue) async {
    x1.clear();
    loader(context);

    var res = await http.post(
        Uri.https(
          'dthclass.com',
          'api/AuthDataGet/ExecuteJson/sptblEncryptionHistory/3',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "tblEncryptionHistory": {
            "PackageId": 1,
            "VideoType": selectedValue.toString()
          }
        }));
    var jsondata = jsonDecode(res.body);
    print(jsondata);
    var data = jsonDecode(jsondata['result']);
    if (data != null) {
      for (int i = 0; i < data.length; i++) {
        final data1 = ClassAllVideos(
            videoname: data[i]['VideoName'] ?? ' ',
            chapterName: data[i]['ChapterName'] ?? ' ',
            videoDescription: data[i]['VideoDescription'] ?? ' ',
            videoDuration: data[i]['VideoDuration'] ?? ' ');

        x1.add(data1);
      }
      setState(() {});
    }

    Get.back();
  }

  @override
  void initState() {
    super.initState();
    fnfindallpackage(widget.token);
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 6,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context)
            .startShowCase([showcase_one, showcase_searchkey]));
    Timer(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  MotionTabBarController? _motionTabBarController;
  List<String> tabfield = const [
    "VIDEO",
    "LIVE",
    "STUDY MATERIAL",
    "TEST SERIES",
    "MCQ",
    "OPTION 6",
  ];

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Row(
            children: [
              Container(
                child: Expanded(
                  child: DefaultTabController(
                      length: 6,
                      child: Obx(
                        ()=> Scaffold(
                          backgroundColor: ColorPage.appbarcolor,
                          appBar: AppBar(
                            iconTheme: IconThemeData(color: ColorPage.white),
                            backgroundColor: ColorPage.appbarcolor,
                            // actions: [
                            //   Center(
                            //     child: Container(
                        
                            //       height: 50,
                            //       margin: EdgeInsets.only(top: 10,right: 20),
                        
                            //       width: MediaQuery.of(context).size.width/1.5,
                            //       child: Center(
                            //         child: TextFormField(
                            //           controller: searchController,
                        
                            //           decoration: InputDecoration(
                            //             hintStyle: TextStyle(
                            //                 color: ColorPage.brownshade300,
                            //                 fontSize:15),
                            //             hintText: 'Search',
                            //             fillColor: ColorPage.white,
                            //             filled: true,
                            //             suffixIcon: IconButton(
                            //               icon: Icon(Icons.search),
                            //               onPressed: () {
                            //                 setFilterData();
                            //               },
                            //             ),
                            //             border: OutlineInputBorder(
                            //                 borderRadius: BorderRadius.circular(30),
                            //                 borderSide: BorderSide.none),
                            //           ),
                            //           style: TextStyle(color: ColorPage.colorblack,fontSize: 15,),
                            //           onChanged: (value) {
                            //             setFilterData();
                            //           },
                            //         ),
                            //       ),
                            //     ),
                            //   )
                            // ],
                            actions: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.search,color: ColorPage.white,),
                              )
                            ],
                            
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(90),
                              child: MotionTabBar(
                                controller: _motionTabBarController,
                                initialSelectedTab: "VIDEO",
                                labels: tabfield,
                                icons: const [
                                  Icons.video_library_rounded,
                                  Icons.wifi_tethering,
                                  Icons.menu_book_sharp,
                                  Icons.abc,
                                  Icons.wifi_protected_setup_outlined,
                                  Icons.wifi_tethering,
                                ],
                                badges: [
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                  null,
                                ],
                                tabSize: 50,
                                tabBarHeight: 55,
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                                tabIconColor: Colors.blue[600],
                                tabIconSize: 28.0,
                                tabIconSelectedSize: 26.0,
                                tabSelectedColor: Colors.blue[900],
                                tabIconSelectedColor: Colors.white,
                                onTabItemSelected: (int value) {
                                  setState(() {
                                    _motionTabBarController!.index = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          body: TabBarView(
                            controller: _motionTabBarController,
                            children: [
                              Container(
                                child: filteredPackage.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: filteredPackage.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: ColorPage.white,
                                            ),
                                            margin: EdgeInsets.all(10),
                                            child: ExpansionTile(
                                              shape: Border.all(
                                                  color: Colors.transparent),
                                              title: Text(
                                                filteredPackage[index]
                                                    .packageName,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              onExpansionChanged: (value) {
                                                if (value &&
                                                    !allnestedData.containsKey(
                                                        filteredPackage[index]
                                                            .packageId)) {
                                                  fnfindpackage(
                                                      widget.token,
                                                      filteredPackage[index]
                                                          .packageId);
                                                }
                                              },
                                              children: [
                                                allnestedData.containsKey(
                                                        filteredPackage[index]
                                                            .packageId)
                                                    ? ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: 1,
                                                        itemBuilder:
                                                            (context, subIndex) {
                                                          var subItem = allnestedData[
                                                                  filteredPackage[
                                                                          index]
                                                                      .packageId]![
                                                              subIndex];
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                top: BorderSide(
                                                                    color: ColorPage
                                                                        .colorblack,
                                                                    width: 1),
                                                              ),
                                                            ),
                                                            child: ExpansionTile(
                                                              shape: Border.all(
                                                                  color: Colors
                                                                      .transparent),
                                                              title: Text(subItem
                                                                  .courseName),
                                                              subtitle: Text(
                                                                  subItem
                                                                      .termName),
                                                              onExpansionChanged:
                                                                  (value) {
                                                                if (value &&
                                                                    !allnestedData
                                                                        .containsKey(
                                                                            subItem
                                                                                .packageId)) {
                                                                  fnfindpackage(
                                                                      widget
                                                                          .token,
                                                                      subItem
                                                                          .packageId);
                                                                }
                                                              },
                                                              children: [
                                                                allnestedData.containsKey(
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
                                                                              allnestedData[subItem.packageId]![subSubIndex];
                                                                          return Container(
                                                                            decoration:
                                                                                BoxDecoration(border: Border(top: BorderSide(color: ColorPage.colorblack))),
                                                                            child:
                                                                                ListTile(
                                                                              onTap:
                                                                                  () {
                                                                                Get.to(() => MobileVideoPlayer(filteredPackage[index].courseName,
                                                                                widget.token));
                                                                              },
                                                                              title:
                                                                                  Text(subItem.termName+"Abhi"),
                                                                              subtitle:
                                                                                  Text(subSubItem.packageDisplayName),
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
                                            'assets/android/nodatafound.png'),
                                      ),
                              ),
                              Container(
                                color: Color.fromARGB(255, 249, 24, 204),
                              ),
                              Container(
                                color: ColorPage.blue,
                              ),
                              Container(),
                              Container(),
                              Container(),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
              // Expanded(
              //     child: Container(
              //         color: Colors.black,
              //         child: Column(
              //           children: [
              //             Flexible(
              //               child: Column(
              //                 children: [
              //                   Stack(children: [
              //                     Image.asset(
              //                       fit: BoxFit.fitHeight,
              //                       'assets/wallpaperflare.com_wallpaper.jpg',
              //                       height: MediaQuery.sizeOf(context).height,
              //                     ),
              //                   ]),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         )))
            ],
          );
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
      setState(() {});
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
}



