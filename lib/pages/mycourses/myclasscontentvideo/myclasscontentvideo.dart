// ignore_for_file: unnecessary_import, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/package/packagevideo.dart/category/McqCategory.dart';
import 'package:dthlms/package/packagevideo.dart/category/pdfcategory.dart';
import 'package:dthlms/pages/mycourses/myclasscontentvideo/videoplay.dart';
import 'package:dthlms/utils/loader.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_platform_alert/flutter_platform_alert.dart';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dthlms/getx/getxcontroller.dart';
import 'package:dthlms/key/key.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:media_kit_video/media_kit_video_controls/src/controls/extensions/duration.dart';
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

  final List<double> speeds = [0.5, 1.0, 1.5, 2.0];
  double selectedSpeed = 1.0;

  late VideoPlayClass videoPlay;
  int t = 0;
  @override
  void initState() {
    videoPlay = VideoPlayClass();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    print(videoPlay.controller.player.state.duration.inSeconds);
    super.initState();
    // videoPlay.player.stream.playing.take()
    videoPlay.player.stream.playing.listen((bool playing) {
      if (!mounted) {
        print(mounted);
        print("Video total watch: ${videoPlay.totalPlayTime.inSeconds}");
        if (playing) {
          print(videoPlay.controller.player.state.duration.inSeconds);
          videoPlay.startTrackingPlayTime();
        } else {
          videoPlay.stopTrackingPlayTime();
        }
      }
    });

    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    // });
    permission();
  }

  // List<Widget> category = [];
  @override
  void dispose() {
    super.dispose();
    videoPlay.controller.player.dispose();

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

  var startseek = 0;
  var endseek = 0;
  TextEditingController gototext = TextEditingController();
  // Getx getx = Get.put(Getx());
  // GlobalKey tabbarkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialVideoControlsTheme(
 
       normal: MaterialVideoControlsThemeData( controlsHoverDuration: Duration(seconds: 15),primaryButtonBar: [ MaterialSkipPreviousButton(
            iconSize: 80,
          ),
          // MaterialDesktopPositionIndicator(),
          // MaterialSeekBar(),
          MaterialPlayOrPauseButton(
            iconSize: 80,
            // iconColor: ColorPage.blue,
          )
        ],

        seekBarThumbColor: Colors.blue,
        seekBarPositionColor: Colors.blue,
         bottomButtonBar: [
          MaterialPlayOrPauseButton(),
         
          MaterialPositionIndicator()
        ],
         topButtonBar: [
          Obx(
            () => MaterialCustomButton(
              onPressed: () {
                getx.videoplaylock.value = !getx.videoplaylock.value;
                print(getx.videoplaylock.value);
              },
              icon: getx.videoplaylock.value
                  ? Icon(Icons.lock)
                  : Icon(Icons.lock_open),
            ),
          ),
          const Spacer(),
          MaterialCustomButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shadowColor: ColorPage.white,
                      backgroundColor: ColorPage.white,
                      surfaceTintColor: ColorPage.white,
                      content: Card(
                        child: SizedBox(
                            width: 200,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Typing somthing...'),
                              maxLines: 5,
                            )),
                      ),
                      title: Text(
                        'Write your tag',
                        style: FontFamily.font,
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Cancel',
                            style: FontFamily.font3,
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(ColorPage.red),
                              shape: MaterialStatePropertyAll(
                                  ContinuousRectangleBorder())),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Save',
                            style: FontFamily.font3,
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(ColorPage.color1),
                              shape: MaterialStatePropertyAll(
                                  ContinuousRectangleBorder())),
                        )
                      ],
                    );
                  });
            },
            icon: Icon(Icons.edit_note),
          ),
          MaterialCustomButton(
            onPressed: () {
              showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(10, 0, 0, 10),
                  items: speeds.map((speed) {
                    return PopupMenuItem<double>(
                      value: speed,
                      child: Row(
                        children: [
                          Radio<double>(
                            value: speed,
                            groupValue: selectedSpeed,
                            onChanged: (double? value) {
                              setState(() {
                                selectedSpeed = value!;

                                videoPlay.player.setRate(selectedSpeed);
                                Navigator.pop(context);
                              });
                            },
                          ),
                          Text('${speed}x'),
                        ],
                      ),
                    );
                  }).toList());
            },
            icon: Icon(Icons.slow_motion_video),
          ),
          MaterialCustomButton(
            onPressed: () {
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog.adaptive(
              //         actions: [
              //           ElevatedButton(
              //             child: Text('Cancel'),
              //             onPressed: () {
              //               Get.back();
              //             },
              //           ),
              //           ElevatedButton(
              //             child: Text('Ok'),
              //             onPressed: () {
              //               videoPlay.player.seek(
              //                   Duration(seconds: int.parse(gototext.text)));
              //               Get.back();
              //             },
              //           )
              //         ],
              //         content: SizedBox(
              //           width: 300,
              //           child: TextFormField(
              //             controller: gototext,
              //           ),
              //         ),
              //       );
              //     });

              // videoPlay.player.seek(Duration(seconds: 30));
            },
            icon: Text(
              'GOTO',
              style: FontFamily.font3,
            ),
          ),
        ],
      
       ),
        fullscreen: const MaterialVideoControlsThemeData(
    // Modify theme options:
    // displaySeekBar: false,
    // automaticallyImplySkipNextButton: false,
    // automaticallyImplySkipPreviousButton: false,
  ),
      child: Row(
        children: [
          Container(
            child: Expanded(
              child: DefaultTabController(
                length: 4,
                child:Scaffold(
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
                              textColor: Colors
                                  .white, // optional, default to Colors.white
                              color:
                                  Colors.red, // optional, default to Colors.red
                              size: 18, // optional, default to 18
                            ),
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
                              _motionTabBarController!.index = value;

                              fngetVideodetailsApi(
                                  widget.token, tabfield[value]);
                            });
                          },
                        ),
                      ),
                    ),
                    body: TabBarView(
                        // physics:
                        //     NeverScrollableScrollPhysics(), // swipe navigation handling is not supported

                        controller: _motionTabBarController,
                        children: [
                          pdflink.isNotEmpty
                              ? PdfCategory(pdflink)
                              : Center(
                                  child: Image.asset(
                                      "assets/android/nodatafound.png")),
                          mcq.isNotEmpty ? McqCategory() : Container(),
                          pdflink.isNotEmpty
                              ? PdfCategory(pdflink)
                              : CircularProgressIndicator(),
                          pdflink.isNotEmpty
                              ? PdfCategory(pdflink)
                              : CircularProgressIndicator(),
                        ]),
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
                        child: Center(
                            child: SizedBox(
                          child: Video(
                            controller: videoPlay.controller,
                          ),
                        )),
                      ),
                    ],
                  )))
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
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
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
