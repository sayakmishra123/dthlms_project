import 'dart:async';
import 'dart:convert';

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/mcq/modelclass.dart';
import 'package:dthlms/widget/mybutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class McqExamPage extends StatefulWidget {
  const McqExamPage({super.key});

  @override
  State<McqExamPage> createState() => _McqExamPageState();
}

class _McqExamPageState extends State<McqExamPage> {
  Future getdata() async {
    String jsonData = '''
[
  {
    "mcqId": 1,
    "mcqType": "SimpleMcq",
    "mcqQuestion": "Who is the leader of the Avengers?",
    "options": [
      {"optionId": 1, "optionName": "Iron Man"},
      {"optionId": 2, "optionName": "Captain America"},
      {"optionId": 3, "optionName": "Thor"},
      {"optionId": 4, "optionName": "Hulk"}
    ]
  },
  {
    "mcqId": 2,
    "mcqType": "SimpleMcq",
    "mcqQuestion": "What is the name of Thor's hammer?",
    "options": [
      {"optionId": 1, "optionName": "Stormbreaker"},
      {"optionId": 2, "optionName": "Mjolnir"},
      {"optionId": 3, "optionName": "Gungnir"},
      {"optionId": 4, "optionName": "Hofund"}
    ]
  },
  {
    "mcqId": 3,
    "mcqType": "VideoBasedQuestion",
    "mcqQuestion": "Which infinity stone does Vision have?",
    "videoUrl": "https://www.youtube.com/embed/fPyGnlct1o0?si=LksYWMaAg-Oerj1D",
    "options": [
      {"optionId": 1, "optionName": "Mind Stone"},
      {"optionId": 2, "optionName": "Space Stone"},
      {"optionId": 3, "optionName": "Reality Stone"},
      {"optionId": 4, "optionName": "Time Stone"}
    ]
  },
  {
    "mcqId": 4,
    "mcqType": "SimpleMcq",
    "mcqQuestion": "Who is Tony Stark's father?",
    "options": [
      {"optionId": 1, "optionName": "Howard Stark"},
      {"optionId": 2, "optionName": "Steve Rogers"},
      {"optionId": 3, "optionName": "Nick Fury"},
      {"optionId": 4, "optionName": "Bruce Banner"}
    ]
  },
  {
    "mcqId": 5,
    "mcqType": "SimpleMcq",
    "mcqQuestion": "What is the real name of Black Panther?",
    "options": [
      {"optionId": 1, "optionName": "T'Challa"},
      {"optionId": 2, "optionName": "M'Baku"},
      {"optionId": 3, "optionName": "N'Jadaka"},
      {"optionId": 4, "optionName": "Okoye"}
    ]
  },
  {
    "mcqId": 6,
    "mcqType": "SimpleMcq",
    "mcqQuestion": "Which Avenger is from Asgard?",
    "options": [
      {"optionId": 1, "optionName": "Thor"},
      {"optionId": 2, "optionName": "Hulk"},
      {"optionId": 3, "optionName": "Black Widow"},
      {"optionId": 4, "optionName": "Hawkeye"}
    ]
  },
  {
    "mcqId": 7,
    "mcqType": "SimpleMcq",
    "mcqQuestion": "Who is the villain in 'Avengers: Infinity War'?",
    "options": [
      {"optionId": 1, "optionName": "Loki"},
      {"optionId": 2, "optionName": "Thanos"},
      {"optionId": 3, "optionName": "Ultron"},
      {"optionId": 4, "optionName": "Red Skull"}
    ]
  },
  {
    "mcqId": 8,
    "mcqType": "SimpleMcq",
    "mcqQuestion": "What is the name of Black Widow?",
    "options": [
      {"optionId": 1, "optionName": "Natasha Romanoff"},
      {"optionId": 2, "optionName": "Wanda Maximoff"},
      {"optionId": 3, "optionName": "Carol Danvers"},
      {"optionId": 4, "optionName": "Hope van Dyne"}
    ]
  },
  {
    "mcqId": 9,
    "mcqType": "SimpleMcq",
    "mcqQuestion": "Who is the first Avenger?",
    "options": [
      {"optionId": 1, "optionName": "Iron Man"},
      {"optionId": 2, "optionName": "Captain America"},
      {"optionId": 3, "optionName": "Thor"},
      {"optionId": 4, "optionName": "Hulk"}
    ]
  },
  {
    "mcqId": 10,
    "mcqType": "ImageBasedQuestion",
    "imageUrl": "https://e0.pxfuel.com/wallpapers/778/909/desktop-wallpaper-thanos-thanos-army-darkseid-vs-thanos.jpg",
    "mcqQuestion": "What is the name of the army led by Thanos?",
    "options": [
      {"optionId": 1, "optionName": "Chitauri"},
      {"optionId": 2, "optionName": "Kree"},
      {"optionId": 3, "optionName": "Skrulls"},
      {"optionId": 4, "optionName": "Dark Elves"}
    ]
  }
]
''';

    List<dynamic> parsedJson = jsonDecode(jsonData);
    List<McqItem> mcqDatalist =
        parsedJson.map((json) => McqItem.fromJson(json)).toList();
    mcqData = mcqDatalist;
  }

  @override
  void initState() {
    getdata().whenComplete(() => setState(() {}));
    // TODO: implement initState
    super.initState();
  }

  String groupname = 'Group A';

  List<int> savelist = [];
  List<int> reviewlist = [];

  int qindex = 0;
  int selectedIndex = -1;

  List<McqItem> mcqData = []; // Add the mcqData here

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.blue,
          title: Text(
            '10th Social Exam-1 Mock Exam',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      'Time : 3:05 mins',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Row(
                  children: [
                    MyButton(
                        btncolor: Colors.white,
                        onPressed: () {},
                        mychild: 'Submit',
                        mycolor: Colors.orangeAccent),
                    SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: SizedBox(
                    height: height,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(8, 8),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  groupname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(8, 8),
                                        blurRadius: 10,
                                      )
                                    ]),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      mcqData[qindex].mcqQuestion,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    if (mcqData[qindex].imageUrl != null)
                                      Image.network(mcqData[qindex].imageUrl!),
                                    if (mcqData[qindex].videoUrl != null)
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          // child: WebView(
                                          //   initialUrl: mcqData[qindex].videoUrl!,
                                          //   javascriptMode: JavascriptMode.unrestricted,
                                        ),
                                      ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      color: Colors.black26,
                                      height: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: SizedBox(
                    height: height,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(8, 8),
                                        blurRadius: 10,
                                      )
                                    ]),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Options',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: mcqData[qindex].options.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeInOut,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? Colors.blue[200]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text(
                                              mcqData[qindex]
                                                  .options[index]
                                                  .optionName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              height: 40,
                              color: Colors.blueAccent,
                              padding: EdgeInsets.all(16),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              onPressed: () {
                                if (qindex > 0) {
                                  setState(() {
                                    qindex--;
                                  });
                                }
                              },
                              child: Text(
                                'Previous',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            MaterialButton(
                              height: 40,
                              color: Color.fromARGB(255, 22, 140, 26),
                              padding: EdgeInsets.all(16),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              onPressed: () {
                                if (qindex < mcqData.length - 1) {
                                  setState(() {
                                    savelist.add(qindex);
                                    qindex++;
                                  });
                                }
                              },
                              child: Text(
                                'Save & Next',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Container(
                        width: 270,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: ExpansionTile(
                            shape: Border.all(color: Colors.transparent),
                            backgroundColor: ColorPage.white,
                            collapsedBackgroundColor: ColorPage.white,
                            title: Text("All Questions"),
                            children: [
                              Container(
                                height: 400,
                                child: GridView.builder(
                                  itemCount: 120,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                  itemBuilder: (context, index) {
                                    return SingleChildScrollView(
                                      child: MaterialButton(
                                        height: 55,
                                        color: reviewlist.contains(index)
                                            ? Colors.amber
                                            : qindex == index
                                                ? Color.fromARGB(
                                                    255, 70, 150, 241)
                                                : savelist.contains(index)
                                                    ? Colors.green
                                                    : Colors.white,
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                color: Colors.black12)),
                                        onPressed: () {
                                          setState(() {
                                            qindex = index;
                                          });
                                        },
                                        child: Text((index + 1).toString()),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          height: 40,
                          color: Colors.grey,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          onPressed: () {
                            setState(() {
                              reviewlist.add(qindex);
                            });
                          },
                          child: Text(
                            'Mark for Review',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        MaterialButton(
                          height: 40,
                          color: Colors.orange,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          onPressed: () {
                            setState(() {
                              reviewlist.remove(qindex);
                              savelist.remove(qindex);
                            });
                          },
                          child: Text(
                            'Clear Responce',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
























// class McqExamPage extends StatefulWidget {
//   const McqExamPage({super.key});

//   @override
//   State<McqExamPage> createState() => _McqExamPageState();
// }

// class _McqExamPageState extends State<McqExamPage> {
//   String groupname = 'Group A';
//  List selectedquestion=[];
//   List<String> grouplist = [];
//   int qindex = 0;
//   bool isNumberPadVisible = false;
//   RxBool selecte = false.obs;
//   String selectedNumber = 'Select a number';
  













//   Map<String, List<String>> mcq = {
//     'Group A': [
//       "question1",
//       "question2",
//       "question3",
//       "question4",
//       "question5"
//     ],
//     'Group B': [
//       "question6",
//       "question7",
//       "question8",
//       "question9",
//       "question10",
//       'question100'
//     ],
//     'Group C': [
//       "question11",
//       "question12",
//       "question13",
//       "question14",
//       "question15",
//       'question16',
//       'question17'
//     ],
//      'Group D': [
//       "question11",
//       "question12",
//       "question13",
//       "question14",
//       "question15",
//       'question16',
//       'question17'
//     ],
//   };

//   int itemcno = 0;
//   var timerStyle =
//       TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20);
//   var headerStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20);
//   var optionStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 15);

//   List options = ['A) 56', 'B) 6', 'C) 5566', 'D) All'];
//   int selectedIndex = -1;
//   @override
//   void initState() {
//     itemcno = mcq.length;
//     grouplist = mcq.keys.toList();
//     selectedquestion=[0,0];

//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           backgroundColor: Colors.blue,
//           title: Text(
//             '10th Social Exam-1 Mock Exam',
//             style: timerStyle,
//           ),
//           actions: [
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Text(
//                         'Time : 3:05 mins',
//                         style: timerStyle,
//                       ),
//                     ],
//                   ),
//                   Text(
//                     '10th Social Exam-1 Mock Exam',
//                     style: timerStyle,
//                   ),
//                   Row(
//                     children: [
//                       MyButton(
//                           btncolor: Colors.white,
//                           onPressed: () {},
//                           mychild: 'Submit',
//                           mycolor: Colors.orangeAccent),
//                       SizedBox(
//                         width: 20,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                   // color: Colors.blue,
//                   child: SizedBox(
//                     height: height,
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         offset: Offset(8, 8),
//                                         blurRadius: 10,
//                                       )
//                                     ]),
//                                 padding: EdgeInsets.symmetric(vertical: 15),
//                                 child: Text(
//                                   textAlign: TextAlign.center,
//                                   groupname,
//                                   style: headerStyle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         offset: Offset(8, 8),
//                                         blurRadius: 10,
//                                       )
//                                     ]),
//                                 padding: EdgeInsets.symmetric(vertical: 15),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       textAlign: TextAlign.center,
//                                       mcq[groupname]![qindex],
//                                       style: headerStyle,
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.symmetric(
//                                           vertical: 20, horizontal: 10),
//                                       color: Colors.black26,
//                                       height: 3,
//                                     ),
//                                     Image.network(
//                                         'https://sigma-docs-screenshots.s3.us-west-2.amazonaws.com/Workbooks/Visualizations/Build+a+Bar+Chart/bar-chart.png'),
//                                     Container(
//                                       margin: EdgeInsets.symmetric(
//                                           vertical: 20, horizontal: 10),
//                                       color: Colors.black26,
//                                       height: 3,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                   // color: Colors.blue,
//                   child: SizedBox(
//                     height: height,
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         offset: Offset(8, 8),
//                                         blurRadius: 10,
//                                       )
//                                     ]),
//                                 padding: EdgeInsets.symmetric(vertical: 15),
//                                 child: Text(
//                                   textAlign: TextAlign.center,
//                                   'Options',
//                                   style: headerStyle,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           height: 400,
//                           child: ListView.builder(
//                             itemCount: 4,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 10),
//                                 child: AnimatedContainer(
//                                   duration: Duration(milliseconds: 600),
//                                   curve: Curves.easeInOut,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                     color: selectedIndex == index
//                                         ? Colors.blue[200]
//                                         : Colors.white,
//                                     borderRadius: BorderRadius.circular(8),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         blurRadius: 10,
//                                         offset: Offset(0, 5),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Material(
//                                     color: Colors.transparent,
//                                     child: InkWell(
//                                       borderRadius: BorderRadius.circular(8),
//                                       onTap: () {
//                                         setState(() {
//                                           selectedIndex = index;
//                                         });
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 16),
//                                             child: Text(
//                                               options[index].toString(),
//                                               style: optionStyle,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             MaterialButton(
//                               height: 40,
//                               color: Colors.blueAccent,
//                               padding: EdgeInsets.all(16),
//                               shape: ContinuousRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12)),
//                               onPressed: () {},
//                               child: Text(
//                                 'Previous',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                             MaterialButton(
//                               height: 40,
//                               color: Color.fromARGB(255, 22, 140, 26),
//                               padding: EdgeInsets.all(16),
//                               shape: ContinuousRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12)),
//                               onPressed: () {},
//                               child: Text(
//                                 'Save & Next',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                   child: SizedBox(
//                     height: height,
//                     child: ListView.builder(
//                         itemCount: itemcno + 1,
//                         itemBuilder: (context, gindex) {
//                           return gindex == itemcno
//                               ? Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     MaterialButton(
//                                       height: 40,
//                                       color: Colors.grey,
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 15, vertical: 5),
//                                       shape: ContinuousRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(12)),
//                                       onPressed: () {},
//                                       child: Text(
//                                         'Mark for Review',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                     MaterialButton(
//                                       height: 40,
//                                       color: Colors.orange,
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 15, vertical: 5),
//                                       shape: ContinuousRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(12)),
//                                       onPressed: () {},
//                                       child: Text(
//                                         'Clear Responce',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               : Padding(
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   child: ClipRRect(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(7)),
//                                     child: ExpansionTile(
//                                       // clipBehavior: Clip.hardEdge,
//                                       shape:
//                                           Border.all(color: Colors.transparent),

//                                       backgroundColor: ColorPage.white,

//                                       collapsedBackgroundColor: ColorPage.white,

//                                       title: Text(grouplist[gindex]),

//                                       children: [
//                                         Container(
//                                           height: 400,
//                                           child: GridView.builder(
//                                             itemCount:
//                                                 mcq[grouplist[gindex]]!.length,
//                                             gridDelegate:
//                                                 SliverGridDelegateWithFixedCrossAxisCount(
//                                                     crossAxisCount: 4),
//                                             itemBuilder: (context, index) {
//                                               return Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: MaterialButton(
//                                                   color: gindex==selectedquestion[0]&& index==selectedquestion[1]?Colors.orange:Colors.white,

//                                                   shape: CircleBorder(
//                                                       side: BorderSide(
//                                                           color:
//                                                               Colors.black12)),
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       groupname =
//                                                           grouplist[gindex];
//                                                       qindex = index;
//                                                       selectedquestion=[gindex,index];
//                                                     });
//                                                   },
//                                                   child: Text(
//                                                       (index + 1).toString()),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                         }),
                    
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

