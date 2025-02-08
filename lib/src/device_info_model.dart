import 'dart:convert';
import 'location_model.dart';

class DeviceInfoModel {
  DeviceInfoModel();

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
      'locationModel': locationModel?.toJson(),
      'date': date,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson);
  }
}
