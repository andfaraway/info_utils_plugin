import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'info_utils_plugin_method_channel.dart';

abstract class InfoUtilsPluginPlatform extends PlatformInterface {
  /// Constructs a InfoUtilsPluginPlatform.
  InfoUtilsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static InfoUtilsPluginPlatform _instance = MethodChannelInfoUtilsPlugin();

  /// The default instance of [InfoUtilsPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelInfoUtilsPlugin].
  static InfoUtilsPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InfoUtilsPluginPlatform] when
  /// they register themselves.
  static set instance(InfoUtilsPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  Future<String> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }

}
