import 'dart:convert';

import 'package:dthlms/login/dth_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    test();
    // TODO: implement initState
    super.initState();
  }

  Future test() async {
    var res = await get(
        Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    var res1 = await get(
        Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    setState(() {
      var data = jsonDecode(res.body);
      var data1 = jsonDecode(res1.body);
      print(data.toString());
      print(data1.toString());
    });

    var res2 = await get(
        Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    var res13 = await get(
        Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    setState(() {
      var data = jsonDecode(res.body);
      var data1 = jsonDecode(res1.body);
      print(data.toString());
      print(data1.toString());
    });
    var res4 = await get(
        Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    var res5 = await get(
        Uri.parse('https://official-joke-api.appspot.com/random_joke'));
    setState(() {
      var data = jsonDecode(res.body);
      var data1 = jsonDecode(res1.body);
      print(data.toString());
      print(data1.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(';ldmgf'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(DthLmsLogin());
        },
      ),
    );
  }
}
