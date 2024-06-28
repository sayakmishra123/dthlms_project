// ignore_for_file: unnecessary_import, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/home/homepage.dart';

import 'package:dthlms/utctime.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dashboard extends StatefulWidget {
  late final dbdata;
  Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  UtcTime time = UtcTime();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Text(
              time.utctime(),
              style: FontFamily.font2,
            ),
            IconButton(
                tooltip: 'Profile',
                onPressed: () {},
                icon: const Icon(
                  Icons.person,
                  color: ColorPage.white,
                )),
            IconButton(
                tooltip: 'Support',
                onPressed: () {},
                icon: const Icon(
                  Icons.support_agent,
                  color: ColorPage.white,
                )),
            IconButton(
                tooltip: 'Logout',
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                  color: ColorPage.white,
                ))
          ],
          backgroundColor: ColorPage.appbarcolor,
          title: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Hi, Sayak Mishra',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ClsFontsize.Small), //20
              ),
            ),
          ),
          titleTextStyle: FontFamily.font2,
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DrawerWidget(),
            Expanded(
              child: HomePage(),
            ),
          ],
        ),
      ),
    );
  }
}
