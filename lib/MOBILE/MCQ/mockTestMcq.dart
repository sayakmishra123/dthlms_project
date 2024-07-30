import 'dart:async';
import 'dart:convert';

import 'package:dthlms/PC/MCQ/modelclass.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
// import 'package:dthlms/android/MCQ/mockTestRank.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';

import 'package:dthlms/GLOBAL_WIDGET/mybutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MockTestMcqExamPageMobile extends StatefulWidget {
  const MockTestMcqExamPageMobile({super.key});

  @override
  State<MockTestMcqExamPageMobile> createState() =>
      _MockTestMcqExamPageMobileState();
}

class _MockTestMcqExamPageMobileState extends State<MockTestMcqExamPageMobile> {
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
  RxInt _start = 1800.obs;

  PageController _pageController = PageController();

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
    _pageController.dispose();
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

  String groupname = ' All Questions';

  List<int> reviewlist = [];

  RxInt qindex = 0.obs;
  int selectedIndex = -1;
  RxBool isSubmitted = false.obs;
  RxInt score = 0.obs;

  List<McqItem> mcqData = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Obx(() => SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              iconTheme: IconThemeData(color: ColorPage.white),
              leading:
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              centerTitle: false,
              backgroundColor: ColorPage.appbarcolor,
              title: Text(
                '10th Social Exam-1 Mock Exam',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(
                          Icons.alarm_outlined,
                          color: ColorPage.white,
                        ),
                        Text(
                          ' $timerText',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
            body: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        qindex.value = index;
                      },
                      itemCount: mcqData.length,
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: (){
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => DraggableScrollableSheet(
                                expand: false,
                                builder: (context, scrollController) => Container(
                                  decoration: BoxDecoration(
                                    color: ColorPage.bgcolor,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(2.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            controller: scrollController,
                                            itemCount: mcqData.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              childAspectRatio: 1.5,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: MaterialButton(
                                                  height: 55,
                                                  color: reviewlist.contains(index)
                                                      ? Colors.amber
                                                      : userAns.containsKey(index + 1)
                                                          ? isSubmitted.value
                                                              ? answer.any((map) =>
                                                                      map[index + 1] ==
                                                                      userAns[index + 1])
                                                                  ? Colors.green
                                                                  : Colors.red
                                                              : Colors.blue
                                                          : qindex.value == index
                                                              ? Color.fromARGB(
                                                                  255, 13, 32, 79)
                                                              : Colors.white,
                                                  shape: CircleBorder(
                                                    side: BorderSide(
                                                      width: qindex.value == index
                                                          ? 4
                                                          : 1,
                                                      color: qindex.value == index
                                                          ? ColorPage.white
                                                          : Colors.black12,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    qindex.value = index;
                                                    _pageController.jumpToPage(
                                                        index);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                      color: qindex.value == index
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
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
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                groupname,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20),
                                              ),
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Column(
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  mcqData[index].mcqQuestion,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 20),
                                                ),
                                                if (mcqData[index].imageUrl !=
                                                    null)
                                                  Padding(
                                                    padding: const EdgeInsets.all(
                                                        15),
                                                    child: Image.network(
                                                        mcqData[index].imageUrl!),
                                                  ),
                                                if (mcqData[index].videoUrl !=
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
                                                      vertical: 20,
                                                      horizontal: 10),
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
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: SizedBox(
                                  height: height,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.4,
                                        child: ListView.builder(
                                          physics: mcqData[index]
                                                      .options.length <
                                                  5
                                              ? NeverScrollableScrollPhysics()
                                              : AlwaysScrollableScrollPhysics(),
                                          itemCount:
                                              mcqData[index].options.length,
                                          itemBuilder: (context, optionIndex) {
                                            int optionId = mcqData[index]
                                                .options[optionIndex]
                                                .optionId;
                                            int questionId =
                                                mcqData[index].mcqId;
                                            bool isSelected =
                                                userAns[questionId] == optionId;
                                            bool isCorrect = answer.any((map) =>
                                                map[questionId] == optionId);
                                            bool isAnswered =
                                                userAns.containsKey(questionId);

                                            Color tileColor;
                                            if (isSubmitted.value) {
                                              if (isCorrect) {
                                                tileColor = Colors.green;
                                              } else if (isSelected &&
                                                  !isCorrect) {
                                                tileColor = Colors.red;
                                              } else {
                                                tileColor = Colors.white;
                                              }
                                            } else {
                                              tileColor = isSelected
                                                  ? Colors.blue
                                                  : Colors.white;
                                            }

                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 600),
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
                                                        BorderRadius.circular(
                                                            8),
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
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16),
                                                          child: Text(
                                                            mcqData[index]
                                                                .options[
                                                                    optionIndex]
                                                                .optionName,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                            color: ColorPage.appbarcolorcopy,
                                            padding: EdgeInsets.all(16),
                                            shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            onPressed: () {
                                              if (index > 0) {
                                                _pageController.previousPage(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            },
                                            child: Text(
                                              'Previous',
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          MaterialButton(
                                            height: 40,
                                            color: ColorPage.appbarcolorcopy,
                                            padding: EdgeInsets.all(16),
                                            shape: ContinuousRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            onPressed: () {
                                              if (index < mcqData.length - 1) {
                                                _pageController.nextPage(
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              } else if (index ==
                                                      mcqData.length - 1 &&
                                                  !isSubmitted.value) {
                                                _onSubmitExam(context);
                                              }
                                            },
                                            child: Text(
                                              !isSubmitted.value &&
                                                      index ==
                                                          mcqData.length - 1
                                                  ? 'Submit'
                                                  : 'Next',
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Positioned(
                        right: 10,
                        top: 5,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => DraggableScrollableSheet(
                                expand: false,
                                builder: (context, scrollController) => Container(
                                  decoration: BoxDecoration(
                                    color: ColorPage.bgcolor,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(2.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            controller: scrollController,
                                            itemCount: mcqData.length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              childAspectRatio: 1.5,
                                            ),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: MaterialButton(
                                                  height: 55,
                                                  color: reviewlist.contains(index)
                                                      ? Colors.amber
                                                      : userAns.containsKey(index + 1)
                                                          ? isSubmitted.value
                                                              ? answer.any((map) =>
                                                                      map[index + 1] ==
                                                                      userAns[index + 1])
                                                                  ? Colors.green
                                                                  : Colors.red
                                                              : Colors.blue
                                                          : qindex.value == index
                                                              ? Color.fromARGB(
                                                                  255, 13, 32, 79)
                                                              : Colors.white,
                                                  shape: CircleBorder(
                                                    side: BorderSide(
                                                      width: qindex.value == index
                                                          ? 4
                                                          : 1,
                                                      color: qindex.value == index
                                                          ? ColorPage.white
                                                          : Colors.black12,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    qindex.value = index;
                                                    _pageController.jumpToPage(
                                                        index);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                      color: qindex.value == index
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorPage.appbarcolorcopy,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.list_alt,
                              color: ColorPage.white,
                            ),
                          ),
                        ))
                  ],
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
            Get.toNamed("/Mocktestrankpagemobile",arguments:{"mcqData":mcqData,"correctAnswers":answer,"userAns":userAns,"totalnomber":correctAnswers*1});
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
          child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
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


























// import 'dart:async';
// import 'dart:convert';

// import 'package:dthlms/ThemeData/color/color.dart';
// import 'package:dthlms/ThemeData/font/font_family.dart';
// import 'package:dthlms/getx/getxcontroller.getx.dart';
// import 'package:dthlms/mcq/ResultPage.dart';
// import 'package:dthlms/mcq/mcoktestResult.dart';
// import 'package:dthlms/mcq/modelclass.dart';
// import 'package:dthlms/widget/mybutton.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:path/path.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// class MockTestMcqExamPageMobile extends StatefulWidget {
//   const MockTestMcqExamPageMobile({super.key});

//   @override
//   State<MockTestMcqExamPageMobile> createState() => _MockTestMcqExamPageMobileState();
// }

// class _MockTestMcqExamPageMobileState extends State<MockTestMcqExamPageMobile> {
//   List<Map<int, int>> answer = [
//     {1: 2},
//     {2: 3},
//     {3: 2},
//     {4: 1},
//     {5: 1},
//     {6: 1},
//     {7: 2},
//     {8: 1},
//     {9: 2},
//     {10: 1},
//   ];

//   RxMap userAns = <int, int> {}.obs;
//   RxList<McqItem> mcqData = <McqItem>[].obs;
//   late Timer _timer;
//   Getx getx_obj = Get.put(Getx());
//   RxBool buttonshow = false.obs;
//   RxInt _start = 1800.obs;
//   RxInt qindex = 0.obs;
//   RxBool isSubmitted = false.obs;
//   RxInt score = 0.obs;
//   RxList<int> reviewlist = <int>[].obs;

//   @override
//   void initState() {
//     super.initState();
//     getdata().whenComplete(() => null);
//     startTimer();
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   Future getdata() async {
//     String jsonData = '''
// [
//   {
//     "mcqId": 1,
//     "mcqType": "SimpleMcq",
//     "mcqQuestion": "Who is the leader of the Avengers?",
//     "options": [
//       {"optionId": 1, "optionName": "Iron Man"},
//       {"optionId": 2, "optionName": "Captain America"},
//       {"optionId": 3, "optionName": "Thor"},
//       {"optionId": 4, "optionName": "Hulk"}
//     ]
//   },
//   {
//     "mcqId": 2,
//     "mcqType": "SimpleMcq",
//     "mcqQuestion": "What is the name of Thor's hammer?",
//     "options": [
//       {"optionId": 1, "optionName": "Stormbreaker"},
//       {"optionId": 2, "optionName": "Mjolnir"},
//       {"optionId": 3, "optionName": "Gungnir"},
//       {"optionId": 4, "optionName": "Hofund"}
//     ]
//   },
//   {
//     "mcqId": 3,
//     "mcqType": "VideoBasedQuestion",
//     "mcqQuestion": "Which infinity stone does Vision have?",
//     "videoUrl": "https://www.youtube.com/embed/fPyGnlct1o0?si=LksYWMaAg-Oerj1D",
//     "options": [
//       {"optionId": 1, "optionName": "Mind Stone"},
//       {"optionId": 2, "optionName": "Space Stone"},
//       {"optionId": 3, "optionName": "Reality Stone"},
//       {"optionId": 4, "optionName": "Time Stone"}
//     ]
//   },
//   {
//     "mcqId": 4,
//     "mcqType": "SimpleMcq",
//     "mcqQuestion": "Who is Tony Stark's father asjdsahgdhgfuysd gczxbczhg csdfc gzjz hxgcy ugfhdb chxzgc sdfbdsc zhbch jgcbsdh gcsdy gfsdcgc fsdbvxch csdgd h cbjgcufsd?",
//     "options": [
//       {"optionId": 1, "optionName": "Howard Stark"},
//       {"optionId": 2, "optionName": "Steve Rogers"},
//       {"optionId": 3, "optionName": "Nick Fury"},
//       {"optionId": 4, "optionName": "Bruce Banner"}
//     ]
//   },
//   {
//     "mcqId": 5,
//     "mcqType": "SimpleMcq",
//     "mcqQuestion": "What is the real name of Black Panther?",
//     "options": [
//       {"optionId": 1, "optionName": "T'Challa"},
//       {"optionId": 2, "optionName": "M'Baku"},
//       {"optionId": 3, "optionName": "N'Jadaka"},
//       {"optionId": 4, "optionName": "Okoye"}
//     ]
//   },
//   {
//     "mcqId": 6,
//     "mcqType": "SimpleMcq",
//     "mcqQuestion": "Which Avenger is from Asgard?",
//     "options": [
//       {"optionId": 1, "optionName": "Thor"},
//       {"optionId": 2, "optionName": "Hulk"},
//       {"optionId": 3, "optionName": "Black Widow"},
//       {"optionId": 4, "optionName": "Hawkeye"},
//       {"optionId": 5, "optionName": "Hawkeye2"},
//       {"optionId": 6, "optionName": "Hawkeye3"}
//     ]
//   },
//   {
//     "mcqId": 7,
//     "mcqType": "SimpleMcq",
//     "mcqQuestion": "Who is the villain in 'Avengers: Infinity War'?",
//     "options": [
//       {"optionId": 1, "optionName": "Loki"},
//       {"optionId": 2, "optionName": "Thanos"},
//       {"optionId": 3, "optionName": "Ultron"},
//       {"optionId": 4, "optionName": "Red Skull"}
//     ]
//   },
//   {
//     "mcqId": 8,
//     "mcqType": "SimpleMcq",
//     "mcqQuestion": "What is the name of Black Widow?",
//     "options": [
//       {"optionId": 1, "optionName": "Natasha Romanoff"},
//       {"optionId": 2, "optionName": "Wanda Maximoff"},
//       {"optionId": 3, "optionName": "Carol Danvers"},
//       {"optionId": 4, "optionName": "Hope van Dyne"}
//     ]
//   },
//   {
//     "mcqId": 9,
//     "mcqType": "SimpleMcq",
//     "mcqQuestion": "Who is the first Avenger?",
//     "options": [
//       {"optionId": 1, "optionName": "Iron Man"},
//       {"optionId": 2, "optionName": "Captain America"},
//       {"optionId": 3, "optionName": "Thor"},
//       {"optionId": 4, "optionName": "Hulk"}
//     ]
//   },
//   {
//     "mcqId": 10,
//     "mcqType": "ImageBasedQuestion",
//     "imageUrl": "https://e0.pxfuel.com/wallpapers/778/909/desktop-wallpaper-thanos-thanos-army-darkseid-vs-thanos.jpg",
//     "mcqQuestion": "What is the name of the army led by Thanos?",
//     "options": [
//       {"optionId": 1, "optionName": "Chitauri"},
//       {"optionId": 2, "optionName": "Kree"},
//       {"optionId": 3, "optionName": "Skrulls"},
//       {"optionId": 4, "optionName": "Dark Elves"}
//     ]
//   }
// ]
// ''';

//     List<dynamic> parsedJson = jsonDecode(jsonData);
//     List<McqItem> mcqDatalist = parsedJson.map((json) => McqItem.fromJson(json)).toList();
//     mcqData.value = mcqDatalist;
//   }

//   void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//       (Timer timer) {
//         if (_start.value == 0) {
//           timer.cancel();
//           _onimeUp(context);
//         } else {
//           _start.value--;
//         }
//       },
//     );
//   }

//   String get timerText {
//     int hours = _start.value ~/ 3600;
//     int minutes = (_start.value % 3600) ~/ 60;
//     int seconds = _start.value % 60;
//     return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Obx(() => SafeArea(
//           child: Scaffold(
//             backgroundColor: Colors.grey[200],
//             appBar: AppBar(
//               iconTheme: IconThemeData(color: ColorPage.white),
//               leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
//               centerTitle: false,
//               backgroundColor: ColorPage.appbarcolor,
//               title: Text(
//                 '10th Social Exam-1 Mock Exam',
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
//               ),
//               actions: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         SizedBox(width: 20),
//                         Icon(
//                           Icons.alarm_outlined,
//                           color: ColorPage.white,
//                         ),
//                         Text(
//                           ' $timerText',
//                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             body: Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black12,
//                                           offset: Offset(8, 8),
//                                           blurRadius: 10,
//                                         )
//                                       ],
//                                     ),
//                                     padding: EdgeInsets.symmetric(vertical: 15),
//                                     child: Text(
//                                       textAlign: TextAlign.center,
//                                       'Questions',
//                                       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black12,
//                                             offset: Offset(8, 8),
//                                             blurRadius: 10,
//                                           )
//                                         ]),
//                                     padding: EdgeInsets.symmetric(vertical: 15),
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           textAlign: TextAlign.center,
//                                           mcqData[qindex.value].mcqQuestion,
//                                           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
//                                         ),
//                                         if (mcqData[qindex.value].imageUrl != null)
//                                           Padding(
//                                             padding: const EdgeInsets.all(15),
//                                             child: Image.network(mcqData[qindex.value].imageUrl!),
//                                           ),
//                                         if (mcqData[qindex.value].videoUrl != null)
//                                           Container(
//                                             margin: EdgeInsets.symmetric(vertical: 20),
//                                             child: AspectRatio(
//                                               aspectRatio: 16 / 9,
//                                               child: Container(
//                                                 child: Text("Video Placeholder"), // replace with a video player
//                                               ),
//                                             ),
//                                           ),
//                                         Container(
//                                           margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                                           color: Colors.black26,
//                                           height: 3,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                         child: SizedBox(
//                           height: height,
//                           child: Column(
//                             children: [
//                               SizedBox(height: 20),
//                               SizedBox(
//                                 height: MediaQuery.of(context).size.height / 2.4,
//                                 child: ListView.builder(
//                                   physics: mcqData[qindex.value].options.length < 5
//                                       ? NeverScrollableScrollPhysics()
//                                       : AlwaysScrollableScrollPhysics(),
//                                   itemCount: mcqData[qindex.value].options.length,
//                                   itemBuilder: (context, index) {
//                                     int optionId = mcqData[qindex.value].options[index].optionId;
//                                     int questionId = mcqData[qindex.value].mcqId;
//                                     bool isSelected = userAns[questionId] == optionId;
//                                     bool isCorrect = answer.any((map) => map[questionId] == optionId);
//                                     bool isAnswered = userAns.containsKey(questionId);

//                                     Color tileColor;
//                                     if (isSubmitted.value) {
//                                       if (isCorrect) {
//                                         tileColor = Colors.green;
//                                       } else if (isSelected && !isCorrect) {
//                                         tileColor = Colors.red;
//                                       } else {
//                                         tileColor = Colors.white; // default color
//                                       }
//                                     } else {
//                                       tileColor = isSelected ? Colors.blue : Colors.white; // default color
//                                     }

//                                     return Padding(
//                                       padding: EdgeInsets.symmetric(vertical: 10),
//                                       child: AnimatedContainer(
//                                         duration: Duration(milliseconds: 600),
//                                         curve: Curves.easeInOut,
//                                         height: 60,
//                                         decoration: BoxDecoration(
//                                           color: tileColor,
//                                           borderRadius: BorderRadius.circular(8),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: Colors.black12,
//                                               blurRadius: 10,
//                                               offset: Offset(0, 5),
//                                             ),
//                                           ],
//                                         ),
//                                         child: Material(
//                                           color: Colors.transparent,
//                                           child: InkWell(
//                                             borderRadius: BorderRadius.circular(8),
//                                             onTap: () {
//                                               if (!isSubmitted.value) {
//                                                 userAns[questionId] = optionId;
//                                               }
//                                             },
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.symmetric(horizontal: 16),
//                                                   child: Text(
//                                                     mcqData[qindex.value].options[index].optionName,
//                                                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   MaterialButton(
//                                     height: 40,
//                                     color: ColorPage.appbarcolorcopy,
//                                     padding: EdgeInsets.all(16),
//                                     shape: ContinuousRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12)),
//                                     onPressed: () {
//                                       if (qindex.value > 0) {
//                                         qindex.value--;
//                                       }
//                                     },
//                                     child: Text(
//                                       'Previous',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                   MaterialButton(
//                                     height: 40,
//                                     color: ColorPage.appbarcolorcopy,
//                                     padding: EdgeInsets.all(16),
//                                     shape: ContinuousRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12)),
//                                     onPressed: () {
//                                       if (qindex.value < mcqData.length - 1) {
//                                         qindex.value++;
//                                       } else if (qindex.value == mcqData.length - 1 &&
//                                           !isSubmitted.value) {
//                                         _onSubmitExam(context);
//                                       }
//                                     },
//                                     child: Text(
//                                       !isSubmitted.value && qindex.value == mcqData.length - 1
//                                           ? 'Submit'
//                                           : 'Next',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                     right: 10,
//                     top: 5,
//                     child: InkWell(
//                       onTap: () {
//                         showDialog(
//                             context: context,
//                             builder: (context) {
//                               return Padding(
//                                 padding: EdgeInsets.only(
//                                     left: MediaQuery.of(context).size.width / 8,
//                                     top: 40,
//                                     bottom: MediaQuery.of(context).size.width - 110),
//                                 child: Container(
//                                   padding: EdgeInsets.only(left: 10, right: 10, top: 30),
//                                   decoration: BoxDecoration(
//                                     color: ColorPage.bgcolor,
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(20),
//                                     ),
//                                   ),
//                                   child: Obx(()=>
//                                   Column(
//                                       children: [
//                                         Visibility(
//                                           visible: isSubmitted.value ? false : true,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               MaterialButton(
//                                                 height: 40,
//                                                 color: Colors.orange,
//                                                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                                                 shape: ContinuousRectangleBorder(
//                                                     borderRadius: BorderRadius.circular(12)),
//                                                 onPressed: () {
//                                                   if (reviewlist.contains(qindex.value)) {
//                                                   } else {
//                                                     reviewlist.add(qindex.value);
//                                                   }
//                                                 },
//                                                 child: Text(
//                                                   'Mark for Review',
//                                                   style: TextStyle(color: Colors.white),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 width: 30,
//                                               ),
//                                               MaterialButton(
//                                                 height: 40,
//                                                 color: Colors.blueGrey,
//                                                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                                                 shape: ContinuousRectangleBorder(
//                                                     borderRadius: BorderRadius.circular(12)),
//                                                 onPressed: () {
//                                                   reviewlist.remove(qindex.value);
//                                                 },
//                                                 child: Text(
//                                                   'Clear Response',
//                                                   style: TextStyle(color: Colors.white),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           height: 400,
//                                           padding: EdgeInsets.only(top: 20),
//                                           child: GridView.builder(
//                                             itemCount: mcqData.length,
//                                             gridDelegate:
//                                                 SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
//                                             itemBuilder: (context, index) {
//                                               return SingleChildScrollView(
//                                                 child: MaterialButton(
//                                                   height: 55,
//                                                   color: reviewlist.contains(index)
//                                                       ? Colors.amber
//                                                       : userAns.containsKey(index + 1)
//                                                           ? isSubmitted.value
//                                                               ? answer.any((map) =>
//                                                                       map[index + 1] ==
//                                                                       userAns[index + 1])
//                                                                   ? Colors.green
//                                                                   : Colors.red
//                                                               : Colors.blue
//                                                           : qindex.value == index
//                                                               ? Color.fromARGB(255, 13, 32, 79)
//                                                               : Colors.white,
//                                                   shape: CircleBorder(
//                                                       side: BorderSide(
//                                                           width: qindex.value == index ? 4 : 1,
//                                                           color: qindex.value == index
//                                                               ? ColorPage.white
//                                                               : Colors.black12)),
//                                                   onPressed: () {
//                                                     qindex.value = index;
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: Text(
//                                                     (index + 1).toString(),
//                                                     style: TextStyle(
//                                                         color: qindex.value == index
//                                                             ? Colors.white
//                                                             : Colors.black),
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             });
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: ColorPage.appbarcolorcopy,
//                             borderRadius: BorderRadius.all(Radius.circular(5))),
//                         padding: EdgeInsets.all(5),
//                         child: Icon(
//                           Icons.list_alt,
//                           color: ColorPage.white,
//                         ),
//                       ),
//                     ))
//               ],
//             ),
//           ),
//         ));
//   }

//   _onSubmitExam(context) {
//     int correctAnswers = 0;
//     userAns.forEach((questionId, selectedOptionId) {
//       if (answer.any((map) => map[questionId] == selectedOptionId)) {
//         correctAnswers++;
//       }
//     });

//     Alert(
//       context: context,
//       type: AlertType.info,
//       style: AlertStyle(
//         animationType: AnimationType.fromLeft,
//         titleStyle: TextStyle(color: ColorPage.red, fontWeight: FontWeight.bold),
//         descStyle: FontFamily.font6,
//         isCloseButton: false,
//       ),
//       title: "Are You Sure?",
//       desc: "Once You submit, You can't Change your Sheet \n If you are sure then Click on 'Yes' Button",
//       buttons: [
//         DialogButton(
//           child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 18)),
//           highlightColor: Color.fromRGBO(77, 3, 3, 1),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           color: Color.fromRGBO(158, 9, 9, 1),
//         ),
//         DialogButton(
//           child: Text("Yes", style: TextStyle(color: Colors.white, fontSize: 18)),
//           highlightColor: Color.fromRGBO(77, 3, 3, 1),
//           onPressed: () {
//             _timer.cancel();
//             score.value = correctAnswers;

//             isSubmitted.value = true;
//             Navigator.pop(context);
//           },
//           color: Color.fromRGBO(9, 89, 158, 1),
//         ),
//       ],
//     ).show();
//   }

//   _onimeUp(context) {
//     _onSubmitExam(context);
//     Alert(
//       context: context,
//       type: AlertType.info,
//       style: AlertStyle(
//         animationType: AnimationType.fromTop,
//         titleStyle: TextStyle(color: ColorPage.red, fontWeight: FontWeight.bold),
//         descStyle: FontFamily.font6,
//         isCloseButton: false,
//       ),
//       title: "Your Time is Up !!",
//       desc: "Sorry! But Your time is over. \n Your Exam has been submitted.",
//       buttons: [
//         DialogButton(
//           child: Text("OK", style: TextStyle(color: Colors.white, fontSize: 18)),
//           highlightColor: Color.fromRGBO(3, 77, 59, 1),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           color: Color.fromRGBO(9, 89, 158, 1),
//         ),
//       ],
//     ).show();
//   }

//   _onincompleteSubmission(context) {
//     Alert(
//       context: context,
//       type: AlertType.info,
//       style: AlertStyle(
//         animationType: AnimationType.fromLeft,
//         titleStyle: TextStyle(color: ColorPage.red, fontWeight: FontWeight.bold),
//         descStyle: FontFamily.font6,
//         isCloseButton: false,
//       ),
//       title: "Your Sheet is Incomplete",
//       desc: "Your Answer sheet is Incomplete. \n Are you Sure to Submit then Click on Yes Button.  ",
//       buttons: [
//         DialogButton(
//           child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 18)),
//           highlightColor: Color.fromRGBO(77, 3, 3, 1),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           color: Color.fromRGBO(177, 58, 58, 1),
//         ),
//         DialogButton(
//           child: Text("Yes", style: TextStyle(color: Colors.white, fontSize: 18)),
//           highlightColor: Color.fromRGBO(3, 77, 59, 1),
//           onPressed: () {
//             isSubmitted.value = true;
//             Navigator.pop(context);
//           },
//           color: Color.fromRGBO(9, 89, 158, 1),
//         ),
//       ],
//     ).show();
//   }
// }
