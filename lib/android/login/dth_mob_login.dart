import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/android/ForgetPassword/ForgetPasswordScreen.dart';

import 'package:dthlms/android/SigninOtp/OtpScreen.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/apiHandleing/apifetchall.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';

// import 'package:dthlms/getx/getxcontroller.dart';
import 'package:dthlms/login/login_api.dart';
// import 'package:dthlms/utils/getpackagebyid.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:win32/win32.dart';

import '../phone/siminformation.dart';

class Mobilelogin extends StatefulWidget {
  const Mobilelogin({super.key});

  @override
  State<Mobilelogin> createState() => _MobileloginState();
}

class _MobileloginState extends State<Mobilelogin> {
  TextEditingController signupuser = TextEditingController();
  TextEditingController signupfirstname = TextEditingController();
  TextEditingController signuplastname = TextEditingController();
  TextEditingController signupemail = TextEditingController();
  TextEditingController signupphno = TextEditingController();
  TextEditingController signuppassword = TextEditingController();

  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();
  TextEditingController loginotp = TextEditingController();

  int controllerIndex = 0;

  // ignore: non_constant_identifier_names
  // final GlobalKey<FormState> desktop_key = GlobalKey();
  FocusNode focusNode = FocusNode();

  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> mobile_key_login = GlobalKey();
  // ignore: non_constant_identifier_names
  final GlobalKey<FormState> mobile_key_signup = GlobalKey();
  late double formfieldsize = MediaQuery.of(context).size.width - 60;
  late double fontsize = ClsFontsize.ExtraLarge + 2;
  Getx getxController = Get.put(Getx());
  InputBorder border = const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorPage.colorgrey));
  var key = '0';
  Getx getx = Get.put(Getx());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/Black and Red Minimalist Modern Registration Gym Website Prototype (1).jpg'),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 180,
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 80,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      width: 400,
                      // height: MediaQuery.sizeOf(context).height - 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  // height: 200,
                                  // color: Colors.red,
                                  child: Image.network(
                                    'https://videoencryptor.com/assets/images/logo.png',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text('Signup'),
                                // Text('Login'),
                                SizedBox(
                                  width: 300,
                                  child: AnimatedButtonBar(
                                    controller: AnimatedButtonController()
                                      ..setIndex(getxController
                                          .ButtonControllerIndex.value),
                                    radius: 32.0,
                                    padding: const EdgeInsets.all(16.0),
                                    backgroundColor: Colors.blueGrey.shade800,
                                    foregroundColor: Colors.blueGrey.shade300,
                                    elevation: 24,
                                    curve: Curves.linear,
                                    borderColor: Colors.white,
                                    borderWidth: 2,
                                    innerVerticalPadding: 16,
                                    children: [
                                      ButtonBarEntry(
                                          onTap: () {
                                            getxController.show.value = false;
                                            getxController.ButtonControllerIndex
                                                .value = 0;
                                            print(getxController
                                                .ButtonControllerIndex.value
                                                .toString());
                                          },
                                          child: Text(
                                            'Log in',
                                            style: FontFamily.font,
                                          )),
                                      ButtonBarEntry(
                                          onTap: () {
                                            getxController.show.value = true;
                                            getxController.ButtonControllerIndex
                                                .value = 1;
                                            print(getxController
                                                .ButtonControllerIndex.value
                                                .toString());
                                          },
                                          child: Text(
                                            'Sign up',
                                            style: FontFamily.font,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            getxController.show.value
                                ? Form(
                                    // autovalidateMode:
                                    //     AutovalidateMode.onUserInteraction,
                                    key: mobile_key_signup,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: formfieldsize,
                                              child: Text(
                                                'User Name',
                                                style: FontFamily.mobilefont,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: formfieldsize,
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Cannot blank';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  keyboardType:
                                                      TextInputType.name,
                                                  controller: signupuser,
                                                  decoration: InputDecoration(
                                                      enabledBorder: border,
                                                      focusedBorder: border,
                                                      hintText: 'Your Name'),
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: formfieldsize / 2,
                                              child: Text(
                                                'First Name',
                                                style: FontFamily.font,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SizedBox(
                                              width: formfieldsize / 2.2,
                                              child: Text(
                                                'Last Name',
                                                style: FontFamily.font,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: formfieldsize / 2.2,
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Cannot blank';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  keyboardType:
                                                      TextInputType.name,
                                                  controller: signupfirstname,
                                                  decoration: InputDecoration(
                                                      prefixIcon: const Icon(
                                                          Icons.person),
                                                      enabledBorder: border,
                                                      focusedBorder: border,
                                                      hintText: 'First Name'),
                                                )),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            SizedBox(
                                                width: formfieldsize / 2,
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Cannot blank';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  keyboardType:
                                                      TextInputType.name,
                                                  controller: signuplastname,
                                                  decoration: InputDecoration(
                                                      prefixIcon: const Icon(
                                                          Icons.person),
                                                      enabledBorder: border,
                                                      focusedBorder: border,
                                                      hintText: 'Last Name'),
                                                ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: formfieldsize,
                                              child: Text(
                                                'Email',
                                                style: FontFamily.mobilefont,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: formfieldsize,
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Cannot blank';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  controller: signupemail,
                                                  decoration: InputDecoration(
                                                      enabledBorder: border,
                                                      focusedBorder: border,
                                                      hintText:
                                                          'hello@email.com'),
                                                ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: formfieldsize,
                                              child: Text(
                                                'Phone Number',
                                                style: FontFamily.mobilefont,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: formfieldsize,
                                                child: IntlPhoneField(
                                                  initialCountryCode: 'IN',
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (value) {
                                                    if (value
                                                            .toString()
                                                            .length >
                                                        10) {
                                                      return "number may not be";
                                                    }
                                                    return null;
                                                  },
                                                  disableLengthCheck: true,
                                                  focusNode: focusNode,
                                                  controller: signupphno,
                                                  style: FontFamily.font6,
                                                  onTap: () async {
                                                    await ClsSimInfo()
                                                        .printSimCardsData(
                                                            context)
                                                        .whenComplete(() {
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 1), () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Obx(() {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Choose Sim number'),
                                                                  content:
                                                                      SizedBox(
                                                                    height: 100,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        for (int i =
                                                                                0;
                                                                            i < getx.simCardinfo.length;
                                                                            i++)
                                                                          ElevatedButton(
                                                                              onPressed: () {
                                                                                signupphno.text = getx.simCardinfo[i].phoneNumber.toString().substring(3);
                                                                                Get.back();
                                                                              },
                                                                              child: Text(getx.simCardinfo[i].phoneNumber.toString().substring(3))),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                            });
                                                      });
                                                    });
                                                  },
                                                  languageCode: "en",
                                                  onChanged: (phone) {
                                                    print(phone.completeNumber);
                                                  },
                                                  onCountryChanged: (country) {
                                                    // ignore: avoid_print, prefer_interpolation_to_compose_strings
                                                    print(
                                                        'Country changed to: ' +
                                                            country.name);
                                                  },
                                                ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: formfieldsize,
                                              child: Text(
                                                'Password',
                                                style: FontFamily.mobilefont,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: formfieldsize,
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Cannot blank';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  controller: signuppassword,
                                                  decoration: InputDecoration(
                                                      enabledBorder: border,
                                                      focusedBorder: border,
                                                      suffixIcon: IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(Icons
                                                              .visibility)),
                                                      hintText: 'Password'),
                                                ))
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: formfieldsize,
                                                  // height: 30,
                                                  child: MaterialButton(
                                                    shape:
                                                        ContinuousRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    color: ColorPage.colorgrey,
                                                    onPressed: () {
                                                      if (mobile_key_signup
                                                              .currentState!
                                                              .validate() &
                                                          GetUtils.isEmail(
                                                              signupemail
                                                                  .text)) {
                                                        mobile_key_signup
                                                            .currentState!
                                                            .save();
                                                        Get.toNamed(
                                                            "/Mobilesigninotpscreen",
                                                            arguments: {
                                                              'signupuser':
                                                                  signupuser
                                                                      .text,
                                                              'signupfirstname':
                                                                  signupfirstname
                                                                      .text,
                                                              'signuplastname':
                                                                  signuplastname
                                                                      .text,
                                                              'signupemail':
                                                                  signupemail
                                                                      .text,
                                                              'signuppassword':
                                                                  signuppassword
                                                                      .text,
                                                              'signupphno':
                                                                  signupphno
                                                                      .text,
                                                            });
                                                      } else {
                                                        Get.snackbar("Error",
                                                            "Please enter valid details",
                                                            colorText: ColorPage
                                                                .white);
                                                      }
                                                    },
                                                    child: Text(
                                                      'Sign Up',
                                                      style: TextStyle(
                                                          fontSize:
                                                              ClsFontsize.Large,
                                                          color: Colors.white),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     SizedBox(
                                        //         width: formfieldsize,
                                        //         // height: 10,
                                        //         child: MaterialButton(
                                        //           shape:
                                        //               ContinuousRectangleBorder(
                                        //                   borderRadius:
                                        //                       BorderRadius
                                        //                           .circular(
                                        //                               20)),

                                        //           // color: ColorPage.colorgrey,
                                        //           onPressed: () {},
                                        //           child: Text(
                                        //             'Login',
                                        //             style: TextStyle(
                                        //               fontSize: ClsFontsize
                                        //                   .DoubleExtraSmall,
                                        //             ),
                                        //           ),
                                        //         ))
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  )
                                : Form(
                                    key: mobile_key_login,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: formfieldsize,
                                              child: Text(
                                                'Email/Phone',
                                                style: FontFamily.mobilefont,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: formfieldsize,
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Cannot blank';
                                                    }
                                                    return null;
                                                  },
                                                  controller: loginemail,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  // controller: ,
                                                  decoration: InputDecoration(
                                                      enabledBorder: border,
                                                      focusedBorder: border,
                                                      hintText:
                                                          'Enter Your Email or Phone'),
                                                ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: formfieldsize,
                                              child: Text(
                                                'Password',
                                                style: FontFamily.mobilefont,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: formfieldsize,
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Cannot blank';
                                                    }
                                                    return null;
                                                  },
                                                  controller: loginpassword,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: InputDecoration(
                                                      enabledBorder: border,
                                                      focusedBorder: border,
                                                      hintText: '************'),
                                                ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.topRight,
                                              width: formfieldsize,
                                              child: TextButton(
                                                onPressed: () {
                                                  Get.to(() =>
                                                      const ForgetPasswordMobile());
                                                },
                                                child: Text(
                                                  'Forget password',
                                                  style: FontFamily.mobilefont,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     SizedBox(
                                        //       width: formfieldsize,
                                        //       child: Text(
                                        //         'OTP',
                                        //         style:
                                        //             FontFamily.mobilefont,
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     SizedBox(
                                        //         width: formfieldsize,
                                        //         child: TextFormField(
                                        //           autovalidateMode:
                                        //               AutovalidateMode
                                        //                   .onUserInteraction,
                                        //           validator: (value) {
                                        //             if (value!.isEmpty) {
                                        //               return 'Cannot blank';
                                        //             }
                                        //             return null;
                                        //           },
                                        //           controller: loginotp,
                                        //           keyboardType:
                                        //               const TextInputType
                                        //                   .numberWithOptions(),
                                        //           decoration: InputDecoration(
                                        //               enabledBorder: border,
                                        //               focusedBorder: border,
                                        //               suffixIcon: IconButton(
                                        //                   onPressed: () {},
                                        //                   icon: const Icon(Icons
                                        //                       .visibility)),
                                        //               hintText:
                                        //                   '*'),
                                        //         ))
                                        //   ],
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: formfieldsize,
                                                  child: MaterialButton(
                                                    shape:
                                                        ContinuousRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    color: ColorPage.colorgrey,
                                                    onPressed: () async {
                                                      // var token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJGaXJzdE5hbWUiOiJTb3VyYXYiLCJMYXN0TmFtZSI6Ik5hdGgiLCJuYW1laWQiOiI2NTg0YWUzNC00NjMwLTRhNjMtYjI3MC1kNjUwNjdmNTNmZDIiLCJGcmFuY2hpc2VJZCI6IjEiLCJNb2JpbGUiOiI5ODMxODExOTIzIiwiZW1haWwiOiJpc3NzYnN0MjAxNkBnbWFpbC5jb20iLCJyb2xlIjoiVGVzdGVyIiwibmJmIjoxNzIxNzI2NjA3LCJleHAiOjE3MjE3MzAyMDcsImlhdCI6MTcyMTcyNjYwN30.Z3ALSqb6bZwjkOcx2uSFpPjS3Ktqhp8dkolsUrekH1o";
                                                      //  await tableEncryptionHistory(context,token);

                                                      // if (mobile_key_login
                                                      //     .currentState!
                                                      //     .validate()) {
                                                      //   mobile_key_login.currentState!
                                                      //       .save();

                                                      // await loginApi(
                                                      //     context,
                                                      //     loginemail.text,
                                                      //     loginpassword.text,
                                                      //     loginotp.text);

                                                      // }

                                                      await loginApi(
                                                          context,
                                                          'tester1',
                                                          'Admin@1234',
                                                          loginotp.text);
                                                    },
                                                    child: Text(
                                                      'Login',
                                                      style: TextStyle(
                                                          fontSize: fontsize,
                                                          color: Colors.white),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'New User ?',
                                              style: TextStyle(
                                                fontSize:
                                                    ClsFontsize.ExtraSmall,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                width: formfieldsize,
                                                child: MaterialButton(
                                                  shape:
                                                      ContinuousRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),

                                                  // color: ColorPage.colorgrey,
                                                  onPressed: () {},
                                                  child: Text(
                                                    'Create an account',
                                                    style: TextStyle(
                                                      fontSize: ClsFontsize
                                                          .ExtraSmall,
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
