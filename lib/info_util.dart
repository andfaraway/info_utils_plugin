import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 获取应用版本信息
class InfoUtil {
  static String appName = '';
  static String packageName = '';
  static String version = '';
  static String buildNumber = '';
  static String phoneName = '';
  static String systemVersion = '';
  static String hardwareType = '';
  static String uuid = '';
  static String network = '';

  static bool hasInit = false;

  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    phoneName = await getPhoneName();
    systemVersion = await getSystemVersion();
    hardwareType = await getHardwareType();
    uuid = await getDeviceId();
    network = await getNetwork();

    hasInit = true;
  }

  static Future<Map<String, dynamic>> toJson() async {
    if (!hasInit) {
      await init();
    }
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
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson);
  }

  /// 获取应用名称
  static Future<String> getAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }

  /// 获取应用包名
  static Future<String> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  /// 获取应用版本信息
  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// 获取应用构建版本号
  static Future<String> getBuildNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  /// 手机名称
  static Future<String> getPhoneName() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfoPlugin.iosInfo;
      return info.name;
    } else {
      AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      return info.model;
    }
  }

  /// eg. android 11
  static Future<String> getSystemVersion() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      return '${iosDeviceInfo.systemName}${iosDeviceInfo.systemVersion}';
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      String sdkName = androidDeviceInfo.version.release.toString();
      return 'android $sdkName';
    }
    return '';
  }

  /// Hardware type (e.g. 'iPhone7,1' for iPhone 6 Plus).
  static Future<String> getHardwareType() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      return '${androidDeviceInfo.brand} ${androidDeviceInfo.model}';
    }

    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      final type = iosDeviceInfo.utsname.machine;
      return type;
    }

    return '';
  }

  /// device uuid
  static Future<String> getDeviceId() async {
    return await FlutterUdid.udid;
  }

  static Future<String> getNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return 'mobile';
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return 'wifi';
    }
    return connectivityResult.join(',').replaceAll('ConnectivityResult.', '');
  }
}
