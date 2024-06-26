// ignore_for_file: camel_case_types

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';

import 'package:dthlms/login/login_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SignInOtpScreen extends StatefulWidget {

  SignInOtpScreen(
      {super.key});

  // signInOtpScreen({super.key});

  @override
  State<SignInOtpScreen> createState() => _SignInOtpScreenState();
}

class _SignInOtpScreenState extends State<SignInOtpScreen> {





  late double screenwidth = MediaQuery.of(context).size.width;
  late double spaceBetweenOtpAndText = MediaQuery.of(context).size.width / 22;
  late double spaceBetweenOtpboxAndText =
      MediaQuery.of(context).size.width / 20;
  // ignore: non_constant_identifier_names
  late double OtpBoxWidth = MediaQuery.of(context).size.width / 9;
  // ignore: non_constant_identifier_names
  late double OtpBoxHeight = MediaQuery.of(context).size.width / 8;
  late double spaceBetweenOtpboxAndResendOtp =
      MediaQuery.of(context).size.width / 18;
  // ignore: non_constant_identifier_names
  Getx get_obj = Get.put(Getx());

   final signupuser=Get.arguments['signupuser'];
  final signupfirstname=Get.arguments['signupfirstname'];
  final signuplastname=Get.arguments['signuplastname'];
  final signupemail=Get.arguments['signupemail'];
  final signuppassword=Get.arguments['signuppassword'];
  final signupphno=Get.arguments['signupphno'];


  String key = '';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      call();
    });

    super.initState();
  }

  Future call() async {
    try {
      signupcodegenerate(signupphno, signupemail, context)
          .then((value) {
        print(value);
        key = value;
        if (key == 'error') {
          Get.back();
        }
      });
    } catch (e) {
      print(e);
      Get.back();
    }
  }

  GlobalKey<FormState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        // backgroundColor: ColorPage.color1,
        body: Container(
          decoration: const BoxDecoration(
              gradient: SweepGradient(
            colors: [ColorPage.color1, ColorPage.bgcolor],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Visibility(
                  visible: get_obj.otplineshow.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: get_obj.otplineshow.value
                            ? ColorPage.green
                            : ColorPage.red,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.info,
                                color: ColorPage.deepblue,
                              ),
                              label: Text(
                                get_obj.otplineshow.value
                                    ? 'OTP has been send to your mail'
                                    : 'OTP send failed',
                                style: FontFamily.font3,
                                // textScaler: TextScaler.linear(1.8),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  get_obj.otplineshow.value = false;
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 30,
                    child: Container(
                      width: screenwidth - 10,
                      decoration: BoxDecoration(
                          color: ColorPage.white,
                          borderRadius: BorderRadius.circular(20)),

                      // padding: const EdgeInsets.all(250),
                      // height: 300,
                      //  width: 300,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'OTP Verification',
                                style: FontFamily.font,
                                textScaler: const TextScaler.linear(1.8),
                              )
                            ],
                          ),
                          SizedBox(
                            height: spaceBetweenOtpAndText,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: screenwidth - 40,
                                child: AutoSizeText(
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  'Enter the 7 digit code we sent to  your ("Email@gmail.com") email address to verify you new account',
                                  style: FontFamily.font4,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: spaceBetweenOtpboxAndText,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Form(
                                key: globalKey,
                                child: OtpTextField(
                                  fieldWidth: OtpBoxWidth,
                                  fieldHeight: OtpBoxHeight,
                                  keyboardType: TextInputType.number,
                                  numberOfFields: 7,
                                  clearText: true,
                                  fillColor: ColorPage.color1,
                                  enabled: true,
                                  autoFocus: true,
                                  borderColor: ColorPage.color1,
                                  enabledBorderColor: ColorPage.color1,
                                  focusedBorderColor: ColorPage.blue,

                                  showFieldAsBox: true,

                                  onCodeChanged: (String code) {},

                                  onSubmit: (String verificationCode) {
                                    get_obj.signupotp.value = verificationCode;
                                  }, // end onSubmit
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: spaceBetweenOtpboxAndResendOtp,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "Didn't you receive the OTP? ",
                                  maxLines: 1,
                                  style: GoogleFonts.outfit(
                                      textStyle: const TextStyle()),
                                ),
                                InkWell(
                                  onTap: () {
                                    // _verifyPhoneNumber();
                                  },
                                  child: Text(
                                    'Resend OTP',
                                    style: FontFamily.ResendOtpfont,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SizedBox(
                              width: screenwidth / 1.5,
                              child: ElevatedButton(
                                onPressed: () {
                                  signupApi(
                                      context,
                                    signupuser,
                                      signupfirstname,
                                    signuplastname,
                                   signupemail,
                                   signuppassword,
                                    signupphno,
                                      key,
                                      get_obj.signupotp.value);
                                },
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20)),
                                    backgroundColor: MaterialStatePropertyAll(
                                        ColorPage.color1),
                                    shape: MaterialStatePropertyAll(
                                        ContinuousRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(15, 15))))),
                                child: Text(
                                  'Verify & Continue',
                                  style: FontFamily.font2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenwidth / 4,
                            height: screenwidth / 8,
                            child: TextButton(
                              onPressed: () {
                                // Get.offAll(() => const DthLmsLogin());
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(ColorPage.red),
                                  shape: MaterialStatePropertyAll(
                                      ContinuousRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(15, 15))))),
                              child: Text(
                                'Cancel',
                                style: FontFamily.font3,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
