import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hyper_pay_payment/helper/log/hyperpay_log.dart';

import 'hyper_pay_payment_platform_interface.dart';


/// An implementation of [HyperPayPlatform] that uses method channels.
class MethodChannelHyperPay extends HyperPayPaymentPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('hyper_pay');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    HyperPayLog.i("abdo - MethodChannelHyperPay - getPlatformVersion()");
    return version;
  }

  @override
  Future fromFlutter() async {
    HyperPayLog.i("abdo - MethodChannelHyperPay - fromFlutter()");
    await methodChannel.invokeMethod('fromFlutter');
  }

  static MethodChannel getMethodChannel( String name) => MethodChannel(name);
  static EventChannel getEventChannel( String name) => EventChannel(name);

}
