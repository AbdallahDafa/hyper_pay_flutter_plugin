import Flutter
import UIKit
import OPPWAMobile
 

public class HyperPayPlugin: NSObject, FlutterPlugin {

    nonisolated(unsafe) public static var binaryMessenger : FlutterBinaryMessenger?;
    
//    nonisolated(unsafe) public static var myViewController : UIViewController?;
    

  public static func register(with registrar: FlutterPluginRegistrar) {
      print("abdo - HyperPayPlugin - register() swift code ");
      let instance = HyperPayPlugin()
      
      // set controller
      HyperPayPlugin.binaryMessenger = registrar.messenger();
//      HyperPayPlugin.myViewController = instance.getTopViewController();
      
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
        
        var base : UIViewController? = nil;
        
        MainActor.assumeIsolated {
            base = UIApplication.shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }?.rootViewController
        }
        print("abdo - HyperPayPlugin - getTopViewController() - base: \(base) ");
        
 
        if let nav = base as? UINavigationController {
            print("abdo - HyperPayPlugin - getTopViewController() - as UINavigationController ");
//            return getTopViewController(base: nav.visibleViewController)
            var baseCast : UIViewController? = MainActor.assumeIsolated {
                nav.visibleViewController
            }
            return baseCast;
            
        }
        if let tab = base as? UITabBarController {
            print("abdo - HyperPayPlugin - getTopViewController() - as UITabBarController ");
//            return getTopViewController(base: tab.selectedViewController)
        }
        
        var present =  MainActor.assumeIsolated {
            base?.presentedViewController
        }
        print("abdo - HyperPayPlugin - getTopViewController() - present: \(present)");
        
        if( base != nil ) { return base;}
        if( present != nil ) { return present; }
        return base
    }
    
}
