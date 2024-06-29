// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';
import 'package:advertising_id/advertising_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:windows_system_info/windows_system_info.dart';

class ClsDeviceInfo {
  static Future<Map<String, dynamic>> windowsInfo() async {
    try {
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
    } catch (e) {
      return {};
    }
  }

  static Future<Map<String, dynamic>> androidInfo(BuildContext context) async {
    try {
      DeviceInfoPlugin android = DeviceInfoPlugin();
      List<dynamic> information = [];
      String? advertisingId;

      String? typeKind;

      try {
        advertisingId = await AdvertisingId.id(true);
      } on PlatformException {
        advertisingId = null;
      }

      var info = await android.androidInfo;
      bool istablet = (MediaQuery.of(context).size.shortestSide >= 600);
      typeKind = istablet ? 'Tablet' : 'Mobile';

      print(information);
      return {
        'deviceid1': advertisingId,
        "deviceid2": info.id,
        "type": "Android",
        'typekind': "$typeKind",
        'configaration': {
          'id': '${info.supportedAbis}',
          'model': '${info.model}',
          'proccesor': '${info.manufacturer}',
          'version': Platform.operatingSystemVersion
        }
      };
    } catch (e) {
      return {};
    }
  }
}
