import 'package:dthlms/API/PACKAGE_API/packageapi.dart';
import 'package:dthlms/GETX/getxcontroller.getx.dart';
import 'package:dthlms/MOBILE/PACKAGE_DASHBOARD/package_contents.dart';
import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mobile_Package_List extends StatefulWidget {
  final String token;
  const Mobile_Package_List({super.key, required this.token});

  @override
  State<Mobile_Package_List> createState() => _Mobile_Package_ListState();
}

class _Mobile_Package_ListState extends State<Mobile_Package_List> {
  final Getx getx = Get.put(Getx());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      allPackage(widget.token, context).whenComplete(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 10,
          automaticallyImplyLeading: false,
            backgroundColor: ColorPage.colorbutton,
           
            bottom: TabBar(
              indicatorPadding: EdgeInsets.all(2),
              indicatorSize: TabBarIndicatorSize.tab,
          
              indicatorColor: ColorPage.white,labelPadding: EdgeInsets.all(10),
              tabs: [
              Text("Packages",style: FontFamily.font2,),
              Text("Free Services",style: FontFamily.font2,),
          
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildPackageListView(context),
              buildFreeServicesListView(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPackageListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 3,
          //     color: Color.fromARGB(255, 192, 191, 191),
          //     offset: Offset(0, 0),
          //   ),
          // ],
      
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          child: ListView.builder(
            itemCount: getx.package.length,
            itemBuilder: (context, index) {
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
                  onPressed: () {
                    Get.to(() => Mobile_Package_content(
                        token: widget.token,
                        packageid: getx.package[index].packageId,
                        packagename: getx.package[index].packageName));
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/folder8.png",
                      width: 45,
                    ),
                    title: Text(getx.package[index].packageName,
                        style: FontFamily.font4.copyWith(fontWeight: FontWeight.bold)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorPage.colorbutton,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildFreeServicesListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
      
        
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: 5                                                                   ,
            itemBuilder: (context, index) {
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
                  onPressed: () {
                    // Get.to(() => Mobile_Package_content(
                    //     token: widget.token,
                    //     packageid: getx.freeServices[index].serviceId,
                    //     packagename: getx.freeServices[index].serviceName));
                  },
                  child: ListTile(
                    leading: Image.asset(
                      "assets/folder8.png",
                      width: 45,
                    ),
                    title: Text("freeServices",
                        style: FontFamily.font4.copyWith(fontWeight: FontWeight.bold)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: ColorPage.colorbutton,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
