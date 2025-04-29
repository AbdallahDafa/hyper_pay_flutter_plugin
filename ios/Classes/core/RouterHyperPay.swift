//
//  RouterHyperPay.swift
//  ApplePayDafaIos
//
//  Created by Abdallah Android on 13/04/2025.
//

import UIKit

class RouterHyperPay {
    
    
    
    public static func open(selfVC : UIViewController, onStatusChanged: @escaping (Bool) -> Void  ) {
        let vc = HyperPaySingleBrandPromaticallyViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        vc.onStatusChanged = onStatusChanged;
//
//        vc.onStatusChanged = { status in
//            if status {
//                print("hyperpay - RouterHyperPay - Payment succeeded!")
//                // Do what you need with success
//            } else {
//                print("hyperpay - RouterHyperPay - Payment failed.")
//            }
//        }
        selfVC.present(vc, animated: true, completion: nil)
    }


    
}
