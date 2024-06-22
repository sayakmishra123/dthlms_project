import 'package:dthlms/ThemeData/color/color.dart';
import 'package:dthlms/ThemeData/font/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> with TickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) {}); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material();
  }
}
