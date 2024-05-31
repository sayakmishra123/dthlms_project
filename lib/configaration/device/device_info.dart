import 'dart:io';
import 'package:advertising_id/advertising_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import 'package:windows_system_info/windows_system_info.dart';

class ClsDeviceInfo {
  static Future<List<String>> windowsInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    WindowsDeviceInfo windowsInfo = await deviceInfoPlugin.windowsInfo;

    await WindowsSystemInfo.initWindowsInfo(requiredValues: [
      WindowsSystemInfoFeat.os,
      WindowsSystemInfoFeat.cpu,
      WindowsSystemInfoFeat.system,
    ]);
    if (await WindowsSystemInfo.isInitilized) {}

    // if (kDebugMode) {
    //   print("motherboard uuid id- ${WindowsSystemInfo.os?.uuid.toString()}");
    // }
    // if (kDebugMode) {
    //   print('Windows processer:${WindowsSystemInfo.cpu?.brand.toString()}');
    // }
    // if (kDebugMode) {
    //   print('Type:${Platform.operatingSystem}');
    // }
    // if (kDebugMode) {
    //   print('id:${WindowsSystemInfo.os?.serial.toString()}');
    // }
    // if (kDebugMode) {
    //   print('Windows Version:${WindowsSystemInfo.os?.distro.toString()}');
    // }
    // WindowsSystemInfoFeat.os.
    print([
      "${WindowsSystemInfo.os?.uuid.toString()}",
      windowsInfo.deviceId,
      'Type:${Platform.operatingSystem}',
      'id:${WindowsSystemInfo.os?.serial.toString()},${WindowsSystemInfo.os?.distro.toString()},${WindowsSystemInfo.cpu?.brand.toString()}',
    ]);
    return [
      "${WindowsSystemInfo.os?.uuid.toString()}",
      windowsInfo.deviceId,
      'Type:${Platform.operatingSystem}',
      'id:${WindowsSystemInfo.os?.serial.toString()},${WindowsSystemInfo.os?.distro.toString()},${WindowsSystemInfo.cpu?.brand.toString()}',
    ];
  }

  static Future<List<String>> androidInfo() async {
    DeviceInfoPlugin android = DeviceInfoPlugin();
    List<String> information = [];
    String? advertisingId;
// Platform messages may fail, so we use a try/catch PlatformException.

    try {
      advertisingId = await AdvertisingId.id(true);
    } on PlatformException {
      advertisingId = null;
    }

    var info = await android.androidInfo;

    print(information);
    return [
      "AddId--$advertisingId",
      "deviceId--${info.id}",
      "type--Android",
      "Android(${info.version.release})${info.supportedAbis}${info.model},${info.manufacturer}",
    ];
  }
}
