// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/pages/StudyMaterial/StudyMaterial.dart';
import 'package:dthlms/utctime.dart';
import 'package:dthlms/widget/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ThemeData/font/font_family.dart';

// ignore: must_be_immutable
class StudyMaterialDashboard extends StatefulWidget {
  String name;
  StudyMaterialDashboard(
    this.name, {
    super.key,
  });

  @override
  State<StudyMaterialDashboard> createState() => _StudyMaterialDashboardState();
}

class _StudyMaterialDashboardState extends State<StudyMaterialDashboard> {
  UtcTime time = UtcTime();
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
          // leading: IconButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   icon: Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //   ),
          // ),
          backgroundColor: ColorPage.appbarcolor,
          title: Text(
            widget.name,
            style: FontFamily.font2,
            textScaler: TextScaler.linear(1.5),
          ),
        ),
        body: Row(
          children: [
            const DrawerWidget(),
            Expanded(
              child: Container(
                child: ListView.builder(itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                    child: Card(
                      color: Color.fromARGB(255, 245, 247, 248),
                      surfaceTintColor: Color.fromARGB(255, 243, 245, 247),
                      elevation: 10,
                      child: ListTile(
                        onTap: () {
                          Get.to(() => StudyMaterialPdf('All Online'),
                              transition: Transition.leftToRight);
                        },
                        title: Text(
                          'All Online',
                          style: FontFamily.mobilefont,
                        ),
                        subtitle: Text(
                          'Content: 4',
                          style: GoogleFonts.outfit(),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        // trailing:
                      ),
                    ),
                  );
                }),
              ),
            ),
            Expanded(
                child: Container(
                    // color: Colors.black,
                    child: Column(
              children: [],
            )))
          ],
        ),
      ),
    );
  }
}
