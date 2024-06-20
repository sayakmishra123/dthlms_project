class ClsMap {
  static Map objLoginApi(String loginemail, String password, String otp,
      String device1, String device2, String type, String configaration) {
    return {
      'userName': loginemail,
      'password': password,
      'franchiseId': 1,
      'deviceid1': device1,
      'deviceid2': device2,
      'type': type,
      'configaration': configaration
    };
  }

  static Map objSignupApi(
      String signupuser,
      String signupfirstname,
      String signuplastname,
      signupemail,
      signuppassword,
      signupphno,
      key,
      otp,
      String device1,
      String device2,
      String type,
      String configaration) {
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
    };
  }

  static Map objSignupconfirmation(
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
}
