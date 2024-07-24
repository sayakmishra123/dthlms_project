import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/mcq/modelclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MocktestAnswer extends StatefulWidget {
 

  @override
  State<MocktestAnswer> createState() => _MocktestAnswerState();
}

class _MocktestAnswerState extends State<MocktestAnswer> {


   Getx getxController = Get.put(Getx());
  final List<McqItem> mcqData= Get.arguments['mcqData'];
   final Map<int, int> userAns = Get.arguments['userAns'];
  final List<Map<int, int>> correctAnswers = Get.arguments['correctAnswers'];
  @override
  Widget build(BuildContext context) {
    int totalMarks = 0;
    List<Widget> questionWidgets = mcqData.asMap().entries.map((entry) {
      int index = entry.key;
      McqItem mcqItem = entry.value;
      int questionId = mcqItem.mcqId;
      String question = mcqItem.mcqQuestion;
      String userSelected = userAns.containsKey(questionId)
          ? mcqItem.options
              .firstWhere(
                  (option) => option.optionId == userAns[questionId])
              .optionName
          : 'Not Answered';
      String correctAnswer = mcqItem.options
          .firstWhere((option) => correctAnswers
              .any((map) => map[questionId] == option.optionId))
          .optionName;
      int marks = userAns.containsKey(questionId) &&
              correctAnswers
                  .any((map) => map[questionId] == userAns[questionId])
          ? 1
          : 0;
      totalMarks += marks;

      return Container(
        margin: EdgeInsets.only(top: 10),
        // decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255), borderRadius: BorderRadius.all(Radius.circular(10),),boxShadow: [
        //   BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1, blurRadius: 2),
        // ]),
        child: ListTile(
          title: Text(
            '${index + 1}. $question',
            style: FontFamily.font4.copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Answer: $userSelected'),
              Text('Correct Answer: $correctAnswer'),
            ],
          ),
          trailing: Text(
            marks.toString(),
            style: FontFamily.font3.copyWith(color: Colors.black),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPage.appbarcolor,
        iconTheme: IconThemeData(color: ColorPage.white),
        centerTitle: true,
        title: Text(
          "QNA",
          style: FontFamily.font3,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 218, 225, 227),
                border: Border(
                  left: BorderSide(color: ColorPage.appbarcolor, width: 3),
                ),
              ),
              child: Container(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: questionWidgets,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
