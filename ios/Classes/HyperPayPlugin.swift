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
  print("abdo - HyperPayPlugin - handle() - call.method \( call.method )");

    switch call.method {

        case "getPlatformVersion":
            print("abdo - HyperPayPlugin - method - getPlatformVersion -");
           result("iOS getPlatformVersion from swift native to flutter" )


        default:
            result( "no implementation found")
        }
  }
}