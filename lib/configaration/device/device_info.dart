// ignore_for_file: avoid_print

import 'dart:io';
import 'package:advertising_id/advertising_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import 'package:windows_system_info/windows_system_info.dart';

class ClsDeviceInfo {
  static Future<Map<String, dynamic>> windowsInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    WindowsDeviceInfo windowsInfo = await deviceInfoPlugin.windowsInfo;

    await WindowsSystemInfo.initWindowsInfo(requiredValues: [
      WindowsSystemInfoFeat.all,
    ]);
    if (await WindowsSystemInfo.isInitilized) {}

    return {
      'deviceid1': WindowsSystemInfo.os?.uuid.toString(),
      'deviceid2': windowsInfo.deviceId,
      'type': Platform.operatingSystem,
      'typekind': 'windows',
      'configaration': {
        "id": WindowsSystemInfo.os?.serial.toString(),
        "model": WindowsSystemInfo.system?.model.toString(),
        "proccesor": WindowsSystemInfo.cpu?.brand.toString(),
        "version": Platform.operatingSystemVersion.toString(),
      },
    };
  }

  static Future<Map<String, dynamic>> androidInfo() async {
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
    return {
      'deviceid1': advertisingId,
      "deviceid2": info.id,
      "type": "Android",
      'typekind': 'mobile',
      'configaration': {
        'id': '${info.supportedAbis}',
        'model': '${info.model}',
        'proccesor': '${info.manufacturer}'
      }
    };
  }
}
