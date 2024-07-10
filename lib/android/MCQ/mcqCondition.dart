import 'dart:io';

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/mcq/mcqexampage.dart';
import 'package:dthlms/mcq/practiceMcqPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class McqTermAndConditionmobile extends StatelessWidget {

  bool androiddevice=Platform.isAndroid?true:false;
  bool windowsddevice=Platform.isWindows?true:false;

  McqTermAndConditionmobile({super.key});
  RxBool checkbox = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        backgroundColor: ColorPage.appbarcolor,
        leading: Image.asset(
          'assets/2.png',
        ),
        title: Text(
          'Welcome xyz classes',
          style: FontFamily.font5,
        ),
        actions: [
          Text(
            'Exam Starts in : 4.50 min  ',
            style: TextStyle(
                color: ColorPage.white,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.home,
                color: ColorPage.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person_3_rounded,
                color: ColorPage.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Platform.isAndroid?30:100, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '* Math Test',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: ColorPage.green),
                    textScaler: TextScaler.linear(1.5),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    width: androiddevice?MediaQuery.sizeOf(context).width/1.5:MediaQuery.sizeOf(context).width-200,

                    child: Text(
                      'Please read the following instructions carefully',
                      style: TextStyle(
                        // decoration: TextDecoration.underline,
                        decorationColor: ColorPage.appbarcolor,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaler: TextScaler.linear(1.4),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Container(
                      // alignment: Alignment.center,
                      width:androiddevice? MediaQuery.sizeOf(context).width /1.2:MediaQuery.of(context).size.width-200,
                      child: Text(
                        textAlign: TextAlign.justify,
                        'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sequi officia doloribus veritatis facere autem necessitatibus, similique asperiores consectetur aliquam excepturi dolor error reiciendis beatae? Reprehenderit ducimus, voluptate facilis eveniet autem ab fuga accusantium suscipit labore obcaecati amet voluptatibus corporis numquam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolor accusantium voluptatibus, aliquam ratione exercitationem aut debitis quos saepe nemo atque, odio magni architecto sapiente voluptate! Dolores voluptate sapiente voluptatibus explicabo beatae, praesentium necessitatibus. Alias et perspiciatis fugiat est? Explicabo, neque vel est numquam quam similique ullam soluta veritatis dolores, quas ut cumque porro, eaque accusantium odio? Ad id officiis quis ducimus dolorem eum nobis dignissimos maxime! Porro id ratione quam deserunt eum adipisci, similique, qui placeat nisi voluptatem ullam nemo accusantium laudantium quas quidem voluptatum eveniet laboriosam. Iusto, adipisci, deleniti ullam possimus exercitationem at cum, illum maxime eius iure ipsam? Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sequi officia doloribus veritatis facere autem necessitatibus, similique asperiores consectetur aliquam excepturi dolor error reiciendis beatae? Reprehenderit ducimus, voluptate facilis eveniet autem ab fuga accusantium suscipit labore obcaecati amet voluptatibus corporis numquam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolor accusantium voluptatibus, aliquam ratione exercitationem aut debitis quos saepe nemo atque, odio magni architecto sapiente voluptate! Dolores voluptate sapiente voluptatibus explicabo beatae, praesentium necessitatibus. Alias et perspiciatis fugiat est? Explicabo, neque vel est numquam quam similique ullam soluta veritatis dolores, quas ut cumque porro, eaque accusantium odio? Ad id officiis quis ducimus dolorem eum nobis dignissimos maxime! Porro id ratione quam deserunt eum adipisci, similique, qui placeat nisi voluptatem ullam nemo accusantium laudantium quas quidem voluptatum eveniet laboriosam. Iusto, adipisci, deleniti ullam possimus exercitationem at cum, illum maxime eius iure ipsam? Lorem ipsum, dolor sit amet consectetur adipisicing elit. Sequi officia doloribus veritatis facere autem necessitatibus, similique asperiores consectetur aliquam excepturi dolor error reiciendis beatae? Reprehenderit ducimus, voluptate facilis eveniet autem ab fuga accusantium suscipit labore obcaecati amet voluptatibus corporis numquam. Lorem ipsum dolor sit amet consectetur adipisicing elit. Dolor accusantium voluptatibus, aliquam ratione exercitationem aut debitis quos saepe nemo atque, odio magni architecto sapiente voluptate! Dolores voluptate sapiente voluptatibus explicabo beatae, praesentium necessitatibus. Alias et perspiciatis fugiat est? Explicabo, neque vel est numquam quam similique ullam soluta veritatis dolores, quas ut cumque porro, eaque accusantium odio? Ad id officiis quis ducimus dolorem eum nobis dignissimos maxime! Porro id ratione quam deserunt eum adipisci, similique, qui placeat nisi voluptatem ullam nemo accusantium laudantium quas quidem voluptatum eveniet laboriosam. Iusto, adipisci, deleniti ullam possimus exercitationem at cum, illum maxime eius iure ipsam? Dolor accusantium voluptatibus, aliquam ratione exercitationem aut debitis quos saepe nemo atque, odio magni architecto sapiente voluptate! Dolores voluptate sapiente voluptatibus explicabo beatae, praesentium necessitatibus. Alias et perspiciatis fugiat est? Explicabo, neque vel est numquam quam similique ullam soluta veritatis dolores, quas ut cumque porro, eaque accusantium odio? Ad id officiis quis ducimus dolorem eum nobis dignissimos maxime! Porro id ratione quam deserunt eum adipisci, similique, qui placeat nisi voluptatem ullam nemo accusantium laudantium quas quidem voluptatum eveniet laboriosam. Iusto, adipisci, deleniti ullam possimus exercitationem at cum, illum maxime eius iure ipsam?',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: ColorPage.grey)),
                        textScaler: TextScaler.linear(1.2),
                      ))
                ],
              ),
              SizedBox(
                height: androiddevice?30:windowsddevice?150:100,
              ),



              androiddevice?Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Name : Paper 1 - Arithmetic',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaler:androiddevice? null:TextScaler.linear(1.4),
                      ),
                    ],
                  ),
                  Text(
                    'Total Questions : 60',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaler:androiddevice? null:TextScaler.linear(1.4),
                  )
                ],
              ):
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name : Paper 1 - Arithmetic',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaler:androiddevice? null:TextScaler.linear(1.4),
                  ),
                  Text(
                    'Total Questions : 60',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaler:androiddevice? null:TextScaler.linear(1.4),
                  )
                ],
              ),
           androiddevice? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Type : Multiple Choice',
                        style: TextStyle(fontWeight: FontWeight.bold),
                       textScaler:androiddevice? null:TextScaler.linear(1.4),
                      ),
                    ],
                  ),
                  Text(
                    'Total Duration : 60 Minutes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaler:androiddevice? null:TextScaler.linear(1.4),
                  )
                ],
              ):   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Type : Multiple Choice',
                    style: TextStyle(fontWeight: FontWeight.bold),
                   textScaler:androiddevice? null:TextScaler.linear(1.4),
                  ),
                  Text(
                    'Total Duration : 60 Minutes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaler:androiddevice? null:TextScaler.linear(1.4),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Marks : 60',
                    style: TextStyle(fontWeight: FontWeight.bold),
                   textScaler:androiddevice? null:TextScaler.linear(1.4),
                  ),
                ],
              ),
             androiddevice?Column(children: [
               Row(
                    children: [
                      Obx(
                        () => SizedBox(
                            // width: 100,
                            child: Checkbox(
                              
                              activeColor:Color.fromARGB(255, 54, 127, 244),
                          // fillColor: MaterialStatePropertyAll(Color.fromARGB(255, 193, 37, 214)),
                          value: checkbox.value,
                          onChanged: (v) {
                            checkbox.value = !checkbox.value;
                          },
                        )),
                      ),
                      Container(
                          // width: 300,
                          child: Text(
                        'I have read the instructions carefully',
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkbox.value? Get.to(() => McqExamPage()):_onTermDeniey(context);
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                        shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStatePropertyAll(ColorPage.blue)),
                  )
              


             ],)


             //For Windows
:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => SizedBox(
                            // width: 100,
                            child: Checkbox(
                          // fillColor: MaterialStatePropertyAll(ColorPage.blue),
                          value: checkbox.value,
                          onChanged: (v) {
                            checkbox.value = !checkbox.value;
                          },
                        )),
                      ),
                      Container(
                          // width: 300,
                          child: Text(
                        'I have read the instructions carefully',
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                     checkbox.value? Get.to(() =>PracticeMcq()):_onTermDeniey(context);
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
                        shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStatePropertyAll(ColorPage.blue)),
                  )
                ],
              )         ],
          ),
        ),
      ),
    );
  }


  _onTermDeniey(context) {
    Alert(
      context: context,
      type: AlertType.info,
      style: AlertStyle(
        titleStyle: TextStyle(color: ColorPage.red,fontWeight: FontWeight.bold),
        descStyle: FontFamily.font6,
        isCloseButton: false,
      ),
      title: "Term Not Accepted !!",
      desc: "Please agree with our Term & condition of Exam. \n Fill the check box After reading the term & condition.  ",
      buttons: [
        DialogButton(
          child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(3, 77, 59, 1), 
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color.fromRGBO(9, 89, 158, 1),
        ),
       
      ],
    ).show();
  }
}
