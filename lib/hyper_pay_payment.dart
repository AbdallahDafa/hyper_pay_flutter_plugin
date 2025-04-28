
import 'package:hyper_pay_payment/helper/log/hyperpay_log.dart';
import 'package:hyper_pay_payment/hyper_pay_native/controller/channel/hyperpay_channel_stream_controller.dart';
export 'package:hyper_pay_payment/hyper_pay_native/controller/channel/hyperpay_channel_stream_controller.dart';
import 'package:hyper_pay_payment/hyper_pay_native/model/request/hyperpay_channel_request.dart';
import 'package:hyper_pay_payment/hyper_pay_payment_method_channel.dart';
import 'package:hyper_pay_payment/hyper_pay_payment_platform_interface.dart';
export 'package:hyper_pay_payment/hyper_pay_native/model/request/hyperpay_channel_request.dart';




class HyperPayPayment {

  late HyperpayChannelStreamController cont;
  late HyperpayChannelRequest req ;


  /// test method
  static Future<String > getPlatformVersion() async {
    // var result =  await HyperPayPaymentPlatform.instance.getPlatformVersion();
    var methodChannel = MethodChannelHyperPay.getMethodChannel( "hyper_pay");
    final result = await methodChannel.invokeMethod<String>('getPlatformVersion');
    // var result =    await methodChannel.getPlatformVersion();
    HyperPayLog.i("getPlatformVersion() -methodChannel - result: $result");
    return result??"not  fond" ;
  }


  /// open  ui checkout of any type  ( VISA/MASTER/MADA/ APPLEPAY )
  static Future newPayment( { required HyperpayChannelRequest channelRequest ,
    required HyperPayOnCompleteListener onComplete} ) async {
    /// listener to result
    await HyperpayChannelStreamController.setupListenerFromNative(
        callback: ( result ) {
          bool isSuccess = result.toString() == "success";
          onComplete( isSuccess );
        }
    );

    /// open ui
    await HyperpayChannelStreamController.sendDataToNative(channelRequest);
  }



}
