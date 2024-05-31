// ignore_for_file: camel_case_types

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class forgetPasswordMobile extends StatefulWidget {
  const forgetPasswordMobile({super.key});

  @override
  State<forgetPasswordMobile> createState() => _forgetPasswordMobileState();
}

class _forgetPasswordMobileState extends State<forgetPasswordMobile> {
  late double screenwidth = MediaQuery.of(context).size.width;
  late double spaceAroundForgetpassword =
      MediaQuery.of(context).size.width / 12;
  late double spaceBetweenEmailAndPassword =
      MediaQuery.of(context).size.width / 25;
  late double spaceBetweenConfirmPassAndButtons =
      MediaQuery.of(context).size.width / 8;
  late double spaceBetweenSaveAndCancelButton =
      MediaQuery.of(context).size.width / 18;
  late double spaceBetweenOpenEmailAndforgetPassword =
      MediaQuery.of(context).size.width / 12;

  GlobalKey<FormState> key = GlobalKey();
  Getx getx = Get.put(Getx());
  final email = InputDecoration(
      hintText: 'solution@gmail.com',
      hintStyle: const TextStyle(color: ColorPage.colorgrey),
      labelText: 'Email',
      labelStyle: GoogleFonts.outfit(),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPage.color1),
          borderRadius: BorderRadius.circular(
            10,
          )),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPage.color1),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPage.color1),
          borderRadius: BorderRadius.circular(10)));
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          backgroundColor: ColorPage.white,
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/Black and Red Minimalist Modern Registration Gym Website Prototype (1).jpg'),
                    fit: BoxFit.fill)),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: screenwidth / 30,
                      ),
                      IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: ColorPage.white,
                            size: 32,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 80,
                        // color: Colors.white,
                        child: Container(
                          width: screenwidth - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorPage.white,
                          ),
                          child: Form(
                            key: key,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      // height: 400,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            'https://videoencryptor.com/assets/images/logo.png',
                                            width: screenwidth / 2.1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   height: 30,
                                // ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Forgot your password',
                                      style: FontFamily.font,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: spaceAroundForgetpassword,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: screenwidth - 100,
                                        child: TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            style: const TextStyle(),
                                            decoration: email))
                                  ],
                                ),
                                SizedBox(
                                  height: spaceBetweenEmailAndPassword,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: screenwidth - 100,
                                          child: Obx(
                                            () => TextFormField(
                                                obscureText:
                                                    getx.forgetpassword1.value,
                                                textInputAction:
                                                    TextInputAction.next,
                                                decoration: InputDecoration(
                                                    hintStyle: const TextStyle(
                                                        color: ColorPage
                                                            .colorgrey),
                                                    labelStyle:
                                                        GoogleFonts.outfit(),
                                                    hintText: 'Password',
                                                    labelText: 'Password',
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                          getx.forgetpassword1
                                                                  .value =
                                                              !getx
                                                                  .forgetpassword1
                                                                  .value;
                                                        },
                                                        icon: getx
                                                                .forgetpassword1
                                                                .value
                                                            ? const Icon(
                                                                Icons
                                                                    .visibility,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .visibility_off,
                                                              )),
                                                    border: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            color: ColorPage
                                                                .color1),
                                                        borderRadius: BorderRadius
                                                            .circular(
                                                          10,
                                                        )),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: ColorPage
                                                                    .color1),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                            color: ColorPage.color1),
                                                        borderRadius: BorderRadius.circular(10)))),
                                          ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: screenwidth - 100,
                                          child: Obx(
                                            () => TextFormField(
                                              obscureText:
                                                  getx.forgetpassword2.value,
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: const TextStyle(),
                                              decoration: InputDecoration(
                                                  labelStyle:
                                                      GoogleFonts.outfit(),
                                                  hintStyle: const TextStyle(
                                                      color:
                                                          ColorPage.colorgrey),
                                                  hintText: 'Confirm Password',
                                                  labelText: 'Confirm Password',
                                                  suffixIcon: IconButton(
                                                      onPressed: () {
                                                        getx.forgetpassword2
                                                                .value =
                                                            !getx
                                                                .forgetpassword2
                                                                .value;
                                                      },
                                                      icon: getx.forgetpassword2
                                                              .value
                                                          ? const Icon(
                                                              Icons.visibility,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .visibility_off,
                                                            )),
                                                  border: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color:
                                                              ColorPage.color1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      )),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color:
                                                              ColorPage.color1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(
                                                          color:
                                                              ColorPage.color1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: spaceBetweenConfirmPassAndButtons),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: screenwidth / 2.8,
                                      child: OutlinedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStatePropertyAll(
                                                  ContinuousRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)))),
                                          onPressed: () {},
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.outfit(
                                                textStyle: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorPage.colorblack)),
                                          )),
                                    ),
                                    SizedBox(
                                        width: spaceBetweenSaveAndCancelButton),
                                    SizedBox(
                                      width: screenwidth / 2.8,
                                      height: 60,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  const MaterialStatePropertyAll(
                                                      ColorPage.color1),
                                              shape: MaterialStatePropertyAll(
                                                  ContinuousRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)))),
                                          onPressed: () {},
                                          child: Text(
                                            'Save',
                                            style: FontFamily.font3,
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: screenwidth / 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenwidth - 100,
                        child: ElevatedButton.icon(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(ColorPage.white),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 50))),
                            onPressed: () {
                              void openEmailClient() async {
                                final Uri emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: '',
                                );
                                if (await canLaunchUrlString(
                                    emailLaunchUri.toString())) {
                                  await launchUrl(emailLaunchUri);
                                } else {
                                  throw 'Could not launch email';
                                }
                              }

                              openEmailClient();
                            },
                            icon: Image.asset(
                              'assets/email.png',
                              width: 40,
                            ),
                            label: Text(
                              'Open Email App',
                              style: FontFamily.font,
                            )),
                      )
                    ],
                  ),
                  const Row(
                    children: [],
                  )
                ],
              ),
            ),
          )),
    );
    ;
  }
}
