//
//  RouterHyperPay.swift
//  ApplePayDafaIos
//
//  Created by Abdallah Android on 13/04/2025.
//

import UIKit

class RouterHyperPay {
    
    
    
    public static func open(selfVC : UIViewController, onStatusChanged: @escaping (Bool) -> Void  ) {
        
        HyperPaySingleBrandPromaticallyData.onStatusChanged = onStatusChanged;
        
        MainActor.assumeIsolated {
            let vc = HyperPaySingleBrandPromaticallyViewController()
            vc.modalPresentationStyle = .overFullScreen 
            selfVC.present(vc, animated: true, completion: nil)
        }
        
    }


    
}
