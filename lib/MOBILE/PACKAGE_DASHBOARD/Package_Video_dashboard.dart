import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:dthlms/PC/PACKAGEDETAILS/packagedetails.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobilePackageVideoDashboard extends StatefulWidget {
  const MobilePackageVideoDashboard({super.key});

  @override
  State<MobilePackageVideoDashboard> createState() =>
      _MobilePackageVideoDashboardState();
}

class _MobilePackageVideoDashboardState
    extends State<MobilePackageVideoDashboard> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();

    getListStructure().whenComplete(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Getx getx = Get.put(Getx());

  Future getListStructure() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    getx.isFolderview.value = prefs.getBool("folderview") ?? false;
  }

  void scrollGridView() {
    double scrollAmount = 300.0;

    double newOffset = _scrollController.offset + scrollAmount;

    if (newOffset > _scrollController.position.maxScrollExtent) {
      newOffset = _scrollController.position.maxScrollExtent;
    }

    _scrollController.animateTo(
      newOffset,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorPage.white),
          backgroundColor: ColorPage.appbarcolor,
          title: Text(
            "Packages",
            style: FontFamily.font2,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 5, right: 13),
          child: Obx(
            () => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Contents",
                        style: FontFamily.font,
                      ),
                      Row(
                        children: [
                          Tooltip(
                            message: "Folder View",
                            child: IconButton(
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool("folderview", true);
                                  getx.isFolderview.value = true;
                                },
                                icon: Icon(
                                  Icons.grid_view_rounded,
                                  color: getx.isFolderview.value
                                      ? ColorPage.colorbutton
                                      : ColorPage.colorblack,
                                )),
                          ),
                          Tooltip(
                            message: "List View",
                            child: IconButton(
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool("folderview", false);
                                  getx.isFolderview.value = false;
                                },
                                icon: Icon(
                                  Icons.view_list,
                                  color: !getx.isFolderview.value
                                      ? ColorPage.colorbutton
                                      : ColorPage.colorblack,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: getx.isFolderview.value ? 9 : 11,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 7, left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Color.fromARGB(255, 192, 191, 191),
                            offset: Offset(0, 0),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: getx.isFolderview.value
                          ? Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: GridView.builder(
                                    controller: _scrollController,
                                    itemCount: 50,
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.0,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "assets/folder5.png",
                                              scale: 8,
                                            ),
                                            AutoSizeText(
                                              "Folder Name",
                                              overflow: TextOverflow.ellipsis,
                                              style: FontFamily.font9.copyWith(
                                                  color: ColorPage.colorblack),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: -10,
                                  // top: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_right_alt_outlined,
                                      color: ColorPage.colorbutton,
                                      size: 50,
                                    ),
                                    onPressed: scrollGridView,
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              padding: EdgeInsets.all(10),
                              child: ListView.builder(
                                itemCount: 100,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: Color.fromARGB(
                                                255, 192, 191, 191),
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {},
                                        child: ListTile(
                                          leading: Image.asset(
                                            "assets/folder.png",
                                            width: 30,
                                          ),
                                          title: Text(
                                              "Folder no - ${index + 1}",
                                              style: FontFamily.font9.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorPage.colorblack)),
                                        ),
                                      ));
                                },
                              ),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Videos",
                        style: FontFamily.font,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: Color.fromARGB(255, 192, 191, 191),
                            offset: Offset(0, 0),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color:
                                            Color.fromARGB(255, 192, 191, 191),
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
                                      subtitle: Text(
                                        "This in New Video",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      leading: Image.asset(
                                        "assets/video2.png",
                                        color: ColorPage.colorbutton,
                                        width: 25,
                                      ),
                                      title: Text("Videos no - ${index + 1}",
                                          style: FontFamily.font4.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      trailing: Text("25:30 min"),
                                    ),
                                  ));
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
