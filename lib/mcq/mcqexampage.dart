import 'package:dthlms/widget/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class McqExamPage extends StatefulWidget {
  const McqExamPage({super.key});

  @override
  State<McqExamPage> createState() => _McqExamPageState();
}


class _McqExamPageState extends State<McqExamPage> {

  bool isNumberPadVisible = false;
  RxBool selecte=false.obs;
  String selectedNumber = 'Select a number';
var timerStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20);
var headerStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 20);
var optionStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 15);

List options = ['A) 56', 'B) 6', 'C) 5566', 'D) All'];
int selectedIndex = -1;

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
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            height: 60,
            decoration: BoxDecoration(
              color: selectedIndex == index ? Colors.blue[200] : Colors.white,
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        options[index].toString(),
                        style: optionStyle,
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
                            height: 60,
                     color: Colors.blueAccent,
                        padding: EdgeInsets.all(16),
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                  
                onPressed: () {
                  
                },
                        child: Text('Previous',style: TextStyle(color: Colors.white),),
                      ),
                       MaterialButton(
                        height: 60,
                     color: Colors.greenAccent[400],
                        padding: EdgeInsets.all(16),
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                  
                onPressed: () {
                  
                },
                        child: Text('Save & Next',style: TextStyle(color: Colors.white),),
                      ),
                        ],)
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
                              child: Column(
                                children: [
                                
                                 
                                  
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Group A',
                                          style: headerStyle,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              // selecte.value=!selecte.value;
                                            },
                                            icon:
                                                Icon(Icons.keyboard_arrow_down))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                       decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                                                                    'Group B',
                                                                  
                                          style: headerStyle,
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              // selecte.value=!selecte.value;
                                            },
                                            icon:
                                                Icon(Icons.keyboard_arrow_down))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                              
                                  Container(
                                       decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                                                       'Group C',
                                                                      
                                              style: headerStyle,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  selecte.value=!selecte.value;
                                                },
                                                icon:
                                                    Icon(Icons.keyboard_arrow_down))
                                          ],
                                        ),
                                         Obx(()=>
                                     Visibility(
                                      visible: selecte.value,
                                       child: AnimatedContainer(
                                        duration: Duration(milliseconds: 600),
                                        curve: Curves.bounceOut,
                                         child: SizedBox(
                                          height: 400,
                                          child: Expanded(
                                            child: GridView.builder(
                                              itemCount: 60,
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: MaterialButton(
                                                 
                                                  shape: CircleBorder(side: BorderSide(color: Colors.black12)),
                                                  onPressed: (){
                                                                                        
                                                },
                                                child: Text(index.toString()),
                                                ),
                                              );
                                            },),
                                          ),
                                                                               ),
                                       ),
                                     ),
                                  )
                                      ],
                                    ),
                                  ),
                                 
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                                height: 60,
                                                 color: Colors.grey,
                            padding: EdgeInsets.all(16),
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                                              
                                            onPressed: () {
                                              
                                            },
                            child: Text('Mark for Review',style: TextStyle(color: Colors.white),),
                                                  ),
                                                  MaterialButton(
                            height: 60,
                     color: Colors.orange,
                        padding: EdgeInsets.all(16),
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                  
                onPressed: () {
                  
                },
                        child: Text('Clear Responce',style: TextStyle(color: Colors.white),),
                      )
                          ],
                        ),
                       
                        // SizedBox(
                        //   height: 20,
                        // ),
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
