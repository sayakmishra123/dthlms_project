import 'dart:async';
import 'dart:convert';

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/mcq/ResultPage.dart';
import 'package:dthlms/mcq/mcoktestResult.dart';
import 'package:dthlms/mcq/modelclass.dart';
import 'package:dthlms/widget/mybutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MockTestMcqExamPage extends StatefulWidget {
  const MockTestMcqExamPage({super.key});

  @override
  State<MockTestMcqExamPage> createState() => _MockTestMcqExamPageState();
}

class _MockTestMcqExamPageState extends State<MockTestMcqExamPage> {
  List<Map<int, int>> answer = [
    {1: 2},
    {2: 3},
    {3: 2},
    {4: 1},
    {5: 1},
    {6: 1},
    {7: 2},
    {8: 1},
    {9: 2},
    {10: 1},
  ];
  Map<int, int> userAns = {};

  late Timer _timer;
  Getx getx_obj = Get.put(Getx());
  RxBool buttonshow = false.obs;
  RxInt _start = 1200.obs;

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
    "mcqQuestion": "Who is Tony Stark's father asjdsahgdhgfuysd gczxbczhg csdfc gzjz hxgcy ugfhdb chxzgc sdfbdsc zhbch jgcbsdh gcsdy gfsdcgc fsdbvxch csdgd h cbjgcufsd?",
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
      {"optionId": 4, "optionName": "Hawkeye"},
      {"optionId": 5, "optionName": "Hawkeye2"},
      {"optionId": 6, "optionName": "Hawkeye3"}
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
    super.initState();
    getdata().whenComplete(() => setState(() {}));
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start.value == 0) {
          timer.cancel();
          _onimeUp(context);
        } else {
          _start.value--;
        }
      },
    );
  }

  String get timerText {
    int hours = _start.value ~/ 3600;
    int minutes = (_start.value % 3600) ~/ 60;
    int seconds = _start.value % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String groupname = 'Group A';

  List<int> reviewlist = [];

  RxInt qindex = 0.obs;
  int selectedIndex = -1;
  RxBool isSubmitted = false.obs;
  RxInt score = 0.obs;

  List<McqItem> mcqData = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Obx(() => Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorPage.white),
            automaticallyImplyLeading: true,
            centerTitle: false,
            backgroundColor: Colors.blue,
            title: Text(
              '10th Social Exam-1 Mock Exam',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        'Remaining Time ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      Icon(
                        Icons.watch_later_outlined,
                        color: ColorPage.white,
                      ),
                      Text(
                        ' $timerText',
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
                //  isSubmitted.value?
                  Row(
                    children: [
                      MyButton(
                          btncolor: Colors.white,
                          onPressed: () {
                            // Get.to(()=>ResultPage(mcqData: mcqData,correctAnswers: answer,userAns: userAns,));
                            Get.to(()=>MockTestResultPage());
                         
                          },
                          mychild: 'Result',
                          mycolor: Colors.orangeAccent),
                      SizedBox(width: 20),
                    ],
                  )
                  // :SizedBox(),
                ],
              ),
            ],
          ),
          body: Obx(() => SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            mcqData[qindex.value].mcqQuestion,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                          if (mcqData[qindex.value].imageUrl !=
                                              null)
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Image.network(
                                                  mcqData[qindex.value]
                                                      .imageUrl!),
                                            ),
                                          if (mcqData[qindex.value].videoUrl !=
                                              null)
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: AspectRatio(
                                                aspectRatio: 16 / 9,
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
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
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: ListView.builder(
                                  itemCount:
                                      mcqData[qindex.value].options.length,
                                  itemBuilder: (context, index) {
                                    int optionId = mcqData[qindex.value]
                                        .options[index]
                                        .optionId;
                                    int questionId =
                                        mcqData[qindex.value].mcqId;
                                    bool isSelected =
                                        userAns[questionId] == optionId;
                                    bool isCorrect = answer.any(
                                        (map) => map[questionId] == optionId);
                                    bool isAnswered =
                                        userAns.containsKey(questionId);

                                    Color tileColor;
                                    if (isSubmitted.value) {
                                      if (isCorrect) {
                                        tileColor = Colors.green;
                                      } else if (isSelected && !isCorrect) {
                                        tileColor = Colors.red;
                                      } else {
                                        tileColor =
                                            Colors.white; // default color
                                      }
                                    } else {
                                      tileColor = isSelected
                                          ? Colors.blue
                                          : Colors.white; // default color
                                    }

                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 600),
                                        curve: Curves.easeInOut,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: tileColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            onTap: () {
                                              setState(() {
                                                if (!isSubmitted.value) {
                                                  userAns[questionId] =
                                                      optionId;
                                                }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16),
                                                  child: Text(
                                                    mcqData[qindex.value]
                                                        .options[index]
                                                        .optionName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    height: 40,
                                    color: Colors.blueAccent,
                                    padding: EdgeInsets.all(16),
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    onPressed: () {
                                      if (qindex.value > 0) {
                                        qindex.value--;
                                      }
                                    },
                                    child: Text(
                                      'Previous',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  MaterialButton(
                                    height: 40,
                                    color: Color.fromARGB(255, 32, 104, 192),
                                    padding: EdgeInsets.all(16),
                                    shape: ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    onPressed: () {
                                      if (qindex.value < mcqData.length - 1) {
                                        // savelist.add(qindex.value);
                                        qindex.value++;
                                      } else if (qindex.value ==
                                          mcqData.length - 1 && !isSubmitted.value) {
                                        // savelist.add(qindex.value);
                                        _onSubmitExam(context);
                                      }
                                    },
                                    child: Text(
                                      !isSubmitted.value &&
                                              qindex.value == mcqData.length - 1
                                          ? 'Submit'
                                          : 'Next',
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
                                vertical: 5, horizontal: 15),
                            child: Container(
                              width: 270,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: ExpansionTile(
                                  onExpansionChanged: (Value) {
                                    buttonshow.value = Value;
                                  },
                                  shape: Border.all(color: Colors.transparent),
                                  backgroundColor: ColorPage.white,
                                  collapsedBackgroundColor: ColorPage.white,
                                  title: Text("All Questions"),
                                  children: [
                                    Container(
                                      height: 400,
                                      child: GridView.builder(
                                        itemCount: mcqData.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                            child: MaterialButton(
                                              height: 55,
                                              color: reviewlist.contains(index)
                                                  ? Colors.amber
                                                  : userAns.containsKey(index+1)
                                                      ? isSubmitted.value
                                                          ? answer.any((map) =>
                                                                  map[index+1] ==
                                                                  userAns[
                                                                      index+1])
                                                              ? Colors.green
                                                              : Colors.red
                                                          : Colors.blue
                                                      : qindex.value == index
                                                          ? Color.fromARGB(
                                                              255, 13, 32, 79)
                                                          : Colors.white,
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                      width:
                                                          qindex.value == index
                                                              ? 4
                                                              : 1,
                                                      color: qindex.value ==
                                                              index
                                                          ? ColorPage.white
                                                          : Colors.black12)),
                                              onPressed: () {
                                                qindex.value = index;
                                              },
                                              child: Text(
                                                (index + 1).toString(),
                                                style: TextStyle(
                                                    color: qindex.value == index
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
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
                          Visibility(
                            visible:isSubmitted.value?false: buttonshow.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  height: 40,
                                  color: Colors.orange,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () {
                                   if(reviewlist.contains(qindex.value) ){


                                   }
                                   else{
                                    reviewlist.add(qindex.value);
                                   }
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
                                  color: Colors.blueGrey,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () {
                                    reviewlist.remove(qindex.value);
                                  },
                                  child: Text(
                                    'Clear Response',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  _onSubmitExam(context) {
    int correctAnswers = 0;
    userAns.forEach((questionId, selectedOptionId) {
      if (answer.any((map) => map[questionId] == selectedOptionId)) {
        correctAnswers++;
      }
    });

    Alert(
      context: context,
      type: AlertType.info,
      style: AlertStyle(
        animationType: AnimationType.fromLeft,
        titleStyle:
            TextStyle(color: ColorPage.red, fontWeight: FontWeight.bold),
        descStyle: FontFamily.font6,
        isCloseButton: false,
      ),
      title: "Are You Sure?",
      desc:
          "Once You submit, You can't Change your Sheet \n If you are sure then Click on 'Yes' Button",
      buttons: [
        DialogButton(
          child: Text("Cancel",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(77, 3, 3, 1),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color.fromRGBO(158, 9, 9, 1),
        ),
        DialogButton(
          child:
              Text("Yes", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(77, 3, 3, 1),
          onPressed: () {
            _timer.cancel();
            score.value = correctAnswers;

            isSubmitted.value = true;
            Navigator.pop(context);
          },
          color: Color.fromRGBO(9, 89, 158, 1),
        ),
      ],
    ).show();
  }

  _onimeUp(context) {
    _onSubmitExam(context);
    Alert(
      context: context,
      type: AlertType.info,
      style: AlertStyle(
        animationType: AnimationType.fromTop,
        titleStyle:
            TextStyle(color: ColorPage.red, fontWeight: FontWeight.bold),
        descStyle: FontFamily.font6,
        isCloseButton: false,
      ),
      title: "Your Time is Up !!",
      desc: "Sorry! But Your time is over. \n Your Exam has been submitted.",
      buttons: [
        DialogButton(
          child:
              Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(3, 77, 59, 1),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color.fromRGBO(9, 89, 158, 1),
        ),
      ],
    ).show();
  }

  _onincompleteSubmission(context) {
    Alert(
      context: context,
      type: AlertType.info,
      style: AlertStyle(
        animationType: AnimationType.fromLeft,
        titleStyle:
            TextStyle(color: ColorPage.red, fontWeight: FontWeight.bold),
        descStyle: FontFamily.font6,
        isCloseButton: false,
      ),
      title: "Your Sheet is Incomplete",
      desc:
          "Your Answer sheet is Incomplete. \n Are you Sure to Submit then Click on Yes Button.  ",
      buttons: [
        DialogButton(
          child: Text("Cancel",
              style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(77, 3, 3, 1),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color.fromRGBO(177, 58, 58, 1),
        ),
        DialogButton(
          child:
              Text("Yes", style: TextStyle(color: Colors.white, fontSize: 18)),
          highlightColor: Color.fromRGBO(3, 77, 59, 1),
          onPressed: () {
            setState(() {
              

          

            isSubmitted.value = true;
            });
            Navigator.pop(context);
          },
          color: Color.fromRGBO(9, 89, 158, 1),
        ),
      ],
    ).show();
  }
}
