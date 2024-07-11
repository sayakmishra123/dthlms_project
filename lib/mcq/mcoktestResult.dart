import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';
import 'package:dthlms/mcq/modelclass.dart';
import 'package:flutter/widgets.dart';

class ResultPage extends StatefulWidget {
  final List<McqItem> mcqData;
  final Map<int, int> userAns;
  final List<Map<int, int>> correctAnswers;

  ResultPage({
    required this.mcqData,
    required this.userAns,
    required this.correctAnswers,
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    int totalMarks = 0;

    List<DataRow> dataRows = widget.mcqData.asMap().entries.map((entry) {
      int index = entry.key;
      McqItem mcqItem = entry.value;
      int questionId = mcqItem.mcqId;
      String question = mcqItem.mcqQuestion;
      String userSelected = widget.userAns.containsKey(questionId)
          ? mcqItem.options
              .firstWhere(
                  (option) => option.optionId == widget.userAns[questionId])
              .optionName
          : 'Not Answered';
      String correctAnswer = mcqItem.options
          .firstWhere((option) => widget.correctAnswers
              .any((map) => map[questionId] == option.optionId))
          .optionName;
      int marks = widget.userAns.containsKey(questionId) &&
              widget.correctAnswers
                  .any((map) => map[questionId] == widget.userAns[questionId])
          ? 1
          : 0;
      totalMarks += marks;

      return DataRow(cells: [
        DataCell(
          Container(
            child: Text((index + 1).toString()),
          ),
        ),
        DataCell(Container(
          width: MediaQuery.of(context).size.width / 5,
          child: Text(
            question,
            overflow: TextOverflow.ellipsis,
          ),
        )),
        DataCell(Container(
          width: 150,
          child: Text(
            userSelected,
          ),
        )),
        DataCell(Container(
          width: 150,
          child: Text(
            correctAnswer,
            overflow: TextOverflow.clip,
          ),
        )),
        DataCell(Text(marks.toString())),
      ]);
    }).toList();

    // Add a row for the total marks
    dataRows.add(
      DataRow(
        cells: [
          DataCell(Container()),
          DataCell(Container()),
          DataCell(Container()),
          DataCell(Container(
            alignment: Alignment.centerRight,
            child: Text(
              'Total Marks:',
              style: FontFamily.font3.copyWith(color: Colors.black),
            ),
          )),
          DataCell(Text(totalMarks.toString())),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: ColorPage.appbarcolor,
        iconTheme: IconThemeData(color: ColorPage.white),
        title: Text('Exam Results',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Card(
              elevation: 100,
              child: DataTable(
                border: TableBorder.all(color: ColorPage.colorblack),
                headingRowColor: MaterialStatePropertyAll(Colors.blueGrey[600]),
                dividerThickness: 2,
                columns: [
                  DataColumn(
                    label: Container(
                      child: Text(
                        'SL. No',
                        textAlign: TextAlign.center,
                        style: FontFamily.font3,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Question',
                      textAlign: TextAlign.center,
                      style: FontFamily.font3,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Your ANS.',
                      textAlign: TextAlign.center,
                      style: FontFamily.font3,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Correct ANS.',
                      textAlign: TextAlign.center,
                      style: FontFamily.font3,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Marks',
                      textAlign: TextAlign.center,
                      style: FontFamily.font3,
                    ),
                  ),
                ],
                rows: dataRows,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
