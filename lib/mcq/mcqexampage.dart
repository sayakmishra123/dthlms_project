import 'package:dthlms/widget/mybutton.dart';
import 'package:flutter/material.dart';

class McqExamPage extends StatefulWidget {
  const McqExamPage({super.key});

  @override
  State<McqExamPage> createState() => _McqExamPageState();
}

var timerStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20);
var headerStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20);
var optionStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 15);

List options = ['A) 56', 'B) 6', 'C) 5566', 'D) All'];

class _McqExamPageState extends State<McqExamPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(
            '10th Social Exam-1 Mock Exam',
            style: timerStyle,
          ),
          actions: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Time : 3:05 mins',
                        style: timerStyle,
                      ),
                    ],
                  ),
                  Text(
                    '10th Social Exam-1 Mock Exam',
                    style: timerStyle,
                  ),
                  Row(
                    children: [
                      MyButton(
                          btncolor: Colors.white,
                          onPressed: () {},
                          mychild: 'Submit',
                          mycolor: Colors.orangeAccent),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        
        bottomNavigationBar: Container(
          color: Colors.white,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  MyButton(
                    btncolor: Colors.grey,
                    mychild: 'Mark for Review',
                    mycolor: Colors.orangeAccent,
                    onPressed: () {
                      // Add your functionality here
                    },
                  ),
                  SizedBox(width: 20,),
                  MyButton(
                    btncolor: Colors.red,
                    mychild: 'Clear Responce',
                    mycolor: Colors.orangeAccent,
                    onPressed: () {
                      // Add your functionality here
                    },
                  ),
                  // MyButton(
                  //   btncolor: Colors.grey,
                  //   mychild: 'Bookmark',
                  //   mycolor: Colors.orangeAccent,
                  //   onPressed: () {
                  //     // Add your functionality here
                  //   },
                  // ),
                  // MyButton(
                  //   btncolor: Colors.grey,
                  //   mychild: 'Report',
                  //   mycolor: Colors.orangeAccent,
                  //   onPressed: () {
                  //     // Add your functionality here
                  //   },
                  // ),
                ],
              ),
              Row(
                children: [
                  MyButton(
                    btncolor: Colors.blue,
                    mychild: 'Previous',
                    mycolor: Colors.orangeAccent,
                    onPressed: () {
                      // Add your functionality here
                    },
                  ),
                  SizedBox(width: 20,),
                  MyButton(
                    btncolor: Colors.greenAccent,
                    mychild: 'Save & Next',
                    mycolor: Colors.orangeAccent,
                    onPressed: () {
                      // Add your functionality here
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  // color: Colors.blue,
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
                                  'Question : 1',
                                  style: headerStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium ipsa magni tempore, atque quaerat architecto, distinctio laborum asperiores id et consectetur similique dicta eos hic aspernatur, impedit vel. Iusto, tempora.",
                                      style: headerStyle,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      color: Colors.black26,
                                      height: 3,
                                    ),
                                    Image.network(
                                        'https://sigma-docs-screenshots.s3.us-west-2.amazonaws.com/Workbooks/Visualizations/Build+a+Bar+Chart/bar-chart.png'),
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
                  // color: Colors.blue,
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
                                  style: headerStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 20),
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
                                          vertical: 16, horizontal: 10),
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        options[index].toString(),
                                        style: optionStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
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
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                child: Column(
                                  children: [
                                    DropdownMenu(dropdownMenuEntries: [])
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       'Options',
                                    //       style: headerStyle,
                                    //     ),
                                    //     IconButton(
                                    //         onPressed: () {},
                                    //         icon:
                                    //             Icon(Icons.keyboard_arrow_down))
                                    //   ],
                                    // ),
                                    ,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Options',
                                          style: headerStyle,
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon:
                                                Icon(Icons.keyboard_arrow_down))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        // drop down
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
