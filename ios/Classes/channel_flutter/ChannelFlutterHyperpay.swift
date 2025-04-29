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
    
    static var eventSink: FlutterEventSink?
    static var data : [String: Any]  = [ : ];
    
    static var request : HyperPayChannelRequest = HyperPayChannelRequest();
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

extension AppDelegate {
    
    func setupHyperPay(){
        
        _setupSendDataFromSwiftToFlutter();
        _setupRecieveDataFromFlutter();
    }
    
    func _setupSendDataFromSwiftToFlutter(){
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let eventChannel = FlutterEventChannel(name: "com.hyperpay/listenFromNative", binaryMessenger: controller.binaryMessenger)
        
        eventChannel.setStreamHandler(self)
        print("HyperPay - _setupSendDataFromSwiftToFlutter() - setup stream");
    }
    
    
    func _setupRecieveDataFromFlutter(){
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.hyperpay/sendToNative", binaryMessenger: controller.binaryMessenger)
        print("hyperpay - _setupRecieveDataFromFlutter()- setup")
        channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "fromFlutter" {
                if let args = call.arguments as? [String: Any] {
                    print("hyperpay - _setupRecieveDataFromFlutter()- Received from Flutter - args: \(args)")
                    self.parseDataReceivedFromFlutter(args);
                    self.openUIPaymentByChooseBrandType();
                    // Handle it
                    result("OK")
                } else {
                    result(FlutterError(code: "BAD_ARGS", message: "Missing data", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
    

}


//------------------------------------------------------------ send from swift to native

extension AppDelegate : FlutterStreamHandler {
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
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

      func onCancel(withArguments arguments: Any?) -> FlutterError? {
          HyperPayResultData.eventSink = nil
          return nil
      }
    
    
    func fireResultToFlutterSuccess(){
        print("HyperPay - fireResultToFlutterSuccess() - send data");
        if( HyperPayResultData.eventSink == nil ) { return;}
        HyperPayResultData.eventSink!( "success")
        
    }
    
    func fireResultToFlutterFailed(){
        print("HyperPay - fireResultToFlutterFailed() - send data");
        if( HyperPayResultData.eventSink == nil ) { return;}
        HyperPayResultData.eventSink!( "failed")
    }
    
}

//--------------------------------------------------- from flutter reciever

extension AppDelegate {
    
    func parseDataReceivedFromFlutter( _ jsonData : [String: Any]){
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonData, options: [])
            let decodeRequest = try JSONDecoder().decode(HyperPayChannelRequest.self, from: data)
            HyperPayResultData.request =  decodeRequest;
            print("hyperpay - parseDataReceivedFromFlutter() - toDictionary:", decodeRequest.toDictionary())
//            print("hyperpay - parseDataReceivedFromFlutter() -Is Mada:", response.isMada)
            
        } catch {
            print("hyperpay - parseDataReceivedFromFlutter() - Failed to decode JSON:", error)
        }
    }
    
}

//----------------------------------------------------------- open payment

extension AppDelegate {
    
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
        print("hyperpay - _setterConfigHyperPay() - request before: \( HyperPayResultData.request.toDictionary() )");
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
        print("hyperpay - _setterConfigHyperPay() - Config.oPPProviderMode: \(Config.oPPProviderMode.rawValue)");
        print("hyperpay - _setterConfigHyperPay() - Config.merchantId: \(Config.merchantId)");
        print("hyperpay - _setterConfigHyperPay() - Config.checkoutID: \(Config.checkoutID)");
        print("hyperpay - _setterConfigHyperPay() - Config.amount: \(Config.amount)");
        print("hyperpay - _setterConfigHyperPay() - Config.urlScheme: \(Config.urlScheme)");
        print("hyperpay - _setterConfigHyperPay() - Config.paymentButtonBrand: \(Config.paymentButtonBrand)");
        
    }
    
    
    
    func openWithListener(){
        // ui
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        print("hyperpay - run (RouterHyperPay.open) by FlutterViewController: \( controller )");
        RouterHyperPay.open(selfVC:   controller, onStatusChanged:  { status in
            if status {
                print("hyperpay - openWithListener() - Payment success")
                self.fireResultToFlutterSuccess();
            } else {
                print("hyperpay - openWithListener() - Payment failed")
                self.fireResultToFlutterFailed();
            }
        });
    }
    
    
}
