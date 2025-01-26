package com.example.info_utils_plugin

import android.content.Context
import android.os.BatteryManager
import android.os.Build

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** InfoUtilsPlugin */
class InfoUtilsPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin wi th the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "info_utils_plugin")
        context = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android " + Build.VERSION.RELEASE)
            "getBatteryLevel" -> {
                val manager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                val battery = manager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                result.success(battery)
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
