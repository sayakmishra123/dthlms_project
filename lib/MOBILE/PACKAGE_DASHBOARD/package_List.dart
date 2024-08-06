import 'package:dthlms/THEME_DATA/color/color.dart';
import 'package:dthlms/THEME_DATA/font/font_family.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mobile_Package_List extends StatefulWidget {
  const Mobile_Package_List({super.key});

  @override
  State<Mobile_Package_List> createState() => _Mobile_Package_ListState();
}

class _Mobile_Package_ListState extends State<Mobile_Package_List> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPage.colorbutton,
          title: Text("Packages",style: FontFamily.font2,),
        ),
        body:    Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
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
                                style: FontFamily.font4.copyWith(fontWeight: FontWeight.bold)),
                            trailing: Text("25:30 min"),
                          ),
                        ));
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
