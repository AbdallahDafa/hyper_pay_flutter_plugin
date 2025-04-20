package com.dafa.hyperpay.hyper_pay

import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** HyperPayPlugin */
class HyperPayPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "hyper_pay")
    Log.i("abdo", "HyperPayPlugin - channel: $channel")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    Log.i("abdo", "HyperPayPlugin - onMethodCall() - result: $result")

    if (call.method == "getPlatformVersion") {
      Log.i("abdo", "HyperPayPlugin - onMethodCall() - getPlatformVersion - success")
      result.success("Test Android ${android.os.Build.VERSION.RELEASE}")

    }  else if ( call.method == "fromFlutter") {
      Log.i("abdo", "HyperPayPlugin - onMethodCall() - method: fromFlutter - result: $result")

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
