// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:dthlms/MOBILE/FORGETPASSWORD/forgetpassword_screen.dart';
import 'package:dthlms/MOBILE/HOMEPAGE/homepage_mobile.dart';
import 'package:dthlms/MOBILE/LOGIN/loginpage_mobile.dart';
import 'package:dthlms/MOBILE/MCQ/mcqCondition.dart';
import 'package:dthlms/MOBILE/MCQ/mockTestAns.dart';
import 'package:dthlms/MOBILE/MCQ/mockTestMcq.dart';
import 'package:dthlms/MOBILE/MCQ/mockTestRank.dart';
import 'package:dthlms/MOBILE/MCQ/practiceMcq.dart';
import 'package:dthlms/MOBILE/SIGNIN_OTP/OtpScreen.dart';
// import 'package:dthlms/MOBILE/VIDEO/mobileVideoDashboard.dart';
// import 'package:dthlms/MOBILE/VIDEO/mobileVideoPlayer.dart';
import 'package:dthlms/PC/HOMEPAGE/homepage.dart';
import 'package:dthlms/PC/LOGIN/login.dart';
import 'package:dthlms/PC/MCQ/ResultPage.dart';
import 'package:dthlms/PC/MCQ/macterm&conditionpage.dart';
import 'package:dthlms/PC/MCQ/mockTestmcqPage.dart';
import 'package:dthlms/PC/MCQ/practiceMcqPage.dart';
// import 'package:dthlms/PC/VIDEO/videocontent.dart';
import 'package:dthlms/THEORY_EXAM/theoryexampage.dart';
// import 'package:dthlms/package/packagedashboard/newPackageDashboard.dart';


// import 'package:dthlms/package/packagedashboard/packagedashboard.dart';
// import 'package:dthlms/package/packagevideo.dart/videodashboard.dart';
// // import 'package:dthlms/package/packagevideo.dart/videorelatetedPage.dart';


import 'package:get/get.dart';

class pageRouter {
  List<GetPage<dynamic>>? Route = [
    GetPage(
      name: '/',
      page: () => const DthLmsLogin(),
    ),
 
  
 
   
    GetPage(
      name: '/Mobilelogin',
      page: () => const Mobilelogin(),
    ),
   
    GetPage(
      name: '/Mobileforgetpassword',
      page: () => ForgetPasswordMobile(),
    ),
    
    GetPage(
      name: '/Mobilesigninotpscreen',
      page: () => SignInOtpScreen(),
    ),
  
  
  
 
 
    GetPage(
      name: "/Newmobilepakagedashboard",
      // page: () => NewPackageDashboardMobile(),
      // changed by shubha
      page: () => DashBoardMobile(),

    ),
  
    GetPage(
      name: "/Theoryexampage",
      page: () => TheoryExamPage(),
    ),
    GetPage(
      name: "/Mcqtermandcondition",
      page: () => McqTermAndCondition(),
    ),
    GetPage(
      name: "/Mocktestmcqexampage",
      page: () => MockTestMcqExamPage(),
    ),
    GetPage(
      name: "/Practicemcq",
      page: () => PracticeMcq(),
    ),
    GetPage(
      name: "/Mocktestresult",
      page: () => MockTestresult(),
    ),
    GetPage(
      name: "/Mcqterandconditionmobile",
      page: () => McqTermAndConditionmobile(),
    ),
    GetPage(
      name: "/Mocktestanswermobile",
      page: () => MocktestAnswer(),
    ),
    GetPage(
      name: "/Mocktestexampagemobile",
      page: () => MockTestMcqExamPageMobile(),
    ),
    GetPage(
      name: "/Mocktestrankpagemobile",
      page: () => RankPage(),
    ),
    GetPage(
      name: "/Practicemcqmobile",
      page: () => PracticeMcqMobile(),
    ),
    GetPage(name: "/Homepage", page:()=> DthDashboard())
  ];
}
