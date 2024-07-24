import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/android/Videodashboard/mobileVideoDashboard.dart';
import 'package:dthlms/getx/getxcontroller.getx.dart';
import 'package:dthlms/package/packagevideo.dart/videodashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DynamicFolderMobile extends StatefulWidget {
  int content = 0;
  String token;
  List datacontent;
  int count = 0;
  DynamicFolderMobile(
      {required this.content,
      required this.token,
      required this.datacontent,
      required this.count});

  @override
  State<DynamicFolderMobile> createState() => _DynamicFolderMobileState(datacontent);
}

class _DynamicFolderMobileState extends State<DynamicFolderMobile> {
  List extructcontent = [];
  Getx getx = Get.put(Getx());
  List duplicatecontent = [];

  _DynamicFolderMobileState(this.duplicatecontent);

  Future editList() async {
    getx.name.add(widget.datacontent.first);
    print(extructcontent);

    // widget.datacontent.remove(widget.datacontent.first);
    print(widget.datacontent);
  }

  @override
  void initState() {
    editList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> textWidgets =
        widget.datacontent.map((e) => Text('$e')).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPage.appbarcolor,
        title: Text(
          textWidgets.toString(),
          style: TextStyle(color: ColorPage.white),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              ListTile(
                onTap: () {
                  widget.content--;

                  widget.content == 1
                      ? Get.to(() => MobileVideoDashboard(),
                          arguments: {'token': widget.token})
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DynamicFolderMobile(
                                    content: widget.content,
                                    token: widget.token,
                                    datacontent: widget.datacontent,
                                    count: 0,
                                  )));
                  // Get.to(() => DynamicFolder(widget.content, Colors.red));
                },
                title: Text(widget.content.toString()),
              ),
            ],
          )),
         
        ],
      ),
    );
  }
}
