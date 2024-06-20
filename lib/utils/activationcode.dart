import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ActivationCodePage extends StatefulWidget {
  const ActivationCodePage({super.key});

  @override
  State<ActivationCodePage> createState() => _ActivationCodePageState();
}

class _ActivationCodePageState extends State<ActivationCodePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController activationfield = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPage.bgcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorPage.color1,
                ),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                width: 500,

                // height: 300,
                // color: Colors.red,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Activation Code',
                          style: GoogleFonts.kadwa(
                              textStyle: TextStyle(color: ColorPage.blue)),
                          textScaler: TextScaler.linear(2),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Please fill field *',
                                    style: TextStyle(color: ColorPage.red),
                                  ),
                                ],
                              ),
                            ),
                            TextFormField(
                              controller: activationfield,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'cannot blank';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  // prefixIcon: Icon(Icons.code),
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.visibility)),
                                  labelText: 'Enter Activation Code',
                                  // hintText: 'Enter Activation Code',
                                  fillColor: ColorPage.white,
                                  filled: true,
                                  focusColor: ColorPage.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              activationfield != '') {}
                        },
                        child: Text(
                          'Submit',
                          style: FontFamily.font2,
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(ColorPage.blue),
                            shape: MaterialStatePropertyAll(
                                ContinuousRectangleBorder())),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
