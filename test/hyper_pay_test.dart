import 'package:flutter_test/flutter_test.dart';
import 'package:hyper_pay/hyper_pay.dart';
import 'package:hyper_pay/hyper_pay_platform_interface.dart';
import 'package:hyper_pay/hyper_pay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHyperPayPlatform
    with MockPlatformInterfaceMixin
    implements HyperPayPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HyperPayPlatform initialPlatform = HyperPayPlatform.instance;

  test('$MethodChannelHyperPay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHyperPay>());
  });

  test('getPlatformVersion', () async {
    HyperPay hyperPayPlugin = HyperPay();
    MockHyperPayPlatform fakePlatform = MockHyperPayPlatform();
    HyperPayPlatform.instance = fakePlatform;

    expect(await hyperPayPlugin.getPlatformVersion(), '42');
  });
}
