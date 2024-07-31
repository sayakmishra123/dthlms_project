import 'dart:io';
import 'dart:math';

// import 'package:dthlms/Master/dashboard.dart';
import 'package:dthlms/API/PACKAGE_API/packageapi.dart';
import 'package:dthlms/PC/HOMEPAGE/homepage.dart';
import 'package:dthlms/PC/MCQ/PRACTICE/termandcondition.dart';
// import 'package:dthlms/PC/MCQ/practiceMCQtermandcondition.dart.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
// import 'package:dthlms/ThemeData/color/color.dart';
// import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageDetailsPage extends StatefulWidget {
  String token;
  String packageName;
  int packageId;
  PackageDetailsPage(this.packageName, this.token, this.packageId, {super.key});

  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  Getx getx = Get.put(Getx());
  // final token = Get.arguments['token'];
  int selectedIndex = -1;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      packagedetails(context, widget.token, widget.packageId);
    });
    // TODO: implement initState
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
              child: SlideBarPackageDetails(
                selectedIndex: selectedIndex,
                headname: widget.packageName,
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

class SlideBarPackageDetails extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final String headname;

  const SlideBarPackageDetails({
    super.key,
    required this.headname,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<SlideBarPackageDetails> createState() => _SlideBarPackageDetailsState();
}

class _SlideBarPackageDetailsState extends State<SlideBarPackageDetails> {
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
  int hoverIndex = -1;

  int colorchoose() {
    return Random().nextInt(9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          var entriesList = getx.packagedetailsfoldername.entries.toList();
          return Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorPage.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Color.fromARGB(255, 192, 191, 191),
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: getx.packagedetailsfoldername.isNotEmpty
                ? SingleChildScrollView(
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: entriesList.length,
                          itemBuilder: (context, index) {
                            var entry = entriesList[index];
                            return buttonWidget(
                              entry.value,
                              () {
                                widget.onItemSelected(index);
                              },
                              widget.selectedIndex == index,
                              hoverIndex == index,
                              index,
                              entry.key,
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Container(),
          );
        },
      ),
    );
  }

  Widget buttonWidget(
    bool folder,
    void Function()? onTap,
    bool isActive,
    bool isHover,
    int index,
    String foldername,
  ) {
    Color backgroundColor =
        isActive || isHover ? ColorPage.colorbutton : Colors.white;
    Color textColor = isActive || isHover ? Colors.white : Colors.black;
    Color mcqtextColor = Colors.black;

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
      child: foldername == "MCQ"
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey),
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ExpansionTile(
                    iconColor: ColorPage.white,
                    leading: Icon(
                          Icons.folder,
                          color: colors[colorchoose()],
                        ),
                    collapsedIconColor: ColorPage.white,
                    
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    shape: Border.all(color: Colors.transparent),
                    title: Text(
                      foldername,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: textColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed("/Practicetermandcondition");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5, color: Colors.grey),
                              color: ColorPage.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: ListTile(
                                
                                title: Text(
                                  "Practice",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: mcqtextColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                       InkWell(
                        onTap: () {Get.toNamed("/Mockmcqtermandcondition");
                        },
                         child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5, color: Colors.grey),
                              color: ColorPage.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: ListTile(
                                
                                title: Text(
                                  "Moct Test",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: mcqtextColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                                               ),
                       ),
                       InkWell(
                        onTap: () {
                          Get.toNamed("/Examtermandcondition");
                        },
                         child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5, color: Colors.grey),
                              color: ColorPage.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: ListTile(
                                
                                title: Text(
                                  "Exam",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: mcqtextColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                                               ),
                       ),
                    ],
                  )),
            )
          : InkWell(
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
                      title: Text(
                        foldername,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: textColor),
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
