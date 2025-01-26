import Flutter
import UIKit

public class InfoUtilsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "info_utils_plugin", binaryMessenger: registrar.messenger())
        let instance = InfoUtilsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result(UIDevice.current.systemVersion)
        case "getBatteryLevel":
            result(getBatteryLevel())
        default:
            result(FlutterMethodNotImplemented)
        }
    }
   
    func getBatteryLevel() -> Int? {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if let batteryLevel = Optional(device.batteryLevel) {
            return Int(batteryLevel * 100)
        }
        return nil
    }
}
