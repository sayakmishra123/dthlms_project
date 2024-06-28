// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:dthlms/android/Drawer/Mobiledrawer.dart';
import 'package:dthlms/android/ForgetPassword/ForgetPasswordScreen.dart';
import 'package:dthlms/android/Homepage/MobileHomepage.dart';
import 'package:dthlms/android/SigninOtp/OtpScreen.dart';
import 'package:dthlms/android/Videodashboard/mobileVideoDashboard.dart';
import 'package:dthlms/android/Videodashboard/mobileVideoPlayer.dart';
import 'package:dthlms/android/login/dth_mob_login.dart';
import 'package:dthlms/login/dth_login.dart';
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
// import 'package:dthlms/showpdf/showpdf.dart';
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
    GetPage(name: '/Myclassvideocontent', page:()=> MyClassVideoContent()),
     GetPage(name: '/Videodashboard',page: () => VideoDashboard(),),
     GetPage(name: '/Videodetails', page:()=> VideoDetails()),
     GetPage(name: "/Myclassdashboard", page:()=> MyClassDashboard()),
     GetPage(name: '/Myclasscontent', page: ()=>MyClassContent()),
     GetPage(name: "/Profile", page: ()=>Profile()),
  ];
}
