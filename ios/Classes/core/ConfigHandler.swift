//
//  ConfigHandler.swift
//  ApplePayDafaIos
//
//  Created by Abdallah Android on 13/04/2025.
//


import UIKit
import OPPWAMobile

class ConfigHandler {
    
    //------------------------------------------------------------------------- enviroment test
    
    static func setTypeTestApplePay( checkoutID : String , amount : Double    ){
        Config.oPPProviderMode = OPPProviderMode.test;
        Config.checkoutID = checkoutID;
        Config.amount = amount;
        Config.paymentButtonBrand = "APPLEPAY";
    }
    
    static func setTypeTestVisa( checkoutID : String , amount : Double    ){
        Config.oPPProviderMode = OPPProviderMode.test;
        Config.checkoutID = checkoutID;
        Config.amount = amount;
        Config.paymentButtonBrand = "VISA";
    }
    
    
    static func setTypeTestMADA( checkoutID : String , amount : Double    ){
        Config.oPPProviderMode = OPPProviderMode.test;
        Config.checkoutID = checkoutID;
        Config.amount = amount;
        Config.paymentButtonBrand = "MADA";
    }
    
    
    static func setTypeTestMasterCard( checkoutID : String , amount : Double    ){
        Config.oPPProviderMode = OPPProviderMode.test;
        Config.checkoutID = checkoutID;
        Config.amount = amount;
        Config.paymentButtonBrand = "MASTER";
    }
    
    
    //------------------------------------------------------------------------- enviroment live
    
    static func setTypeLiveApplePay( checkoutID : String , amount : Double    ){
        Config.oPPProviderMode = OPPProviderMode.live;
        Config.checkoutID = checkoutID;
        Config.amount = amount;
        Config.paymentButtonBrand = "APPLEPAY";
    }
    
    static func setTypeeLiveVisa( checkoutID : String , amount : Double    ){
        Config.oPPProviderMode = OPPProviderMode.live;
        Config.checkoutID = checkoutID;
        Config.amount = amount;
        Config.paymentButtonBrand = "VISA";
    }
    
    
    static func setTypeeLiveMADA( checkoutID : String , amount : Double    ){
        Config.oPPProviderMode = OPPProviderMode.live;
        Config.checkoutID = checkoutID;
        Config.amount = amount;
        Config.paymentButtonBrand = "MADA";
    }
    
    
    static func setTypeeLiveMasterCard( checkoutID : String , amount : Double    ){
        Config.oPPProviderMode = OPPProviderMode.live;
        Config.checkoutID = checkoutID;
        Config.amount = amount;
        Config.paymentButtonBrand = "MASTER";
    }
    
    
}
