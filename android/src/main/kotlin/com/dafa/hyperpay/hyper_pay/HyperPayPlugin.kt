package com.dafa.hyperpay.hyper_pay

//import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import android.Manifest
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel

///---------------------------------- hyperpay import files
import com.dafa.hyperpay.hyper_pay.core.flutter.HyperpayFlutterChannelController
import com.dafa.hyperpay.hyper_pay.core.flutter.HyperpayFlutterRequest
import android.util.Log
import com.dafa.hyperpay.hyper_pay.core.router.HyperPayRouter

/** HyperPayPlugin */
class HyperPayPlugin: FlutterPlugin {

  companion object   {
    var eventSink: EventChannel.EventSink? = null
  }

  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "hyper_pay")
    Log.i("abdo", "HyperPayPlugin - channel: $channel")
//    channel.setMethodCallHandler(this)
  }


  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
