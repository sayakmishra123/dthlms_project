import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dthlms/API/PACKAGE_API/packageapi.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';

import 'package:dthlms/PC/PACKAGEDETAILS/packagedetails.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// import '../getx/getxcontroller.getx.dart';

class DthDashboard extends StatefulWidget {
  const DthDashboard({super.key});

  @override
  State<DthDashboard> createState() => _DthDashboardState();
}

class _DthDashboardState extends State<DthDashboard> {
  Getx getx = Get.put(Getx());
  int selectedIndex = -1;
  final token = Get.arguments['token'];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      allPackage(token, context);
    });
    super.initState();
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: DashboardSlideBar(
                selectedIndex: selectedIndex,
                headname: 'DTH LMS',
                onItemSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
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

class DashboardSlideBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final String headname;
  const DashboardSlideBar({
    super.key,
    required this.headname,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<DashboardSlideBar> createState() => _DashboardSlideBarState();
}

class _DashboardSlideBarState extends State<DashboardSlideBar> {
  Getx getx = Get.find<Getx>();
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
  int colorchoose() {
    return Random().nextInt(9);
  }

  final token = Get.arguments['token'];
  int hoverIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Container(
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
                    widget.headname,
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
                for (int i = 0; i < getx.package.length; i++)
                  buttonWidget(
                    getx.package[i].packageName,
                    () {
                      widget.onItemSelected(i);

                      Get.to(() => PackageDetailsPage(
                          getx.package[i].packageName,
                          token,
                          int.parse(getx.package[i].packageId)));
                    },
                    widget.selectedIndex == i,
                    hoverIndex == i,
                    i,
                  ),
              ],
            ),
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
                  color: colors[colorchoose()],
                ),
                // subtitle: Text(
                //   getx.package[index].,
                //   style:
                //       TextStyle(fontWeight: FontWeight.w100, color: textColor),
                //   overflow: TextOverflow.ellipsis,
                // ),
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
                      automaticallyImplyLeading:  true,
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
            HeadingBox(
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
                                  'Basic of tax class by Avinash Sureka',
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

  Widget learningGoalButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 50, top: 10, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: MaterialButton(
          hoverColor: Color.fromARGB(255, 237, 235, 246),
          onPressed: () {},
          color: ColorPage.white,
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            child: Text(
              "Learning Goal",
              style: FontFamily.font2.copyWith(
                  color: ColorPage.colorbutton, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 1.9,
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.only(left: 5, right: 5, top: 20),
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


class HeadingBox extends StatefulWidget {


  @override
  State<HeadingBox> createState() => _HeadingBoxState();
}

class _HeadingBoxState extends State<HeadingBox> {
  final List<Widget> contentList = [
    HeadingBoxContent(
        date: "May 29,2024",
        title: 'Welcome back, Reet!',
        desc: 'Always updated in your portal',
        isImage: false,
        imagePath: '',
        trailing:SizedBox()),
         HeadingBoxContent(
        date: "May 29,2025",
        title: 'Welcome back, Reet!',
        desc: 'Always updated in your portal',
         imagePath: 'assets/no_data_found.jpg',
        trailing: SizedBox(),
        isImage: true,),
        
         HeadingBoxContent(
        date: "May 29,2026",
        title: 'Welcome back, Reet!',
        desc: 'Always updated in your portal',
        trailing: SizedBox(),
         imagePath: '',
        isImage: false,),
         HeadingBoxContent(
        date: "May 29,2027",
        title: 'Welcome back, Reet!',
        desc: 'Always updated in your portal',
        trailing: SizedBox(),
         imagePath: '',
        isImage: false,),
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width - 200,
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: CarouselSlider(
                items: contentList
                    .map((item) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ColorPage.colorbutton,
                                border: Border.all(
                                    color: ColorPage.white, width: 2)),
                            child: item,
                          ),
                        ))
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 0.98,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: contentList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: currentIndex == entry.key ? 18 : 10,
                  height: 7,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorPage.colorbutton),
                      borderRadius: BorderRadius.circular(20),
                      color: currentIndex == entry.key
                          ? ColorPage.blue
                          : ColorPage.white),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class HeadingBoxContent extends StatelessWidget {
  final String? date;
  final String? title;
  final String? desc;
  final Widget? trailing;
  final String imagePath;
  final bool isImage;
  const HeadingBoxContent({
    super.key,
   this.date,
     this.title,
   this.desc,
   this.trailing,
    required this.isImage,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return  isImage?Container(
   
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                         
                                            
                                          image: DecorationImage(
                                            image: AssetImage(
                                           imagePath,
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                    ): Row(
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
                    date!,
                    style: FontFamily.font2,
                    // textScaler: TextScaler.linear(2),
                  ),
                ),
                Flexible(
                  child: AutoSizeText(
                    title!,
                    textScaleFactor: 1.5,
                    style: FontFamily.font2,
                    // textScaler: TextScaler.linear(1.5),
                  ),
                ),
                Flexible(
                  child: AutoSizeText(
                    desc!,
                    style: FontFamily.font3,
                  ),
                )
              ],
            ),
          ),
        ),
        trailing!,
      ],
    );
  }
}


