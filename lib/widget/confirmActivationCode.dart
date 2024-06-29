import 'dart:ui';

import 'package:dthlms/ThemeData/color/color.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future confirmActivationCode(context, String body) async {
  // Reusable alert style
  var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
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
      titleStyle: TextStyle(color: ColorPage.blue, fontWeight: FontWeight.bold),
      constraints: BoxConstraints.expand(width: 700),
      //First to chars "55" represents transparency of color
      overlayColor: Color(0x55000000),
      alertElevation: 0,
      alertAlignment: Alignment.center);

  // Alert dialog using custom alert style
  Alert(
    context: context,
    style: alertStyle,
    // type: AlertType.info,

    title: "Do You Want To Activate?",

    content: Form(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  height: 2,
                  color: ColorPage.appbarcolor,
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 200,
                  color: ColorPage.bluegrey300,
                  child: Center(
                    child: Text(body),
                  ),
                ))
              ],
            )
          ],
        ),
      ],
    )),
    buttons: [
      DialogButton(
        width: MediaQuery.of(context).size.width / 6,
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromARGB(255, 177, 11, 11),
        radius: BorderRadius.circular(5.0),
      ),
      DialogButton(
        width: MediaQuery.of(context).size.width / 6,
        child: Text(
          "Confirm",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromARGB(255, 35, 166, 12),
        radius: BorderRadius.circular(5.0),
      ),
    ],
  ).show();
}
