import 'package:flutter/material.dart';

class McqTermAndCondition extends StatelessWidget {
  const McqTermAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/applogo.png',
        ),
        title: Text('Welcome xyz classes'),
        actions: [
          Text('Exam Starts in : 4.50 min'),
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
