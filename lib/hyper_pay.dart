
import 'hyper_pay_platform_interface.dart';

class HyperPay {
  Future<String?> getPlatformVersion() {
    return HyperPayPlatform.instance.getPlatformVersion();
  }
}
