import 'package:dthlms/MOBILE/MCQ/mcqCondition.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MCQtypePage extends StatefulWidget {
  const MCQtypePage({super.key});

  @override
  State<MCQtypePage> createState() => _MCQtypePageState();
}

class _MCQtypePageState extends State<MCQtypePage> {
List<String> typelist=[
"Practice",
"MockTest",
"Exam"

];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPage.colorbutton,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: ColorPage.white),
        title: Text(
          "MCQ",
          style: FontFamily.font2,
        ),
      ),
      body: Container(
        child:  ListView.builder(
            itemCount: typelist.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color.fromARGB(255, 196, 190, 244),
                      offset: Offset(0, 0),
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: MaterialButton(
                  onPressed: () {
                  Get.to(()=>McqTermAndConditionmobile(type: typelist[index],));
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/folder8.png",
                      width: 45,
                    ),
                    title: Text(typelist[index],
                        style: FontFamily.font4.copyWith(fontWeight: FontWeight.bold)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorPage.colorbutton,
                    ),
                  ),
                ),
              );
            },
          ),
      ),
    ));
  }


}
