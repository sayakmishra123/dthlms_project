// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:dthlms/android/Homepage/MobileHomepage.dart';
import 'package:dthlms/android/login/dth_mob_login.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:dthlms/pages/dashboard.dart';
import 'package:dthlms/pages/study/studydashboard.dart';
// import 'package:dthlms/showpdf/showpdf.dart';
import 'package:get/get.dart';

class pageRouter {
  List<GetPage<dynamic>>? Route = [
    GetPage(name: '/', page: () =>const  DthLmsLogin()),
    GetPage(name: '/Dashboard', page: () => Dashboard()),
    GetPage(name: '/Studydashboard', page: () => const StudyDashboard()),
    GetPage(
      name: '/Mobilelogin',
      page: () => const Mobilelogin(),
    ),
    GetPage(name: '/Mobilehomepage', page: () => const MobileHomepage()),
  ];
}
