
import 'package:hyper_pay/hyper_pay_native/controller/channel/hyperpay_channel_stream_controller.dart';
export 'package:hyper_pay/hyper_pay_native/controller/channel/hyperpay_channel_stream_controller.dart';
import 'package:hyper_pay/hyper_pay_native/model/request/hyperpay_channel_request.dart';
export 'package:hyper_pay/hyper_pay_native/model/request/hyperpay_channel_request.dart';



import 'hyper_pay_platform_interface.dart';


class HyperPay {

  late HyperpayChannelStreamController cont;
  late HyperpayChannelRequest req ;

  /// test method
  Future<String?> getPlatformVersion() {
    return HyperPayPlatform.instance.getPlatformVersion();
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
