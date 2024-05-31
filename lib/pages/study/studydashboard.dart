import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';

import '../../widget/buttonwidget.dart';

// ignore: must_be_immutable
class StudyDashboard extends StatefulWidget {
  const StudyDashboard({super.key});

  @override
  State<StudyDashboard> createState() => _StudyDashboardState();
}

class _StudyDashboardState extends State<StudyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPage.color1,
          title: Text(
            'Studty Material',
            style: FontFamily.font2,
            textScaler: const TextScaler.linear(1.4),
          ),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 10; i++)
                        const Padding(
                          padding: EdgeInsets.only(left: 5, right: 30, top: 20),
                          child: ButtonWidget(),
                        )
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
