import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:dthlms/pages/mycourses/myclasscontentvideo/myclasscontentvideo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class McqCategory extends StatefulWidget {
//  late List<McqDetails> mcq;
  McqCategory({super.key});

  @override
  State<McqCategory> createState() => _McqCategoryState();
}

class _McqCategoryState extends State<McqCategory> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: ColorPage.bgcolor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              // width: 700,
              // height: 700,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    ListTile(
                      trailing: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(ColorPage.color1),
                              shape: MaterialStatePropertyAll(
                                  ContinuousRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () {},
                          child: Text(
                            'Submit',
                            style: TextStyle(color: ColorPage.white),
                          )),
                      leading: Icon(Icons.punch_clock),
                      title: Text(
                        'Time remaining',
                        style: GoogleFonts.kadwa(
                            textStyle: TextStyle(color: ColorPage.grey)),
                      ),
                      subtitle: Text(
                        '14:44:00',
                        style: GoogleFonts.kadwa(
                            textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Question 1 of 10',
                          style: GoogleFonts.kadwa(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Which of the programming language for developing webpages.',
                          style: GoogleFonts.kadwa(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // alignment: Alignment.topLeft,

                          // width: 300,
                          child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlinedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStatePropertyAll(
                                                  BeveledRectangleBorder(
                                                      side: BorderSide(
                                                          color:
                                                              ColorPage.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                          onPressed: () {},
                                          child: Text(
                                            'A. COBOL',
                                            style: FontFamily.font,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlinedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStatePropertyAll(
                                                  BeveledRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                          onPressed: () {},
                                          child: Text(
                                            'B. COBOL',
                                            style: FontFamily.font,
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlinedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStatePropertyAll(
                                                  BeveledRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                          onPressed: () {},
                                          child: Text(
                                            'C. COBOL',
                                            style: FontFamily.font,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: OutlinedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStatePropertyAll(
                                                  BeveledRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)))),
                                          onPressed: () {},
                                          child: Text(
                                            'D. COBOL',
                                            style: FontFamily.font,
                                          )),
                                    ),
                                  ],
                                )
                              ]),
                        ),
                        Column(
                          children: [],
                        )
                      ],
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: PaginationWidget(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaginationWidget extends StatefulWidget {
  @override
  _PaginationWidgetState createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int currentPage = 1;
  int totalPages = 5;

  void _goToPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed:
                currentPage > 1 ? () => _goToPage(currentPage - 1) : null,
            child: Text('Prev'),
          ),
          ...List.generate(totalPages, (index) {
            int pageIndex = index + 1;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor:
                      currentPage == pageIndex ? Colors.white : Colors.black,
                  backgroundColor:
                      currentPage == pageIndex ? Colors.green : Colors.white,
                  side: BorderSide(color: Colors.green),
                ),
                onPressed: () => _goToPage(pageIndex),
                child: Text(pageIndex.toString()),
              ),
            );
          }),
          ElevatedButton(
            onPressed: currentPage < totalPages
                ? () => _goToPage(currentPage + 1)
                : null,
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
