import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hyper_pay_method_channel.dart';

abstract class HyperPayPlatform extends PlatformInterface {
  /// Constructs a HyperPayPlatform.
  HyperPayPlatform() : super(token: _token);

  static final Object _token = Object();

  static HyperPayPlatform _instance = MethodChannelHyperPay();

  /// The default instance of [HyperPayPlatform] to use.
  ///
  /// Defaults to [MethodChannelHyperPay].
  static HyperPayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HyperPayPlatform] when
  /// they register themselves.
  static set instance(HyperPayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
