import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future ThemePage(BuildContext context) async {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
            elevation: 20,
            enableDrag: true,
            // animationController:
            //     AnimationController(vsyn),
            onClosing: () {},
            builder: (context) {
              return Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Theme',
                            style: FontFamily.font4,
                            textScaler: TextScaler.linear(2),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'assets/sun.png',
                              width: 50,
                            ),
                          ),
                          SizedBox(width: 50),
                          InkWell(
                            onTap: () {},
                            child: Image.asset(
                              'assets/themes.png',
                              width: 50,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Primary Color',
                            style: FontFamily.font4,
                            textScaler: TextScaler.linear(2),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF87CEEB))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF000080))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF4169E1))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF008080))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF40E0D0))),
                                onPressed: () {},
                                icon: Text('')),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFF98FF98),
                                )),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF50C878))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF228B22))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF40E0D0))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFF808000))),
                                onPressed: () {},
                                icon: Text('')),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFFFFB6C1))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                  Color(0xFFFF69B4),
                                )),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFFFF00FF))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFFDE3163))),
                                onPressed: () {},
                                icon: Text('')),
                            IconButton.filled(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Color(0xFFAEC6CF))),
                                onPressed: () {},
                                icon: Text('')),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton.filled(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFFFA8072))),
                              onPressed: () {},
                              icon: Text('')),
                          IconButton.filled(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFF800000))),
                              onPressed: () {},
                              icon: Text('')),
                          IconButton.filled(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFF800020))),
                              onPressed: () {},
                              icon: Text('')),
                          IconButton.filled(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color(0xFFB87333))),
                              onPressed: () {},
                              icon: Text('')),
                          IconButton.filled(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 7, 3, 212))),
                              onPressed: () {},
                              icon: Text('')),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      });
}
