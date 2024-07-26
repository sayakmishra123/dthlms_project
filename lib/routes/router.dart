// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:dthlms/Master/HomePage.dart';
import 'package:dthlms/TheoryExam/theoryexampage.dart';
import 'package:dthlms/android/Drawer/Mobiledrawer.dart';
import 'package:dthlms/android/ForgetPassword/ForgetPasswordScreen.dart';
import 'package:dthlms/android/Homepage/MobileHomepage.dart';
import 'package:dthlms/android/MCQ/mcqCondition.dart';
import 'package:dthlms/android/MCQ/mockTestAns.dart';
import 'package:dthlms/android/MCQ/mockTestMcq.dart';
import 'package:dthlms/android/MCQ/mockTestRank.dart';
import 'package:dthlms/android/MCQ/practiceMcq.dart';
import 'package:dthlms/android/SigninOtp/OtpScreen.dart';
import 'package:dthlms/android/Videodashboard/mobileVideoDashboard.dart';
import 'package:dthlms/android/Videodashboard/mobileVideoPlayer.dart';
import 'package:dthlms/android/Videodashboard/newMobileVideoPlayer.dart';
import 'package:dthlms/android/login/dth_mob_login.dart';
import 'package:dthlms/android/packagemobile/newPackages.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:dthlms/Master/mainmobile/mainnewpackagemobiledashboard.dart';
import 'package:dthlms/mcq/ResultPage.dart';
import 'package:dthlms/mcq/macterm&conditionpage.dart';
import 'package:dthlms/mcq/mockTestmcqPage.dart';
import 'package:dthlms/mcq/practiceMcqPage.dart';
import 'package:dthlms/package/packagedashboard/newPackageDashboard.dart';
import 'package:dthlms/package/packagedashboard/packagedashboard.dart';
import 'package:dthlms/package/packagescreen.dart';
import 'package:dthlms/package/packagevideo.dart/videodashboard.dart';
import 'package:dthlms/package/packagevideo.dart/videorelatetedPage.dart';
import 'package:dthlms/pages/dashboard.dart';
import 'package:dthlms/pages/mycourses/coursescontent.dart';
import 'package:dthlms/pages/mycourses/myclasscontentvideo/myclasscontentvideo.dart';
import 'package:dthlms/pages/mycourses/mycoursesdashboar.dart';
import 'package:dthlms/pages/profile/profile.dart';
import 'package:dthlms/pages/study/studydashboard.dart';
import 'package:dthlms/android/packagemobile/packages.dart';
import 'package:get/get.dart';

class pageRouter {
  List<GetPage<dynamic>>? Route = [
    GetPage(
      name: '/',
      page: () => const DthLmsLogin(),
    ),
    GetPage(
      name: '/package',
      page: () => PackageDashboard(),
    ),
    GetPage(
      name: '/Mobiledrawer',
      page: () => MobileDrawer(),
    ),
    GetPage(
      name: '/Dashboard',
      page: () => Dashboard(),
    ),
    GetPage(
      name: '/Studydashboard',
      page: () => const StudyDashboard(),
    ),
    GetPage(
      name: '/Mobilelogin',
      page: () => const Mobilelogin(),
    ),
    GetPage(
      name: '/Mobilehomepage',
      page: () => const MobileHomepage(),
    ),
    GetPage(
      name: '/Mobileforgetpassword',
      page: () => ForgetPasswordMobile(),
    ),
    GetPage(
      name: '/Mobilepakagedashboard',
      page: () => PackageDashboardMobile(),
    ),
    GetPage(
      name: '/Mobilesigninotpscreen',
      page: () => SignInOtpScreen(),
    ),
    GetPage(
      name: '/Mobilevideodashboard',
      page: () => MobileVideoDashboard(),
    ),
    GetPage(
      name: '/Mobilevideoplayer',
      page: () => MobileVideoPlayer(),
    ),
    GetPage(
      name: '/Packagescreen',
      page: () => PackageScreen(),
    ),
    GetPage(
      name: '/Myclassvideocontent',
      page: () => MyClassVideoContent(),
    ),
    GetPage(
      name: '/Videodashboard',
      page: () => VideoDashboard(),
    ),
    GetPage(
      name: '/Videodetails',
      page: () => VideoDetails(),
    ),
    GetPage(
      name: "/Myclassdashboard",
      page: () => MyClassDashboard(),
    ),
    GetPage(
      name: '/Myclasscontent',
      page: () => MyClassContent(),
    ),
    GetPage(
      name: "/Profile",
      page: () => Profile(),
    ),
    GetPage(
      name: "/Newpackagedashboard",
      page: () => NewPackageDashboard(),
    ),
    GetPage(
      name: "/Newmobilepakagedashboard",
      // page: () => NewPackageDashboardMobile(),
      // changed by shubha
      page: () => MainNewPackageDashboardMobile(),
    ),
    GetPage(
      name: "/Newmobilevideoplayer",
      page: () => NewMobileVidePlayer(),
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
    GetPage(name: "/Homepage", page: () => Homepagedashboard())
  ];
}
