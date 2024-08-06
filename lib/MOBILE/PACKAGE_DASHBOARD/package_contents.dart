import 'package:dthlms/API/PACKAGE_API/packageapi.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mobile_Package_content extends StatefulWidget {
  final token;
  final packageid;
  final packagename;
  const Mobile_Package_content(
      {super.key,
      required this.token,
      required this.packageid,
      this.packagename});

  @override
  State<Mobile_Package_content> createState() => _Mobile_Package_contentState();
}

class _Mobile_Package_contentState extends State<Mobile_Package_content> {
  Getx getx = Get.put(Getx());
  // List packagecontentlist=[];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      packagedetails(context, widget.token, int.parse(widget.packageid))
          .whenComplete(() {
        setState(() {});
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        var packagecontentlist = getx.packagedetailsfoldername.entries.toList();
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorPage.white),
            backgroundColor: ColorPage.colorbutton,
            title: Text(
              widget.packagename,
              style: FontFamily.font2,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: ListView.builder(
                    itemCount: packagecontentlist.length,
                    itemBuilder: (context, index) {
                      var item = packagecontentlist[index];
                      return Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromARGB(255, 196, 190, 244),
                                offset: Offset(0, 0),
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: ListTile(
                                leading: Image.asset(
                                  item.key == "Videos"
                                      ? "assets/video15.png"
                                      : item.key == "Live"
                                          ? "assets/live-channel.png"
                                          : item.key == "VideosBackup"
                                              ? "assets/video-backup.png"
                                              : item.key == "MCQ"
                                                  ? "assets/choose2.png"
                                                  : item.key == "Theory"
                                                      ? "assets/exam2.png"
                                                      : item.key == "Book"
                                                          ? "assets/book2.png"
                                                          : "assets/folder8.png",
                                  // color: ColorPage.colorbutton,
                                  width: 45,
                                ),
                                title: Text(item.key,
                                    style: FontFamily.font4
                                        .copyWith(fontWeight: FontWeight.bold)),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorPage.colorbutton,
                                )),
                          ));
                    }),
              ),
            ),
          ),
        );
      }),
    );
  }
}
