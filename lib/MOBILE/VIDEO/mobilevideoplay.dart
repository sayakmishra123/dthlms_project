// import 'package:dthlms/Master/scrollbarhide.dart';
import 'package:dthlms/PC/VIDEO/scrollbarhide.dart';
import 'package:dthlms/THEME_DATA/FontSize/FontSize.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
// import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
// import 'package:dthlms/ThemeData/color/color.dart';
// import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class VideoPlayerMobile extends StatefulWidget {
  const VideoPlayerMobile({super.key});

  @override
  State<VideoPlayerMobile> createState() => _VideoPlayerMobileState();
}

class _VideoPlayerMobileState extends State<VideoPlayerMobile> {
  final GlobalKey _menuKey = GlobalKey();

  void _showMenu(BuildContext context) {
    final RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'Download All',
          child: Text('Download All'),
        ),
        // Add more items as needed
      ],
    ).then((value) {
      if (value != null) {
        // Handle menu item selection
        if (value == 'Download All') {
          // Implement download all functionality
        }
      }
    });
  }

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
            child: GestureDetector(
              key: _menuKey,
              onTap: () => _showMenu(context),
              child: Icon(
                Icons.more_vert,
                color: Colors.black,
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
        ],
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

  int selectedIndex = 0;
  int selectedListIndex = -1; // Track the selected list tile

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ScrollConfiguration(
        behavior: HideScrollbarBehavior(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: ColorPage.grey, fontSize: ClsFontsize.DoubleExtraSmall),
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
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                            ),
                          ),
                          trailing: SizedBox(
                            width: 120,
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
                                Icon(
                                  selectedListIndex == index
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down_outlined,
                                  color: ColorPage.colorbutton,
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
