import 'package:dthlms/utctime.dart';

class ClsMap {
  Map objLoginApi(String loginemail, String password, String otp, Map info) {
    return {
      'userName': loginemail,
      'password': password,
      'franchiseId': 1,
      'deviceinfo': info
    };
  }

  Map objSignupApi(
    String signupuser,
    String signupfirstname,
    String signuplastname,
    signupemail,
    signuppassword,
    signupphno,
    key,
    otp,
    deviceinfo,
  ) {
    return {
      'userName': signupuser,
      'password': signuppassword,
      'franchiseId': 1,
      'phoneNumber': signupphno,
      'firstName': signupfirstname,
      'lastName': signuplastname,
      'email': signupemail,
      'emailCode': otp,
      'phoneNumberCode': null,
      'deviceinfo': deviceinfo
    };
  }

  Map objSignupconfirmation(
    String signupphno,
    String signupemail,
  ) {
    return {
      "phoneNumber": signupphno,
      "email": signupemail,
      "franchiseId": 1,
      'captchaId': null,
      'userEnteredCaptchaCode': 'abcd'
    };
  }

  Map objforgetPassword(String signupemail, String code) {
    return {"user": signupemail, "code": code};
  }

  Map objresetPassword(
      String signupemail, String ph, String pass, String confirmpass) {
    return {
      "email": signupemail,
      "phoneNumber": ph,
      "password": pass,
      "confirmPassword": confirmpass
    };
  }

  Map objStudentWatchTime(videoId, watchtime, studentid) {
    return {
      'videoid': videoId,
      'watchtime': watchtime,
      'studentId': studentid,
      'date': UtcTime().utctime()
    };
  }

  Map objStudentVideoReview(videoid, optionid) {
    return {'videoid': videoid, 'optionid': optionid};
  }
}
