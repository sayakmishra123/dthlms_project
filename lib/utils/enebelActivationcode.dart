import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/apiHandleing/apifetchall.dart';

import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class GlobalDialog extends StatefulWidget {
  String token='';
  GlobalDialog(this.token);
  @override
  _GlobalDialogState createState() => _GlobalDialogState(token);
}

class _GlobalDialogState extends State<GlobalDialog>
    with TickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _animation;
  String token='';
  _GlobalDialogState(this.token);

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _blinkController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  Getx getxController = Get.put(Getx());

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.0,
      right: 20.0,
      child: FadeTransition(
        opacity: _animation,
        child: CustomMessageBubble(
          text: 'Enable Activation Key!',
          token: widget.token,
          color: ColorPage.blue,
          icon: Icons.info_outline,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomMessageBubble extends StatelessWidget {
  final String text;
  final String token;
  final Color color;
  final IconData icon;
  final TextStyle textStyle;

  CustomMessageBubble({
    required this.text,
    required this.token,
    required this.color,
    required this.icon,
    required this.textStyle,
  });
  TextEditingController activationfield = TextEditingController();
  Getx get_obj = Get.put(Getx());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: InkWell(
        onTap: () {
          // Get.to(()=>ActivationCodePage());
          onAlertWithStylePressed(context);

          // _onAlertWithCustomContentPressed(context, activationfield);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20.0,
            ),
            SizedBox(width: 8.0), // space between icon and text
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }

  // Alert custom content
  // _onAlertWithCustomContentPressed(
  //     context, TextEditingController activationfield) {
  //   final _formKey = GlobalKey<FormState>();
  //   Alert(
  //       style: AlertStyle(
  //         alertPadding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
  //         animationType: AnimationType.grow,

  //         backgroundColor: ColorPage.color1,
  //         titleStyle:
  //             GoogleFonts.kadwa(textStyle: TextStyle(color: ColorPage.blue)),
  //       ),
  //       context: context,
  //       title: "Activation Code",
  //       content: Form(
  //         key: _formKey,
  //         child: Column(
  //           children: <Widget>[
  //             SizedBox(height: 20,),
  //             Row(
  //               children: [
  //                 Text(
  //                                       'Please fill field *',
  //                                       style: TextStyle(color: ColorPage.red,fontSize: 15),
  //                                     ),
  //               ],
  //             ),
  //             TextFormField(
  //               controller: activationfield,
  //               validator: (value) {
  //                 if (value!.isEmpty) {
  //                   return 'cannot blank';
  //                 }
  //                 return null;
  //               },
  //               decoration: InputDecoration(
  //                   // prefixIcon: Icon(Icons.code),
  //                   suffixIcon: IconButton(
  //                       onPressed: () {}, icon: Icon(Icons.visibility)),
  //                   labelText: 'Enter Activation Code',
  //                   // hintText: 'Enter Activation Code',
  //                   fillColor: ColorPage.white,
  //                   filled: true,
  //                   focusColor: ColorPage.white),
  //             ),
  //           ],
  //         ),
  //       ),
  //       buttons: [
  //         DialogButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: Text(
  //             "LOGIN",
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //         )
  //       ]).show();
  // }

  onAlertWithStylePressed(context) {
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
        titleStyle:
            TextStyle(color: ColorPage.blue, fontWeight: FontWeight.bold),
        constraints: BoxConstraints.expand(width: 500),
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.center);

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      // type: AlertType.info,

      title: "ACTIVATION CODE",

      content: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  'Please fill field *',
                  style: TextStyle(color: ColorPage.red, fontSize: 12),
                ),
              ),
            ],
          ),
          Obx(() => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  // controller: activationfield,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'cannot blank';
                    }
                    return null;
                  },
                  obscureText: get_obj.passvisibility.value,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.code),
                      suffixIcon: IconButton(
                          onPressed: () {
                            get_obj.passvisibility.value =
                                !get_obj.passvisibility.value;
                          },
                          icon: get_obj.passvisibility.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility)),
                      labelText: 'Enter Activation Code',
                      // hintText: 'Enter Activation Code',

                      filled: false,
                      focusColor: ColorPage.white),
                ),
              ))
        ],
      )),
      buttons: [
        DialogButton(
          width: MediaQuery.of(context).size.width / 4.5,
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () {  Get.back(); packactivationKey(context, activationfield.text, token);
            
          },
          color: ColorPage.colorgrey,
          radius: BorderRadius.circular(5.0),
        ),
      ],
    ).show();
  }





}
