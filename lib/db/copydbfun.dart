// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<void> copyDatabase(String assetPath, String databaseName) async {
  try {
    Directory? dbPath = await getApplicationCacheDirectory();
    print(dbPath);
    if (await Directory("${dbPath.path}/database").exists()) {
      print('object');
    } else {
      await Directory("${dbPath.path}/database").create(recursive: true);
    }
    String targetPath = join("${dbPath.path}/database", databaseName);
    print(targetPath);
    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    print(targetPath);
    await File(targetPath).writeAsBytes(bytes);
    print('Database copied to $targetPath');
  } catch (e) {
    print('Error copying database: $e');
  }
}

fndbpath() async {
  try {
    Directory? dbPath = await getApplicationCacheDirectory();
    return "${dbPath.path}/database";
  } catch (e) {
    print(e);
  }
}
