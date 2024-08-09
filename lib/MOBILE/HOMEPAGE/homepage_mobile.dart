import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dthlms/ACTIVATION_WIDGET/enebelActivationcode.dart';
import 'package:dthlms/API/ALL_FUTURE_FUNTIONS/all_functions.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:dthlms/MOBILE/PACKAGE_DASHBOARD/Package_Video_dashboard.dart';
import 'package:dthlms/MOBILE/PACKAGE_DASHBOARD/package_List.dart';
import 'package:dthlms/PC/HOMEPAGE/homepage.dart';
import 'package:dthlms/THEME_DATA/FontSize/FontSize.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:rflutter_alert/rflutter_alert.dart';


class DashBoardMobile extends StatefulWidget {
  String token;
   DashBoardMobile({super.key,required this.token});

  @override
  State<DashBoardMobile> createState() => _DashBoardMobileState();
}

class _DashBoardMobileState extends State<DashBoardMobile> {
    TextEditingController activationfield = TextEditingController();
  int selectedIndex = -1;

      enterActivationKey(context,String token) {
        
   
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: true,
        alertPadding: EdgeInsets.only(top: 300),
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle:
            TextStyle(color: ColorPage.blue, fontWeight: FontWeight.bold),
        constraints: BoxConstraints.expand(width: 600),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.center);

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      // type: AlertType.info,

      title: "ACTIVATION CODE",

      content: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  'Please fill field *',
                  style: TextStyle(color: ColorPage.red, fontSize: 12),
                ),
              ),
            ],
          ),
          Obx(() => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  // controller: activationfield,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'cannot blank';
                    }
                    return null;
                  },
                  obscureText: getx.passvisibility.value,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.code),
                      suffixIcon: IconButton(
                          onPressed: () {
                            getx.passvisibility.value =
                                !getx.passvisibility.value;
                          },
                          icon: getx.passvisibility.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      labelText: 'Enter Activation Code',
                      // hintText: 'Enter Activation Code',

                      filled: false,
                      focusColor: ColorPage.white),
                ),
              ))
        ],
      )),
      buttons: [
        DialogButton(
          width: MediaQuery.of(context).size.width / 1.3,
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {  Get.back(); packactivationKey(context, activationfield.text, token);
            
          },
          color: ColorPage.colorgrey,
          radius: BorderRadius.circular(5.0),
        ),
      ],
    ).show();
  }
  Getx getx =Get.put(Getx());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          getx.isActivationKeySet.value? IconButton(icon: Icon(Icons.add), onPressed: () {enterActivationKey(context,widget.token);}):SizedBox(),
          Padding(
            padding: const EdgeInsets.only(right: 20,left: 5),
            child: Icon(
              Icons.notification_add_sharp,
              color: Colors.black,
              weight: 5,
            ),
          )
        ],
      ),
      drawer: HomePageDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10,),
            child: Column(
              children: [
           
                HeadingBoxMobile(),

               getx.isActivationKeySet.value? Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 192, 191, 191),
                            offset: Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = constraints.maxWidth;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Basic of tax class by Avinush Sureka',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                            ),
                                            textScaleFactor: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                               Flexible(
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      double screenWidth = constraints.maxWidth;

                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          MaterialButton(
                                            shape: ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth *
                                                  0.05, // Adjusted for responsiveness
                                              vertical: 5,
                                            ),
                                            color: Color.fromARGB(
                                                255, 253, 29, 13),
                                            onPressed: () {},
                                            child: Text(
                                              'Live class',
                                              style: FontFamily.font2.copyWith(
                                                fontSize: ClsFontsize
                                                    .DoubleExtraSmall,
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

                            SizedBox(
                                width: screenWidth *
                                    0.02), // Spacing between texts
                            Text(
                              '5:00-7:00',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: ColorPage.grey,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ):Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 192, 191, 191),
                            offset: Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = constraints.maxWidth;

                        return Row(
                          children: [
                            Flexible(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  double screenWidth = constraints.maxWidth;
                        
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                       Container(
                             child: Text(
                               'Get your Packages here',
                               style: TextStyle(
                                 fontSize: ClsFontsize.ExtraSmall,
                                 fontWeight: FontWeight.w800,
                               ),
                               
                             ),
                           ),
                                      MaterialButton(
                                        shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth *
                                              0.05, // Adjusted for responsiveness
                                          vertical: 5,
                                        ),
                                        color: ColorPage.colorbutton,
                                        onPressed: () {enterActivationKey(context,widget.token);},
                                        child: Text(
                                          'Activate',
                                          style: FontFamily.font2.copyWith(
                                            fontSize: ClsFontsize
                                                .DoubleExtraSmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          
                          ],
                        );
                      },
                    ),
                  ),
                ),
                CalenderWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

learningGoals(context) {
  Alert(
    context: context,
    type: AlertType.none,
    buttons: [],
    style: AlertStyle(
      titleStyle: TextStyle(color: ColorPage.red),
      descStyle: FontFamily.font6,
      isButtonVisible: false,
      isCloseButton: false,
    ),
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorPage.colorbutton,
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
            ),
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Flutter Certification Exam',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '2024-08-15',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.video_library,
                          size: 30, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text('10 ',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      Text('Videos',
                          style: FontFamily.font3.copyWith(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: ClsFontsize.DoubleExtraSmall)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Text("15 Hours",
                        style: FontFamily.font3.copyWith(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: ClsFontsize.DoubleExtraSmall)),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.picture_as_pdf,
                          size: 30, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text('5 ',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                      Text('PDFs',
                          style: FontFamily.font3.copyWith(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: ClsFontsize.DoubleExtraSmall)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Text("10 Hours",
                        style: FontFamily.font3.copyWith(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: ClsFontsize.DoubleExtraSmall)),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.question_answer,
                          size: 30, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text('50 ',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                      Text('MCQs',
                          style: FontFamily.font3.copyWith(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: ClsFontsize.DoubleExtraSmall)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: Text(
                      "5 Hours",
                      style: FontFamily.font3.copyWith(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: ClsFontsize.DoubleExtraSmall),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Total Study Time: 30 hours',
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Total Remaining Day: 15',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Avg Time/Day: 2 hours',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  ).show();
}

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorPage.bgcolor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer header with user profile info
          DrawerHeader(
            decoration: BoxDecoration(color: ColorPage.colorbutton),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 33,
                      backgroundColor: ColorPage.white,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/sorojda.png'), // Replace with your asset path
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'John Doe', // Replace with dynamic username
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'johndoe@example.com', // Replace with dynamic email
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Drawer items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                drawerItem(
                  title: "Profile",
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                  leading:
                      Icon(Icons.account_circle, color: ColorPage.colorblack),
                ),
                drawerItem(
                  title: "Logout",
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  leading: Icon(Icons.exit_to_app, color: ColorPage.colorblack),
                ),
                drawerItem(
                  title: "More",
                  onTap: () {
                    Navigator.pushNamed(context, '/more');
                  },
                  leading: Icon(Icons.more_horiz, color: ColorPage.colorblack),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerItem(
      {required String title,
      required VoidCallback onTap,
      required Widget leading,
      Widget? trailing}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: leading,
        trailing: trailing,
        title: Text(
          title,
          style: TextStyle(
            color: ColorPage.colorblack,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        dense: true,
      ),
    );
  }
}

class HeadingBoxMobile extends StatefulWidget {
  @override
  State<HeadingBoxMobile> createState() => _HeadingBoxMobileState();
}

class _HeadingBoxMobileState extends State<HeadingBoxMobile> {
  final List<Widget> contentList = [
    HeadingBoxMobileContent(
        date: "May 29,2024",
        title: 'Welcome back, Reet!',
        desc: 'Always updated in your portal',
        isImage: false,
        imagePath: '',
        trailing: SizedBox()),
    HeadingBoxMobileContent(
      date: "May 29,2025",
      title: 'Welcome back, Reet!',
      desc: 'Always updated in your portal',
      imagePath: 'assets/no_data_found.jpg',
      trailing: SizedBox(),
      isImage: true,
    ),
    HeadingBoxMobileContent(
      date: "May 29,2026",
      title: 'Welcome back, Reet!',
      desc: 'Always updated in your portal',
      trailing: SizedBox(),
      imagePath: '',
      isImage: false,
    ),
    HeadingBoxMobileContent(
      date: "May 29,2027",
      title: 'Welcome back, Reet!',
      desc: 'Always updated in your portal',
      trailing: SizedBox(),
      imagePath: '',
      isImage: false,
    ),
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: CarouselSlider(
                items: contentList
                    .map((item) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorPage.colorbutton,
                                border: Border.all(
                                    color: ColorPage.white, width: 2)),
                            child: item,
                          ),
                        ))
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 0.98,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: contentList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: currentIndex == entry.key ? 18 : 10,
                  height: 7,
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorPage.colorbutton),
                      borderRadius: BorderRadius.circular(20),
                      color: currentIndex == entry.key
                          ? ColorPage.blue
                          : ColorPage.white),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class HeadingBoxMobileContent extends StatelessWidget {
  final String? date;
  final String? title;
  final String? desc;
  final Widget? trailing;
  final String imagePath;
  final bool isImage;
  const HeadingBoxMobileContent({
    super.key,
    this.date,
    this.title,
    this.desc,
    this.trailing,
    required this.isImage,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return isImage
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(
                  imagePath,
                ),
                fit: BoxFit.contain,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.sizeOf(context).height / 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          // textScaleFactor: 2,
                          date!,
                          style:
                              FontFamily.font.copyWith(color: ColorPage.white),
                          // textScaler: TextScaler.linear(2),
                        ),
                      ),
                      Flexible(
                        child: AutoSizeText(
                          title!,
                          // textScaleFactor: 1.5,
                          style:
                              FontFamily.font.copyWith(color: ColorPage.white),
                          // textScaler: TextScaler.linear(1.5),
                        ),
                      ),
                      Flexible(
                        child: AutoSizeText(
                          desc!,
                          style: FontFamily.font3,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              trailing!,
            ],
          );
  }
}


class HomePageMobile extends StatefulWidget {
  @override
  _HomePageMobileState createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  int _currentIndex = 0;
  
  String? token;

  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
   Getx getx = Get.put(Getx());
    token = Get.arguments['token'];
    _children = [
      DashBoardMobile(token: token!,),
      Mobile_Package_List(token: token!),
      MobilePackageVideoDashboard(),
    ];
  }

  final List<String> _titles = [
    'Home',
    'Search',
    'Profile',
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: ColorPage.white,

        onTap: onTabTapped,
        items: [
          Icon(Icons.home, size: 30, color: ColorPage.colorbutton),
          Icon(Icons.movie_filter_outlined, size: 30, color: ColorPage.colorbutton),
          Icon(Icons.person, size: 30, color: ColorPage.colorbutton),
        ],
      ),
    );
  }




}
