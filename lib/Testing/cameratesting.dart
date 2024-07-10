import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<CameraDescription> ?cameras;
int photoCounter = 0;
Timer? timer;
CameraController ?controller;



class TestCamera extends StatefulWidget {
  @override
  _TestCameraState createState() => _TestCameraState();
}

class _TestCameraState extends State<TestCamera> {
  List<String> photoPaths = [];
  bool isTakingPhotos = false;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      photoCounter = prefs.getInt('photoCounter') ?? 0;
      photoPaths = prefs.getStringList('photoPaths') ?? [];
    });
  }

  void _startTakingPhotos() async {
    final camera = cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);

    controller = CameraController(
      camera,
      ResolutionPreset.high,
    );

    await controller!.initialize();

    setState(() {
      isTakingPhotos = true;
    });

    timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      final directory = await getTemporaryDirectory();
      final folderPath = '${directory.path}/Photos';
      final filePath = '$folderPath/photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Ensure the folder exists
      final folder = Directory(folderPath);
      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      // Take picture and save it
      final picture = await controller!.takePicture();
      await picture.saveTo(filePath);

      // Update UI
      setState(() {
        photoCounter++;
        photoPaths.add(filePath);
       
      });

      // Update shared preferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('photoCounter', photoCounter);
      prefs.setStringList('photoPaths', photoPaths);
    });
  }

  void _stopTakingPhotos() {
    if (timer != null) {
      timer!.cancel();
    }
    if (controller != null) {
      controller!.dispose();
    }
    setState(() {
      isTakingPhotos = false;
    });
  }

  @override
  void dispose() {
    _stopTakingPhotos();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Photos taken: $photoCounter'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isTakingPhotos ? _stopTakingPhotos : _startTakingPhotos,
                child: Text(isTakingPhotos ? 'Stop Taking Photos' : 'Start Taking Photos'),
              ),
              SizedBox(height: 20),
               ElevatedButton(
                onPressed: (){
                 setState(() {
                    photoPaths.clear();
                 });
                },
                child: Text( 'Delete all photo'),
              ),
              
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: photoPaths.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(File(photoPaths[index])),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
