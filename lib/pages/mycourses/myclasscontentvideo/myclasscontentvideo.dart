import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dthlms/getx/getxcontroller.dart';
import 'package:dthlms/key/key.dart';
// import 'package:dthlms/pdfview/pdfview.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter_platform_alert/flutter_platform_alert.dart';
// import 'package:get/get.dart';

// import 'package:google_fonts/google_fonts.dart';

import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:http/http.dart' as http;
import '../../../ThemeData/color/color.dart';

class MyClassVideoContent extends StatefulWidget {
  const MyClassVideoContent({super.key});

  @override
  State<MyClassVideoContent> createState() => _MyClassVideoContentState();
}

class _MyClassVideoContentState extends State<MyClassVideoContent> {
  Getx getx = Get.put(Getx());
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: ColorPage.bgcolor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextFormField(
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
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/folder.png',
                        width: 50,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/google-drive.png',
                        width: 50,
                      ))
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: MediaQuery.sizeOf(context).width,
                      child: Text(
                        'Class Lecture - Toady - TVM',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                                color: ColorPage.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: ClsFontsize.Large + 1)),
                      ),
                    ),
                    for (int i = 0; i < 5; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          color: ColorPage.white,
                          surfaceTintColor: ColorPage.white,
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          // elevation: 0,
                          child: ListTile(
                            leading: Container(
                              //  width: MediaQuery.sizeOf(context).width-100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/video2.png',
                                width: 30,
                              ),
                            ),
                            title: Text(
                              'google-video.mp4',
                              overflow: TextOverflow.ellipsis,
                              style: FontFamily.font4,
                            ),
                            subtitle: Text(
                              overflow: TextOverflow.ellipsis,
                              '7.3 mb Expiry:28-06-14',
                              style: GoogleFonts.kadwa(
                                  textStyle: const TextStyle(
                                color: ColorPage.grey,
                              )),
                            ),
                            trailing: IconButton(
                                onPressed: () async {
                                  await FlutterPlatformAlert.playAlertSound();
                                  final clickButton =
                                      await FlutterPlatformAlert.showAlert(
                                    windowTitle: "Download",
                                    text: "you want to download the video file",
                                    alertStyle: AlertButtonStyle.yesNoCancel,
                                    iconStyle: IconStyle.information,
                                    options: PlatformAlertOptions(),
                                  );
                                  if (clickButton == AlertButton.yesButton) {
                                    filelocationpath =
                                        await getExternalvisibledir;
                                    downloadcretevideo(url, filelocationpath,
                                            filename, true)
                                        .whenComplete(() => convertdecryptfile(
                                                    filelocationpath, filename)
                                                .whenComplete(() {
                                              getx.videoplayer.value = false;
                                            }));
                                  }
                                },
                                icon: const Icon(
                                  Icons.download_for_offline_sharp,
                                  color: ColorPage.downloadbtnofvideo,
                                )),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
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
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      permission();
    });
    super.initState();
  }

  late Directory filelocationpath;
//

  permission() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      if ((info.version.sdkInt) >= 33) {
      } else {}
    } else {}
  }
}
