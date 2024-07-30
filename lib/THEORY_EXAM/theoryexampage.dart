import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:crypto/crypto.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart'; // Add this import

import 'dart:io';

class TheoryExamPage extends StatefulWidget {
  const TheoryExamPage({super.key});

  @override
  State<TheoryExamPage> createState() => _TheoryExamPageState();
}

class _TheoryExamPageState extends State<TheoryExamPage> {
  final List<File> _images = [];
  File? _selectedImage;
  double sheetNumber = 1.0;
  Getx getxController = Get.put(Getx());
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final PdfViewerController _pdfViewerController = PdfViewerController();
  String? _localPdfPath;
  bool _isFilePickerOpen = false; // Add this variable

  TextEditingController sheetController = TextEditingController();
  final GlobalKey<FormState> sheetkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _downloadPdf();
  }

  Future<void> _pickImage() async {
    if (_isFilePickerOpen) return; // Prevent multiple file pickers from opening
    if (getxController.isPaperSubmit.value) {
      _isFilePickerOpen = true; // Set the variable to true when opening the picker
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.image,
            allowMultiple: true,
            dialogTitle: "Press & Hold CTRL to Select Multiple Sheet!");

        if (result != null) {
          setState(() {
            for (var path in result.paths) {
              if (path != null) {
                File file = File(path);
                if (!_isDuplicateImage(file)) {
                  _images.add(file);
                } else {
                  _showDuplicateImageAlert(file.absolute.path.split('\\').last);
                }
              }
            }
          });
        }
      } finally {
        _isFilePickerOpen = false; // Reset the variable after picker is closed
      }
    } else {
      editSheetNumber(context);
    }
  }

  bool _isDuplicateImage(File file) {
    for (var image in _images) {
      if (_calculateFileHash(image) == _calculateFileHash(file)) {
        return true;
      }
    }
    return false;
  }

  String _calculateFileHash(File file) {
    var bytes = file.readAsBytesSync();
    return md5.convert(bytes).toString();
  }

  void _selectImage(File image) {
    setState(() {
      _selectedImage = image;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Image.file(
                image,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                right: 20,
                top: 20,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red, size: 38),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteImage(File image) {
    setState(() {
      _images.remove(image);
      if (_selectedImage == image) {
        _selectedImage = null;
      }
    });
  }

  void _uploadImages() {
    if (_images.length == sheetNumber) {
      _onUploadSuccessFull(context);
      print("Images uploaded: ${_images.length} images");
    } else if (_images.length > sheetNumber) {
      _onSheetOverFlow(context);
    } else if (_images.length < sheetNumber) {
      _onSheetUnderFlow(context);
    }
  }

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

      List<Printer> filteredPrinters = [];
      //  Future<void> fetchPrinters() async {
    final printers = await Printing.listPrinters();

    setState(() {
      filteredPrinters = printers.where((printer) {
        return printer.isAvailable;
      }).toList();
    });
  // }

  // Future<void> printDocument() async {
    if (filteredPrinters.isNotEmpty) {
      await Printing.layoutPdf(
        onLayout: (format) async {
          // Generate your PDF document here
          // final pdfBytes =pdfBytes;
          return pdfBytes;
        },
        usePrinterSettings: true,
        dynamicLayout: true,
      );
    } else {
      print('No suitable printers found. Please check your printer connections.');
    }
  // }

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
                  Text("Remaining Time",
                      style: FontFamily.font3.copyWith(color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(Icons.alarm, color: Colors.white),
                  SizedBox(width: 5),
                  Text("03:56:54",
                      style: FontFamily.font3.copyWith(color: Colors.white)),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ],
          backgroundColor: ColorPage.appbarcolor,
          title: Text("Theory Exam",
              style: FontFamily.font3.copyWith(color: Colors.white)),
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
                        Positioned(
                          bottom: 10,
                          right: 20,
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                child: FloatingActionButton(
                                  hoverColor: ColorPage.deepblue,
                                  backgroundColor: ColorPage.appbarcolorcopy,
                                  child: Icon(
                                    Icons.print,
                                    color: ColorPage.white,
                                  ),
                                  onPressed: _printPdf, // Update this line
                                ),
                              ),
                              SizedBox(height: 20,),

                               Container(
                                height: 40,
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(17)),
                                  child: MaterialButton(
                                    hoverColor: ColorPage.deepblue,
                                    color: ColorPage.appbarcolorcopy,
                                    
                                    child: Icon(
                                      Icons.fullscreen,
                                      color: ColorPage.white,
                                    ),
                                    onPressed: () {
                                      if (_localPdfPath != null) {
                                        _openFullScreenPdf(
                                            _pdfViewerController.pageNumber);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Color.fromARGB(255, 225, 253, 254),
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.all(8.0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemCount: sheetNumber.toInt(),
                              itemBuilder: (context, index) {
                                if (index < _images.length) {
                                  return GestureDetector(
                                    onTap: () => _selectImage(_images[index]),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            _images[index],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: IconButton(
                                            icon: Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () =>
                                                _deleteImage(_images[index]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: _pickImage,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add,
                                              size: 50,
                                              color: Colors.grey[700]),
                                          Text("Select your Sheet",
                                              style: FontFamily.font3.copyWith(
                                                  color: Colors.grey[700])),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Obx(
                            () => getxController.isPaperSubmit.value
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: _uploadImages,
                                      child: Text("Upload Images",
                                          style: FontFamily.font3),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 5, 1, 31),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  editSheetNumber(context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      alertPadding: EdgeInsets.only(top: 200),
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
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

    Alert(
      context: context,
      style: alertStyle,
      title: "Enter Your Sheet Number",
      content: Form(
        key: sheetkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enter How Many Sheets You Want To Upload',
                    style: TextStyle(fontSize: 14)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SpinBox(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  sheetNumber = value;
                },
                decoration: InputDecoration(
                  border:
                      UnderlineInputBorder(borderSide: BorderSide(width: 2)),
                ),
                value: sheetNumber,
              ),
            ),
          ],
        ),
      ),
      buttons: [
        DialogButton(
          width: MediaQuery.of(context).size.width / 5.5,
          child:
              Text("OK", style: TextStyle(color: Colors.white, fontSize: 15)),
          onPressed: () {
            // ignore: unnecessary_null_comparison
            if (sheetNumber == null || sheetNumber == 0) {
              _onSheetNull(context);
            } else if (sheetNumber > 0 && sheetNumber > _images.length) {
              setState(() {
                getxController.isPaperSubmit.value = true;
                Navigator.pop(context);
                _pickImage();
              });
            } else {
              setState(() {
                getxController.isPaperSubmit.value = true;
                Navigator.pop(context);
              });
            }
          },
          color: ColorPage.colorgrey,
          radius: BorderRadius.circular(5.0),
        ),
      ],
    ).show();
  }

  _onSheetOverFlow(context) {
    Alert(
      context: context,
      type: AlertType.error,
      style: AlertStyle(
        titleStyle: TextStyle(color: ColorPage.red),
        descStyle: FontFamily.font6,
        isCloseButton: false,
      ),
      title: "NUMBER OF SHEET NOT MATCH !!",
      desc:
          "Your Assign ${sheetNumber.toStringAsFixed(0)} Sheets.\n But you selected ${_images.length} Sheets.\n Please edit the sheet number or\n remove the extra Pages",
      buttons: [
        DialogButton(
          child:
              Text("Edit", style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {
            Navigator.pop(context);
            editSheetNumber(context);
          },
          color: Color.fromARGB(255, 32, 194, 209),
        ),
        DialogButton(
          child:
              Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ColorPage.buttonColor,
        ),
      ],
    ).show();
  }

  _onSheetNull(context) {
    Alert(
      context: context,
      type: AlertType.error,
      style: AlertStyle(
        titleStyle: TextStyle(color: ColorPage.red),
        descStyle: FontFamily.font6,
        isCloseButton: false,
      ),
      title: "INVALID SHEET !!",
      desc: "At least 1 sheet you should assign",
      buttons: [
        DialogButton(
          child:
              Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: ColorPage.appbarcolor,
          onPressed: () {
            Navigator.pop(context);
            _pickImage();
          },
          color: ColorPage.blue,
        ),
      ],
    ).show();
  }

  _onSheetUnderFlow(context) {
    Alert(
      context: context,
      type: AlertType.error,
      style: AlertStyle(
        titleStyle: TextStyle(color: ColorPage.red),
        descStyle: FontFamily.font6,
        isCloseButton: false,
      ),
      title: "NUMBER OF SHEET NOT MATCH !!",
      desc:
          "Your Assign ${sheetNumber.toStringAsFixed(0)} Sheets.\n But you selected ${_images.length} Sheets.\n Please edit the sheet number or\n add more Pages",
      buttons: [
        DialogButton(
          child:
              Text("Add", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: ColorPage.blue,
          onPressed: () {
            Navigator.pop(context);
            _pickImage();
          },
          color:const Color.fromARGB(255, 33, 226, 243),
        ),
        DialogButton(
          highlightColor: Color.fromARGB(255, 2, 2, 60),
          child:
              Text("Edit", style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {
            Navigator.pop(context);
            editSheetNumber(context);
          },
          color: ColorPage.blue,
        ),
      ],
    ).show();
  }

  void _showDuplicateImageAlert(String file) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Duplicate Image",
      desc: "$file\nThis image has already been selected.",
      buttons: [
        DialogButton(
          child:
              Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {
            Navigator.pop(context);
            _pickImage();
          },
          color: ColorPage.blue,
        ),
      ],
    ).show();
  }

  _onUploadSuccessFull(context) {
    Alert(
      context: context,
      type: AlertType.success,
      style: AlertStyle(
        titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        descStyle: FontFamily.font6,
        isCloseButton: false,
      ),
      title: "UPLOAD SUCCESSFUL!!",
      desc: "Your answer sheets are uploaded successfully!",
      buttons: [
        DialogButton(
          child:
              Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: ColorPage.blue,
          onPressed: () {
            Navigator.pop(context);
          },
          color: ColorPage.green,
        ),
      ],
    ).show();
  }
}
