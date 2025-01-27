import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'info_utils_plugin_platform_interface.dart';

/// An implementation of [InfoUtilsPluginPlatform] that uses method channels.
class MethodChannelInfoUtilsPlugin extends InfoUtilsPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('info_utils_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String> getBatteryLevel() async {
    final version = await methodChannel.invokeMethod<int>('getBatteryLevel');
    return '$version%';
  }
}
