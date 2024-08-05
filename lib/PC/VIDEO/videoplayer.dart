// import 'package:dthlms/Master/scrollbarhide.dart';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dthlms/API/ALL_FUTURE_FUNTIONS/all_functions.dart';
import 'package:dthlms/PC/PACKAGEDETAILS/packagedetails.dart';
import 'package:dthlms/PC/VIDEO/ClsVideoPlay.dart';
import 'package:dthlms/PC/VIDEO/scrollbarhide.dart';
import 'package:dthlms/THEME_DATA/FontSize/FontSize.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
// import 'package:dthlms/ThemeData/color/color.dart';
// import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:win32/win32.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  int selectedIndex = -1;
  Getx getx = Get.put(Getx());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: !getx.isIconSideBarVisible.value
              ? IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                    getx.isIconSideBarVisible.value = true;
                  })
              : IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  }),
          elevation: 0,
          shadowColor: Colors.grey,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: FilePathWidget(path: [
            "Moinak",
            getx.path1.value,
            getx.path2.value,
            getx.path3.value,
          ]),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                      suffixIconColor: Color.fromARGB(255, 103, 103, 103),
                      hintText: 'Search',
                      hintStyle: FontFamily.font9
                          .copyWith(color: ColorPage.brownshade),
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
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getx.isIconSideBarVisible.value
                ? Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: IconSidebar(
                        selecteIndex: -1,
                      ),
                    ),
                  ) // Hidden sidebar
                : Container(width: 0),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 143, 141, 141),
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: VideoPlayerLeft()),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 143, 141, 141),
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: VideoPlayerRight()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class VideoPlayerRight extends StatefulWidget {
  const VideoPlayerRight({super.key});

  @override
  State<VideoPlayerRight> createState() => _VideoPlayerRightState();
}

class _VideoPlayerRightState extends State<VideoPlayerRight> {
  late final player = Player();
  late final controller = VideoController(player);
  final List<double> speeds = [0.5, 1.0, 1.5, 2.0];
  double selectedSpeed = 1.0;
  late VideoPlayClass videoPlay;
  bool isPlaying = false;

  @override
  void initState() {
    videoPlay = VideoPlayClass();
    videoPlay.player.stream.playing.listen((bool playing) {
      if (mounted) {
        setState(() {
          isPlaying = playing;
          if (playing) {
            videoPlay.startTrackingPlayTime();
          } else {
            videoPlay.stopTrackingPlayTime();
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.filled(
                        tooltip: 'Previous',
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorPage.colorbutton)),
                        onPressed: () {},
                        icon: Icon(
                          Icons.fast_rewind,
                        )),
                  ),
                  isPlaying
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton.filled(
                              tooltip: 'Pause',
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorPage.colorbutton)),
                              onPressed: () {
                                setState(() {
                                  videoPlay.pauseVideo();
                                });
                              },
                              icon: Icon(
                                Icons.pause,
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton.filled(
                              tooltip: 'Play',
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      ColorPage.colorbutton)),
                              onPressed: () {
                                setState(() {
                                  videoPlay.playVideo();
                                });
                              },
                              icon: Icon(
                                Icons.play_arrow,
                              )),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.filled(
                        tooltip: 'Next',
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorPage.colorbutton)),
                        onPressed: () {},
                        icon: Icon(
                          Icons.fast_forward,
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.filled(
                        tooltip: 'Tag',
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorPage.colorbutton)),
                        onPressed: () {
                          // showDialog(
                          //     barrierDismissible: false,
                          //     context: context,
                          //     builder: (context) {
                          //       return AlertDialog(
                          //         shadowColor: ColorPage.white,
                          //         backgroundColor: ColorPage.white,
                          //         surfaceTintColor: ColorPage.white,
                          //         content: Card(
                          //           child: SizedBox(
                          //               width: 200,
                          //               child: TextFormField(
                          //                 decoration: InputDecoration(
                          //                     border: OutlineInputBorder(),
                          //                     hintText: 'Typing something...'),
                          //                 maxLines: 5,
                          //               )),
                          //         ),
                          //         title: Text(
                          //           'Write your tag',
                          //           style: FontFamily.font,
                          //         ),
                          //         actions: [
                          //           ClipRRect(
                          //                borderRadius: BorderRadius.all(Radius.circular(10)),
                          //             child: ElevatedButton(
                          //               onPressed: () {
                          //                 Get.back();
                          //               },
                          //               child: Text(
                          //                 'Cancel',
                          //                 style: FontFamily.font3,
                          //               ),
                          //               style: ButtonStyle(
                          //                   backgroundColor:
                          //                       MaterialStatePropertyAll(
                          //                           ColorPage.red),
                          //                   shape: MaterialStatePropertyAll(
                          //                       ContinuousRectangleBorder())),
                          //             ),
                          //           ),
                          //           ClipRRect(
                          //             borderRadius: BorderRadius.all(Radius.circular(10)),
                          //             child: ElevatedButton(
                          //               onPressed: () {
                          //                 Get.back();
                          //               },
                          //               child: Text(
                          //                 ' Save ',
                          //                 style: FontFamily.font3,
                          //               ),
                          //               style: ButtonStyle(
                          //                   backgroundColor:
                          //                       MaterialStatePropertyAll(
                          //                           ColorPage.colorbutton),
                          //                   shape: MaterialStatePropertyAll(
                          //                       ContinuousRectangleBorder())),
                          //             ),
                          //           )
                          //         ],
                          //       );
                          //     });



                          addTage(context);
                        },
                        icon: Icon(
                          Icons.edit_note,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.filled(
                        tooltip: 'Speed',
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorPage.colorbutton)),
                        onPressed: () {
                          showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(10, 118, 0, 10),
                              items: speeds.map((speed) {
                                return PopupMenuItem<double>(
                                  value: speed,
                                  child: Row(
                                    children: [
                                      Radio<double>(
                                        value: speed,
                                        groupValue: selectedSpeed,
                                        onChanged: (double? value) {
                                          setState(() {
                                            selectedSpeed = value!;
                                            videoPlay.player
                                                .setRate(selectedSpeed);
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                      Text('${speed}x'),
                                    ],
                                  ),
                                );
                              }).toList());
                        },
                        icon: Icon(Icons.slow_motion_video)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton.filled(
                        tooltip: 'GOTO',
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                ColorPage.colorbutton)),
                        onPressed: () {},
                        icon: Icon(Icons.drag_indicator)),
                  )
                ],
              ),
            ],
          ),
          Card(
            surfaceTintColor: Colors.white,
            color: Colors.white,
            elevation: 0.0,
            child: MaterialDesktopVideoControlsTheme(
              normal: MaterialDesktopVideoControlsThemeData(
                controlsHoverDuration: Duration(seconds: 5),
                primaryButtonBar: [
                  MaterialDesktopSkipPreviousButton(
                    iconSize: 80,
                    iconColor: ColorPage.red,
                  ),
                  MaterialDesktopPlayOrPauseButton(
                    iconSize: 80,
                  ),
                ],
                seekBarThumbColor: ColorPage.colorbutton,
                seekBarPositionColor: ColorPage.colorbutton,
                toggleFullscreenOnDoublePress: false,
              ),
              fullscreen: MaterialDesktopVideoControlsThemeData(),
              child: Container(
                height: getx.isIconSideBarVisible.value ? 445 : 485,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                padding: EdgeInsets.only(bottom: 40),
                child: Video(controller: videoPlay.controller),
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Future permission() async {
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      if ((info.version.sdkInt) >= 33) {
      } else {}
    } else {}
  }

    addTage(context) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: true,
      alertPadding: EdgeInsets.only(top: 200),
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.grey),
      ),
      titleStyle: TextStyle(color: ColorPage.blue, fontWeight: FontWeight.bold),
      constraints: BoxConstraints.expand(width: 350),
      overlayColor: Color(0x55000000),
      alertElevation: 0,
      alertAlignment: Alignment.center,
    );

    Alert(
      context: context,
      style: alertStyle,
      title: "Contribute your won tag",
      content: Form(
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('Write your tag here.....',
                      style: FontFamily.font.copyWith(fontSize: ClsFontsize.ExtraSmall)),
                ),
              ],
            ),
            Card(
                                    child: SizedBox(
                                     
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Typing something...'),
                                          maxLines: 5,
                                        )),
                                  ),
           
          ],
        ),
      ),
      buttons: [
        DialogButton(
        
          child:
              Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 15)),
          onPressed: () {
            Get.back()
           ;
          },
          color: ColorPage.red,
          radius: BorderRadius.circular(5.0),
        ),

        DialogButton(
        
          child:
              Text("Save", style: TextStyle(color: Colors.white, fontSize: 15)),
          onPressed: () {
            Get.back();
           
          },
          color: ColorPage.colorbutton,
          radius: BorderRadius.circular(5.0),
        ),
      ],
    ).show();
  }

}

class Pdf extends StatelessWidget {
  const Pdf({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: SfPdfViewer.network(
          'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf'),
    );
  }
}

class Mcq extends StatelessWidget {
  const Mcq({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
    );
  }
}

class IconSidebar extends StatefulWidget {
  int? selecteIndex;
  IconSidebar({super.key, required this.selecteIndex});

  @override
  State<IconSidebar> createState() => _IconSidebarState();
}

class _IconSidebarState extends State<IconSidebar> {
  int hoverIndex = -1;

  String intToAscii(int value) {
    if (value < 0 || value > 127) {
      throw ArgumentError('Value must be between 0 and 127');
    }
    return String.fromCharCode(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // var entriesList = getx.packagedetailsfoldername.entries.toList();
          Container(
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
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 5),
                          child: Text(
                            "Chapters",
                            style: FontFamily.font9.copyWith(
                                color: ColorPage.colorblack,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            getx.isIconSideBarVisible.value = false;
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, top: 5),
                            child: Icon(
                              Icons.close,
                              size: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.selecteIndex = index;
                              });
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
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
                                onTap: () {
                                  setState(() {
                                    widget.selecteIndex = index;
                                  });
                                },
                                onDoubleTap: () {
                                  getx.path2.value =
                                      "chapter-" + intToAscii(65 + index);
                                  getx.path3.value = "";
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: hoverIndex == index ||
                                            widget.selecteIndex == index
                                        ? ColorPage.colorbutton
                                        : Colors.transparent,
                                    // border: Border.all(
                                    //     width: 1,
                                    //     color:
                                    //         Color.fromARGB(255, 126, 124, 124)),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/folder.png",
                                        scale: 12,
                                        fit: BoxFit.contain,
                                      ),
                                      Text(
                                        "chapter-" + intToAscii(65 + index),
                                        style: FontFamily.font8.copyWith(
                                          fontSize: 10,
                                          color: hoverIndex == index ||
                                                  widget.selecteIndex == index
                                              ? ColorPage.white
                                              : ColorPage.colorblack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}

class VideoPlayerLeft extends StatefulWidget {
  VideoPlayerLeft({super.key});

  @override
  State<VideoPlayerLeft> createState() => _VideoPlayerLeftState();
}

class _VideoPlayerLeftState extends State<VideoPlayerLeft> {
  var color = Color.fromARGB(255, 102, 112, 133);
  List<Widget> page = [Pdf(), Mcq(), Container(), Container()];

  int flag = 2;
  int selectedIndex = 0;
  int selectedListIndex = -1; // Track the selected list tile
  List<double> downloadProgress =
      List.filled(20, 0.0); // Track download progress for each item

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ScrollConfiguration(
      behavior: HideScrollbarBehavior(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
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
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Videos",
                            style: FontFamily.font
                                .copyWith(color: ColorPage.colorbutton),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: MaterialButton(
                              color: ColorPage.colorbutton,
                              height: 35,
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons.download,size: 15,color: ColorPage.white,),
                                  Text(
                                    " All",
                                    style: FontFamily.font9,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            shape: LinearBorder(),
                            backgroundColor: selectedListIndex == index
                                ? ColorPage.white.withOpacity(0.5)
                                : Color.fromARGB(255, 255, 255, 255),
                            onExpansionChanged: (isExpanded) {
                              setState(() {
                                selectedListIndex = isExpanded ? index : -1;
                              });
                            },
                            leading: Image.asset(
                              "assets/video2.png",
                              scale: 19,
                              color: ColorPage.colorbutton,
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  'Duration: 3:04',
                                  style: TextStyle(
                                    color: ColorPage.grey,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              'This is DTHLMS Video no - ${index + 1}.mp4',
                              style: GoogleFonts.inter().copyWith(
                                fontWeight: FontWeight.w800,
                                overflow: TextOverflow.ellipsis,
                                fontSize:
                                    selectedListIndex == index ? 20 : null,
                              ),
                            ),
                            trailing: SizedBox(
                              width: 130,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (downloadProgress[index] == 0)
                                    IconButton(
                                      onPressed: () {
                                        startDownload(index);
                                      },
                                      icon: Icon(
                                        Icons.download,
                                        color: ColorPage.colorbutton,
                                      ),
                                    )
                                  else if (downloadProgress[index] < 100)
                                    CircularPercentIndicator(
                                      radius: 15.0,
                                      lineWidth: 4.0,
                                      percent: downloadProgress[index] / 100,
                                      center: Text(
                                        "${downloadProgress[index].toInt()}%",
                                        style: TextStyle(fontSize: 10.0),
                                      ),
                                      progressColor: ColorPage.colorbutton,
                                    )
                                  else
                                    IconButton(
                                      onPressed: () {
                                        getx.path3.value =
                                            'Dthlms Video no- ${index + 1}.mp4';
                                      },
                                      icon: Icon(
                                        Icons.play_circle,
                                        color: ColorPage.colorbutton,
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      selectedListIndex == index
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down_outlined,
                                      color: ColorPage.colorbutton,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(255, 243, 240, 240),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          tabbarbutton('PDF', 0),
                                          tabbarbutton('MCQ', 1),
                                          tabbarbutton('TAG', 2),
                                          tabbarbutton('Ask doubt', 3),
                                          IconButton(
                                            tooltip: 'Delete this video',
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.delete_forever,
                                              color: Color.fromARGB(
                                                  255, 253, 29, 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 800, // Fixed height for content
                                        child: SingleChildScrollView(
                                          child: page[selectedIndex],
                                        ),
                                      ),
                                    ],
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabbarbutton(String name, int tabIndex) {
    bool isActive = selectedIndex == tabIndex;
    Color backgroundColor = isActive ? ColorPage.colorbutton : Colors.white;
    Color textColor = isActive ? Colors.white : Colors.black;

    return Expanded(
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            // hoverIndex = tabIndex;
          });
        },
        onExit: (_) {
          setState(() {
            // hoverIndex = -1;
          });
        },
        child: InkWell(
          onTap: () {
            setState(() {
              selectedIndex = tabIndex;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                color: backgroundColor,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startDownload(int index) {
    setState(() {
      downloadProgress[index] = 0;
    });

    const duration = Duration(milliseconds: 30);
    const totalSteps = 100;
    for (int i = 1; i <= totalSteps; i++) {
      Future.delayed(duration * i, () {
        setState(() {
          downloadProgress[index] = i.toDouble();
        });
      });
    }
  }
}

// Dummy widgets for Pdf() and Mcq()
// class Pdf extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class Mcq extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// Dummy class for ColorPage
// class ColorPage {
//   static const white = Colors.white;
//   static const colorbutton = Colors.blue;
//   static const grey = Colors.grey;
// }

// // Dummy class for FontFamily
// class FontFamily {
//   static const font = TextStyle();
//   static const font8 = TextStyle();
// }

// Dummy class for HideScrollbarBehavior
class HideScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

// Dummy class for LinearBorder
class LinearBorder extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return LinearBorder();
  }
}
