import 'dart:io';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:dthlms/API/ALL_FUTURE_FUNTIONS/all_functions.dart';
import 'package:dthlms/API/LOGIN/login_api.dart';
import 'package:dthlms/MOBILE/LOGIN/loginpage_mobile.dart';
import 'package:dthlms/PC/FORGETPASSWORD/forgetpasswordscreen.dart';
import 'package:dthlms/PC/OTP/otpscreen.dart';
import 'package:dthlms/THEME_DATA/FontSize/FontSize.dart';
// import 'package:dthlms/android/login/dth_mob_login.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:dthlms/LOCAL_DATABASE/dbfunction/dbfunction.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:local_notifier/local_notifier.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DthLmsLogin extends StatefulWidget {
  const DthLmsLogin({super.key});

  @override
  State<DthLmsLogin> createState() => _DthLmsLoginState();
}

class _DthLmsLoginState extends State<DthLmsLogin> {
  TextEditingController signupuser = TextEditingController();
  TextEditingController signupfirstname = TextEditingController();
  TextEditingController signuplastname = TextEditingController();
  TextEditingController signupemail = TextEditingController();
  TextEditingController signupphno = TextEditingController();
  TextEditingController signuppassword = TextEditingController();

  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();
  TextEditingController loginotp = TextEditingController();
  FocusNode focusNode = FocusNode();

  final GlobalKey<FormState> desktop_key1 = GlobalKey();
  final GlobalKey<FormState> desktop_key2 = GlobalKey();

  late double formfieldsize = 400;
  late double fontsize = ClsFontsize.DoubleExtraLarge + 2;
  Getx getxController = Get.put(Getx());
  InputBorder border = const UnderlineInputBorder(
      borderSide: BorderSide(color: ColorPage.colorgrey));
  final bool _isVisible = true;
  RxBool fullScreen = true.obs;

  @override
  void initState() {
    print('logindth');
    testSQLCipherOnWindows();
    formfieldsize = Platform.isAndroid ? 300 : formfieldsize;
    super.initState();
  }

  AnimatedButtonController animatedButtonController = AnimatedButtonController();
  var key = '0';

  notification() async {
    await localNotifier.setup(
      appName: 'local_notifier_example',
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );

    LocalNotification notification = LocalNotification(
      title: "local_notifier_example",
      body: "hello flutter!",
    );
    notification.onShow = () {};
    notification.onClose = (closeReason) {
      switch (closeReason) {
        case LocalNotificationCloseReason.userCanceled:
          break;
        case LocalNotificationCloseReason.timedOut:
          break;
        default:
      }
    };
    notification.onClick = () {
      print('onClick ${notification.identifier}');
      Get.to(() => DthLmsLogin());
    };
    notification.onClickAction = (actionIndex) {
      print('onClickAction ${notification.identifier} - $actionIndex');
      Get.to(() => DthLmsLogin());
    };

    notification.show();
  }

  @override
  Widget build(BuildContext context) {
    late RxDouble screenwidth = MediaQuery.of(context).size.width.obs;
    return Material(
      child: Scaffold(
          body: _isVisible && Platform.isWindows
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.sizeOf(context).height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/Black and Red Minimalist Modern Registration Gym Website Prototype (1).jpg'),
                        fit: BoxFit.fill),
                  ),
                  child: Row(
                    children: [
                      Visibility(
                        visible: screenwidth.value > 850 ? true : false,
                        child: Expanded(
                          child: Column(
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          fit: BoxFit.contain,
                                          'assets/loginimg2.png',
                                          height: MediaQuery.sizeOf(context)
                                                  .height -
                                              100,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 80,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 30),
                                  width: 500,
                                  decoration: BoxDecoration(
                                      color: ColorPage.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.center,
                                  child: Obx(
                                    () => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 400,
                                              child: AnimatedButtonBar(
                                                controller:
                                                    animatedButtonController
                                                      ..setIndex(getxController
                                                          .ButtonControllerIndex
                                                          .value),
                                                radius: 32.0,
                                                padding: const EdgeInsets.all(16.0),
                                                backgroundColor:
                                                    ColorPage.bluegrey800,
                                                foregroundColor:
                                                    ColorPage.bluegrey300,
                                                elevation: 24,
                                                curve: Curves.linear,
                                                borderColor: ColorPage.white,
                                                borderWidth: 2,
                                                innerVerticalPadding: 16,
                                                children: [
                                                  ButtonBarEntry(
                                                      onTap: () {
                                                        getxController.show.value = false;
                                                        getxController
                                                            .ButtonControllerIndex
                                                            .value = 0;
                                                      },
                                                      child: Text(
                                                        'Log in',
                                                        style: FontFamily.font,
                                                      )),
                                                  ButtonBarEntry(
                                                      onTap: () {
                                                        getxController.show.value = true;
                                                        getxController
                                                            .ButtonControllerIndex
                                                            .value = 1;
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
                                            ? getxController.isSignup.value
                                                ? Form(
                                                    key: desktop_key1,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width: formfieldsize,
                                                              child: Text(
                                                                'User name',
                                                                style:
                                                                    FontFamily.font,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                                width:
                                                                    formfieldsize,
                                                                child:
                                                                    TextFormField(
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Cannot blank';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  controller:
                                                                      signupuser,
                                                                  decoration: InputDecoration(
                                                                      enabledBorder:
                                                                          border,
                                                                      focusedBorder:
                                                                          border,
                                                                      hintText:
                                                                          'User name'),
                                                                ))
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  formfieldsize /
                                                                      2.1,
                                                              child: Text(
                                                                'First Name',
                                                                style:
                                                                    FontFamily.font,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  formfieldsize /
                                                                      2,
                                                              child: Text(
                                                                'Last Name',
                                                                style:
                                                                    FontFamily.font,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                                width:
                                                                    formfieldsize /
                                                                        2.2,
                                                                child:
                                                                    TextFormField(
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Cannot blank';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  controller:
                                                                      signupfirstname,
                                                                  decoration: InputDecoration(
                                                                      prefixIcon:
                                                                          const Icon(
                                                                              Icons.person),
                                                                      enabledBorder:
                                                                          border,
                                                                      focusedBorder:
                                                                          border,
                                                                      hintText:
                                                                          'First Name'),
                                                                )),
                                                            SizedBox(
                                                              width: 30,
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    formfieldsize /
                                                                        2,
                                                                child:
                                                                    TextFormField(
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Cannot blank';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  controller:
                                                                      signuplastname,
                                                                  decoration: InputDecoration(
                                                                      enabledBorder:
                                                                          border,
                                                                      focusedBorder:
                                                                          border,
                                                                      hintText:
                                                                          'Last Name'),
                                                                ))
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  formfieldsize,
                                                              child: Text(
                                                                'Email',
                                                                style:
                                                                    FontFamily.font,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                                width:
                                                                    formfieldsize,
                                                                child:
                                                                    TextFormField(
                                                                  autovalidateMode:
                                                                      AutovalidateMode
                                                                          .onUserInteraction,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return 'Cannot blank';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .emailAddress,
                                                                  controller:
                                                                      signupemail,
                                                                  decoration: InputDecoration(
                                                                      prefixIcon:
                                                                          const Icon(
                                                                              Icons.email),
                                                                      enabledBorder:
                                                                          border,
                                                                      focusedBorder:
                                                                          border,
                                                                      hintText:
                                                                          'hello@email.com'),
                                                                ))
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  formfieldsize,
                                                              child: Text(
                                                                'Phone Number',
                                                                style:
                                                                    FontFamily.font,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  formfieldsize,
                                                              child:
                                                                  IntlPhoneField(
                                                                initialCountryCode:
                                                                    'IN',
                                                                controller:
                                                                    signupphno,
                                                                showCountryFlag:
                                                                    true,
                                                                disableLengthCheck:
                                                                    false,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  formfieldsize,
                                                              child: Text(
                                                                'Password',
                                                                style:
                                                                    FontFamily.font,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Obx(
                                                              () => SizedBox(
                                                                  width:
                                                                      formfieldsize,
                                                                  child:
                                                                      TextFormField(
                                                                    onFieldSubmitted:
                                                                        (value) {
                                                                      if (desktop_key1.currentState!.validate() &&
                                                                          GetUtils.isEmail(
                                                                              signupemail.text)) {
                                                                        desktop_key1
                                                                            .currentState!
                                                                            .save();
                                                                        Get.to(
                                                                            () =>
                                                                                OTPScreen(
                                                                                  signupuser.text,
                                                                                  signupfirstname.text,
                                                                                  signuplastname.text,
                                                                                  signupemail.text,
                                                                                  signuppassword.text,
                                                                                  signupphno.text,
                                                                                ),
                                                                            transition:
                                                                                Transition.leftToRight);
                                                                      } else {
                                                                        Get.snackbar("Error",
                                                                            "Please enter valid details",
                                                                            colorText: ColorPage.white);
                                                                      }
                                                                    },
                                                                    obscureText:
                                                                        getx.signuppasswordshow
                                                                            .value,
                                                                    autovalidateMode:
                                                                        AutovalidateMode
                                                                            .onUserInteraction,
                                                                    textInputAction:
                                                                        TextInputAction
                                                                            .next,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!.isEmpty) {
                                                                        return 'Password cannot be blank';
                                                                      } else if (value.length < 8) {
                                                                        return 'Password must be at least 8 characters long';
                                                                      } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                                                                        return 'Password must contain at least one uppercase letter';
                                                                      } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
                                                                        return 'Password must contain at least one lowercase letter';
                                                                      } else if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
                                                                        return 'Password must contain at least one number';
                                                                      } else if (!RegExp(r'^(?=.*[\W_])').hasMatch(value)) {
                                                                        return 'Password must contain at least one special character';
                                                                      }
                                                                      return null;
                                                                    },
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .visiblePassword,
                                                                    controller:
                                                                        signuppassword,
                                                                    decoration: InputDecoration(
                                                                        prefixIcon: const Icon(Icons.password),
                                                                        enabledBorder: border,
                                                                        focusedBorder: border,
                                                                        suffixIcon: IconButton(
                                                                            onPressed: () {
                                                                              getx.signuppasswordshow.value = !getx.signuppasswordshow.value;
                                                                            },
                                                                            icon: getx.signuppasswordshow.value
                                                                                ? const Icon(Icons.visibility)
                                                                                : const Icon(Icons.visibility_off)),
                                                                        hintText: 'Password'),
                                                                  )),
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                  width:
                                                                      formfieldsize,
                                                                  child:
                                                                      MaterialButton(
                                                                    shape: ContinuousRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            20),
                                                                    color: ColorPage
                                                                        .buttonColor,
                                                                    onPressed:
                                                                        () {
                                                                      if (desktop_key1.currentState!.validate() &&
                                                                          GetUtils.isEmail(signupemail.text)) {
                                                                        desktop_key1
                                                                            .currentState!
                                                                            .save();
                                                                        Get.to(() =>
                                                                            OTPScreen(
                                                                              signupuser.text,
                                                                              signupfirstname.text,
                                                                              signuplastname.text,
                                                                              signupemail.text,
                                                                              signuppassword.text,
                                                                              signupphno.text,
                                                                            ),
                                                                            transition: Transition.leftToRight);
                                                                      } else {
                                                                        Get.snackbar("Error",
                                                                            "Please enter valid details",
                                                                            colorText: ColorPage.white);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      'Sign Up',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              fontsize,
                                                                          color: ColorPage.white),
                                                                    ),
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Already a member ?',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ClsFontsize
                                                                          .ExtraSmall),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                                width:
                                                                    formfieldsize,
                                                                child:
                                                                    MaterialButton(
                                                                  shape: ContinuousRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  onPressed:
                                                                      () {
                                                                    getxController
                                                                            .show
                                                                            .value =
                                                                        false;
                                                                    getxController
                                                                        .ButtonControllerIndex
                                                                        .value = 0;
                                                                  },
                                                                  child: Text(
                                                                    'Login',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          ClsFontsize
                                                                              .ExtraSmall,
                                                                    ),
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    child: Text(
                                                        "Sign up is Disable by Admin!"),
                                                  )
                                            : Form(
                                                key: desktop_key2,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: formfieldsize,
                                                          child: Text(
                                                            'Email/Phone',
                                                            style:
                                                                FontFamily.font,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            width:
                                                                formfieldsize,
                                                            child:
                                                                TextFormField(
                                                              autovalidateMode:
                                                                  AutovalidateMode
                                                                      .onUserInteraction,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Cannot blank';
                                                                }
                                                                return null;
                                                              },
                                                              controller:
                                                                  loginemail,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .emailAddress,
                                                              decoration: InputDecoration(
                                                                  enabledBorder:
                                                                      border,
                                                                  focusedBorder:
                                                                      border,
                                                                  hintText:
                                                                      'Enter Your Email / Phone'),
                                                            ))
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: formfieldsize,
                                                          child: Text(
                                                            'Password',
                                                            style:
                                                                FontFamily.font,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            width:
                                                                formfieldsize,
                                                            child: Obx(
                                                              () =>
                                                                  TextFormField(
                                                                onFieldSubmitted:
                                                                    (value) async {
                                                                  if (desktop_key2
                                                                      .currentState!
                                                                      .validate()) {
                                                                    desktop_key2
                                                                        .currentState!
                                                                        .save();
                                                                    await loginApi(
                                                                      context,
                                                                      loginemail
                                                                          .text,
                                                                      loginpassword
                                                                          .text,
                                                                      loginotp
                                                                          .text,
                                                                    );
                                                                  }
                                                                },
                                                                obscureText: getx
                                                                    .loginpasswordshow
                                                                    .value,
                                                                autovalidateMode:
                                                                    AutovalidateMode
                                                                        .onUserInteraction,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .next,
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Cannot blank';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller:
                                                                    loginpassword,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .visiblePassword,
                                                                decoration: InputDecoration(
                                                                    suffixIcon: IconButton(
                                                                        onPressed: () {
                                                                          getx.loginpasswordshow.value = !getx
                                                                              .loginpasswordshow
                                                                              .value;
                                                                        },
                                                                        icon: getx.loginpasswordshow.value
                                                                            ? const Icon(Icons.visibility)
                                                                            : const Icon(Icons.visibility_off)),
                                                                    enabledBorder: border,
                                                                    focusedBorder: border,
                                                                    hintText: '************'),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.topRight,
                                                          width: formfieldsize,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Get.to(() =>
                                                                  const ForgotScreen());
                                                            },
                                                            child: Text(
                                                              'Forget password',
                                                              style: FontFamily
                                                                  .mobilefont,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                              width:
                                                                  formfieldsize,
                                                              child:
                                                                  MaterialButton(
                                                                shape:
                                                                    ContinuousRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            18),
                                                                color: ColorPage
                                                                    .colorgrey,
                                                                onPressed:
                                                                    () async {
                                                                  notification();
                                                                  if (!desktop_key2
                                                                      .currentState!
                                                                      .validate()) {
                                                                    desktop_key2
                                                                        .currentState!
                                                                        .save();
                                                                    await loginApi(
                                                                        context,
                                                                        'tester1',
                                                                        'Admin@1234',
                                                                        '1234');
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'Login',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          fontsize,
                                                                      color: ColorPage
                                                                          .white),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'New User ?',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  ClsFontsize
                                                                      .ExtraSmall),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            width:
                                                                formfieldsize,
                                                            child:
                                                                MaterialButton(
                                                              shape: ContinuousRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              onPressed: () {},
                                                              child: Text(
                                                                'Create an account',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        ClsFontsize
                                                                            .ExtraSmall),
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
                        ),
                      )
                    ],
                  ),
                )
              : Platform.isAndroid
                  ? const Mobilelogin()
                  : Container(
                      color: ColorPage.colorblack,
                    )),
    );
  }
}