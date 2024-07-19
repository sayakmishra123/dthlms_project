import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/android/MCQ/mockTestAns.dart';
import 'package:dthlms/mcq/modelclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';

class RankPage extends StatefulWidget {
final List<McqItem> mcqData;
  final Map<int, int> userAns;
  final List<Map<int, int>> correctAnswers;
  final int totalnomber;

  RankPage({
    required this.mcqData,
    required this.userAns,
    required this.correctAnswers,
    required this.totalnomber
  });

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> with SingleTickerProviderStateMixin{


    bool _isLottieVisible = true;
  late AnimationController _animationController;
  List<Map<String, dynamic>> dummyData = [
    {
      'rank': 1,
      'image': 'https://picsum.photos/500/500',
      'level': 9.5,
      'project': 3.8,
      'name': 'Alice'
    },
    {
      'rank': 2,
      'image': 'https://picsum.photos/500/500',
      'level': 8.7,
      'project': 4.2,
      'name': 'Bob'
    },
    {
      'rank': 3,
      'image': 'https://picsum.photos/500/500',
      'level': 7.8,
      'project': 3.5,
      'name': 'Charlie'
    },
    {
      'rank': 4,
      'image': 'https://picsum.photos/500/500',
      'level': 8.3,
      'project': 3.9,
      'name': 'David'
    },
    {
      'rank': 5,
      'image': 'https://picsum.photos/500/500',
      'level': 9.1,
      'project': 4.0,
      'name': 'Eve'
    },
    {
      'rank': 6,
      'image': 'https://picsum.photos/500/500',
      'level': 7.5,
      'project': 3.7,
      'name': 'Frank'
    },
    {
      'rank': 7,
      'image': 'https://picsum.photos/500/500',
      'level': 8.0,
      'project': 3.6,
      'name': 'Grace'
    },
    {
      'rank': 8,
      'image': 'https://picsum.photos/500/500',
      'level': 7.9,
      'project': 4.1,
      'name': 'Hank'
    },
    {
      'rank': 9,
      'image': 'https://picsum.photos/500/500',
      'level': 8.6,
      'project': 3.4,
      'name': 'Ivy'
    },
    {
      'rank': 10,
      'image': 'https://picsum.photos/500/500',
      'level': 9.0,
      'project': 3.8,
      'name': 'Jack'
    }
  ];

   void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8), // Adjust this duration to match your Lottie animation
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isLottieVisible = false;
          });
        }
      });

    _animationController.forward();
  }

  var rankStyle = TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   
   

    

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottomOpacity: 0.99,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: ColorPage.appbarcolorcopy,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              onPressed: () {

                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios_new_outlined)),
          title: Text(
            'Leaderboard',
            style: TextStyle(color: Colors.white),
          ),
          actions: [IconButton(onPressed: (){

            Get.to(()=>MocktestAnswer(mcqData:widget.mcqData, userAns: widget.userAns, correctAnswers: widget.correctAnswers));
          }, icon: Icon(Icons.list_alt_rounded))],
        
        ),
        
        body: Stack(
          children: [
            Column(
              children: [
                 Container(
                    color: Colors.white,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image( color: ColorPage.appbarcolorcopy, image: AssetImage('assets/topbg.png')),
                        Positioned(
                          top: 40,
                          left: 20,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      Colors.white,
                                    ]),
                                borderRadius: BorderRadius.circular(4)),
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  'assets/sorojda.png',
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 90,
                          child: SizedBox(
                              height: 80, child: Image.asset('assets/rank2.png')),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.amber.shade300,
                                    Colors.amber.shade800,
                                  ]),
                              borderRadius: BorderRadius.circular(4)),
                          child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset(
                                'assets/sorojda.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                        Positioned(
                          top: 50,
                          child: SizedBox(
                              height: 80, child: Image.asset('assets/rank1.png')),
                        ),
                        Positioned(
                          right: 20,
                          top: 40,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      Colors.white,
                                    ]),
                                borderRadius: BorderRadius.circular(4)),
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Image.asset(
                                  'assets/sorojda.png',
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          top: 90,
                          child: SizedBox(
                              height: 80, child: Image.asset('assets/rank3.png')),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text('Rank'),
                        ],
                      ),
                      Text('Name'),
                      Row(
                        children: [
                          Text('Score'),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: dummyData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        surfaceTintColor: Colors.blue,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          // titleAlignment: title,
                          leading: index == 0
                              ? SizedBox(
                                  height: 35,
                                  child: Image.asset('assets/rank1.png'))
                              : index == 1
                                  ? SizedBox(
                                      height: 35,
                                      child: Image.asset('assets/rank2.png'))
                                  : index == 2
                                      ? SizedBox(
                                          height: 35,
                                          child: Image.asset('assets/rank3.png'))
                                      : Text('#${dummyData[index]['rank']}',
                                          style: TextStyle(fontSize: 15)),
                          title: Center(
                            child: Text(
                              '${dummyData[index]['name']} hello',
                              style: TextStyle(
                                  color: Colors.black54, fontWeight: FontWeight.w600),
                            ),
                          ),
                          trailing: Text(
                            '${dummyData[index]['project']}',
                            style: TextStyle(
                                color: Colors.red[400],
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            
              ],
            ),

            
           Positioned(
                    bottom: 20,
                    left: 5,
                    right: 5,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: ColorPage.appbarcolorcopy,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                '50',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Text(
                                'Floating Container',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                               widget.totalnomber.toString(),
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isLottieVisible,
                    child: Positioned(
                      left: 5,
                      right: 5,
                      child: Container(
                        height: 600,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: LottieBuilder.asset(
                            'assets/C2.json',
                            repeat: false,
                            controller: _animationController,
                          ),
                        ),
                      ),
                    ),
                  ),
            ],
        ));
  }
}