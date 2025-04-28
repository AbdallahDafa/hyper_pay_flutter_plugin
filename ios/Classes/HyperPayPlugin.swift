import Flutter
import UIKit

public class HyperPayPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "hyper_pay", binaryMessenger: registrar.messenger())
    let instance = HyperPayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

          //:::::::::::::::::::::::::::::::::::::::::::::::::::::: hyperpay

          //setupHyperPay();

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
