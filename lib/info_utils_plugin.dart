import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:info_utils_plugin/src/device_info_model.dart';
import 'package:info_utils_plugin/src/location_manager.dart';
import 'package:info_utils_plugin/src/location_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'info_utils_plugin_platform_interface.dart';

export 'package:info_utils_plugin/src/device_info_model.dart';

class InfoUtilsPlugin {
  Future<DeviceInfoModel> getDeviceInfo() async {
    DeviceInfoModel model = DeviceInfoModel();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    model.appName = packageInfo.appName;
    model.packageName = packageInfo.packageName;
    model.version = packageInfo.version;
    model.buildNumber = packageInfo.buildNumber;
    model.phoneName = await getPhoneName();
    model.systemVersion = await getSystemVersion();
    model.hardwareType = await getHardwareType();
    model.uuid = await getDeviceId();
    model.network = await getNetwork();
    model.battery = await getBatteryLevel();
    model.isPhysical = await isPhysicalDevice();
    model.date = DateTime.now().toString();
    model.locationModel = await getLocation();

    return model;
  }

  static Future<bool> isPhysicalDevice() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isIOS) {
      return (await deviceInfoPlugin.iosInfo).isPhysicalDevice;
    } else if (Platform.isAndroid) {
      return (await deviceInfoPlugin.androidInfo).isPhysicalDevice;
    } else {
      return false;
    }
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

  /// get Network
  static Future<String> getNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return 'mobile';
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return 'wifi';
    }
    return connectivityResult.join(',').replaceAll('ConnectivityResult.', '');
  }

  /// get BatteryLevel
  static Future<String> getBatteryLevel() async {
    return InfoUtilsPluginPlatform.instance.getBatteryLevel();
  }

  /// get Location
  Future<LocationModel?> getLocation() async {
    LocationModel? locationModel = await LocationManager.instance.getLocation();

    locationModel ??= await LocationManager.instance.getLastKnowPosition();

    return locationModel;
  }
}
