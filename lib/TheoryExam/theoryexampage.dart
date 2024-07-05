import 'dart:ffi';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:crypto/crypto.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
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

  TextEditingController sheetController = TextEditingController();
  final GlobalKey<FormState> sheetkey = GlobalKey();


  Future<void> _pickImage() async {
    if (getxController.isPaperSubmit.value) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          for (var path in result.paths) {
            if (path != null) {
              File file = File(path);
              if (!_isDuplicateImage(file)) {
                _images.add(file);
              } else {
                // Show an alert or a message that the image is already selected
                _showDuplicateImageAlert(file.absolute.path.split('\\').last);
              
              }
            }
          }
        });
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

  void _openFullScreenPdf(int pageNumber) {
       final PdfViewerController fullScreenController = PdfViewerController();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Full Screen PDF", style: FontFamily.font3.copyWith(color: Colors.white)),
            backgroundColor: ColorPage.appbarcolor,
          ),
          body: SfPdfViewer.network('https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf', controller: fullScreenController,
            key: GlobalKey<SfPdfViewerState>(),
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              fullScreenController.jumpToPage(pageNumber);
            },),
        ),
      ),
    );
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
                  Text("Remaining Time", style: FontFamily.font3.copyWith(color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(Icons.alarm, color: Colors.white),
                  SizedBox(width: 5),
                  Text("03:56:54", style: FontFamily.font3.copyWith(color: Colors.white)),
                  SizedBox(width: 20)
                ],
              ),
            ),
          ],
          backgroundColor: ColorPage.appbarcolor,
          title: Text("Theory Exam", style: FontFamily.font3.copyWith(color: Colors.white)),
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
                          decoration: BoxDecoration(color: Colors.white,border: Border(right: BorderSide(width: 10,color:ColorPage.appbarcolor))),
                      
                          child: SfPdfViewer.network(
                              'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',key: _pdfViewerKey,controller: _pdfViewerController,),
                           
                              
                        ),
                        Positioned(
                          bottom: 10,
                          right: 20,
                          child: Container(
                            height: 40,
                            width: 40,
                            child: FloatingActionButton(
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 50,
                              hoverColor: ColorPage.color1,
                              onPressed: (){
                              final currentPage = _pdfViewerController.pageNumber;
                              _openFullScreenPdf(currentPage);
                              },
                              child: Icon(Icons.fullscreen, color: Colors.white,size: 26,),
                              backgroundColor: Color.fromARGB(255, 0, 140, 255),
                            ),
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
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemCount: _images.length + 1,
                              itemBuilder: (context, index) {
                                if (index == _images.length) {
                                  return GestureDetector(
                                    onTap: _pickImage,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add, size: 50, color: Colors.grey[700]),
                                          Text("Select your Sheet", style: FontFamily.font3.copyWith(color: Colors.grey[700])),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () => _selectImage(_images[index]),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
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
                                          icon: Icon(Icons.delete, color: Colors.red),
                                          onPressed: () => _deleteImage(_images[index]),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Obx(
                            () => getxController.isPaperSubmit.value
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: _uploadImages,
                                      child: Text("Upload Images", style: FontFamily.font3),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 5, 1, 31),
                                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
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
                Text('Enter How Many Sheets You Want To Upload', style: TextStyle( fontSize: 14)),
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
                  border: UnderlineInputBorder(borderSide: BorderSide(width: 2)),
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
          child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 15)),
          onPressed: () {
             
            if(sheetNumber == null || sheetNumber == 0) {
              _onSheetNull(context);

            }
            else if(sheetNumber>0){
               getxController.isPaperSubmit.value = true;
            Navigator.pop(context);
            _pickImage();
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
      desc: "Your Assign ${sheetNumber.toStringAsFixed(0)} Sheets.\n But you selected ${_images.length} Sheets.\n Please edit the sheet number or\n remove the extra Pages",
      buttons: [
       
        DialogButton(
          child: Text("Edit", style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {
            Navigator.pop(context);
            editSheetNumber(context);
          },
          color: ColorPage.blue,
        ),
         DialogButton(
          child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color.fromRGBO(2, 150, 59, 1),
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
      desc: "Atleast 1 sheet you should assign",
      buttons: [
        DialogButton(
          child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(3, 77, 59, 1), 
          onPressed: () {
            Navigator.pop(context);
            _pickImage();
          },
          color: Color.fromRGBO(2, 167, 33, 1),
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
      desc: "Your Assign ${sheetNumber.toStringAsFixed(0)} Sheets.\n But you selected ${_images.length} Sheets.\n Please edit the sheet number or\n add more Pages",
      buttons: [
        DialogButton(
          child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(1, 90, 58, 1),
          onPressed: () {
            Navigator.pop(context);
            _pickImage();
          },
          color: Color.fromRGBO(28, 203, 139, 1),
        ),
        DialogButton(
          highlightColor: Color.fromARGB(255, 2, 2, 60),
          child: Text("Edit", style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {
            Navigator.pop(context);
            editSheetNumber(context);
          },
          color: ColorPage.blue,
        ),
      ],
    ).show();
  }


    void _showDuplicateImageAlert( String file) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Duplicate Image",
      desc: "$file\nThis image has already been selected.",
      buttons: [
        DialogButton(
          child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          onPressed: () {
            Navigator.pop(context);
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
          child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(3, 77, 59, 1), 
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color.fromRGBO(2, 167, 33, 1),
        ),
      ],
    ).show();
  }
}

