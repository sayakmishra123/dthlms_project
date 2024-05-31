import 'package:dthlms/package/packagescreen.dart';
import 'package:get/get.dart';
import 'package:simnumber/siminfo.dart';

import '../login/loginmodel.dart';

class Getx extends GetxController {
  RxBool show = false.obs;
  RxBool hide = true.obs;
  // ignore: non_constant_identifier_names
  RxInt page_index = 0.obs;
  RxBool buttonfocuscolor = false.obs;
  RxBool dropbuttonvalueshow = true.obs;

  RxList<DthloginUserDetails> loginuserdata = <DthloginUserDetails>[].obs;
  RxBool otplineshow = false.obs;
  // RxBool otpshow = false.obs;
  RxBool loginpasswordshow = false.obs;
  RxBool signuppasswordshow = false.obs;
  RxString signupotp = ''.obs;
  RxBool forgetpassword1 = false.obs;
  RxBool forgetpassword2 = false.obs;
  RxBool pdfview = true.obs;
  RxBool videoplayer = true.obs;
  RxBool isSelectXXL = false.obs;

  RxBool isSelectXL = false.obs;
  RxBool isSelectL = false.obs;
  RxBool isSelectS = false.obs;
  RxBool isSelectXS = false.obs;
  RxBool isSelectXXS = false.obs;
    RxBool isMypackages=false.obs;

  RxList<SimCard> simCardinfo = <SimCard>[].obs;
  RxList<AllPackage> package = <AllPackage>[].obs;
  RxList<PackageFind> packagefind = <PackageFind>[].obs;
  RxBool packageshow = true.obs;
}
