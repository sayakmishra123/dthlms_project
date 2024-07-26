import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
  List page = [Pdf(), Mcq()];
  int index = 0;
  int hoverIndex = -1;
  // bool isPageVisible = true;
  // int indexvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'index.mp4',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[900]),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       isPageVisible = false;
                      //       indexvalue = 1;
                      //     });
                      //     getx.flex.value = false;
                      //   },
                      //   icon: Icon(Icons.close),
                      // ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.punch_clock_rounded,
                        color: color,
                      ),
                      Text('Duration: 3:04',
                          style: TextStyle(
                              color: color, fontWeight: FontWeight.w800))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.tag_sharp,
                        color: color,
                      ),
                      Text(
                        'Tags:',
                        style: TextStyle(
                            color: color, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromARGB(255, 243, 240, 240),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    tabbarbutton('PDF', () {
                      setState(() {
                        index = 0;
                      });
                    }, index == 0, hoverIndex == 0),
                    tabbarbutton('MCQ', () {
                      setState(() {
                        index = 1;
                      });
                    }, index == 1, hoverIndex == 1),
                    tabbarbutton('TAG', () {}, index == 2, hoverIndex == 2),
                    tabbarbutton(
                        'Ask doubt', () {}, index == 3, hoverIndex == 3),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => page[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabbarbutton(
      String name, void Function()? onTap, bool isActive, bool isHover) {
    Color backgroundColor = isActive ? ColorPage.colorbutton : Colors.white;
    Color textColor = isActive || isHover ? Colors.white : Colors.black;

    return Expanded(
      // Use Expanded to allow the button to take up available space
      child: MouseRegion(
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
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.grey),
                color: backgroundColor,
                borderRadius: BorderRadius.circular(6),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Center(
                // Use Center to align the content
                child:
                    // SizedBox(width: 8), // Add some spacing between icon and text
                    Text(
                  overflow: TextOverflow.ellipsis,
                  name,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, color: textColor),
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
          color: Colors.white,
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
