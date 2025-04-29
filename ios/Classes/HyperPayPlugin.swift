import Flutter
import UIKit
import OPPWAMobile

public class HyperPayPlugin: NSObject, FlutterPlugin {


  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "hyper_pay", binaryMessenger: registrar.messenger())
    let instance = HyperPayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      print("abdo - HyperPayPlugin - register() swift code ");
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":

        result("iOS getPlatformVersion from swift native to flutter" ) //+ UIDevice.current.systemVersion

    default:
        result( "no implementation found")
    }
  }
}