// ignore_for_file: file_names, must_be_immutable, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/key/key.dart';
import 'package:dthlms/pdfview/pdfview.dart';

import 'package:flutter/material.dart';

import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../ThemeData/color/color.dart';
import '../../ThemeData/font/font_family.dart';
import '../../widget/drawerWidget.dart';
import '../utctime.dart';
import 'package:http/http.dart' as http;

class StudyMaterialPdf extends StatefulWidget {
  String name;
  StudyMaterialPdf(this.name, {super.key});

  @override
  State<StudyMaterialPdf> createState() => _StudyMaterialPdfState();
}

class _StudyMaterialPdfState extends State<StudyMaterialPdf> {
  UtcTime time = UtcTime();
  Getx getx = Get.put(Getx());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: ColorPage.bgcolor,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                time.utctime(),
                style: FontFamily.font2,
              ),
            )
          ],
          backgroundColor: ColorPage.appbarcolor,
          title: Text(
            widget.name,
            style: FontFamily.font2,
            textScaler: const TextScaler.linear(1.5),
          ),
        ),
        body: Row(
          children: [
            const DrawerWidget(),
            SizedBox(
              width: 700,
              child: ListView.builder(itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                  child: Card(
                    color: const Color.fromARGB(255, 245, 247, 248),
                    surfaceTintColor: ColorPage.white,
                    elevation: 10,
                    child: ListTile(
                      onTap: () {
                        Get.to(() => const PdfView());
                      },
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/pdf3.png',
                          width: 30,
                        ),
                      ),
                      title: Text(
                        'google-drive.pdf',
                        style: FontFamily.mobilefont,
                      ),
                      subtitle: Text(
                        '1.3 mb Expiry:25-05-14',
                        style: GoogleFonts.kadwa(
                            textStyle: const TextStyle(color: ColorPage.grey)),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await FlutterPlatformAlert.playAlertSound();

                            final clickedButton =
                                await FlutterPlatformAlert.showAlert(
                                    windowTitle: 'Download',
                                    text: 'You want to download the pdf file',
                                    alertStyle: AlertButtonStyle.yesNoCancel,
                                    iconStyle: IconStyle.information,
                                    options: PlatformAlertOptions());
                            if (clickedButton == AlertButton.yesButton) {
                              filelocationpath = await getExternalvisibledir;
                              downloadcrete(
                                      url, filelocationpath, filename, true)
                                  .whenComplete(() => convertdecryptfile(
                                      filelocationpath, filename));
                            }
                          },
                          icon: const Icon(Icons.download)),
                    ),
                  ),
                );
              }),
            ),
            Obx(
              () => Expanded(
                  child: getx.pdfview.value
                      ? Container(
                          color: ColorPage.colorblack,
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                  // width: MediaQuery.sizeOf(context).width,
                                  height:
                                      MediaQuery.sizeOf(context).height - 50,
                                  child: SfPdfViewer.memory(
                                    decryptedPdfData,
                                  )),
                            ],
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }

  String filename = "encrypt1.pdf";
  late Directory appDocDir;
  Future<Directory> get getExternalvisibledir async {
    if (Platform.isAndroid) {
      if (await Directory('/storage/emulated/0/Solution_infotech_pdf')
          .exists()) {
        final externalDir =
            Directory('/storage/emulated/0/Solution_infotech_pdf');
        return externalDir;
      } else {
        await Directory('/storage/emulated/0/Solution_infotech_pdf')
            .create(recursive: true);
        final externalDir =
            Directory('/storage/emulated/0/Solution_infotech_pdf');
        return externalDir;
      }
    } else {
      final Directory _appDocDir = await getApplicationDocumentsDirectory();
      //App Document Directory + folder name
      final Directory _appDocDirFolder =
          Directory('${_appDocDir.path}/Solution_infotech_pdf');

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

  String url = "https://pspdfkit.com/downloads/pspdfkit-web-demo.pdf";
  Future downloadcrete(url, Directory d, filename, bool check) async {
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
                  children: [Text('Pdf Downloading..')],
                )
              ],
            )),
          );
        });

    if (check == true) {
      print('Data downloading......');
      var res = await http.get(Uri.parse(url));
      // final bytes = await ;
      List<int> encResult = await encryptPdf(res.bodyBytes);
      String p = await writedata(encResult, "${d.path}/$filename");
      print('file encryption successfully $p');
    } else {
      final File file = File(url);
      final List<int> bytes = await file.readAsBytes();
      final List<int> encryptedBytes = await encryptPdf(bytes);
      // final File encryptedFile = File();
      String p = await writedata(encryptedBytes, "${d.path}/$filename");
      print('File encrypted successfully: $p');
    }
    Navigator.pop(context);
    print('${d.path}/$filename');
  }

  Uint8List decryptedPdfData = Uint8List(0);
  convertdecryptfile(Directory d, filename) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    Uint8List encdata = await readData("${d.path}/$filename");
    decryptedPdfData = await decryptPdf(encdata);
    // ignore: unused_local_variable
    String p = await writedata(decryptedPdfData, "${d.path}/decrypt.pdf");

    print('file decrypted successfully.......$decryptedPdfData ');
    setState(() {});
    Navigator.pop(context);
    getx.pdfview.value = false;
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
