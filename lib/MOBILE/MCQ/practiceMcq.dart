import 'dart:async';
import 'dart:convert';

import 'package:dthlms/PC/MCQ/modelclass.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
// import 'package:dthlms/widget/mybutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PracticeMcqMobile extends StatefulWidget {
  const PracticeMcqMobile({super.key});

  @override
  State<PracticeMcqMobile> createState() => _PracticeMcqMobileState();
}

class _PracticeMcqMobileState extends State<PracticeMcqMobile> {
  List<Map<int, int>> answer = [
    {1: 2},
    {2: 3},
    {3: 2},
    {4: 1},
    {5: 1},
    {6: 5},
    {7: 2},
    {8: 1},
    {9: 2},
    {10: 1},
  ];
  Map<int, int> userAns = {};

  Getx getx_obj = Get.put(Getx());
  RxBool buttonshow = false.obs;

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
      {"optionId": 4, "optionName": "Dark Elves"},
      {"optionId": 5, "optionName": "Dark Elves"},
      {"optionId": 6, "optionName": "Dark Elves"},
      {"optionId": 7, "optionName": "Dark Elves"},
      {"optionId": 8, "optionName": "Dark Elves"}
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  String groupname = 'Questions';

  List<int> wrongsavelist = [];
  List<int> rightsavelist = [];

  RxInt qindex = 0.obs;
  int selectedIndex = -1;

  List<McqItem> mcqData = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          
          iconTheme: IconThemeData(color: ColorPage.white),
          automaticallyImplyLeading: true,
          centerTitle: false,
          backgroundColor:ColorPage.appbarcolor,
          title: Text(
            '10th Social Exam-1 Practice Exam',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
      
                IconButton(onPressed: (){
                  showDialog(context: context, builder: (context) {
                    return    Padding(
                      padding: const EdgeInsets.only(left: 50,top: 40,bottom: 300),
                      child: Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 30),
                    decoration: BoxDecoration(    color: ColorPage.bgcolor,borderRadius: BorderRadius.all(Radius.circular(20)))
                    ,
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
                                              color: wrongsavelist.contains(index)
                                                  ? Color.fromARGB(255, 214, 8, 29)
                                                  : rightsavelist.contains(index)
                                                      ? Color.fromARGB(
                                                          255, 13, 146, 24)
                                                      : qindex.value == index
                                                          ? Color.fromARGB(
                                                              255, 8, 10, 79)
                                                          : Colors.white,
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                      width: qindex.value == index
                                                          ? 4
                                                          : 1,
                                                      color: qindex.value == index
                                                          ? Colors.white
                                                          : Colors.black12)),
                                              onPressed: () {
                                                qindex.value = index;
                                                Navigator.pop(context);
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
                    );
                  },);
                }, icon: Icon(Icons.list_alt_rounded,size: 35,)),
               
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ],
        ),
        body: Obx(() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
             
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                                            mcqData[qindex.value].imageUrl!),
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
                  Container(
                  
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: SizedBox(
                      height: height,
                      child: Column(
                        children: [
                      
                         
                          SizedBox(
                            height: MediaQuery.of(context).size.height/2.4,
                            child: ListView.builder(
                           physics:mcqData[qindex.value].options.length<5? NeverScrollableScrollPhysics():AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: mcqData[qindex.value].options.length,
                              itemBuilder: (context, index) {
                                int optionId = mcqData[qindex.value]
                                    .options[index]
                                    .optionId;
                                int questionId = mcqData[qindex.value].mcqId;
                                bool isSelected =
                                    userAns[questionId] == optionId;
                                bool isCorrect = answer
                                    .any((map) => map[questionId] == optionId);
                                bool isAnswered =
                                    userAns.containsKey(questionId);
                  
                                Color tileColor;
                                if (isAnswered) {
                                  if (isSelected && isCorrect) {
                                    tileColor = Colors.green;
                                  } else if (isSelected && !isCorrect) {
                                    tileColor = Colors.red;
                                  } else if (isCorrect) {
                                    tileColor = Colors.green;
                                  } else {
                                    tileColor = Colors.white; // default color
                                  }
                                } else {
                                  tileColor = Colors.white; // default color
                                }
                  
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 600),
                                    curve: Curves.easeInOut,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: tileColor,
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
                                            if (!wrongsavelist
                                                    .contains(qindex.value) &&
                                                !rightsavelist
                                                    .contains(qindex.value)) {
                                              userAns[questionId] = optionId;
                                              isCorrect
                                                  ? rightsavelist
                                                      .add(qindex.value)
                                                  : wrongsavelist
                                                      .add(qindex.value);
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  height: 40,
                                  color: Colors.blueAccent,
                                  padding: EdgeInsets.all(16),
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
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
                                      borderRadius: BorderRadius.circular(12)),
                                  onPressed: () {
                                    if (qindex.value < mcqData.length - 1) {
                                      // savelist.add(qindex.value);
                                      qindex.value++;
                                    } else if (qindex.value ==
                                        mcqData.length - 1) {
                                      // savelist.add(qindex.value);
                                      mcqData.length!=userAns.length?_onincompleteSubmission(context):
                                      _onSubmitExam(context);
                                    }
                                  },
                                  child: Text(
                                    qindex.value == mcqData.length - 1
                                        ? 'Reset'
                                        : 'Next',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                 
                ],
              ),
            )),
      ),
    );
  }

  _onSubmitExam(context) {
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
      title: "Are you Sure?",
      desc:
          "If you are sure to Restartt Your Practice. \n Then Click on Yes Button.  ",
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
              userAns.clear();
              wrongsavelist.clear();
              rightsavelist.clear();

              qindex = 0.obs;
              selectedIndex = -1;
            });
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
          "Your Answer sheet is Incomplete. \n Are you Sure to Resrt then Click on Yes Button.  ",
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
              userAns.clear();
              wrongsavelist.clear();
              rightsavelist.clear();

              qindex = 0.obs;
              selectedIndex = -1;
            });
            Navigator.pop(context);
          },
          color: Color.fromRGBO(9, 89, 158, 1),
        ),
      ],
    ).show();
  }

  _ontimeUp(context) {
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
      desc:
          "Sorry! But Your time is over. \n To Submit your Answer Clik Ok Button  ",
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



    void showCornerDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 300,
              height: 200,
              margin: EdgeInsets.only(bottom: 50, right: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text('This is a custom dialog!'),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim, secondaryAnim, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1, 1),
            end: Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
    );
  }
}
