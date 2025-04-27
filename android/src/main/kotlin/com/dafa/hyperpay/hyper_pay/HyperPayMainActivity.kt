package com.dafa.hyperpay.hyper_pay


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

class HyperPayMainActivity: FlutterActivity(){
    companion object   {
        var eventSink: EventChannel.EventSink? = null
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        ///---------------------------------- hyperpay

        setUpChannelHyperPayFromFlutter(flutterEngine.dartExecutor.binaryMessenger)
        setupChannelHyperPaySendToFlutter(flutterEngine.dartExecutor.binaryMessenger);
    }


    //------------------------------------------------------------- channel hyperpay

    private fun setUpChannelHyperPayFromFlutter(messenger: BinaryMessenger){
        val METHOD_CHANNEL_NAME = "com.hyperpay/sendToNative"
        var methodChannel = MethodChannel(messenger,METHOD_CHANNEL_NAME)
        methodChannel.setMethodCallHandler {
                call, result ->

            Log.i("abdo", "HyperPayMainActivity - setUpChannelHyperPayFromFlutter() - result: $result")

            if (call.method.equals("fromFlutter")){
                Log.i("abdo", "HyperPayMainActivity - setUpChannelHyperPayFromFlutter() - result: $result");
                Log.i("abdo", "HyperPayMainActivity - setUpChannelHyperPayFromFlutter() - call.arguments: ${call.arguments}");

                /// parse
                val arguments = call.arguments as? Map<*, *>
                if (arguments != null) {
                    val data = arguments.mapKeys { it.key.toString() } // now it's Map<String, Any?>
                    val checkoutId = data["checkoutId"] as  String
                    val brandName = data["brandName"] as  String
                    val amount = data["amount"] as   Double
                    val isTest = data["isTest"] as  Boolean
                    Log.i("abdo", "HyperPayMainActivity - setUpChannelHyperPayFromFlutter() - parse checkoutId: $checkoutId")
                    Log.i("abdo", "HyperPayMainActivity - setUpChannelHyperPayFromFlutter() - parse amount: $amount")
                    Log.i("abdo", "HyperPayMainActivity - setUpChannelHyperPayFromFlutter() - parse isTest: $isTest")
                    Log.i("abdo", "HyperPayMainActivity - setUpChannelHyperPayFromFlutter() - parse brandName: $brandName")

                    // open ui with request
                    val request = HyperpayFlutterRequest(
                        checkoutId = checkoutId,
                        amount = amount,
                        brandName = brandName,
                        isLive = isTest == false
                    )
                    Log.i("abdo", "HyperPayMainActivity - setUpChannelHyperPayFromFlutter() - request: $request")
                    HyperPayRouter.openHyperPayDialog( this,  request)
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
                    HyperPayMainActivity.eventSink = events
                    Log.i("abdo", "HyperPayMainActivity - setupChannelHyperPaySendToFlutter() - onListen - arguments: $arguments");

                }

                override fun onCancel(arguments: Any?) {
                    HyperPayMainActivity.eventSink = null
                    Log.i("abdo", "HyperPayMainActivity - setupChannelHyperPaySendToFlutter() - onCancel - arguments: $arguments");
                }
            }
        )
    }




}
