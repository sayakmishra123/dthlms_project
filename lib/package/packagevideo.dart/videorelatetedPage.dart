import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/pages/mycourses/myclasscontentvideo/myclasscontentvideo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VideoDetails extends StatefulWidget {
  String videoname = '';
  String token;
  VideoDetails(this.videoname, this.token, {super.key});

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPage.bgcolor,
      body: Row(
        children: [
          Expanded(child: MyClassVideoContent(widget.videoname, widget.token)),
          Expanded(
              child: Container(
            color: Colors.black,
          ))
        ],
      ),
    );
  }
}
