import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/API/ALL_FUTURE_FUNTIONS/all_functions.dart';
import 'package:dthlms/API/PACKAGE_API/packageapi.dart';
import 'package:dthlms/PC/HOMEPAGE/homepage.dart';
import 'package:dthlms/PC/MCQ/PRACTICE/termandcondition.dart';
import 'package:dthlms/THEME_DATA/FontSize/FontSize.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:dthlms/THEORY_EXAM/theoryexampage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PackageDetailsPage extends StatefulWidget {
  final String token;
  final String packageName;
  final int packageId;

  PackageDetailsPage(this.packageName, this.token, this.packageId, {super.key});

  @override
  State<PackageDetailsPage> createState() => _PackageDetailsPageState();
}

class _PackageDetailsPageState extends State<PackageDetailsPage> {
  Getx getx = Get.put(Getx());
  int selectedIndex = -1;
  // State variable for sidebar collapse

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      packagedetails(context, widget.token, widget.packageId);
    });
    super.initState();
  }

  void toggleSidebar() {
    getx.isCollapsed.value = !getx.isCollapsed.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getx.isCollapsed.value
                ? Container(width: 0) // Hidden sidebar
                : Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 20, bottom: 20),
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
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        getx.isCollapsed.value
                            ? IconButton(
                                icon: Icon(Icons.list),
                                onPressed: toggleSidebar,
                              )
                            : SizedBox(),
                      ],
                    ),
                    Obx(() => Expanded(
                        child: !getx.isVideoDashBoard.value
                            ? DashBoardRight()
                            : VideoDashboardRight())), // Main content area
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoDashboardRight extends StatefulWidget {
  const VideoDashboardRight({super.key});

  @override
  State<VideoDashboardRight> createState() => _VideoDashboardRightState();
}

class _VideoDashboardRightState extends State<VideoDashboardRight> {
  @override
  void initState() {
    getListStructure().whenComplete(() {
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  Future getListStructure() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    getx.isFolderview.value = prefs.getBool("folderview")!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Obx(
        () => Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: FilePathWidget(path: [
                          'C:',
                          'Users',
                          'Username',
                          'Documents',
                          'Project',
                          'File.txt'
                        ]),
                      ),

                       Padding(
                         padding: const EdgeInsets.only(right: 20),
                         child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: 300,
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search,),
                              suffixIconColor: Color.fromARGB(255, 103, 103, 103),
                                hintText: 'Search',
                                hintStyle:FontFamily.font9.copyWith(color: ColorPage.brownshade),
                                fillColor: Color.fromARGB(255, 237, 237, 238),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(40))),
                          ),
                                               ),
                       ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contents",
                    style: FontFamily.font,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 38,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            child: MaterialButton(
                              
                              shape: Border.all(
                                  color: !getx.isFolderview.value
                                      ? ColorPage.colorblack
                                      : Colors.transparent,
                                  width: 2),
                              color: getx.isFolderview.value
                                  ? ColorPage.colorbutton
                                  : Color.fromARGB(255, 255, 255, 255),
                              height: 20,
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool("folderview", true);

                                getx.isFolderview.value = true;
                              },
                              child: Text(
                                "Folder view",
                                style: FontFamily.font4.copyWith(
                                    color: getx.isFolderview.value
                                        ? ColorPage.white
                                        : ColorPage.colorblack),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 38,
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: MaterialButton(
                              shape: Border.all(
                                  color: getx.isFolderview.value
                                      ? ColorPage.colorblack
                                      : Colors.transparent,
                                  width: 2),
                              color: !getx.isFolderview.value
                                  ? ColorPage.colorbutton
                                  : Color.fromARGB(255, 255, 255, 255),
                              height: 20,
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool("folderview", false);
                                getx.isFolderview.value = false;
                              },
                              child: Text(
                                "List view",
                                style: FontFamily.font4.copyWith(
                                    color: !getx.isFolderview.value
                                        ? ColorPage.white
                                        : ColorPage.colorblack),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: getx.isFolderview.value?7:9,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Color.fromARGB(255, 192, 191, 191),
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: getx.isFolderview.value
                      ? Container(
                          padding: EdgeInsets.all(10),
                          child: GridView.builder(
                            itemCount: 100,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/folder.png",
                                      scale: 5,
                                    ),
                                    AutoSizeText(
                                      "Folder Name",
                                      overflow: TextOverflow.ellipsis,
                                      style: FontFamily.font9.copyWith(
                                          color: ColorPage.colorblack),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(10),
                          child: ListView.builder(
                            itemCount: 100,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color:
                                            Color.fromARGB(255, 192, 191, 191),
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: ListTile(
                                      leading: Image.asset(
                                        "assets/folder.png",
                                        width: 30,
                                      ),
                                      title: Text("Folder no - ${index + 1}",
                                          style: FontFamily.font9.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: ColorPage.colorblack)),
                                    ),
                                  ));
                            },
                          ),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Text(
                    "Videos",
                    style: FontFamily.font,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 11,
              child: Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color.fromARGB(255, 192, 191, 191),
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 3,
                                    color: Color.fromARGB(255, 192, 191, 191),
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                child: ListTile(
                                  subtitle: Text(
                                    "This in New Video",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Image.asset(
                                    "assets/video2.png",
                                    width: 25,
                                  ),
                                  title: Text("Videos no - ${index + 1}",
                                      style: FontFamily.font4.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  trailing: Text("25:30 min"),
                                ),
                              ));
                        }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilePathWidget extends StatelessWidget {
  final List<String> path;

  FilePathWidget({required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        // spacing: 1.0,
        children: path.map((part) {
          return GestureDetector(
            onTap: () {
              // Implement onTap functionality if needed
              print('Tapped on: $part');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  part,
                  style: TextStyle(
                    color: ColorPage.colorblack,
                  ),
                ),
                if (part != path.last)
                  Text(' > ',
                      style: TextStyle(
                        color: Colors.grey,
                      )),
              ],
            ),
          );
        }).toList(),
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
    Colors.orange.shade900,
    Colors.pink,
    Colors.deepPurple,
    Colors.indigo,
    Colors.yellow,
    Colors.green.shade900,
    Colors.red,
    Colors.green,
  ];
  int hoverIndex = -1;

  int colorchoose() {
    return Random().nextInt(9);
  }

  String pagename = '';

  paging(String pageName) {
    switch (pageName) {
      case 'Videos':
        getx.isVideoDashBoard.value = true;
        break;
      case 'Live':
        getx.isVideoDashBoard.value = false;
        break;
      case 'VideosBackup':
        getx.isVideoDashBoard.value = false;
        break;
      case 'MCQ':
        getx.isVideoDashBoard.value = false;
        break;
      case 'Book':
        getx.isVideoDashBoard.value = false;
        break;

      case "Theory":
        getx.isVideoDashBoard.value = false;
        Get.toNamed("/Theoryexampage");
        break;
      default:
        print("null");
    }
  }

  @override
  void initState() {
    paging(pagename);
    super.initState();
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
              borderRadius: BorderRadius.circular(7),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {Get.back();}, icon: Icon(Icons.arrow_back)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AutoSizeText(
                                widget.headname,
                                style: FontFamily.font.copyWith(fontSize: 17),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  getx.isCollapsed.value =
                                      !getx.isCollapsed.value;
                                },
                                icon: Icon(Icons.close))
                          ],
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
                                paging(entry.key);
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
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
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
                        onTap: () {
                          Get.toNamed("/Mockmcqtermandcondition");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              color: ColorPage.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: ListTile(
                                title: Text(
                                  "Mock Test",
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
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
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
