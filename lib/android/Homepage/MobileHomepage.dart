import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dthlms/android/Drawer/Mobiledrawer.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
// import 'package:dthlms/android/PackageDashboard/PackageDashboard.dart';
import 'package:dthlms/getx/getxcontroller.dart';
import 'package:dthlms/utils/packages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileHomepage extends StatefulWidget {
  
  const MobileHomepage({super.key});

  @override
  State<MobileHomepage> createState() => _MobileHomepageState();
}

class _MobileHomepageState extends State<MobileHomepage> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  final List<Map<String, String>> imageList = [
    {"id": "1", "image_path": 'assets/android/p1.jpg'},
    {"id": "2", "image_path": 'assets/android/p3.jpg'},
    {"id": "3", "image_path": 'assets/android/p2.jpg'},
    {"id": "4", "image_path": 'assets/android/p4.avif'},
    {"id": "5", "image_path": 'assets/android/p3.jpg'},
  ];

  final Getx get = Get.put(Getx());
  late final double elemenContainerWidth = screenwidth / 3.2;
  late final double screenwidth = MediaQuery.of(context).size.width;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  static const double iconSize = 80;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const mobileDrawer(),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  size: 30,
                  color: ColorPage.colorblack,
                ),
                onPressed: () {
                  _showPopupMenu(context);
                },
              ),
            ),
          ],
          title: Text(
            "Hi, Sayak Mishra",
            style: FontFamily.font6,
          ),
        ),
        backgroundColor: ColorPage.appbarcolor,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hi, Sayak Mishra",
                            style: FontFamily.font5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(
            padding: const EdgeInsets.only(top: 20),
            width: screenwidth,
            decoration: const BoxDecoration(
              color: ColorPage.bgcolor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    buildRow(
                      context,
                      [
                        InkWell(
                          onTap: () {
                            Get.to(() =>const PackageDashboardMobile(''));
                          },
                          child: buildContainer(
                            context,
                            'assets/online-learning.png',
                            'My Courses',
                            const LinearGradient(
                              colors: [
                                Color.fromRGBO(61, 140, 229, 1),
                                Color.fromRGBO(0, 234, 255, 1)
                              ],
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                          Get.to(()=>PackageDashboardMobile(''));
                          },
                          child: buildContainer(
                            context,
                            'assets/book.png',
                            'Study Material',
                            const LinearGradient(
                              colors: [
                                Color.fromRGBO(247, 97, 161, 1),
                                Color.fromRGBO(140, 27, 71, 1)
                              ],
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        buildContainer(
                          context,
                          'assets/instagram-live.png',
                          'Live',
                          const LinearGradient(
                            colors: [
                              Color.fromRGBO(201, 84, 17, 1),
                              Color.fromRGBO(228, 10, 2, 1)
                            ],
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildRow(
                      context,
                      [
                        buildContainer(
                          context,
                          'assets/file-upload.png',
                          'Online Backup',
                          const LinearGradient(
                            colors: [
                              Color.fromRGBO(225, 8, 68, 1),
                              Color.fromRGBO(255, 177, 153, 1)
                            ],
                            end: Alignment.bottomRight,
                          ),
                        ),
                        buildContainer(
                          context,
                          'assets/user-avatar.png',
                          'Profile',
                          const LinearGradient(
                            colors: [
                              Color.fromRGBO(17, 201, 156, 1),
                              Color.fromRGBO(0, 227, 29, 1)
                            ],
                            end: Alignment.bottomRight,
                          ),
                        ),
                        buildContainer(
                          context,
                          'assets/exam.png',
                          'MCQ',
                          const LinearGradient(
                            colors: [
                              Color.fromRGBO(61, 140, 229, 1),
                              Color.fromRGBO(0, 234, 255, 1)
                            ],
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildRowSpaceEvenly(
                      context,
                      [
                        buildContainer(
                          context,
                          'assets/Theory exam.png',
                          'Theory Exam',
                          const LinearGradient(
                            colors: [
                              Color.fromRGBO(61, 140, 229, 1),
                              Color.fromRGBO(0, 234, 255, 1)
                            ],
                            end: Alignment.bottomRight,
                          ),
                        ),
                        buildContainer(
                          context,
                          'assets/notification.png',
                          'Notification',
                          const LinearGradient(
                            colors: [
                              Color.fromRGBO(50, 141, 245, 1),
                              Color.fromRGBO(8, 101, 241, 1)
                            ],
                            end: Alignment.bottomRight,
                          ),
                        ),
                        Container(
                          width: elemenContainerWidth,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Stack(children: [
                        InkWell(
                          child: CarouselSlider(
                            items: imageList
                                .map(
                                  (item) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            item['image_path']!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                            color: ColorPage.appbarcolor,
                                            width: 2)),
                                  ),
                                )
                                .toList(),
                            carouselController: carouselController,
                            options: CarouselOptions(
                              scrollPhysics: const BouncingScrollPhysics(),
                              autoPlay: true,
                              aspectRatio: 2,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imageList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    carouselController.animateToPage(entry.key),
                                child: Container(
                                  width: currentIndex == entry.key ? 20 : 10,
                                  height: 10,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: currentIndex == entry.key
                                          ? ColorPage.appbarcolor
                                          : ColorPage.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          1000, 100, 10, 100), // Adjust these values as needed
      items: [
        PopupMenuItem<String>(
          value: 'Profile',
          child: TextButton.icon(
            icon: Icon(Icons.person),
            onPressed: () {},
            label: Text("Profile"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Logout',
          child: TextButton.icon(
            icon: Icon(Icons.logout),
            onPressed: () {},
            label: Text("Logout"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Support',
          child: TextButton.icon(
            icon: Icon(Icons.support_agent),
            onPressed: () {},
            label: Text("Support"),
          ),
        ),
      ],
    );
  }

  Widget buildRow(BuildContext context, List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  Widget buildContainer(
    BuildContext context,
    String assetPath,
    String text,
    Gradient gradient,
  ) {
    return SizedBox(
      width: elemenContainerWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 5),
          Container(
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: gradient,
            ),
            child: Image.asset(
              assetPath,
              width: iconSize,
              scale: 12,
              color: ColorPage.white,
            ),
          ),
          AutoSizeText(
            text,
            style: FontFamily.font4,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget buildRowSpaceEvenly(BuildContext context, List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}
