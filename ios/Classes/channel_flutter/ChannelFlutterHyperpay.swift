//
//  ChannelFlutterHyperpay.swift
//  Runner
//
//  Created by Abdallah Android on 13/04/2025.
//

import UIKit
import Flutter
import Foundation
import OPPWAMobile
 

//------------------------------------------------------------   data

class HyperPayResultData  {
    
    nonisolated(unsafe) static var eventSink: FlutterEventSink?
    nonisolated(unsafe) static var data : [String: Any]  = [ : ];
    
    nonisolated(unsafe) static var request : HyperPayChannelRequest = HyperPayChannelRequest();
}
 

struct HyperPayChannelRequest: Codable {
    
    var shopperResultUrl: String = "";
    var merchantId: String = "";
    var checkoutId: String = "";
    var isTest: Bool = true;
    var amount: Double = 1;
    var brandName: String = "";
    var isMada: Bool = false;

    // Computed property or logic if needed
    func isMadaValue() -> Bool {
        return isMada // or some internal logic
    }

    // Convert to dictionary (similar to toJson in Dart)
    func toDictionary() -> [String: Any] {
        return [
            "shopperResultUrl": shopperResultUrl,
            "merchantId": merchantId,
            "checkoutId": checkoutId,
            "isTest": isTest,
            "amount": amount,
            "brandName": brandName,
            "isMada": isMadaValue()
        ]
    }
}


//------------------------------------------------------------ setup

extension HyperPayPlugin {

     public func setupHyperPay(){
        print("abdo - HyperPay - setupHyperPay() - start");
        _setupSendDataFromSwiftToFlutter();
        _setupRecieveDataFromFlutter();
    }

    
      func _setupSendDataFromSwiftToFlutter( ){
        let eventChannel = FlutterEventChannel(name: "com.hyperpay/listenFromNative",
                                               binaryMessenger: HyperPayPlugin.binaryMessenger!
        )
         eventChannel.setStreamHandler(self)
        print("abdo - HyperPay - _setupSendDataFromSwiftToFlutter() - setup stream");
    }


     func _setupRecieveDataFromFlutter(){
 
        let channel = FlutterMethodChannel(name: "com.hyperpay/sendToNative",
                                           binaryMessenger:   HyperPayPlugin.binaryMessenger! )
        print("abdo - hyperpay - _setupRecieveDataFromFlutter()- setup")
        channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "fromFlutter" {
                if let args = call.arguments as? [String: Any] {
                    print("abdo - hyperpay - _setupRecieveDataFromFlutter()- Received from Flutter - args: \(args)")
                    self.parseDataReceivedFromFlutter(args);
                    self.openUIPaymentByChooseBrandType();
                    // Handle it
                    result("OK")
                } else {
                    result(FlutterError(code: "BAD_ARGS", message: "Missing data", details: nil))
                }
            } else {
                result( "not implemented")
            }
        }
    }


}


//------------------------------------------------------------ send from swift to native

extension HyperPayPlugin : FlutterStreamHandler {
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        HyperPayResultData.eventSink = events

//          // Example: send data every 2 seconds
//          Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
//              let data: [String: Any] = ["message": "Hello from Swift", "time": "\(Date())"]
//              HyperPayResultData.data = data;
//              
//              self.fireResultToFlutter();
//              
//          }
          return nil
      }

      public func onCancel(withArguments arguments: Any?) -> FlutterError? {
          HyperPayResultData.eventSink = nil
          return nil
      }
    
    
    func fireResultToFlutterSuccess(){
        print("abdo - HyperPay - fireResultToFlutterSuccess() - send data");
        if( HyperPayResultData.eventSink == nil ) { return;}
        HyperPayResultData.eventSink!( "success")
        
    }
    
    func fireResultToFlutterFailed(){
        print("abdo - HyperPay - fireResultToFlutterFailed() - send data");
        if( HyperPayResultData.eventSink == nil ) { return;}
        HyperPayResultData.eventSink!( "failed")
    }
    
}

//--------------------------------------------------- from flutter reciever

extension HyperPayPlugin {
    
    func parseDataReceivedFromFlutter( _ jsonData : [String: Any]){
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
            let decodeRequest = try JSONDecoder().decode(HyperPayChannelRequest.self, from: data)
            HyperPayResultData.request =  decodeRequest;
            print("abdo - hyperpay - parseDataReceivedFromFlutter() - toDictionary:", decodeRequest.toDictionary())
//            print("hyperpay - parseDataReceivedFromFlutter() -Is Mada:", response.isMada)
            
        } catch {
            print("abdo - hyperpay - parseDataReceivedFromFlutter() - Failed to decode JSON:", error)
        }
    }
    
}

//----------------------------------------------------------- open payment

extension HyperPayPlugin {
    
    func openUIPaymentByChooseBrandType(){
        
        // validate
        if( HyperPayResultData.request == nil ) {
            fireResultToFlutterFailed();
            return ;
        }
 
        // setter conifg
        _setterConfigHyperPay();
        
        // validate issue in parse
        if( HyperPayResultData.request.checkoutId ==   "" ) {
            fireResultToFlutterFailed();
            return ;
        }
        
  
        openWithListener();
                
    }
    
    
    func _setterConfigHyperPay() {
        print("abdo - hyperpay - _setterConfigHyperPay() - request before: \( HyperPayResultData.request.toDictionary() )");
        Config.amount = HyperPayResultData.request.amount ;
        Config.merchantId = HyperPayResultData.request.merchantId;
        Config.urlScheme = HyperPayResultData.request.shopperResultUrl;
        Config.paymentButtonBrand = HyperPayResultData.request.brandName;
        Config.checkoutID =  HyperPayResultData.request.checkoutId;
       // Config.checkoutID = "C85BC2FD70C8E77AEB97D7DD1F3401CF.uat01-vm-tx02";  static test
        
        if( HyperPayResultData.request.isTest   ){
            Config.oPPProviderMode = OPPProviderMode.test;
        } else {
            Config.oPPProviderMode = OPPProviderMode.live;
        }
        print("abdo - hyperpay - _setterConfigHyperPay() - Config.oPPProviderMode: \(Config.oPPProviderMode.rawValue)");
        print("abdo - hyperpay - _setterConfigHyperPay() - Config.merchantId: \(Config.merchantId)");
        print("abdo - hyperpay - _setterConfigHyperPay() - Config.checkoutID: \(Config.checkoutID)");
        print("abdo - hyperpay - _setterConfigHyperPay() - Config.amount: \(Config.amount)");
        print("abdo - hyperpay - _setterConfigHyperPay() - Config.urlScheme: \(Config.urlScheme)");
        print("abdo - hyperpay - _setterConfigHyperPay() - Config.paymentButtonBrand: \(Config.paymentButtonBrand)");
        
    }
    
    
    
    func openWithListener(){
        // ui
//        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
//        print("abdo - hyperpay - run (RouterHyperPay.open) by FlutterViewController: \( controller )");
//        RouterHyperPay.open(selfVC:   controller, onStatusChanged:  { status in
//            if status {
//                print("abdo - hyperpay - openWithListener() - Payment success")
//                self.fireResultToFlutterSuccess();
//            } else {
//                print("abdo - hyperpay - openWithListener() - Payment failed")
//                self.fireResultToFlutterFailed();
//            }
//        });
    }
    
    
}
