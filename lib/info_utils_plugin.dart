import 'package:info_utils_plugin/src/info_util.dart';
import 'package:info_utils_plugin/src/location_manager.dart';
import 'package:info_utils_plugin/src/location_model.dart';
import 'info_utils_plugin_platform_interface.dart';

class InfoUtilsPlugin {
  Future<Map<String, dynamic>> getDeviceInfo() async {
    Map<String, dynamic> data = await InfoUtil.toJson();
    data.addAll({'battery': await getBatteryLevel()});
    return data;
  }

  Future<Map<String, dynamic>> getLocation() async {
    LocationModel? locationModel = await LocationManager.instance.getLocation();

    locationModel ??= await LocationManager.instance.getLastKnowPosition();

    return locationModel?.toJson() ?? {};
  }

  Future<String?> getBatteryLevel() async {
    return InfoUtilsPluginPlatform.instance.getBatteryLevel();
  }
}
