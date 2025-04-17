import 'package:flutter/services.dart';
import 'package:tuxedo/core/hyper_pay_native/model/request/hyperpay_channel_request.dart';
import 'package:tuxedo/core/log/Log.dart';

typedef HyperPayChannelListenerResult = Function( dynamic result );

class HyperpayChannelStreamController {

  static const MethodChannel _methodChannelSender = MethodChannel('com.hyperpay/sendToNative');
  static EventChannel _eventChannelListener = EventChannel('com.hyperpay/listenFromNative');
  static Stream<dynamic> _getDataStream() => _eventChannelListener.receiveBroadcastStream();

  static Future setupListenerFromNative( {required HyperPayChannelListenerResult callback}) async {
    _getDataStream().listen((event) {
      Log.i("setupListenerFromNative()  from native: $event");
      callback(event );

    });
  }


  static Future sendDataToNative( HyperpayChannelRequest request ) async {
    Log.i("sendDataToNative()  request: ${request.toJson()}");
    //jsonEncode(json)
    await _methodChannelSender.invokeMethod('fromFlutter', request.toJson()  );
  }



}