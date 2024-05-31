import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.dart';
import 'package:dthlms/pages/StudyMaterial/StudyMaterialDashboard.dart';
import 'package:dthlms/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/mycourses/coursescontent.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: non_constant_identifier_names
  Getx get_obj = Get.put(Getx());
  double? size = 80;
  double? hight = 230;
  double width = 349;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: ColorPage.bgcolor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: ColorPage.white,
                  surfaceTintColor: ColorPage.white,
                  child: InkWell(
                    onTap: () {
                      get_obj.page_index.value = 1;
                      Get.offAll(() => MyClassDashboard('My Courses'),
                              transition: Transition.leftToRight)
                          ?.then((value) => get_obj.page_index.value = 0);
                    },
                    child: SizedBox(
                      height: hight,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(colors: [
                                        Color.fromRGBO(61, 140, 229, 1),
                                        Color.fromRGBO(0, 234, 255, 1)
                                      ], end: Alignment.bottomRight)),
                                  child: Image.asset(
                                    'assets/online-learning.png',
                                    width: size,
                                    color: ColorPage.white,
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'My Courses',
                                style: FontFamily.font,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: ColorPage.white,
                  surfaceTintColor: ColorPage.white,
                  child: InkWell(
                    onTap: () {
                      get_obj.page_index.value = 2;
                      Get.offAll(() => StudyMaterialDashboard('Study Material'),
                              transition: Transition.leftToRight)
                          ?.then((value) => get_obj.page_index.value = 0);
                    },
                    child: SizedBox(
                      height: hight,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(colors: [
                                        Color.fromRGBO(247, 97, 161, 1),
                                        Color.fromRGBO(140, 27, 71, 1)
                                      ], end: Alignment.bottomRight)),
                                  child: Image.asset(
                                    'assets/book.png',
                                    color: ColorPage.white,
                                    width: size,
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Study Material',
                                style: FontFamily.font,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: ColorPage.white,
                  surfaceTintColor: ColorPage.white,
                  child: SizedBox(
                    height: hight,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(201, 84, 17, 1),
                                      Color.fromRGBO(228, 10, 2, 1)
                                    ], end: Alignment.bottomRight)),
                                child: Image.asset(
                                  'assets/instagram-live.png',
                                  width: size,
                                  color: ColorPage.white,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Live',
                              style: FontFamily.font,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: ColorPage.white,
                  surfaceTintColor: ColorPage.white,
                  child: SizedBox(
                    height: hight,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(225, 8, 68, 1),
                                      Color.fromRGBO(255, 177, 153, 1)
                                    ], end: Alignment.bottomRight)),
                                child: Image.asset(
                                  'assets/file-upload.png',
                                  width: size,
                                  color: ColorPage.white,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Online Backup',
                              style: FontFamily.font,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  color: ColorPage.white,
                  surfaceTintColor: ColorPage.white,
                  child: InkWell(
                    onTap: () {
                      get_obj.page_index.value = 5;
                      Get.offAll(() => Profile('Profile'),
                              transition: Transition.leftToRight)
                          ?.then((value) => get_obj.page_index.value = 0);
                    },
                    child: SizedBox(
                      height: hight,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: const LinearGradient(colors: [
                                        Color.fromRGBO(17, 201, 156, 1),
                                        Color.fromRGBO(0, 227, 29, 1)
                                      ], end: Alignment.bottomRight)),
                                  child: Image.asset(
                                    'assets/user-avatar.png',
                                    width: size,
                                    color: ColorPage.white,
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Profile',
                                style: FontFamily.font,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  color: ColorPage.white,
                  surfaceTintColor: ColorPage.white,
                  child: SizedBox(
                    height: hight,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(61, 140, 229, 1),
                                      Color.fromRGBO(0, 234, 255, 1)
                                    ], end: Alignment.bottomRight)),
                                child: Image.asset(
                                  'assets/exam.png',
                                  width: size,
                                  color: ColorPage.white,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'MCQ',
                              style: FontFamily.font,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: ColorPage.white,
                  surfaceTintColor: ColorPage.white,
                  child: SizedBox(
                    height: hight,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(61, 140, 229, 1),
                                      Color.fromRGBO(0, 234, 255, 1)
                                    ], end: Alignment.bottomRight)),
                                child: Image.asset(
                                  'assets/Theory exam.png',
                                  width: size,
                                  color: ColorPage.white,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Theory Exam',
                              style: FontFamily.font,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  color: ColorPage.white,
                  surfaceTintColor: ColorPage.white,
                  child: SizedBox(
                    height: hight,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(50, 141, 245, 1),
                                      Color.fromRGBO(8, 101, 241, 1)
                                    ], end: Alignment.bottomRight)),
                                child: Image.asset(
                                  'assets/notification.png',
                                  width: size,
                                  color: ColorPage.white,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Notification',
                              style: FontFamily.font,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
