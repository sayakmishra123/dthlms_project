import 'dart:io';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:crypto/crypto.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SelectExamPapers extends StatefulWidget {
  const SelectExamPapers({super.key});

  @override
  State<SelectExamPapers> createState() => _SelectExamPapersState();
}

class _SelectExamPapersState extends State<SelectExamPapers> {
  final List<File> _images = [];
  File? _selectedImage;
  double sheetNumber = 1.0;
  bool _isFilePickerOpen = false; // Add this variable
  Getx getxController = Get.put(Getx());

  final GlobalKey<FormState> sheetkey = GlobalKey();

  Future<void> _pickImage() async {
    if (_isFilePickerOpen) return; // Prevent multiple file pickers from opening
    if (getxController.isPaperSubmit.value) {
      _isFilePickerOpen =
          true; // Set the variable to true when opening the picker
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,

        onPressed: _uploadImages,child: Icon(Icons.upload_rounded,color: ColorPage.appbarcolor,)) ,
      appBar: AppBar(
        // actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: ColorPage.appbarcolor,
        title: Text(
          'Paper Upload',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          // padding: EdgeInsets.all(10),
          // color: Color.fromARGB(255, 225, 253, 254),
          child: Column(
            children: [
           _images.isNotEmpty ?    Expanded(
         flex: 3,
                  // scrollDirection: Axis.horizontal,
       
           child: 
               Container(
                      child: 
                      
                    _images.isNotEmpty ?  Image.file(
                    _selectedImage != null  ? _selectedImage!:_images[0],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ): SizedBox(),
                    ),
                  
                
              ): SizedBox(),
             _images.isNotEmpty ? Expanded(
                
                child:  Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(10),
                      
                        scrollDirection: Axis.horizontal,
                                         itemCount: sheetNumber.toInt(),
                      
                        itemBuilder: (context, index) {
                             if (index < _images.length) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: GestureDetector(
                                onTap: () {
                                  _selectImage(_images[index]);
                                 
                                },
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        _images[index],
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: IconButton(
                                        icon: Icon(Icons.close_rounded, color: Color(0xFF008080)),
                                        onPressed: () => _deleteImage(_images[index]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                      
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_rounded,
                                          size: 30 , color: Colors.grey[700]),
                                      // Text("Select your Sheet",
                                      //     style: FontFamily.font3.copyWith(
                                      //         color: Colors.grey[700])),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }}),
                    ),
                  ],
                ),
              ): Expanded(
                child: Center(
                  child: Column(
               
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     GestureDetector(
                           onTap: _pickImage,
                           child: Container(
                            height: 200,
                             width: 100,
                             decoration: BoxDecoration(
                               color: Colors.transparent,
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(Icons.add_rounded,
                                     size: 30 , color: Colors.grey[700]),
                                 // Text("Select your Sheet",
                                 //     style: FontFamily.font3.copyWith(
                                 //         color: Colors.grey[700])),
                               ],
                             ),
                           ),
                         ),
                    ]
                  ),
                ),
              ),
            
            ],
          ),
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
          color: const Color.fromARGB(255, 33, 226, 243),
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
