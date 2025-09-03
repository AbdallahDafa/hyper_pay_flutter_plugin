//
//  Config.swift
//  ApplePayDafaIos
//
//  Created by Abdallah Android on 10/04/2025.
//

import UIKit
import OPPWAMobile


class Config: NSObject {
    
    nonisolated(unsafe) static var oPPProviderMode = OPPProviderMode.test
    nonisolated(unsafe) static var checkoutID = "";
    
    nonisolated(unsafe) static var merchantId =   ""; //example: merchant.com.tuxedo.dafa"
    nonisolated(unsafe) static var countryCode = "SA";
    /// get from socket
 
    
    // MARK: - The default amount and currency that are used for all payments
    nonisolated(unsafe) static var amount: Double = 1
    nonisolated(unsafe) static var currency: String = "SAR" //"EUR" or "SAR"
 

    // MARK: - The payment brands for Ready-to-use UI
    nonisolated(unsafe) static var checkoutPaymentBrands = [ "VISA", "MASTER", "MADA"   ]
    nonisolated(unsafe) static let supportedNetwork = [ PKPaymentNetwork.init("VISA") , PKPaymentNetwork.init("MASTER") , PKPaymentNetwork.init("MADA")  ]
    
    // MARK: - The default payment brand for Payment Button
    nonisolated(unsafe) static var paymentButtonBrand =   "APPLEPAY"

    nonisolated(unsafe) static var itemName =   ""

     
    // MARK: - shopperResultUrl
    nonisolated(unsafe)static var urlScheme =  "" ; //example "com.tuxedo.dafa.payment"
 
    
    
  
}
