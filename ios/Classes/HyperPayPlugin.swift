import Flutter
import UIKit

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
//       result(FlutterMethodNotImplemented)
        result( "no implementation found")
    }
  }
}

//
// public class HyperPayPlugin: NSObject, FlutterPlugin {
//
//
//
//   public static func register(with registrar: FlutterPluginRegistrar)    {
//
//
//     print("abdo - HyperPayPlugin - register() swift code ");
//   }
//
//
// public func handlerWithMainActorThread(_ registrar: FlutterPluginRegistrar) async {
// //    await MainActor.run {
//             let channel = FlutterMethodChannel(name: "hyper_pay", binaryMessenger: registrar.messenger())
//             let instance = HyperPayPlugin()
// //             registrar.addMethodCallDelegate(instance, channel: channel)
//             register.addMethodCallDelegate (_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//
//
//             }
// //           }
// }
//
//
//  @MainActor
//   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult)   {
//     if call.method == "getPlatformVersion" {
//
// //             DispatchQueue.main.async {
// //
// //             }
//         result(UIDevice.current.name)
//
//     } else {
//    //   result(FlutterMethodNotImplemented)
//     }
//   }
// }
