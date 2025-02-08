import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'location_model.dart';

class DeviceInfoModel {
  DeviceInfoModel();

  static bool get isWeb => kIsWeb;

  static bool get isIOS => isWeb ? false : Platform.isIOS;

  static bool get isAndroid => isWeb ? false : Platform.isAndroid;

  static String get platform => isIOS
      ? 'ios'
      : isAndroid
      ? 'android'
      : 'web';

  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';
  String phoneName = '';
  String systemVersion = '';
  String hardwareType = '';
  String uuid = '';
  String network = '';
  String battery = '';
  bool isPhysical= true;
  LocationModel? locationModel;
  String? date;

  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'packageName': packageName,
      'version': version,
      'buildNumber': buildNumber,
      'phoneName': phoneName,
      'systemVersion': systemVersion,
      'hardwareType': hardwareType,
      'uuid': uuid,
      'network': network,
      'battery': battery,
      'isPhysical': isPhysical,
      'locationModel': locationModel?.toJson(),
      'date': date,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson);
  }
}
