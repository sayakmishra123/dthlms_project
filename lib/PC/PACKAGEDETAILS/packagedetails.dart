import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/API/PACKAGE_API/packageapi.dart';
import 'package:dthlms/PC/HOMEPAGE/homepage.dart';
import 'package:dthlms/PC/VIDEO/videoplayer.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
    getx.path2.value='';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      packagedetails(context, widget.token, widget.packageId);
    });
    super.initState();
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
                          const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
              child: Column(
                children: [
                  Obx(
                    () => Expanded(
                      child: getx.isVideoDashBoard.value
                          ? Padding(
                            padding: !getx.isCollapsed.value? EdgeInsets.only(top: 10 ,right: 10):EdgeInsets.all(0),
                            child: VideoDashboardVDRight(),
                          )
                          : getx.isLiveDashBoard.value
                              ? SizedBox()
                              : getx.isBookDashBoard.value
                                  ? SizedBox()
                                  : getx.isBackupDashBoard.value
                                      ? SizedBox()
                                      
                                          : DashBoardRight(token: widget.token,),
                    ),
                  ), // Main content area
                ],
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
        getx.isLiveDashBoard.value = false;
        getx.isTheoryDashBoard.value = false;
        getx.isBookDashBoard.value = false;
        getx.isMCQDashBoard.value = false;
        getx.isBackupDashBoard.value = false;
        getx.path1.value="Videos";
        
        break;
      case 'Live':
      getx.isVideoDashBoard.value = false;
         
        getx.isLiveDashBoard.value = true;
        getx.isTheoryDashBoard.value = false;
        getx.isBookDashBoard.value = false;
        getx.isMCQDashBoard.value = false;
        getx.isBackupDashBoard.value = false;
        break;
      case 'Backup':
        getx.isVideoDashBoard.value = false;
         
        getx.isLiveDashBoard.value = false;
        getx.isTheoryDashBoard.value = false;
        getx.isBookDashBoard.value = false;
        getx.isMCQDashBoard.value = false;
        getx.isBackupDashBoard.value = true;
        break;
      case 'MCQ':
        getx.isVideoDashBoard.value = false;
          
        getx.isLiveDashBoard.value = false;
        getx.isTheoryDashBoard.value = false;
        getx.isBookDashBoard.value = false;
        getx.isMCQDashBoard.value = true;
        getx.isBackupDashBoard.value = false;
        break;
      case 'Book':
        getx.isVideoDashBoard.value = false;
         
        getx.isLiveDashBoard.value = false;
        getx.isTheoryDashBoard.value = false;
        getx.isBookDashBoard.value = true;
        getx.isMCQDashBoard.value = false;
        getx.isBackupDashBoard.value = false;
        break;

      case "Theory":
        getx.isVideoDashBoard.value = false;
        getx.isLiveDashBoard.value = false;
         
        getx.isTheoryDashBoard.value = true;
        getx.isBookDashBoard.value = false;
        getx.isMCQDashBoard.value = false;
        getx.isBackupDashBoard.value = false;
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
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.arrow_back)),
                            Container(
                              width: 125,
                              padding:  EdgeInsets.all(8.0),
                              child: Text(
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

                      //  leading: Image.asset(
                      //             foldername== "Videos"
                      //                 ? "assets/video15.png"
                      //                 :foldername == "Live"
                      //                     ? "assets/live-channel.png"
                      //                     : foldername == "VideosBackup"
                      //                         ? "assets/video-backup.png"
                      //                         : foldername == "MCQ"
                      //                             ? "assets/choose2.png"
                      //                             : foldername == "Theory"
                      //                                 ? "assets/exam2.png"
                      //                                 : foldername == "Book"
                      //                                     ? "assets/book2.png"
                      //                                     : "assets/folder8.png",
                            
                      //             width: 25,
                      //           ),
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

class VideoListLeft extends StatefulWidget {
  VideoListLeft({
    super.key,
  });

  @override
  State<VideoListLeft> createState() => _VideoListLeftState();
}

class _VideoListLeftState extends State<VideoListLeft> {
  int lastTapVideoIndex = -1; // Track the last tapped item index
  DateTime lastTapvideoTime = DateTime.now();
  var color = Color.fromARGB(255, 102, 112, 133);
  Getx getx=Get.put(Getx())
; 

  int flag = 2;
  int selectedVideoIndex = -1;
  int selectedvideoListIndex = -1;

  void handleTap(int index) {
    DateTime now = DateTime.now();
    if (index == lastTapVideoIndex &&
        now.difference(lastTapvideoTime) < Duration(seconds: 1)) {
      print('Double tapped on folder: $index');
    }
    lastTapVideoIndex = index;
    lastTapvideoTime = now;
  } // Track the selected list tile

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return 
       
         Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorPage.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Color.fromARGB(255, 192, 191, 191),
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      Get.to(()=>VideoPlayer());
                  
                   
                      print("object find");
                    },
                    onTap: () {
                      setState(() {
                        selectedVideoIndex = index;
                      });
         
                      handleTap(index);
                    },
                    child: Card(
                      color: selectedVideoIndex == index
                          ? ColorPage.colorbutton.withOpacity(0.9)
                          : Color.fromARGB(255, 245, 243, 248),
                      child: ListTile(
                        leading: Image.asset("assets/video2.png",scale: 19,color: selectedVideoIndex == index?ColorPage.white.withOpacity(0.85):ColorPage.colorbutton ,),
                        subtitle: Text(
                          'Duration: 3:04',
                          style: TextStyle(
                            color: selectedVideoIndex == index
                                ? ColorPage.white.withOpacity(0.9)
                                : ColorPage.grey,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        title: Text(
                          'Dthlms Video no- ${index+1}.mp4',
                          style: GoogleFonts.inter().copyWith(
                            color: selectedVideoIndex == index
                                ? ColorPage.white
                                : ColorPage.colorblack,
                            fontWeight: FontWeight.w800,
                            fontSize:
                                selectedvideoListIndex == index ? 20 : null,
                            // color: selectedListIndex == index
                            //     ? Colors.amber[900]
                            //     : Colors.black,
                          ),
                        ),
                        trailing: SizedBox(
                    
                          child: IconButton(
                              onPressed: () {
                                 getx.path3.value=  'Dthlms Video no- ${index+1}.mp4';
                                
                                  Get.to(()=>VideoPlayer());},
                              icon: Icon(
                                Icons.play_circle,
                                color: selectedVideoIndex == index
                                    ? ColorPage.white
                                    : ColorPage.colorbutton,
                              )),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}

class VideoDashboardVDRight extends StatefulWidget {
  const VideoDashboardVDRight({super.key});

  @override
  State<VideoDashboardVDRight> createState() => _VideoDashboardVDRightState();
}

class _VideoDashboardVDRightState extends State<VideoDashboardVDRight> {
  int selectedIndex = -1; // Track the selected item index
  int lastTapIndex = -1; // Track the last tapped item index
  DateTime lastTapTime = DateTime.now(); 
  // Track the last tap time
  Getx getx=Get.put(Getx());

  @override
  void initState() {
    getListStructure().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  String intToAscii(int value) {
  if (value < 0 || value > 127) {
    throw ArgumentError('Value must be between 0 and 127');
  }
  return String.fromCharCode(value);
}

  Future getListStructure() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    getx.isFolderview.value = prefs.getBool("folderview")!;
    // getx.isFolderviewVideo.value = prefs.getBool("folderviewVideo")!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: !getx.isCollapsed.value? 5:0,),
      child: Obx(
        () => Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 7, ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          getx.isCollapsed.value
                              ? IconButton(
                                  icon: Icon(Icons.list),
                                  onPressed: () {
                                    getx.isCollapsed.value =
                                        !getx.isCollapsed.value;
                                  })
                              : SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: FilePathWidget(path: [
                             "Moinak",
                             getx.path1.value,
                              getx.path2.value,
                                getx.path3.value,
                              
                            ]),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          width: 300,
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              suffixIconColor:
                                  Color.fromARGB(255, 103, 103, 103),
                              hintText: 'Search',
                              hintStyle: FontFamily.font9
                                  .copyWith(color: ColorPage.brownshade),
                              fillColor: Color.fromARGB(255, 237, 237, 238),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Contents", style: FontFamily.font),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              Tooltip(
                                message: "Folder View",
                                child: IconButton(
                                  onPressed: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setBool("folderview", true);

                                    getx.isFolderview.value = true;
                                  },
                                  icon: Icon(
                                    Icons.grid_view_rounded,
                                    color: getx.isFolderview.value
                                        ? ColorPage.colorbutton
                                        : ColorPage.colorblack,
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: "List View",
                                child: IconButton(
                                  onPressed: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setBool("folderview", false);
                                    getx.isFolderview.value = false;
                                  },
                                  icon: Icon(
                                    Icons.view_list,
                                    color: !getx.isFolderview.value
                                        ? ColorPage.colorbutton
                                        : ColorPage.colorblack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text("Videos", style: FontFamily.font),
                      ),
                     
                      
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
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
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child:  getx.isFolderview.value
                      ? Container(
                          padding: EdgeInsets.all(10),
                          child: GridView.builder(
                            itemCount: 50,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: getx.isCollapsed.value?5:4,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                   setState(() {
                                                  selectedIndex = index;
                                                  getx.path2.value= "Chapter-"+intToAscii(65+index);
                                                  getx.path3.value='';

                                                });
                                                handleTap(index);

                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    padding: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5),),color: selectedIndex==index?ColorPage.blue.withOpacity(0.3):Colors.transparent ,),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/folder8.png",
                                          scale: 8,
                                        ),
                                        AutoSizeText(
                                          "Chapter-"+intToAscii(65+index),
                                          overflow: TextOverflow.ellipsis,
                                          style: FontFamily.font9.copyWith(
                                              color: ColorPage.colorblack),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ):
                                  
                                   Container(
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
                                                  color: Color.fromARGB(
                                                      255, 192, 191, 191),
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: selectedIndex == index
                                                  ? ColorPage.colorbutton
                                                  : ColorPage.white,
                                            ),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  selectedIndex = index;
                                                       getx.path2.value= "Chapter-"+intToAscii(65+index);
                                                  getx.path3.value='';
                                                });
                                                handleTap(index);
                                              },
                                              child: ListTile(
                                                leading: Image.asset(
                                                  "assets/folder8.png",
                                                  width: 30,
                                                ),
                                                trailing: Icon(
                                                  Icons.arrow_forward_ios_sharp,
                                                  size: 20,
                                                  color: selectedIndex == index
                                                      ? ColorPage.white
                                                      : ColorPage.colorblack,
                                                ),
                                                title: Text(
                                                  "Chapter-"+intToAscii(65+index),
                                                  style:
                                                      FontFamily.font9.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: selectedIndex ==
                                                            index
                                                        ? ColorPage.white
                                                        : ColorPage.colorblack,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 11,
                    child: Padding(
                      padding:  EdgeInsets.only(top: 7,right: getx.isCollapsed.value?10:0),
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
                        child: VideoListLeft(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleTap(int index) {
    DateTime now = DateTime.now();
    if (index == lastTapIndex &&
        now.difference(lastTapTime) < Duration(seconds: 1)) {
      print('Double tapped on folder: $index');
    }
    lastTapIndex = index;
    lastTapTime = now;
  }
}
