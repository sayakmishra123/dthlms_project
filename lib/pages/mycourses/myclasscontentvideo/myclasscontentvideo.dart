// ignore_for_file: unnecessary_import, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/package/packagevideo.dart/category/McqCategory.dart';
import 'package:dthlms/package/packagevideo.dart/category/pdfcategory.dart';
import 'package:dthlms/utils/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dthlms/getx/getxcontroller.dart';
import 'package:dthlms/key/key.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
// import 'package:dthlms/pdfview/pdfview.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter_platform_alert/flutter_platform_alert.dart';
// import 'package:get/get.dart';

// import 'package:google_fonts/google_fonts.dart';

import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:http/http.dart' as http;
import 'package:showcaseview/showcaseview.dart';
import '../../../ThemeData/color/color.dart';

class MyClassVideoContent extends StatefulWidget {
  String videoname;
  String token;
  MyClassVideoContent(this.videoname, this.token, {super.key});

  @override
  State<MyClassVideoContent> createState() => _MyClassVideoContentState();
}

class McqDetails {
  int videoDetailsId;
  int videoId;
  String names;
  String option1;
  String option2;
  String option3;
  String option4;
  String answer;
  String category;
  bool isActive;
  String createdBy;
  String modifiedBy;
  String modifiedOn;
  String createdOn;
  String modifiedIp;
  String createdIp;
  bool isDeleted;

  McqDetails({
    required this.videoDetailsId,
    required this.videoId,
    required this.names,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.answer,
    required this.category,
    required this.isActive,
    required this.createdBy,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.createdOn,
    required this.modifiedIp,
    required this.createdIp,
    required this.isDeleted,
  });
}

class _MyClassVideoContentState extends State<MyClassVideoContent>
    with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   // ShowCaseWidget.of(context).startShowCase([tabbarkey]);
    //   // fngetVideodetailsApi(widget.token, tabfield[0]);3
    //   fngetVideodetailsApi(widget.token, 'PDF');
    // });
    permission();
  }

  // List<Widget> category = [];
  @override
  void dispose() {
    super.dispose();
    // category = [PdfCategory(), McqCategory(), PdfCategory(), McqCategory()];

    // _tabController.dispose();
    _motionTabBarController!.dispose();
  }

  List<String> tabfield = const ["PDF", "MCQ", "TAG", "Review"];
  Getx getx = Get.put(Getx());
  List pdf = [];
  List<McqDetails> mcq = [];
  List tag = [];
  List review = [];
  String pdflink = '';
  Future fngetVideodetailsApi(String token, String category) async {
    print(category);
    loader(context);
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Center(child: CircularProgressIndicator());
    //     });
    if (category == 'PDF') {
      await fnfindcategory(token, category)
          .then((value) => pdffetchapi(token, 44));
      // print('${pdfdata} ffdkjfdfffdkjfdlkfdkldflkfdkldf');
      setState(() {
        // pdflink = pdfdata;
      });
    } else if (category == 'MCQ') {
      List mcqdata = await fnfindcategory(token, category);
      print(mcqdata);
      mcq.clear();
      for (int i = 0; i < mcqdata.length; i++) {
        final data = McqDetails(
            videoDetailsId: mcqdata[i]['VideoDetailsId'] ?? ' ',
            videoId: mcqdata[i]['VideoId'] ?? ' ',
            names: mcqdata[i]['Names'] ?? ' ',
            option1: mcqdata[i]['Option1'] ?? ' ',
            option2: mcqdata[i]['Option2'] ?? ' ',
            option3: mcqdata[i]['Option3'] ?? ' ',
            option4: mcqdata[i]['Option4'] ?? ' ',
            answer: mcqdata[i]['Answer'] ?? ' ',
            category: mcqdata[i]['Category'] ?? ' ',
            isActive: mcqdata[i]['IsActive'] ?? ' ',
            createdBy: mcqdata[i]['CreatedBy'] ?? ' ',
            modifiedBy: mcqdata[i]['ModifiedBy'] ?? ' ',
            modifiedOn: mcqdata[i]['ModifiedOn'] ?? ' ',
            createdOn: mcqdata[i]['CreatedOn'] ?? ' ',
            modifiedIp: mcqdata[i]['ModifiedIp'] ?? ' ',
            createdIp: mcqdata[i]['CreatedIp'] ?? ' ',
            isDeleted: mcqdata[i]['IsDeleted'] ?? ' ');
        mcq.add(data);
      }
    } else if (category == 'TAG') {
      tag = await fnfindcategory(token, category);
    } else {
      review = await fnfindcategory(token, category);
    }

    Get.back();
  }

  Future<List> pdffetchapi(token, int documentId) async {
    loader(context);
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Center(child: CircularProgressIndicator());
    //     });
    var res = await http.post(
        Uri.https(
          'dthclass.com',
          'api/AuthDataGet/ExecuteJson/spTblDocumentDetails/3',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "TblDocumentDetails": {'DocumentId': documentId}
        }));
    var jsondata = jsonDecode(res.body);
    print(jsondata);
    print(jsondata['result'] + 'wow');
    final data = jsondata['result'];
    pdflink = data.toString();
    print(data);
    setState(() {});
    Get.back();
    return ['abc', 'vhj'];
  }

  Future<List> fnfindcategory(String token, String category) async {
    var res = await http.post(
        Uri.https(
          'dthclass.com',
          'api/AuthDataGet/ExecuteJson/spTblVideoDetails/4',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "TblVideoDetails": {"VideoId": 11, "Category": category}
        }));

    var jsondata = jsonDecode(res.body);
    print(jsondata);

    final data = jsonDecode(jsondata['result']) ?? [];
    print(data.length);
    setState(() {});
    return data;
  }

  // GlobalKey tabbarkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPage.bgcolor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPage.white),
        title: Text(
          widget.videoname,
          style: FontFamily.font5,
        ),
        backgroundColor: ColorPage.appbarcolor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: MotionTabBar(
            controller:
                _motionTabBarController, // ADD THIS if you need to change your tab programmatically
            initialSelectedTab: "PDF",
            labels: tabfield,
            icons: const [
              Icons.picture_as_pdf,
              Icons.question_answer,
              Icons.tag,
              Icons.reviews
            ],

            badges: [
              MotionBadgeWidget(
                text: '604',
                textColor: Colors.white, // optional, default to Colors.white
                color: Colors.red, // optional, default to Colors.red
                size: 18, // optional, default to 18
              ),
              null,
              null,
              null
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
                _motionTabBarController!.index = value;

                fngetVideodetailsApi(widget.token, tabfield[value]);
              });
            },
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: 400,
              height: 500,
              child: Column(
                children: [
                  TabBarView(
                      // physics:
                      //     NeverScrollableScrollPhysics(), // swipe navigation handling is not supported

                      controller: _motionTabBarController,
                      children: [
                        pdflink.isNotEmpty
                            ? PdfCategory(pdflink)
                            : Center(child: CircularProgressIndicator()),
                        mcq.isNotEmpty ? McqCategory() : Container(),
                        PdfCategory(pdflink),
                        PdfCategory(pdflink)
                      ]),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 400,
              child: Column(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String filename = "encrypt_video.mp4";
  late Directory appDocDir;
  Future<Directory> get getExternalvisibledir async {
    if (Platform.isAndroid) {
      if (await Directory('/storage/emulated/0/Solution_infotech_video')
          .exists()) {
        final externalDir =
            Directory('/storage/emulated/0/Solution_infotech_video');
        return externalDir;
      } else {
        await Directory('/storage/emulated/0/Solution_infotech_video')
            .create(recursive: true);
        final externalDir =
            Directory('/storage/emulated/0/Solution_infotech_video');
        return externalDir;
      }
    } else {
      final Directory _appDocDir = await getApplicationDocumentsDirectory();
      //App Document Directory + folder name
      final Directory _appDocDirFolder =
          Directory('${_appDocDir.path}/Solution_infotech_video');

      if (await _appDocDirFolder.exists()) {
        //if folder already exists return path
        return _appDocDirFolder;
      } else {
        //if folder not exists create folder and then return its path
        final Directory _appDocDirNewFolder =
            await _appDocDirFolder.create(recursive: true);
        return _appDocDirNewFolder;
      }
    }
  }

  String url =
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  Future downloadcretevideo(url, Directory d, filename, bool check) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Material(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Video Downloading..')],
                )
              ],
            )),
          );
        });

    if (check == true) {
      print('Data downloading......');
      var res = await http.get(Uri.parse(url));
      List<int> encResult = await encryptPdf(res.bodyBytes);
      String p = await writedata(encResult, "${d.path}/$filename.aes");
      print('file encryption successfully $p');
    } else {
      final File file = File(url);
      final List<int> bytes = await file.readAsBytes();
      final List<int> encryptedBytes = await decryptPdf(bytes);
      // final File encryptedFile = File();
      String p = await writedata(encryptedBytes, "${d.path}/$filename.aes");
      print('File encrypted successfully: $p');
    }
    Navigator.pop(context);
    print('${d.path}/$filename.aes');
  }

  Uint8List decryptedvideoData = Uint8List(0);
  convertdecryptfile(Directory d, filename) async {
    loader(context);
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const Center(child: CircularProgressIndicator());
    //     });
    Uint8List encdata = await readData("${d.path}/$filename.aes");
    decryptedvideoData = await decryptPdf(encdata);
    // String p = await _writeData(plaindata, "${d.path}/$filename");

    print('file decrypted successfully.......$decryptedvideoData ');
    setState(() {});
    Navigator.pop(context);
    //  getx.videoplayer.value = false;
  }

  bool x = false;
  @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     permission();
  //   });
  //   super.initState();
  // }

  late Directory filelocationpath;
//

  Future permission() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      if ((info.version.sdkInt) >= 33) {
      } else {}
    } else {}
  }
}
