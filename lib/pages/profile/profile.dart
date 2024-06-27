import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/pages/utctime.dart';

import 'package:dthlms/widget/drawerWidget.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ThemeData/color/color.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneno = TextEditingController();

  @override
  void initState() {
    name.text = "Sayak Mishra";
    email.text = "william.henry.harrison@example-pet-store.com";
    phoneno.text = "9876543210";
    super.initState();
  }

  double width = 400;
  // ignore: non_constant_identifier_names
  Getx get_obj = Get.put(Getx());
  final optionname = Get.arguments['optionname'];
  UtcTime time = UtcTime();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            actions: [
              Text(
                time.utctime(),
                style: FontFamily.font2,
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/shutdown.png',
                    width: 30,
                  ),
                  label: Text(
                    'Log Out',
                    style: GoogleFonts.kadwa(
                        textStyle: TextStyle(
                            fontSize: ClsFontsize.Small,
                            color: ColorPage.white)), //20
                  ))
            ],
            backgroundColor: ColorPage.appbarcolor,
            title: Text(
              optionname,
              style: FontFamily.font2,
              textScaler: const TextScaler.linear(1.5),
            ),
          ),
          body: Container(
            color: ColorPage.bgcolor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DrawerWidget(),
                Expanded(
                  child: Container(
                    color: ColorPage.color1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/loginimg2.png',
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.sizeOf(context).height,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Form(
                            child: Card(
                          elevation: 30,
                          color: ColorPage.bgcolor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Profile',
                                      style: FontFamily.font,
                                      textScaler: const TextScaler.linear(1.7),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 80,
                                      child:
                                          Image.asset('assets/loginimg2.png'),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: width,
                                        child: Text(
                                          'Name',
                                          style: FontFamily.font,
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: width,
                                        child: TextFormField(
                                          controller: name,
                                          decoration: InputDecoration(
                                              suffix: IconButton(
                                                  onPressed: () {},
                                                  icon:
                                                      const Icon(Icons.edit))),
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width,
                                      child: Text(
                                        'Phone no',
                                        style: FontFamily.font,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: width,
                                        child: TextFormField(
                                          controller: phoneno,
                                          decoration: InputDecoration(
                                              suffix: IconButton(
                                                  onPressed: () {},
                                                  icon:
                                                      const Icon(Icons.edit))),
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: width,
                                        child: Text(
                                          'Email-id',
                                          style: FontFamily.font,
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: width,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                suffix: IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.edit))),
                                            controller: email,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                      ),
                    ),
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
