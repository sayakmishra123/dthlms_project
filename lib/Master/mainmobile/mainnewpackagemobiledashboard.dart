import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/Master/dashboard.dart';
import 'package:dthlms/Master/videoplayer.dart';
import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DashBoardMobile extends StatefulWidget {
  const DashBoardMobile({super.key});

  @override
  State<DashBoardMobile> createState() => _DashBoardMobileState();
}

class _DashBoardMobileState extends State<DashBoardMobile> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          actions: [
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/sorojda.png",
                                  fit: BoxFit.cover,
                                  width: 50,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Reet Mishra',
                                  style: FontFamily.font,
                                ),
                                Text(
                                  'reetmishra@gmail.com',
                                  style: TextStyle(color: Colors.grey),
                                  textScaler: TextScaler.linear(0.9),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                Icons.notification_add_sharp,
                                color: Colors.black,
                                weight: 5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: Color.fromARGB(255, 192, 191, 191),
                          offset: Offset(0, 0))
                    ],
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: ExpansionTile(
                    backgroundColor: Color.fromARGB(255, 234, 237, 248),
                    shape: LinearBorder(),
                    title: Text("Package List"),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Container(
                          color: Color.fromARGB(255, 234, 237, 248),
                          height: 50,

                          // height: 60,
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: ColorPage.grey,
                                    fontSize: ClsFontsize.DoubleExtraSmall),
                                fillColor: ColorPage.white,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(40))),
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: Expanded(
                            flex: 1,
                            child: DashboardSlideBar(
                              headname: 'DTH LMS',
                              selectedIndex: selectedIndex,
                              onItemSelected: (index) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorPage.colorbutton,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Color.fromARGB(255, 192, 191, 191),
                                  offset: Offset(0, 0))
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: MediaQuery.sizeOf(context).height / 6,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: AutoSizeText(
                                          textScaleFactor: 1.3,
                                          'May 29,2024',
                                          style: FontFamily.font2,
                                          // textScaler: TextScaler.linear(2),
                                        ),
                                      ),
                                      Flexible(
                                        child: AutoSizeText(
                                          'Welcome back, Reet!',
                                          textScaleFactor: 0.9,
                                          style: FontFamily.font2,
                                          // textScaler: TextScaler.linear(1.5),
                                        ),
                                      ),
                                      Flexible(
                                        child: AutoSizeText(
                                          'Always updated in your portal',
                                          style: FontFamily.font9,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8, bottom: 0),
                                child: MaterialButton(
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        2, // Adjusted for responsiveness
                                    vertical: 5,
                                  ),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  onPressed: () {
                                    learningGoal(context);
                                  },
                                  child: Text(
                                    'Learning goal',
                                    style: FontFamily.font2.copyWith(
                                        fontSize:
                                            ClsFontsize.DoubleExtraSmall - 3,
                                        color: ColorPage.colorbutton),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 192, 191, 191),
                            offset: Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = constraints.maxWidth;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Basic of tax class by Avinush Sureka',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ),
                                            textScaleFactor: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      double screenWidth = constraints.maxWidth;

                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          MaterialButton(
                                            shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth *
                                                  0.05, // Adjusted for responsiveness
                                              vertical: 5,
                                            ),
                                            color: Color.fromARGB(
                                                255, 253, 29, 13),
                                            onPressed: () {},
                                            child: Text(
                                              'Live class',
                                              style: FontFamily.font2.copyWith(
                                                fontSize: ClsFontsize
                                                    .DoubleExtraSmall,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                                width: screenWidth *
                                    0.02), // Spacing between texts
                            Text(
                              '5:00-7:00',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: ColorPage.grey,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                CalenderWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  learningGoal(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        final double width = MediaQuery.of(context).size.width;
        final double height = MediaQuery.of(context).size.height;
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.08,
            horizontal: width * 0.1,
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorPage.colorbutton,
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Flutter Certification Exam',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '2024-08-15',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.video_library,
                                  size: 30, color: Colors.blueAccent),
                              SizedBox(width: 10),
                              Text('10 ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Text('Videos'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text("15 Hours"),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.picture_as_pdf,
                                  size: 30, color: Colors.blueAccent),
                              SizedBox(width: 10),
                              Text('5 ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Text('PDFs'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text("10 Hours"),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.question_answer,
                                  size: 30, color: Colors.blueAccent),
                              SizedBox(width: 10),
                              Text('50 ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Text('MCQs'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text("5 Hours"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total Study Time: 30 hours',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total Remaining Day: 15',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Avg Time/Day: 2 hours',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
