import 'package:flutter/material.dart';

class PythonFile extends StatefulWidget {
  const PythonFile({super.key});

  @override
  State<PythonFile> createState() => _PythonFileState();
}

class _PythonFileState extends State<PythonFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                // FletApp(pageUrl: pageUrl, assetsDir: assetsDir)
                //     .callPythonFunction();
              },
              child: Text('Press')),
        ),
      ),
    );
  }
}
