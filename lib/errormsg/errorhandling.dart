import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class  ClsErrorMsg
{
 static fnErrorDialog(BuildContext context,error,res) async
  {
       await FlutterPlatformAlert.playAlertSound();

    // ignore: unused_local_variable
    final result = await FlutterPlatformAlert.showCustomAlert(
      windowTitle: 'Login',
      text: '$error',
      positiveButtonTitle: "Ok",
    );
  }
}