import 'package:deepgram_speech_to_text/deepgram_speech_to_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class deepgramStt extends StatefulWidget {
  const deepgramStt({super.key});

  @override
  State<deepgramStt> createState() => _deepgramSttState();
}

class _deepgramSttState extends State<deepgramStt> {
  String? apiKey = "b3abc0c45c2c4fbf46a3a88737bec2b5900a50f6";
  String? speech='';
  Map<String, dynamic>? params = {
    'model': 'nova-2-general',
    'detect_language': true,
    'filler_words': false,
    'punctuation': true,
    //...
  };
  Future fnDeepgram() async {
    Deepgram deepgram = Deepgram(apiKey!, baseQueryParams: params);
    final isValid = await deepgram.isApiKeyValid();
    print('API key is valid: $isValid');
    final res2 = await deepgram.transcribeFromUrl(
        'https://www2.cs.uic.edu/~i101/SoundFiles/taunt.wav');
    print(res2.transcript);
    speech=res2.transcript;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  fnDeepgram();
                  setState(() {
                    
                  });
                },
                child: Text("press")),
          ),
          Container(child: Text(speech!,style: TextStyle(color: Colors.black),),)
        ],
      ),
    );
  }
}



// import 'package:deepgram_speech_to_text/deepgram_speech_to_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';

// class deepgramStt extends StatefulWidget {
//   const deepgramStt({super.key});

//   @override
//   State<deepgramStt> createState() => _deepgramSttState();
// }

// class _deepgramSttState extends State<deepgramStt> {
//   String? apiKey = "b3abc0c45c2c4fbf46a3a88737bec2b5900a50f6";
//   String? speech = '';
//   Map<String, dynamic>? params = {
//     'model': 'nova-2-general',
//     'detect_language': true,
//     'filler_words': false,
//     'punctuation': true,
//   };
//   FlutterSoundRecorder? _recorder;
//   bool _isRecording = false;

//   @override
//   void initState() {
//     super.initState();
//     _recorder = FlutterSoundRecorder();
//     _initializeRecorder();
//   }

//   Future<void> _initializeRecorder() async {
//     await _recorder!.openRecorder();
//     await Permission.microphone.request();
//   }

//   Future<void> _startRecording() async {
//     await _recorder!.startRecorder(
//       toFile: 'audio.wav',
//       codec: Codec.pcm16WAV,
//     );
//     setState(() {
//       _isRecording = true;
//     });
//   }

//   Future<void> _stopRecording() async {
//     String? path = await _recorder!.stopRecorder();
//     setState(() {
//       _isRecording = false;
//     });
//     await _transcribeAudio(path!);
//   }

//   Future<void> _transcribeAudio(String path) async {
//     Deepgram deepgram = Deepgram(apiKey!, baseQueryParams: params);
//     final isValid = await deepgram.isApiKeyValid();
//     print('API key is valid: $isValid');
//     final res2 = await deepgram.transcribeFromFile(path);
//     setState(() {
//       speech = res2.transcript;
//     });
//     print(res2.transcript);
//   }

//   @override
//   void dispose() {
//     _recorder!.closeRecorder();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//                 onPressed: () {
//                   if (_isRecording) {
//                     _stopRecording();
//                   } else {
//                     _startRecording();
//                   }
//                 },
//                 child: Text(_isRecording ? "Stop" : "Start")),
//           ),
//           Container(
//             child: Text(
//               speech!,
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

