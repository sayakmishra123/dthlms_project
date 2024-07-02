import 'package:dthlms/ThemeData/color/color.dart';
import 'package:flutter/material.dart';

class McqPage extends StatefulWidget {
  const McqPage({super.key});

  @override
  State<McqPage> createState() => _McqPageState();
}

class _McqPageState extends State<McqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: ColorPage.appbarcolor,title: Text("MCQ"),),);
  }
}