//
//  Config.swift
//  ApplePayDafaIos
//
//  Created by Abdallah Android on 10/04/2025.
//

import UIKit
import OPPWAMobile


class Config: NSObject {
    
    static var oPPProviderMode = OPPProviderMode.test
    static var checkoutID = "";
    
    static var merchantId = "merchant.com.tuxedo.dafa"
    static var countryCode = "SA";
    /// get from socket
 
    
    // MARK: - The default amount and currency that are used for all payments
    static var amount: Double = 1
    static var currency: String = "SAR" //"EUR"
 
    
    
    // MARK: - The payment brands for Ready-to-use UI
//    static var checkoutPaymentBrands = [ "VISA", "MASTER", "MADA"   ]
    static let supportedNetwork = [ PKPaymentNetwork.init("VISA") , PKPaymentNetwork.init("MASTER") , PKPaymentNetwork.init("MADA")  ]
    
    // MARK: - The default payment brand for Payment Button
    static var paymentButtonBrand =   "APPLEPAY"
    
     
    // MARK: - shopperResultUrl
    static var urlScheme =  "com.tuxedo.dafa.payment"
 
    
    
  
}
