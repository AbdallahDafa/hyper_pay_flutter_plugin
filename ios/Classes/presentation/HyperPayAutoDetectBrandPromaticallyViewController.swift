//
//  ApplePayPromaticallyViewController.swift
//  ApplePayDafaIos
//
//  Created by Abdallah Android on 13/04/2025.
//

import UIKit
import OPPWAMobile


/// listener
class HyperPayAutoDetectBrandPromaticallyData {

    nonisolated(unsafe) static var onStatusChanged: ((Bool) -> Void)?
}


class HyperPayAutoDetectBrandPromaticallyViewController: UIViewController, OPPCheckoutProviderDelegate {
    
    var checkoutProvider: OPPCheckoutProvider?
    var transaction: OPPTransaction?


    
    //------------------------------------------------------ transparent shape
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Make background transparent
        view.backgroundColor = UIColor.black.withAlphaComponent(0.01)
        
        // Optional: Add a dismiss tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelfTouchScreen))
        view.addGestureRecognizer(tapGesture)
        
        // apple pay start
        setupPaymentAutoDetectBrand ( );
        
        
        
    }

    
    @objc func dismissSelfTouchScreen() {
         dismiss(animated: true, completion: nil)
        HyperPayAutoDetectBrandPromaticallyData.onStatusChanged?(false)
     }
    
    
    
    @objc func dismissSelf() {
         dismiss(animated: true, completion: nil)
       
     }
 
    
   //---------------------------------------------------------- pay with visa
   
   func setupPaymentAutoDetectBrand(   ) {
       print( "abdo - setupPaymentAutoDetectBrand() - price: \( Config.amount ) ");
        
 
//
       // init checkout
       self.checkoutProvider =  configureCheckoutProviderAutoDetectBrand(checkoutID: Config.checkoutID )
       print("abdo - setupPaymentAutoDetectBrand() - checkoutID: \(Config.checkoutID )");
       
       self.checkoutProvider?.delegate = self;

       // lisenter
       self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in

           
           print("abdo - setupPaymentAutoDetectBrand() - completionHandler -  transaction: \(transaction )");
           print("abdo - setupPaymentAutoDetectBrand() - completionHandler -  error: \(error )");
           
           if( error != nil  ){
               self.dismissSelf()
               HyperPayAutoDetectBrandPromaticallyData.onStatusChanged?(false)
               return;
           } else  {
               self.dismissSelf()
               HyperPayAutoDetectBrandPromaticallyData.onStatusChanged?(true )
           }
 
           
       }, cancelHandler:  { (     ) in
           
           print("abdo - setupPaymentAutoDetectBrand() - cancelHandler");
           self.dismissSelf()
           HyperPayAutoDetectBrandPromaticallyData.onStatusChanged?(false)
       })
        
       
       
       
   }
   
   ///-------------------------------------------------------------------------- setup
    
   
   func configureCheckoutProviderAutoDetectBrand(checkoutID: String) -> OPPCheckoutProvider? {
       print("abdo - RootViewController - configureCheckoutProviderAutoDetectBrand");
       
       let provider = OPPPaymentProvider(mode: Config.oPPProviderMode )
       let checkoutSettings = OPPCheckoutSettings()
       checkoutSettings.shopperResultURL = Config.urlScheme;
       checkoutSettings.paymentBrands = Config.checkoutPaymentBrands
       
       
       let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier:  Config.merchantId, countryCode:  Config.countryCode )
        
       paymentRequest.supportedNetworks =  Config.supportedNetwork // set up supported payment networks
       checkoutSettings.applePayPaymentRequest = paymentRequest
       checkoutSettings.storePaymentDetails = .prompt
       return OPPCheckoutProvider.init(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
   }
   
}
