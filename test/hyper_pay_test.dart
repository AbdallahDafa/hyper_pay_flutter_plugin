import 'package:flutter_test/flutter_test.dart';
import 'package:hyper_pay_payment/hyper_pay_payment.dart';
import 'package:hyper_pay_payment/hyper_pay_payment_method_channel.dart';
import 'package:hyper_pay_payment/hyper_pay_payment_platform_interface.dart';
// import 'package:hyper_pay_payment/hyper_pay.dart';
// import 'package:hyper_pay_payment/hyper_pay_platform_interface.dart';
// import 'package:hyper_pay_payment/hyper_pay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHyperPayPlatform
    with MockPlatformInterfaceMixin
    implements HyperPayPaymentPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future fromFlutter() {
    // TODO: implement fromFlutter
    throw UnimplementedError();
  }
}

void main() {
  final HyperPayPaymentPlatform initialPlatform = HyperPayPaymentPlatform.instance;

  test('$MethodChannelHyperPay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHyperPay>());
  });

  test('getPlatformVersion', () async {
    HyperPayPayment hyperPayPlugin = HyperPayPayment();
    MockHyperPayPlatform fakePlatform = MockHyperPayPlatform();
    HyperPayPaymentPlatform.instance = fakePlatform;

    // expect(await hyperPayPlugin.getPlatformVersion()??"", '42');
  });
}
