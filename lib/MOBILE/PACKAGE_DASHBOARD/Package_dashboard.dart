
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:dthlms/PC/PACKAGEDETAILS/packagedetails.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobilePackageDashboard extends StatefulWidget {
  const MobilePackageDashboard({super.key});

  @override
  State<MobilePackageDashboard> createState() => _MobilePackageDashboardState();
}

class _MobilePackageDashboardState extends State<MobilePackageDashboard> {
  void initState() {
    getListStructure().whenComplete(() {
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }
  Getx getx=Get.put(Getx());

  Future getListStructure() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    getx.isFolderview.value = prefs.getBool("folderview")??false;
   
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar( title: Text("Packages"),),
        body: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Obx(
            () => Column(
              children: [
                // Expanded(
                //   flex: 2,
                //   child: Padding(
                //     padding: const EdgeInsets.only(bottom: 7),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(10),
                //         ),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.only(left: 15),
                //             child: FilePathWidget(path: [
                //               'C:',
                //               'Users',
                //               'Username',
                //               'Documents',
                //               'Project',
                //               'File.txt'
                //             ]),
                //           ),
                //           // Padding(
                //           //   padding: const EdgeInsets.only(right: 20),
                //           //   child: Container(
                //           //     margin: EdgeInsets.symmetric(vertical: 5),
                //           //     width: 300,
                //           //     child: TextFormField(
                //           //       decoration: InputDecoration(
                //           //           suffixIcon: Icon(
                //           //             Icons.search,
                //           //           ),
                //           //           suffixIconColor:
                //           //               Color.fromARGB(255, 103, 103, 103),
                //           //           hintText: 'Search',
                //           //           hintStyle: FontFamily.font9
                //           //               .copyWith(color: ColorPage.brownshade),
                //           //           fillColor: Color.fromARGB(255, 237, 237, 238),
                //           //           filled: true,
                //           //           border: OutlineInputBorder(
                //           //               borderSide: BorderSide.none,
                //           //               borderRadius: BorderRadius.circular(40))),
                //           //     ),
                //           //   ),
                //           // ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
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
                          // Container(
                          //   height: 38,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(7.0),
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.all(Radius.circular(4)),
                          //       child: MaterialButton(
        
                          //         shape: Border.all(
                          //             color: !getx.isFolderview.value
                          //                 ? ColorPage.colorblack
                          //                 : Colors.transparent,
                          //             width: 2),
                          //         color: getx.isFolderview.value
                          //             ? ColorPage.colorbutton
                          //             : Color.fromARGB(255, 255, 255, 255),
                          //         height: 20,
                          //         onPressed: () async {
                          //           final SharedPreferences prefs =
                          //               await SharedPreferences.getInstance();
                          //           await prefs.setBool("folderview", true);
        
                          //           getx.isFolderview.value = true;
                          //         },
                          //         child:Icon(Icons.grid_view_rounded,color:  getx.isFolderview.value
                          //                   ? ColorPage.white
                          //                   : ColorPage.colorblack,)
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   height: 38,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(7.0),
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.all(Radius.circular(5)),
                          //       child: MaterialButton(
                          //         shape: Border.all(
                          //             color: getx.isFolderview.value
                          //                 ? ColorPage.colorblack
                          //                 : Colors.transparent,
                          //             width: 2),
                          //         color: !getx.isFolderview.value
                          //             ? ColorPage.colorbutton
                          //             : Color.fromARGB(255, 255, 255, 255),
                          //         height: 20,
                          //         onPressed: () async {
                          //           final SharedPreferences prefs =
                          //               await SharedPreferences.getInstance();
                          //           await prefs.setBool("folderview", false);
                          //           getx.isFolderview.value = false;
                          //         },
                          //         child: Text(
                          //           "List view",
                          //           style: FontFamily.font4.copyWith(
                          //               color: !getx.isFolderview.value
                          //                   ? ColorPage.white
                          //                   : ColorPage.colorblack),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: getx.isFolderview.value ? 9 : 11,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 7,left: 10),
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
                          ? Container(
                              padding: EdgeInsets.all(10),
                              child: GridView.builder(
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
                                          leading: Image.asset(
                                            "assets/folder.png",
                                            width: 30,
                                          ),
                                          title: Text("Folder no - ${index + 1}",
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
                  padding: const EdgeInsets.only(left: 5),
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
                      // padding: EdgeInsets.symmetric(vertical: 20),
        
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
        
                      // child: VideoPlayerLeft(),
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
                                          color: Color.fromARGB(255, 192, 191, 191),
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