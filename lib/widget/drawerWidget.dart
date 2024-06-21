// ignore_for_file: file_names

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/pages/StudyMaterial/StudyMaterialDashboard.dart';
import 'package:dthlms/pages/dashboard.dart';
import 'package:dthlms/pages/profile/profile.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/mycourses/coursescontent.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  // ignore: non_constant_identifier_names
  Getx get_obj = Get.put(Getx());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 100,
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(
            () => Container(
              color: get_obj.page_index.value == 0
                  ? ColorPage.drawericonbuttoncolor
                  : null,
              child: IconButton(
                  tooltip: 'Home',
                  onPressed: () {
                    get_obj.page_index.value = 0;
                    Get.offAll(() => Dashboard(),
                        transition: Transition.noTransition);
                  },
                  icon: Image.asset(
                    'assets/home.png',
                  )),
            ),
          ),
          Obx(
            () => Container(
              color: get_obj.page_index.value == 1
                  ? ColorPage.drawericonbuttoncolor
                  : null,
              child: IconButton(
                  tooltip: 'My Courses',
                  onPressed: () {
                    get_obj.page_index.value = 1;
                    Get.offAll(() => MyClassDashboard('My Courses'),
                            transition: Transition.leftToRight)
                        ?.then((value) => get_obj.page_index.value = value);
                  },
                  icon: Image.asset(
                    'assets/1.png',
                  )),
            ),
          ),
          Obx(
            () => Container(
              color: get_obj.page_index.value == 2 ? ColorPage.color1 : null,
              child: IconButton(
                  tooltip: 'StudyMaterial',
                  onPressed: () {
                    get_obj.page_index.value = 2;
                    Get.offAll(() => StudyMaterialDashboard('Study Material'),
                            transition: Transition.leftToRight)
                        ?.then((value) => get_obj.page_index.value = value);
                  },
                  icon: Image.asset('assets/2.png')),
            ),
          ),
          IconButton(
              tooltip: 'Live',
              onPressed: () {},
              icon: Image.asset('assets/3.png')),
          IconButton(
              tooltip: 'Online Backup',
              onPressed: () {},
              icon: Image.asset('assets/4.png')),
          Obx(
            () => Container(
              color: get_obj.page_index.value == 5 ? ColorPage.color1 : null,
              child: IconButton(
                  tooltip: 'Profile',
                  onPressed: () {
                    get_obj.page_index.value = 5;
                    Get.offAll(() => Profile('Profile'),
                            transition: Transition.leftToRight)
                        ?.then((value) => get_obj.page_index.value = value);
                  },
                  icon: Image.asset('assets/5.png')),
            ),
          ),
          IconButton(
              tooltip: 'MCQ',
              onPressed: () {},
              icon: Image.asset('assets/6.png')),
          IconButton(
              tooltip: 'Theory Exam',
              onPressed: () {},
              icon: Image.asset('assets/7.png')),
          IconButton(
              tooltip: 'Notification',
              onPressed: () {},
              icon: Image.asset('assets/8.png')),
        ],
      )),
    );
  }
}
