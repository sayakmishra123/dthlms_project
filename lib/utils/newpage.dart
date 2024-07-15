import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  if (args.length > 1) {
    final windowId = int.parse(args[1]);
    runApp(MyNewWindowApp(windowId: windowId));
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Main Window'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: openNewWindow,
            child: Text('Open New Window'),
          ),
        ),
      ),
    );
  }
}

class MyNewWindowApp extends StatefulWidget {
  final int windowId;

  const MyNewWindowApp({required this.windowId});

  @override
  State<MyNewWindowApp> createState() => _MyNewWindowAppState();
}

class _MyNewWindowAppState extends State<MyNewWindowApp> {
  @override
  void initState() {
    data1().whenComplete(() => null);

    super.initState();
  }

  List<int> data = [];
  Future data1() async {
    var x = await DesktopMultiWindow.getAllSubWindowIds();
    for (var id in x) {
      print(id);
      data.add(id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('New windows'),
        ),
        body: Center(
          child: Text(data.toString()),
        ),
      ),
    );
  }
}

void openNewWindow() async {
  final window = await DesktopMultiWindow.createWindow('dfhfhgf');
  window
    ..setFrame(const Offset(0, 0) & const Size(800, 600))
    ..center()
    ..show();
}
