import Flutter
import UIKit
import OPPWAMobile
 

public class HyperPayPlugin: NSObject, FlutterPlugin {

    nonisolated(unsafe) public static var binaryMessenger : FlutterBinaryMessenger?;
    
    nonisolated(unsafe) public static var myViewController : UIViewController?;
    

  public static func register(with registrar: FlutterPluginRegistrar) {
      print("abdo - HyperPayPlugin - register() swift code ");
      let instance = HyperPayPlugin()
      
      // set controller
      HyperPayPlugin.binaryMessenger = registrar.messenger();
      HyperPayPlugin.myViewController = instance.getTopViewController();
      
      print("abdo - HyperPayPlugin - register() binaryMessenger: \( binaryMessenger ) ");
      
      // channel test version
      let channelGetVersion = FlutterMethodChannel(name: "hyper_pay", binaryMessenger: registrar.messenger())
      registrar.addMethodCallDelegate(instance, channel: channelGetVersion)
        
//      
//      // channel from native
//      let channelFromNative = FlutterMethodChannel(name: "com.hyperpay/sendToNative", binaryMessenger: registrar.messenger())
//      registrar.addMethodCallDelegate(instance, channel: channelFromNative)
 
      // register
      instance.setupHyperPay();
      
  }
     

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  print("abdo - HyperPayPlugin - handle() - call.method \( call.method )");

    switch call.method {

        case "getPlatformVersion":
            print("abdo - HyperPayPlugin - method - getPlatformVersion -");
           result("iOS getPlatformVersion from swift native to flutter" )

//    case "fromFlutter" :
//        print("abdo - HyperPayPlugin - method - fromFlutter -");
//       setupHyperPay();
//        result("iOS fromFlutter" )
        
        default:
            result( "no implementation found")
        }
  }
    
    
    //---------------------------------------- helper code
    
    nonisolated(unsafe) public func getTopViewController(  ) -> UIViewController?  {
        
        let base: UIViewController? = MainActor.assumeIsolated {
                UIApplication.shared
                    .connectedScenes
                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                    .first?.rootViewController
            }
//        
//        var base = UIApplication.shared
//            .connectedScenes
//            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
//            .first?.rootViewController;
//        if let nav = base as? UINavigationController {
//            return getTopViewController(base: nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            return getTopViewController(base: tab.selectedViewController)
//        }
//        if let presented = base?.presentedViewController {
//            return getTopViewController(base: presented)
//        }
        return base
    }
    
}
