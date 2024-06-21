import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Studyvidos extends StatefulWidget {
  const Studyvidos({super.key});

  @override
  State<Studyvidos> createState() => _StudyvidosState();
}

class _StudyvidosState extends State<Studyvidos> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      
      appBar: AppBar  (iconTheme: IconThemeData(color: ColorPage.white),bottom:PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // color: Color.fromRGBO(144, 164, 174, 1),
                          color: ColorPage.white),
                      height: 50,
                      child: TabBar(
                        labelColor: ColorPage.white,
                        // padding: ,
                        // indicatorColor: ColorPage.brownshade300,
                        dragStartBehavior: DragStartBehavior.down,
                        isScrollable: true,
                        unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
                        labelStyle: FontFamily.font,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(

                            // gradient: LinearGradient(
                            //     colors: [ Color.fromARGB(255, 85, 95, 133)]),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(255, 44, 53, 85)),
                        tabs: [
                          Tab(
                            text: "Video",
                          ),
                          Tab(
                            text: "PDF",
                          ),
                          Tab(
                            text: "MCQ",
                          ),
                          Tab(
                            text: "TAG",
                          ),
                          Tab(
                            text: "REVIEW",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                )),
          ),   title: Text("Study Videos",style: FontFamily.font7,),backgroundColor: ColorPage.appbarcolor,),
    ));
  }
}

























