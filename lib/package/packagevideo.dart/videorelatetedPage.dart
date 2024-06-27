import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/pages/mycourses/myclasscontentvideo/myclasscontentvideo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class VideoDetails extends StatefulWidget {

  VideoDetails( {super.key});

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {

  Getx get_obj=Get.put(Getx());
    final videoname = Get.arguments['videoname'];
  final token=Get.arguments['token'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPage.bgcolor,
      body: Row(
        children: [
          Expanded(child: MyClassVideoContent()),
          Expanded(
              child: Container(
            color: Colors.black,
          ))
        ],
      ),
    );
  }
}
