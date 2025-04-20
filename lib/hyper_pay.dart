
import 'package:hyper_pay/helper/dialog/hyperpay_message_dialog.dart';
export 'package:hyper_pay/helper/dialog/hyperpay_message_dialog.dart';

import 'package:hyper_pay/hyper_pay_native/controller/channel/hyperpay_channel_stream_controller.dart';
export 'package:hyper_pay/hyper_pay_native/controller/channel/hyperpay_channel_stream_controller.dart';
import 'package:hyper_pay/hyper_pay_native/model/request/hyperpay_channel_request.dart';
export 'package:hyper_pay/hyper_pay_native/model/request/hyperpay_channel_request.dart';



import 'hyper_pay_platform_interface.dart';


class HyperPay {

  late HyperpayChannelStreamController cont;
  late HyperpayChannelRequest req ;

  late HyperPayMessageDialog dialog;

  Future<String?> getPlatformVersion() {
    return HyperPayPlatform.instance.getPlatformVersion();
  }


}
