import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';

class MockTestResultPage extends StatefulWidget {
  const MockTestResultPage({super.key});

  @override
  State<MockTestResultPage> createState() => _MockTestResultPageState();
}

class _MockTestResultPageState extends State<MockTestResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPage.appbarcolor,
        iconTheme: IconThemeData(color: ColorPage.white),
        title: Text(
          "Your Result",
          style: FontFamily.font7,
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70),
                child: Container(
                  height: 200,
                  width: 120,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 40),
                child: Container(
                 height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          tileMode: TileMode.clamp,
                          begin: Alignment.topLeft,
                          colors: [
                           Color.fromARGB(255, 32, 39, 62),
                            Color.fromARGB(255, 111, 131, 203),
                          ]),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(50, 50))),
                  child: Center(
                      child: Text(
                    "50",
                    style: FontFamily.font7,
                  )),
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25,vertical: 40),
                child: Container(
                height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        
                          begin: Alignment.topLeft,
                          colors: [
                            Color.fromARGB(255, 35, 101, 66),
                              Color.fromARGB(255, 70, 189, 125),
                          ]),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(50, 30))),
                  child: Center(
                      child: Text(
                    "60",
                    style: FontFamily.font7,
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 40),
                child: Container(
                height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        
                          begin: Alignment.topLeft,
                          colors: [
                            Color.fromARGB(255, 125, 37, 37),
                              Color.fromARGB(255, 190, 66, 66),
                          ]),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(50, 30))),
                  child: Center(
                      child: Text(
                    "51",
                    style: FontFamily.font7,
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
