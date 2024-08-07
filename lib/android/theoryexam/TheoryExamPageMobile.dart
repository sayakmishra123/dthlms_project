import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/android/theoryexam/selectexampapers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart'; // Add this import
import 'dart:io';

class TheoryExamPageMobile extends StatefulWidget {
  const TheoryExamPageMobile({super.key});

  @override
  State<TheoryExamPageMobile> createState() => _TheoryExamPageMobileState();
}

class _TheoryExamPageMobileState extends State<TheoryExamPageMobile> {

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final PdfViewerController _pdfViewerController = PdfViewerController();
  String? _localPdfPath;

  TextEditingController sheetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _downloadPdf();
  }

  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    alertPadding: EdgeInsets.only(top: 300),
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 600),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: BorderSide(color: Colors.grey),
    ),
    titleStyle: TextStyle(color: ColorPage.blue, fontWeight: FontWeight.bold),
    constraints: BoxConstraints.expand(width: 350),
    overlayColor: Color(0x55000000),
    alertElevation: 0,
    alertAlignment: Alignment.center,
  );

  Future<void> _downloadPdf() async {
    final response = await http.get(Uri.parse(
        'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf'));
    if (response.statusCode == 200) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/QuestionPaper.pdf';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      setState(() {
        Get.back();
        _localPdfPath = filePath;
        print(filePath);
      });
    } else {
      print('Failed to download PDF.');
    }
  }

  void _openFullScreenPdf(int pageNumber) {
    final PdfViewerController fullScreenController = PdfViewerController();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorPage.white),
            title: Text("Full Screen PDF",
                style: FontFamily.font3.copyWith(color: Colors.white)),
            backgroundColor: ColorPage.appbarcolor,
          ),
          body: SfPdfViewer.file(
            File(_localPdfPath!),
            controller: fullScreenController,
            key: GlobalKey<SfPdfViewerState>(),
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              fullScreenController.jumpToPage(pageNumber);
            },
          ),
        ),
      ),
    );
  }

  void _printPdf() async {
    try {
      if (_localPdfPath != null) {
        final file = File(_localPdfPath!);
        final pdfBytes = await file.readAsBytes();

        // Use Printing.layoutPdf to print the PDF
        await Printing.layoutPdf(
          onLayout: ( format) async => pdfBytes,
        );
      } else {
        print('No PDF file available to print.');
      }
    } catch (e) {
      print('Error printing PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.alarm, color: Colors.white, size: 16),
                  SizedBox(width: 5),
                  Text("03:56:54",
                      style: FontFamily.font3.copyWith(
                          color: Colors.white, fontSize: 14)),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ],
          backgroundColor: ColorPage.appbarcolor,
          title: Text("Theory Exam",
              style: FontFamily.font3
                  .copyWith(color: Colors.white, fontSize: 18)),
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  right: BorderSide(
                                      width: 10,
                                      color: ColorPage.appbarcolor))),
                          child: _localPdfPath == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SfPdfViewer.file(
                                  File(_localPdfPath!),
                                  key: _pdfViewerKey,
                                  controller: _pdfViewerController,
                                ),
                        ),
                  ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 207, 232, 255),
                onPressed: _printPdf,
                child: Icon(Icons.print),
                heroTag: 'btn1',
              ),
              SizedBox(height: 15),
              FloatingActionButton(
                backgroundColor: Color.fromARGB(255, 207, 232, 255),
                onPressed: () {
                 
                 _onSubmitExam(context)
;                },
                child: Icon(Icons.arrow_forward_rounded),
                heroTag: 'btn2',
              ),
            ],
          ),
        ),
      ),
    );
  }



  _onSubmitExam(context) {
  

    Alert(
      context: context,
      type: AlertType.info,
      style: AlertStyle(
        isOverlayTapDismiss: false,
        animationType: AnimationType.fromTop,
        titleStyle:
            TextStyle(color: ColorPage.red, fontWeight: FontWeight.bold),
        descStyle: FontFamily.font6,
        isCloseButton: false,
      ),
      title: "Submit your paper now?",
      desc:
          "Select images to submit your paper",
      buttons: [
        DialogButton(
          child: Text("Cancel",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(77, 3, 3, 1),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color.fromRGBO(158, 9, 9, 1),
        ),
        DialogButton(
          child:
              Text("Yes", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(77, 3, 3, 1),
          onPressed: () {
              Get.back();
            Get.to(SelectExamPapers());
            
          },
          color: Color.fromRGBO(9, 89, 158, 1),
        ),
      ],
    ).show();
  }

}
