// ignore_for_file: avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.dart';
import 'package:dthlms/login/dth_login.dart';
import 'package:dthlms/login/login_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class OTPScreen extends StatefulWidget {
  String signupuser;
  String signupfirstname;
  String signuplastname;

  String signupemail;
  String signuppassword;
  String signupphno;
  OTPScreen(this.signupuser, this.signupfirstname,this.signuplastname, this.signupemail,
      this.signuppassword, this.signupphno,
      {super.key});
  // OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // ignore: non_constant_identifier_names
  Getx get_obj = Get.put(Getx());
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
      signupcodegenerate(widget.signupphno, widget.signupemail, context)
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
        body: SingleChildScrollView(
          child: Container(
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(100.0),
                        child: Card(
                          elevation: 30,
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorPage.white,
                                borderRadius: BorderRadius.circular(20)),
                              
                            padding: const EdgeInsets.all(250),
                            // height: 300,
                            //  width: 300,
                            child: Column(
                              children: [
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      width: 700,
                                      child: AutoSizeText(
                                        'Enter the 7 digit code we sent to  your (${widget.signupemail}) email address to verify you new account',
                                        style:FontFamily.font4,
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                ),
                                Form(
                                  key: globalKey,
                                  child: OtpTextField(
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Didn't you receive the OTP? ",
                                        style: GoogleFonts.outfit(
                                            textStyle: const TextStyle()),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // _verifyPhoneNumber();
                                        },
                                        child: Text(
                                          'Resend OTP',
                                          style: GoogleFonts.outfit(
                                              textStyle: const TextStyle(
                                                  color: ColorPage.red,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      signupApi(
                                          context,
                                          widget.signupuser,
                                          widget.signupfirstname,
                                          widget.signuplastname,
                                          widget.signupemail,
                                          widget.signuppassword,
                                          widget.signupphno,
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.offAll(() =>const DthLmsLogin());
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
