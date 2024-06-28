import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPage.colorblack),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
      ),
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
                          _onAlertWithStylePressed(context);


                          // if (_formKey.currentState!.validate() &&
                          //     activationfield != '') {}
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


  _onAlertWithStylePressed(context) {
    // Reusable alert style
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: true,
        alertPadding: EdgeInsets.only(top: 200),
        descStyle: TextStyle(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: TextStyle(
          color: Colors.red,
        ),
        constraints: BoxConstraints.expand(width: 500),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.bottomCenter);

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      image: Image.asset("assets/splash6.gif"),
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(20.0),
        ),
      ],
    ).show();
  }


   _onCustomAnimationAlertPressed(context) {
    Alert(
      context: context,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      alertAnimation: fadeAlertAnimation,
    ).show();
  }

  Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }


 

}
