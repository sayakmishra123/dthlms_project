import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/Master/videoplayer.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class DashBoardMobile extends StatefulWidget {
  const DashBoardMobile({super.key});

  @override
  State<DashBoardMobile> createState() => _DashBoardMobileState();
}

class _DashBoardMobileState extends State<DashBoardMobile> {

   int selectedIndex = -1;

  List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.pink,
    Colors.lightBlue,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Flexible(
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      title: Container(
                        width: 400,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: ColorPage.grey),
                              fillColor: ColorPage.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(40))),
                        ),
                      ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
            Expanded(
              child: DropdownButton<int>(
                value: selectedIndex,
                items: [
                  DropdownMenuItem<int>(
                    value: -1,
                    child: Container(
                      width: MediaQuery.of(context).size.width-50, // Set a fixed width or wrap in a SizedBox
                      child: ListTile(
                        leading: Icon(Icons.home, color: selectedIndex == -1 ? Colors.white : Colors.black),
                        title: Text(
              'Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selectedIndex == -1 ? const Color.fromARGB(255, 0, 0, 0) : Colors.black,
              ),
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < 5; i++)
                    DropdownMenuItem<int>(
                      value: i,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              width: MediaQuery.of(context).size.width-50,// Set a fixed width or wrap in a SizedBox
              child: ListTile(
                leading: Icon(Icons.folder, color: colors[i]),
                title: Text(
                  'Package ${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selectedIndex == i ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: Text(
                  "No. of content 5",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: selectedIndex == i ? Colors.white : Colors.black,
                  ),
                ),
              ),
                        ),
                      ),
                    ),
                ],
                onChanged: (int? value) {
                  setState(() {
                    selectedIndex = value!;
                  });
                  if (value != null && value >= 0) {
                    Get.to(() => VideoPlayer());
                  }
                },
              ),
            ),

              
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Flexible(
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
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                  textScaleFactor: 2,
                                  'May 29,2024',
                                  style: FontFamily.font2,
                                  // textScaler: TextScaler.linear(2),
                                ),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  'Welcome back, Reet!',
                                  textScaleFactor: 1.5,
                                  style: FontFamily.font2,
                                  // textScaler: TextScaler.linear(1.5),
                                ),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  'Always updated in your portal',
                                  style: FontFamily.font3,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 50, top: 10, bottom: 10),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                          child: MaterialButton(
                            hoverColor: Color.fromARGB(255, 237, 235, 246),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding:  EdgeInsets.symmetric(
                                          vertical: MediaQuery.of(context).size.width/7, horizontal:  MediaQuery.of(context).size.width/3),
                                      child: Container(
                                        padding: EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10.0,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: ColorPage.colorbutton,
                                                borderRadius:
                                                    BorderRadius.all(
                                                  Radius.circular(7),
                                                ),
                                              ),
                                              padding: EdgeInsets.all(15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Flutter Certification Exam',
                                                    style: TextStyle(
                                                      overflow:TextOverflow.ellipsis,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255,
                                                          255,
                                                          255,
                                                          255),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    ' 2024-08-15',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color.fromARGB(
                                                          255,
                                                          250,
                                                          250,
                                                          250),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                   
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                            Icons.video_library,
                                                            size: 30,
                                                            color: Colors
                                                                .blueAccent),
                                                        SizedBox(width: 10),
                                                        Text('10 ',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text('Videos'),
                                                      ],
                                                    ),
                                                     Padding(
                                                       padding: const EdgeInsets.only(right: 20),
                                                       child: Row( mainAxisAlignment: MainAxisAlignment.start, children: [Text("15 Hours")],),
                                                     ),
                                                  ],
                                                ),
                                                SizedBox(height: 15),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .picture_as_pdf,
                                                            size: 30,
                                                            color: Colors
                                                                .blueAccent),
                                                        SizedBox(width: 10),
                                                        Text('5 ',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text('PDFs'),
                                                      ],
                                                    ),
                                                    Padding(
                                                       padding: const EdgeInsets.only(right: 20),
                                                       child: Row(  mainAxisAlignment: MainAxisAlignment.start, children: [Text("10 Hours")],),
                                                     ),
                                                  ],
                                                ),
                                                SizedBox(height: 15),
                                                Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .question_answer,
                                                            size: 30,
                                                            color: Colors
                                                                .blueAccent),
                                                        SizedBox(width: 10),
                                                        Text('50 ',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text('MCQs'),
                                                      ],
                                                    ),
                                                    Padding(
                                                       padding: const EdgeInsets.only(right: 20),
                                                       child: Row(  mainAxisAlignment: MainAxisAlignment.start, children: [Text("5 Hours")],),
                                                     ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Total Study Time: 30 hours',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: const Color.fromARGB(255, 0, 0, 0),
                                              ),
                                            ),
              
                                               SizedBox(height: 10),
                                            Text(
                                              'Total Remaining Day: 15',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: const Color.fromARGB(255, 0, 0, 0),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Avg Time/Day: 2 hours',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(255, 0, 0, 0),
                                              ),
                                            ),
              
                                            
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            color: ColorPage.white,
                            elevation: 10,
                            
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 7),
                              child: Text(
                                "Learning Goal",
                                style: FontFamily.font2.copyWith(
                                    color: ColorPage.colorbutton,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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

                  return Row(
                    children: [
                      Flexible(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Basic of tax class by Avinush Sureka',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textScaleFactor: 1.3,
                                ),
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
                          ),
                        ),
                      ),
                      Flexible(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double screenWidth = constraints.maxWidth;

                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'May 30, 2024',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: ColorPage.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Icon(Icons.broadcast_on_home_sharp),
                                  ),
                                  MaterialButton(
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth *
                                          0.05, // Adjusted for responsiveness
                                      vertical: 15,
                                    ),
                                    color: Color.fromARGB(255, 253, 29, 13),
                                    onPressed: () {},
                                    child: Text(
                                      'Live class',
                                      style: FontFamily.font2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
