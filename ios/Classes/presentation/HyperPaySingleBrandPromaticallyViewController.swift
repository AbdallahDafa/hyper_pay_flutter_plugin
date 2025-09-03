//
//  ApplePayPromaticallyViewController.swift
//  ApplePayDafaIos
//
//  Created by Abdallah Android on 13/04/2025.
//

import UIKit
import OPPWAMobile

/// listener
class HyperPaySingleBrandPromaticallyData {
    
    nonisolated(unsafe) static var onStatusChanged: ((Bool) -> Void)?
}


class HyperPaySingleBrandPromaticallyViewController: UIViewController, OPPCheckoutProviderDelegate {
    
    var checkoutProvider: OPPCheckoutProvider?
    var transaction: OPPTransaction?
    
    var paymentButton   = OPPPaymentButton();
    
    
 
    
    //------------------------------------------------------ transparent shape
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Make background transparent
        view.backgroundColor = UIColor.black.withAlphaComponent(0.01)
        
        // Optional: Add a dismiss tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelfTouchScreen))
        view.addGestureRecognizer(tapGesture)
        
        // apple pay start
        setupPaymentSingleBrand ( );
        
        // ui draw
        drawButtonHyperPay();
        
    }

    
    @objc func dismissSelfTouchScreen() {
         dismiss(animated: true, completion: nil)
        HyperPaySingleBrandPromaticallyData.onStatusChanged?(false)
     }
    
    
    
    @objc func dismissSelf() {
         dismiss(animated: true, completion: nil)
       
     }
    
    //------------------------------------------------------ draw ui progmatically
    
    

    func drawButtonHyperPay() {
        // Add a label
        paymentButton.imageView?.isHidden = true // hide image of not need
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentButton)

        // Add constraints
        NSLayoutConstraint.activate([
            paymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
   //---------------------------------------------------------- pay with visa
   
   func setupPaymentSingleBrand(   ) {
       print( "abdo - setupPaymentSingleBrand() - price: \( Config.amount ) ");
        

       /// setup custom view :
       ///  (notice this view reused by sdk, to view the card details and visa or another view shape )
       paymentButton.paymentBrand = Config.paymentButtonBrand
     
       
       // init checkout
       self.checkoutProvider =  configureCheckoutProvider(checkoutID: Config.checkoutID )
       print("abdo - paymentButtonAction - checkoutID: \(Config.checkoutID )");

       // lisenter
       self.checkoutProvider?.presentCheckout(withPaymentBrand: Config.paymentButtonBrand, loadingHandler: { (inProgress) in
           
           print("abdo - paymentButtonAction - inProgress: \(inProgress )");
           
           //self.loadingHandler(inProgress: inProgress)
       }, completionHandler: { (transaction, error) in
           
           print("abdo - paymentButtonAction - completionHandler -  transaction: \(transaction )");
           print("abdo - paymentButtonAction - completionHandler -  error: \(error )");
           
           print("abdo - paymentButtonAction - stop for testing for hyperpay");
           
           if( error != nil  ){
               self.dismissSelf()
               HyperPaySingleBrandPromaticallyData.onStatusChanged?(false)
               return;
           } else  {
               self.dismissSelf()
               HyperPaySingleBrandPromaticallyData.onStatusChanged?(true )
           }
 
           
       }, cancelHandler:  { (     ) in
           
           print("abdo - paymentButtonAction - cancelHandler");
           self.dismissSelf()
           HyperPaySingleBrandPromaticallyData.onStatusChanged?(false)
       })
       
       
       
   }
   
   ///-------------------------------------------------------------------------- setup
    
   
   func configureCheckoutProvider(checkoutID: String) -> OPPCheckoutProvider? {
       print("abdo - RootViewController - configureCheckoutProvider()");
       
       let provider = OPPPaymentProvider(mode: Config.oPPProviderMode )
       let checkoutSettings = OPPCheckoutSettings()
       checkoutSettings.shopperResultURL = Config.urlScheme;
       let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier:  Config.merchantId, countryCode:  Config.countryCode )
        
       paymentRequest.supportedNetworks =  Config.supportedNetwork // set up supported payment networks
       checkoutSettings.applePayPaymentRequest = paymentRequest

       /// summary payment item for apple only
       if( Config.paymentButtonBrand == "APPLEPAY") {
           let amountDecimal =  NSDecimalNumber(value: Config.amount )
           checkoutSettings.applePayPaymentRequest?.paymentSummaryItems = [PKPaymentSummaryItem.init( label:  Config.itemName, amount:  amountDecimal)];
           print("abdo - RootViewController - configureCheckoutProvider() - add summary item name");
       }

       checkoutSettings.storePaymentDetails = .prompt
       return OPPCheckoutProvider.init(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
   }
   
}
