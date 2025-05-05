//
//  RouterHyperPay.swift
//  ApplePayDafaIos
//
//  Created by Abdallah Android on 13/04/2025.
//

import UIKit

class RouterHyperPay {
    
    

    public static func singleBrand(selfVC : UIViewController, onStatusChanged: @escaping (Bool) -> Void  ) {

        HyperPaySingleBrandPromaticallyData.onStatusChanged = onStatusChanged;

        MainActor.assumeIsolated {
            let vc = HyperPaySingleBrandPromaticallyViewController()
            vc.modalPresentationStyle = .overFullScreen
            selfVC.present(vc, animated: true, completion: nil)
        }

    }

    public static func autoDetectBrand(selfVC : UIViewController, onStatusChanged: @escaping (Bool) -> Void  ) {

        HyperPayAutoDetectBrandPromaticallyData.onStatusChanged = onStatusChanged;

        MainActor.assumeIsolated {
            let vc = HyperPayAutoDetectBrandPromaticallyViewController()
            vc.modalPresentationStyle = .overFullScreen
            selfVC.present(vc, animated: true, completion: nil)
        }

    }
    
}

/**

    public static func singleBrand(selfVC : UIViewController, onStatusChanged: @escaping (Bool) -> Void  ) {
        let vc = HyperPaySingleBrandPromaticallyViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.onStatusChanged = onStatusChanged;
        selfVC.present(vc, animated: true, completion: nil)
    }


    public static func autoDetectBrand(selfVC : UIViewController, onStatusChanged: @escaping (Bool) -> Void ){
        let vc = HyperPayAutoDetectBrandPromaticallyViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.onStatusChanged = onStatusChanged;
        selfVC.present(vc, animated: true, completion: nil)
    }
 */
