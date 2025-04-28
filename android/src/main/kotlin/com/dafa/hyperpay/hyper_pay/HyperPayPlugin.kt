package com.dafa.hyperpay.hyper_pay

//import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import android.content.Context
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

  private lateinit var context: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
   context = flutterPluginBinding.applicationContext
//    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "hyper_pay")
    Log.i("abdo", "HyperPayPlugin - onAttachedToEngine - context: $context")
    setUpChannelHyperPayRecieverFromFlutter(flutterPluginBinding.binaryMessenger)
    setupChannelHyperPaySendToFlutter(flutterPluginBinding.binaryMessenger);
  }


  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    Log.i("abdo", "HyperPayPlugin - onDetachedFromEngine")
//    channel.setMethodCallHandler(null)
  }

  //------------------------------------------------------------- channel hyperpay

  private fun setUpChannelHyperPayRecieverFromFlutter(messenger: BinaryMessenger){
    val METHOD_CHANNEL_NAME = "com.hyperpay/sendToNative"
    var methodChannel = MethodChannel(messenger,METHOD_CHANNEL_NAME)
    Log.i("abdo", "HyperPayPlugin - setUpChannelHyperPayRecieverFromFlutter() -  methodChannel: $methodChannel")
    methodChannel.setMethodCallHandler {
        call, result ->

      Log.i("abdo", "HyperPayPlugin - setUpChannelHyperPayRecieverFromFlutter() - result: $result")

      if (call.method.equals("fromFlutter")){
        Log.i("abdo", "HyperPayPlugin - setUpChannelHyperPayRecieverFromFlutter() - result: $result");
        Log.i("abdo", "HyperPayPlugin - setUpChannelHyperPayRecieverFromFlutter() - call.arguments: ${call.arguments}");

        /// parse
        val arguments = call.arguments as? Map<*, *>
        if (arguments != null) {
          val data = arguments.mapKeys { it.key.toString() } // now it's Map<String, Any?>
          val checkoutId = data["checkoutId"] as  String
          val brandName = data["brandName"] as  String
          val amount = data["amount"] as   Double
          val isTest = data["isTest"] as  Boolean
          Log.i("abdo", "HyperPayPlugin - setUpChannelHyperPayRecieverFromFlutter() - parse checkoutId: $checkoutId")
          Log.i("abdo", "HyperPayPlugin - setUpChannelHyperPayRecieverFromFlutter() - parse amount: $amount")
          Log.i("abdo", "HyperPayPlugin - setUpChannelHyperPayRecieverFromFlutter() - parse isTest: $isTest")
          Log.i("abdo", "HyperPayPlugin - setUpChannelHyperPayRecieverFromFlutter() - parse brandName: $brandName")

          // open ui with request
          val request = HyperpayFlutterRequest(
            checkoutId = checkoutId,
            amount = amount,
            brandName = brandName,
            isLive = isTest == false
          )
          Log.i("abdo", "HyperPayPlugin - setUpChannelHyperPayFromFlutter() - request: $request")
         HyperPayRouter.openHyperPayDialog( context,  request)
        }
      } else{
        result.notImplemented()
      }

    }
  }

  private fun setupChannelHyperPaySendToFlutter(messenger: BinaryMessenger){
    EventChannel(messenger, "com.hyperpay/listenFromNative").setStreamHandler(
      object : EventChannel.StreamHandler {
        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
          HyperPayPlugin.eventSink = events
          Log.i("abdo", "HyperPayPlugin - setupChannelHyperPaySendToFlutter() - onListen - arguments: $arguments");

        }

        override fun onCancel(arguments: Any?) {
          HyperPayPlugin.eventSink = null
          Log.i("abdo", "HyperPayPlugin - setupChannelHyperPaySendToFlutter() - onCancel - arguments: $arguments");
        }
      }
    )
  }


}
