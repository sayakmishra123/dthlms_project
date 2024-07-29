import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/Master/mainmobile/mainnewpackagemobiledashboard.dart';
import 'package:dthlms/Master/mainmobile/mobilevideoplayer.dart';
import 'package:dthlms/Master/videoplayer.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DthDashboard extends StatefulWidget {
  const DthDashboard({super.key});

  @override
  State<DthDashboard> createState() => _DthDashboardState();
}

class _DthDashboardState extends State<DthDashboard> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: SlideBar(
                  selectedIndex: selectedIndex,
                  onItemSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              )),
          Expanded(
              flex: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: DashBoardRight(),
              ))
        ],
      ),
    );
  }
}

class SlideBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SlideBar(
      {super.key, required this.selectedIndex, required this.onItemSelected});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: Column(
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
              Visibility(
                visible: Platform.isWindows,
                child: InkWell(
                  onTap: () {
                    widget.onItemSelected(-1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        color: widget.selectedIndex == -1
                            ? ColorPage.colorbutton
                            : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(
                            Icons.home,
                            color: widget.selectedIndex == -1
                                ? Colors.white
                                : Colors.black,
                          ),
                          title: Text(
                            'Dashboard',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: widget.selectedIndex == -1
                                    ? Colors.white
                                    : Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              for (int i = 0; i < 5; i++)
                buttonWidget(
                  'Package ${i + 1}',
                  () {
                    widget.onItemSelected(i);
                   Platform.isWindows?  Get.to(() => VideoPlayer()): Get.to(() => VideoPlayerMobile());
                  },
                  widget.selectedIndex == i,
                  hoverIndex == i,
                  i,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonWidget(
      String name, void Function()? onTap, bool isActive, bool isHover, int i) {
    Color backgroundColor =
        isActive || isHover ? ColorPage.colorbutton : Colors.white;
    Color textColor = isActive || isHover ? Colors.white : Colors.black;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hoverIndex = i;
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
           HeadingBox(date: 'May 29,2024', title:  'Welcome back, Reet!', desc: 'Always updated in your portal', trailing: learningGoalButton()   ),
           
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
            CalenderWidget(),
            
          ],
        ),
      ),
    );
  }


  Widget learningGoalButton(){
    return Padding(
                            padding: const EdgeInsets.only(
                                right: 50, top: 10, bottom: 10),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: MaterialButton(
                                hoverColor: Color.fromARGB(255, 237, 235, 246),
                                onPressed: () {
                                  learningGoals(context);
                                
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
                          );
  }
}


class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    return 
       Container(
             height: MediaQuery.of(context).size.height/1.5,
              margin: EdgeInsets.symmetric(vertical: 15),
              padding: EdgeInsets.only(left:  5,right: 5,top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  dayTextStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                headerStyle: CalendarHeaderStyle(
                    backgroundColor: ColorPage.colorbutton,
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(color: Colors.white)),
                view: CalendarView.month,
                monthViewSettings: MonthViewSettings(
                  agendaViewHeight: 60,
                  showTrailingAndLeadingDates: true,
                  monthCellStyle: MonthCellStyle(),
                  agendaStyle: AgendaStyle(
                      dateTextStyle: TextStyle(
                        color: Colors.black,
                      ),
                      placeholderTextStyle: TextStyle(color: Colors.red)),
                  showAgenda: true,
                ),
              ),
            
    );
  }
}


class HeadingBox extends StatelessWidget {

 final String date;
  final String title;
  final String desc;
  final Widget trailing;
  const HeadingBox({ super.key, required this.date,required this.title,required this.desc,required this.trailing,});

  @override
  Widget build(BuildContext context) {
    return   Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                                   date,
                                      style: FontFamily.font2,
                                      // textScaler: TextScaler.linear(2),
                                    ),
                                  ),
                                  Flexible(
                                    child: AutoSizeText(
                                      title,
                                      textScaleFactor: 1.5,
                                      style: FontFamily.font2,
                                      // textScaler: TextScaler.linear(1.5),
                                    ),
                                  ),
                                  Flexible(
                                    child: AutoSizeText(
                                    desc,
                                      style: FontFamily.font3,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                       trailing,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
           ;
  }
}