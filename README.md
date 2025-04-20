# hyper_pay_flutter_plugin

# HYPER PAY FLUTTER PLUGIN
 created by developer abdallah at dafa company plugin

## Documenation 
* see [HyperPay Integration Guide](https://www.hyperpay.com/integration-guide/)


## Steps

### First Step : Generate Checkout ID 

* First generate the checkout id from your server side, using your own ceradential you getted from Hyperpay support team

### Second Step : Open UI Checkout Using Flutter Plugin

#### Payment Method : VISA/MASTER/MADA 

* code dart :
```dart
                /// init request channel
                var channelRequest = HyperpayChannelRequest ( );
                channelRequest.shopperResultUrl =   "com.example.myapp.payment";  //contact hyperpay support to get merchantId
                channelRequest.merchantId =  "merchant.com.example.myapp";  //contact hyperpay support to get merchantId
                channelRequest.brandName = "VISA";  // follow documentation to get brand name, example : VISA/MASTER/MADA 
                channelRequest.checkoutId = "**************"; //get from your server side 
                channelRequest.amount =  1;
                channelRequest.isTest = false ; //false means it's live

                await HyperPay.newPayment(channelRequest : channelRequest, onComplete: (bool isSuccess) {

                  setState(() {
                    isPaymentSuccess = isSuccess;
                  });

                } );
```
* the above code will boolean type "isSuccess", when success that's means the payment completed without any failed,
  But Notice you must call your server side to check status of this checkoutID if the money payed or not.
 
### Step Three : Check Status Of Payment 

* call your server side to check after completed payment, if this checkout id is completed and success charge money or not.


-----

-----

## HayperPay Integeration with APPLE PAY :

* First generate the checkout id from your server side, using your own ceradential you getted from Hyperpay support team
