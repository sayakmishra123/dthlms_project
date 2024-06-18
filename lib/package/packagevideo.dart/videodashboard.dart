// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/package/packagevideo.dart/videorelatetedPage.dart';
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

class VideoDashboard extends StatefulWidget {
  String token;
  VideoDashboard(this.token, {super.key});

  @override
  State<VideoDashboard> createState() => _VideoDashboardState(token);
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

class _VideoDashboardState extends State<VideoDashboard>
    with TickerProviderStateMixin {
  String token;
  _VideoDashboardState(this.token);

  GlobalKey showcase_one = GlobalKey();
  GlobalKey showcase_searchkey = GlobalKey();

  List<ClassAllVideos> x1 = [];
  var data1;

  var data2;

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
      // data = data1[0]['VideoName'];
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
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context)
            .startShowCase([showcase_one, showcase_searchkey]));
    super.initState();
  }

  MotionTabBarController? _motionTabBarController;
  List<String> tabfield = const [
    "VIDEO",
    "LIVE",
    "BACKUP",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: ColorPage.bgcolor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorPage.white),
            backgroundColor: ColorPage.appbarcolor,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: MotionTabBar(
                controller:
                    _motionTabBarController, // ADD THIS if you need to change your tab programmatically
                initialSelectedTab: "VIDEO",
                labels: tabfield,
                icons: const [
                  Icons.picture_as_pdf,
                  Icons.question_answer,
                  Icons.tag,
                ],

                badges: [
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
                // tabBarColor: Color.fromARGB(255, 64, 41, 231),
                onTabItemSelected: (int value) {
                  setState(() {
                    // _motionTabBarController!.index = value;
                  });
                },
              ),
            ),
          ),

          // appBar: AppBar(
          //   backgroundColor: ColorPage.appbarcolor,
          //   title: Showcase(
          //     title: 'Please one option',
          //     key: showcase_one,
          //     blurValue: 5,
          //     titleTextStyle: FontFamily.font4,
          //     description: '',
          //     child: SizedBox(
          //         width: 200,
          //         child: DropdownButtonFormField(
          //             borderRadius: BorderRadius.circular(20),
          //             style: TextStyle(color: ColorPage.white),
          //             decoration: InputDecoration(
          //               border: OutlineInputBorder(
          //                 borderSide: BorderSide.none,
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //             ),
          //             dropdownColor: ColorPage.appbarcolor,
          //             value: selectedValue,
          //             onChanged: (String? newValue) async {
          //               setState(() {
          //                 selectedValue = newValue!;
          //               });
          //               await fngetvideoApi(selectedValue);
          //             },
          //             items: dropdownItems)),
          //   ),
          // ),

          body: TabBarView(
              physics:
                  NeverScrollableScrollPhysics(), // swipe navigation handling is not supported

              controller: _motionTabBarController,
              children: [
                Container(),
                Container(),
                Container(),
              ]),
          //  Row(
          //   children: [
          //     Expanded(
          //       child: Column(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 10, vertical: 10),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Expanded(
          //                   child: Showcase(
          //                     description: '',
          //                     title: 'Search your video,live,backup list',
          //                     blurValue: 5,
          //                     titleTextStyle: FontFamily.font4,
          //                     key: showcase_searchkey,
          //                     child: TextFormField(
          //                       decoration: InputDecoration(
          //                           hintStyle: TextStyle(
          //                               color: ColorPage.brownshade300,
          //                               fontSize: ClsFontsize.ExtraSmall - 1),
          //                           hintText: 'Search',
          //                           fillColor: ColorPage.white,
          //                           filled: true,
          //                           suffixIcon: const Icon(
          //                             Icons.search,
          //                             color: ColorPage.blue,
          //                           ),
          //                           border: OutlineInputBorder(
          //                               borderRadius:
          //                                   BorderRadius.circular(30),
          //                               borderSide: BorderSide.none)),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             child: SingleChildScrollView(
          //               child: Column(
          //                 mainAxisSize: MainAxisSize.max,
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   // TabBarView(
          //                   //     physics:
          //                   //         NeverScrollableScrollPhysics(), // swipe navigation handling is not supported

          //                   //     controller: _motionTabBarController,
          //                   //     children: []),

          //                   // x1.isNotEmpty
          //                   //     ? Container(
          //                   //         height: MediaQuery.sizeOf(context).height,
          //                   //         child: ListView.builder(
          //                   //             shrinkWrap: true,
          //                   //             itemCount: x1.length,
          //                   //             itemBuilder: (context, index) {
          //                   //               return Padding(
          //                   //                 padding:
          //                   //                     const EdgeInsets.symmetric(
          //                   //                         horizontal: 10),
          //                   //                 child: Card(
          //                   //                   elevation: 50,

          //                   //                   color: ColorPage.white,
          //                   //                   surfaceTintColor:
          //                   //                       ColorPage.white,
          //                   //                   // shape:
          //                   //                   //     ContinuousRectangleBorder(
          //                   //                   //         borderRadius:
          //                   //                   //             BorderRadius
          //                   //                   //                 .circular(15)),
          //                   //                   // elevation: 0,
          //                   //                   child: ListTile(
          //                   //                     onTap: () {
          //                   //                       print('sss');
          //                   //                       Get.to(() => VideoDetails(
          //                   //                           x1[index].videoname,
          //                   //                           token));
          //                   //                     },
          //                   //                     leading: CircleAvatar(
          //                   //                         foregroundColor:
          //                   //                             ColorPage.white,
          //                   //                         backgroundColor:
          //                   //                             ColorPage.blue,
          //                   //                         child:
          //                   //                             Icon(Icons.videocam)),
          //                   //                     title: Text(
          //                   //                       x1[index].videoname,
          //                   //                       overflow:
          //                   //                           TextOverflow.ellipsis,
          //                   //                       style: GoogleFonts.kadwa(
          //                   //                           textStyle:
          //                   //                               FontFamily.font),
          //                   //                     ),
          //                   //                     trailing: Text(
          //                   //                         x1[index].chapterName,
          //                   //                         style: GoogleFonts.kadwa(
          //                   //                             textStyle: TextStyle(
          //                   //                                 fontSize:
          //                   //                                     ClsFontsize
          //                   //                                             .Small -
          //                   //                                         5))),
          //                   //                     subtitle: Column(
          //                   //                       mainAxisSize:
          //                   //                           MainAxisSize.min,
          //                   //                       // mainAxisAlignment: MainAxisAlignment.start,
          //                   //                       crossAxisAlignment:
          //                   //                           CrossAxisAlignment
          //                   //                               .start,
          //                   //                       children: [
          //                   //                         Text(
          //                   //                             'Video Description: ' +
          //                   //                                 x1[index]
          //                   //                                     .videoDescription,
          //                   //                             style: GoogleFonts.kadwa(
          //                   //                                 textStyle: TextStyle(
          //                   //                                     color: ColorPage
          //                   //                                         .blue))),
          //                   //                         Text(
          //                   //                             'Video Duration: ' +
          //                   //                                 x1[index]
          //                   //                                     .videoDuration
          //                   //                                     .toString(),
          //                   //                             style: GoogleFonts.kadwa(
          //                   //                                 textStyle: TextStyle(
          //                   //                                     color: ColorPage
          //                   //                                         .bluegrey300))),
          //                   //                       ],
          //                   //                     ),
          //                   //                   ),
          //                   //                 ),
          //                   //               );
          //                   //             }),
          //                   //       )
          //                   //     : Center(
          //                   //         child: Image.asset(
          //                   //         'assets/android/nodatafound.png',
          //                   //         color: ColorPage.appbarcolor,
          //                   //       )),
          //                 ],
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         color: Colors.black,
          //         child: Image.asset(
          //           fit: BoxFit.fitHeight,
          //           'assets/wallpaperflare.com_wallpaper.jpg',
          //           height: MediaQuery.sizeOf(context).height,
          //         ),
          //       ),
          //     ),
          //   ],
          // )

          //  x1.isNotEmpty
          //     ? ListView.builder(
          //         itemCount: x1.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             onTap: () {
          //               Get.to(() => VideoDetails(x1[index].videoname, token));
          //             },
          //             title: Text(x1[index].videoname),
          //             trailing: Text('Chapter name: ' + x1[index].chapterName),
          // subtitle: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   // mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //         'Video Description: ' + x1[index].videoDescription),
          //     Text('Video Duration: ' +
          //         x1[index].videoDuration.toString()),
          //   ],
          // ),
          //           );
          //         })
          //     : Center(
          //         child: Text(
          //         'Empty',
          //         textScaler: TextScaler.linear(2),
          //       )),

          // body:
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Container(
          //         child: Expanded(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [Text(x1.toString())],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Container(
          //         child: Expanded(
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [Text(data2.toString())],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
        ));
  }
}
