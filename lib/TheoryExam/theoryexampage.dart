import 'dart:ffi';

import 'package:dthlms/ThemeData/color/color.dart';
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
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final List<File> _images = [];
  File? _selectedImage;
  double sheetNumber= 1.0;
  Getx getxController = Get.put(Getx());

  TextEditingController sheetController = TextEditingController();
  final GlobalKey<FormState> sheetkey = GlobalKey();

  Future<void> _pickImage() async {
    if(getxController.isPaperSubmit.value){
      FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _images.addAll(result.paths.map((path) => File(path!)).toList());
      });
    }
    }
    else{
     editSheetNumber(context);
      
    }
  }

  void _selectImage(File image) {
    setState(() {
      _selectedImage = image;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Color.fromARGB(0, 73, 74, 74),
          child: Stack(
            children: [
              Image.file(
                image,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                right: 100,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.red,size: 38,),
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
      _onUpload(context);
  
    print("Images uploaded: ${_images.length} images");
  }
  else if(_images.length > sheetNumber)
  {
    _onSheetOverFlow(context);


  }
   else if(_images.length < sheetNumber)
  {
    _onSheetUnderFlow(context);


  }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Text("Remaining Time ", style: FontFamily.font3),
            Icon(Icons.alarm, color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text("  03:56:54", style: FontFamily.font3),
            ),
          ],
          backgroundColor: ColorPage.appbarcolor,
          title: Text("Theory Exam", style: FontFamily.font3),
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: ColorPage.brownshade300),
                      padding: EdgeInsets.all(20),
                      child: SfPdfViewer.network(
                          'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
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
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                              ),
                              itemCount: _images.length + 1,
                              itemBuilder: (context, index) {
                                if (index == _images.length) {
                                  return Container(
                                   
                                   decoration: BoxDecoration( color: Color.fromARGB(255, 199, 199, 199),borderRadius: BorderRadius.all(Radius.circular(7))),
                                    child: MaterialButton(
                                      child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Select your Sheet From Device"),
                                        Icon(Icons.add),
                                      ],
                                    ),
                                    
                                      onPressed: () {
                                        _pickImage();
                                      },
                                    )
                                  );
                                }
                                return GestureDetector(
                                  onTap: () => _selectImage(_images[index]),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        _images[index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
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
                              },
                            ),
                          ),
                          Obx(
                            ()=>getxController.isPaperSubmit.value? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width/5.5,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: _uploadImages,
                                  child: Text("Upload Images",style: FontFamily.font3,),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:Color.fromARGB(255, 5, 1, 31)
                                 
                                  ),
                                ),
                              ),
                            ):SizedBox()
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
    // Reusable alert style
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: true,
        alertPadding: EdgeInsets.only(top: 200),
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle:
            TextStyle(color: ColorPage.blue, fontWeight: FontWeight.bold),
        constraints: BoxConstraints.expand(width: 500),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.center);

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      // type: AlertType.info,

      title: "Enter Your Sheet Number",

      content: Form(
          child: Form(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Text(
                    'Please fill field *',
                    style: TextStyle(color: ColorPage.red, fontSize: 12),
                  ),
                ),
              ],
            ),
            
             Padding(
              
              child: SpinBox(
                key:sheetkey,
                keyboardType: TextInputType.number,
                onChanged: (Value){
                  sheetNumber=Value;
                },
                
                decoration: InputDecoration(

                  
                border:UnderlineInputBorder(borderSide: BorderSide(width: 2))
                      
                  
                ),
              
                value: sheetNumber,
               
              ),
              padding: const EdgeInsets.all(16),
            ),
                    // Padding(
                    //         padding:
                    //             const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    //         child: TextFormField(
                    //           // controller: activationfield,
                    //           validator: (value) {
                    //             if (value!.isEmpty) {
                    //               return 'cannot blank';
                    //             }
                    //             return null;
                    //           },
                   
                    //           decoration: InputDecoration(
                      
                    //               // prefixIcon: Icon(Icons.code),
                        
                      
                    //               hintText: 'Enter Number of Answer Sheet',
            
                    //               filled: false,
                    //               focusColor: ColorPage.white),
                    //         ),
                    //       )
                    ],
                  ),
          )),
      buttons: [
        DialogButton(
          width: MediaQuery.of(context).size.width / 3.5,
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {  getxController.isPaperSubmit.value=true;
            
            
            
                                                                                Navigator.pop(context);
                                                                              
            
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
      style: AlertStyle(titleStyle: TextStyle(color: ColorPage.red),descStyle: FontFamily.font6,isCloseButton: false),

      title: "NUMBER OF SHEET NOT MATCH !!",
      desc: "Your Assign ${sheetNumber.toStringAsFixed(0)} Sheets.\n But you selected ${_images.length} Sheets.\n Please edit the sheet number or\n remove the extra Pages",
      buttons: [
        DialogButton(
          child: Text(
            "Remove",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {

        
            Navigator.pop(context);
            
          },
          color: Color.fromRGBO(161, 5, 18, 1),
        ),
        DialogButton(
          child: Text(
            "Edite",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: (){
            Navigator.pop(context);
             editSheetNumber(context);

          },
          color: ColorPage.blue,
        )
      ],
    ).show();
  }


  _onSheetUnderFlow(context) {
    Alert(
      context: context,
      type: AlertType.error,

      style: AlertStyle(titleStyle: TextStyle(color: ColorPage.red),descStyle: FontFamily.font6,
      isCloseButton: false),

      title: "NUMBER OF SHEET NOT MATCH !!",
      desc: "Your Assign ${sheetNumber.toStringAsFixed(0)} Sheets.\n But you selected ${_images.length} Sheets.\n Please edit the sheet number or\n add more Pages",
      buttons: [
        DialogButton(
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {

        
            Navigator.pop(context);
            
          },
          color: Color.fromRGBO(34, 250, 171, 1),
        ),
        DialogButton(
          child: Text(
            "Edite",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed:(){
            Navigator.pop(context);
           editSheetNumber(context);

          },
          color: ColorPage.blue,
        )
      ],
    ).show();
  }

  _onUpload(context) {
    Alert(
      context: context,
      type: AlertType.success,


      style: AlertStyle(titleStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),descStyle: FontFamily.font6,
      isCloseButton: false),

      title: "UPLOAD SUCCESSFULL !!",
      desc: "Your answer sheets are uploaed successfully!",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
          ),
          onPressed: () {

        
            Navigator.pop(context);
            
          },
          color: Color.fromRGBO(2, 167, 33, 1),
        ),
       
      ],
    ).show();
  }

}
