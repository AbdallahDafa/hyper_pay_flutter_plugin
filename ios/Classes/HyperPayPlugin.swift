import Flutter
import UIKit
import OPPWAMobile
 

public class HyperPayPlugin: NSObject, FlutterPlugin {

    nonisolated(unsafe) public static var binaryMessenger : FlutterBinaryMessenger?;

  public static func register(with registrar: FlutterPluginRegistrar) {
      print("abdo - HyperPayPlugin - register() swift code ");
      let instance = HyperPayPlugin()
      
      // set controller
      HyperPayPlugin.binaryMessenger = registrar.messenger();
      
      print("abdo - HyperPayPlugin - register() binaryMessenger: \( binaryMessenger ) ");
      
      // channel test version
      let channelGetVersion = FlutterMethodChannel(name: "hyper_pay", binaryMessenger: registrar.messenger())
      registrar.addMethodCallDelegate(instance, channel: channelGetVersion)
        
      
      // channel from native
      let channelFromNative = FlutterMethodChannel(name: "com.hyperpay/sendToNative", binaryMessenger: registrar.messenger())
      registrar.addMethodCallDelegate(instance, channel: channelFromNative)

  
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  print("abdo - HyperPayPlugin - handle() - call.method \( call.method )");

    switch call.method {

        case "getPlatformVersion":
            print("abdo - HyperPayPlugin - method - getPlatformVersion -");
           result("iOS getPlatformVersion from swift native to flutter" )

    case "fromFlutter" :
        print("abdo - HyperPayPlugin - method - fromFlutter -");
       setupHyperPay();
        result("iOS fromFlutter" )
        default:
            result( "no implementation found")
        }
  }
}
