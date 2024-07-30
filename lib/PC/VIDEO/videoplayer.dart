// import 'package:dthlms/Master/scrollbarhide.dart';
import 'package:dthlms/PC/VIDEO/scrollbarhide.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
// import 'package:dthlms/ThemeData/color/color.dart';
// import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:win32/win32.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          'Abc > Xyz > Chapter1',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.download,
                color: Colors.white,
              ),
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                backgroundColor:
                    MaterialStatePropertyAll(Color.fromARGB(255, 2, 126, 228)),
                // shape: ContinuousRectangleBorder(
                //   borderRadius: BorderRadius.circular(20),
                // ),
                // padding: EdgeInsets.all(15),
                // color: Color.fromARGB(255, 2, 126, 228),
              ),
              onPressed: () {},
              label: Text(
                'Download All',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Row(
        children: [
          Visibility(
            // visible: getx.flex.value,
            child: Flexible(child: VideoPlayerLeft()),
          ),
          Flexible(child: VideoPlayerRight()),
        ],
      ),
    );
  }
}

class VideoPlayerLeft extends StatefulWidget {
  VideoPlayerLeft({
    super.key,
  });

  @override
  State<VideoPlayerLeft> createState() => _VideoPlayerLeftState();
}

class _VideoPlayerLeftState extends State<VideoPlayerLeft> {
  var color = Color.fromARGB(255, 102, 112, 133);
  List<Widget> page = [Pdf(), Mcq(), Container(), Container()];

  int flag = 2;
  int selectedIndex = 0;
  int selectedListIndex = -1; // Track the selected list tile

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ScrollConfiguration(
        behavior: HideScrollbarBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 400,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: ColorPage.grey),
                    fillColor: ColorPage.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                            'index.mp4',
                            style: GoogleFonts.inter().copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: selectedListIndex == index ? 20 : null,
                              // color: selectedListIndex == index
                              //     ? Colors.amber[900]
                              //     : Colors.black,
                            ),
                          ),
                          trailing: SizedBox(
                            width: 130,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.download,
                                      color: ColorPage.colorbutton,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.play_circle,
                                      color: ColorPage.colorbutton,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    selectedListIndex == index
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down_outlined,
                                    color: ColorPage.colorbutton,
                                  ),
                                )
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
                                  vertical: 20,
                                  horizontal: 10,
                                ),
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
                                            ))
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
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                color: backgroundColor,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
}

class VideoPlayerRight extends StatefulWidget {
  const VideoPlayerRight({super.key});

  @override
  State<VideoPlayerRight> createState() => _VideoPlayerRightState();
}

class _VideoPlayerRightState extends State<VideoPlayerRight> {
  late final player = Player();
  late final controller = VideoController(player);

  @override
  void initState() {
    player.open(
        Media(
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        ),
        play: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
          child: Column(
            children: [
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
                        onPressed: () {},
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
                        onPressed: () {},
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
              Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                elevation: 0.5,
                child: MaterialDesktopVideoControlsTheme(
                  normal: MaterialDesktopVideoControlsThemeData(),
                  fullscreen: MaterialDesktopVideoControlsThemeData(),
                  child: Container(
                    height: 700,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                    padding: EdgeInsets.only(bottom: 40),
                    child: Video(controller: controller),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
