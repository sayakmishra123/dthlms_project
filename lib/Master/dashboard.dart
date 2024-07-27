import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/Master/videoplayer.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DthDashboard extends StatefulWidget {
  const DthDashboard({super.key});

  @override
  State<DthDashboard> createState() => _DthDashboardState();
}

class _DthDashboardState extends State<DthDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: SlideBar()),
          Expanded(flex: 5, child: DashBoardRight())
        ],
      ),
    );
  }
}

class SlideBar extends StatefulWidget {
  const SlideBar({super.key});

  @override
  State<SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  List<Color> colors = [
    Colors.blue,
    Colors.orange,
    Colors.pink,
    Colors.lightBlue,
    Colors.orange,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.green,
  ];

  int hoverIndex = -1;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorPage.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  color: Color.fromARGB(255, 192, 191, 191),
                  offset: Offset(0, 0))
            ],
          ),
          child: SingleChildScrollView(
            // Make the SlideBar scrollable
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'DTH LMS',
                    style: FontFamily.font,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                for (int i = 0; i < 5; i++)
                  buttonWidget('Package 1', () {
                    setState(() {
                      index = i;
                    });
                    Get.to(() => VideoPlayer());
                  }, index == i, hoverIndex == i, i),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 65,
      //   child: MouseRegion(
      //     onEnter: (_) {
      //       setState(() {
      //         hoverIndex = index;
      //       });
      //     },
      //     onExit: (_) {
      //       setState(() {
      //         hoverIndex = -1;
      //       });
      //     },
      //     child: InkWell(
      //       onTap: () {},
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Container(
      //           decoration: BoxDecoration(
      //             border: Border.all(width: 0.5, color: Colors.grey),
      //             color: Colors.red,
      //             borderRadius: BorderRadius.circular(6),
      //           ),
      //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      //           child: Center(
      //             child: Text(
      //               'Log Out',
      //               style: TextStyle(
      //                   fontWeight: FontWeight.w600, color: Colors.white),
      //               overflow: TextOverflow.ellipsis,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget buttonWidget(
      String name, void Function()? onTap, bool isActive, bool isHover, int i) {
    Color backgroundColor = isActive ? ColorPage.colorbutton : Colors.white;
    Color textColor = isActive || isHover ? Colors.white : Colors.black;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoverIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          hoverIndex = -1;
        });
      },
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              color: backgroundColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: ListTile(
                leading: Icon(
                  Icons.folder,
                  color: colors[i],
                ),
                subtitle: Text(
                  "No.of content 5",
                  style:
                      TextStyle(fontWeight: FontWeight.w100, color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
                title: Text(
                  name,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, color: textColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashBoardRight extends StatefulWidget {
  const DashBoardRight({super.key});

  @override
  State<DashBoardRight> createState() => _DashBoardRightState();
}

class _DashBoardRightState extends State<DashBoardRight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorPage.colorbutton,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Color.fromARGB(255, 192, 191, 191),
                              offset: Offset(0, 0))
                        ],
                      ),
                      child: Row(
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
                          Container(
  padding: EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10.0,
        offset: Offset(0, 5),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Exam Name: Flutter Certification',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
      SizedBox(height: 10),
      Text(
        'Date: 2024-08-15',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Icon(Icons.video_library, size: 30, color: Colors.blueAccent),
              SizedBox(height: 5),
              Text('10', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Videos'),
            ],
          ),
          Column(
            children: [
              Icon(Icons.picture_as_pdf, size: 30, color: Colors.blueAccent),
              SizedBox(height: 5),
              Text('5', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('PDFs'),
            ],
          ),
          Column(
            children: [
              Icon(Icons.question_answer, size: 30, color: Colors.blueAccent),
              SizedBox(height: 5),
              Text('50', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('MCQs'),
            ],
          ),
        ],
      ),
      SizedBox(height: 20),
      Text(
        'Total Study Time: 30 hours',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
        ),
      ),
      SizedBox(height: 10),
      Text(
        'Avg Time/Day: 2 hours',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
        ),
      ),
    ],
  ),
),

                        ],
                      ),
                    ),
                  )
                ],
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
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorPage.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      color: Color.fromARGB(255, 192, 191, 191),
                      offset: Offset(0, 0))
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: SfCalendar(
                cellBorderColor: Colors.transparent,
                showCurrentTimeIndicator: true,

                viewHeaderHeight: 40,
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: FontFamily.font6,
                ),

                // allowDragAndDrop: false,
                // allowViewNavigation: true,
                // backgroundColor: Color.fromARGB(255, 243, 245, 251),
                headerStyle: CalendarHeaderStyle(
                    backgroundColor: ColorPage.colorbutton,
                    textAlign: TextAlign.center,
                    textStyle: FontFamily.font3),
                // showTodayButton: true,
                view: CalendarView.month,

                monthViewSettings: MonthViewSettings(
                  monthCellStyle: MonthCellStyle(),
                  agendaStyle: AgendaStyle(
                      dateTextStyle: FontFamily.font3.copyWith(
                        color: ColorPage.appbarcolor,
                      ),
                      placeholderTextStyle: TextStyle(color: Colors.red)),
                  showAgenda: true,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
