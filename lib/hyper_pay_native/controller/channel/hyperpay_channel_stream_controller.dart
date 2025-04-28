// import 'dart:js_interop';

import 'package:flutter/services.dart';
import 'package:hyper_pay_payment/helper/log/hyperpay_log.dart';

import 'package:hyper_pay_payment/hyper_pay_native/model/request/hyperpay_channel_request.dart';
import 'package:hyper_pay_payment/hyper_pay_payment_method_channel.dart';



typedef HyperPayChannelListenerResult = Function( dynamic result );
typedef HyperPayOnCompleteListener = Function( bool paymentSuccess );

class HyperpayChannelStreamController {



  static Future setupListenerFromNative( {required HyperPayChannelListenerResult callback}) async {
    // EventChannel _eventChannelListener = EventChannel('com.hyperpay/listenFromNative');
    var _eventChannelListener = MethodChannelHyperPay.getEventChannel( 'com.hyperpay/listenFromNative' );
    Stream<dynamic> _getDataStream() => _eventChannelListener.receiveBroadcastStream();
    _getDataStream().listen((event) {
      HyperPayLog.i("abdo hyperpay - setupListenerFromNative()  from native: $event");
      callback(event );

    });
  }


  static Future sendDataToNative( HyperpayChannelRequest request ) async {
    HyperPayLog.i("abdo hyperpay - sendDataToNative()  request: ${request.toJson()}");
    // MethodChannel _methodChannelSender =  MethodChannel('com.hyperpay/sendToNative');
    var _methodChannelSender = MethodChannelHyperPay.getMethodChannel( 'com.hyperpay/sendToNative' );
    await _methodChannelSender.invokeMethod('fromFlutter', request.toJson()  );
  }



}