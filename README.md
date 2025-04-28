# hyper_pay_flutter_plugin



-----

-----


## Documenation 

[HyperPay Integration Guide](https://www.hyperpay.com/integration-guide/)


-----

-----



## Create Payment Type :  VISA/MASTER/MADA


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

                await HyperPayPayment.newPayment(channelRequest : channelRequest, onComplete: (bool isSuccess) {

                  setState(() {
                    isPaymentSuccess = isSuccess;
                  });

                } );
```
* the above code will boolean type "isSuccess", when success that's means the payment completed without any failed,
  But Notice you must call your server side to check status of this checkoutID if the money payed or not.
 
### Step Three : Check Status Of Payment 

* call your server side to check after completed payment, if this checkout id is completed and success charge money or not.


### Screenshot Visa Payment 

* Android Screens :

<div style="display: flex; gap: 10px;">
  <img src="https://github.com/AbdallahDafa/hyper_pay_flutter_plugin/blob/main/screenshot/android-1.png?raw=true" alt="Image 1" width="200" />
  <img src="https://github.com/AbdallahDafa/hyper_pay_flutter_plugin/blob/main/screenshot/android-2.png?raw=true" alt="Image 2" width="200" />
  <img src="https://github.com/AbdallahDafa/hyper_pay_flutter_plugin/blob/main/screenshot/android-3.png?raw=true" alt="Image 3" width="200" />
</div>


* IPhone Screens :


-----

-----


## Create Payment Type Apple Pay / Hyperpay :


### First Config Apple Pay:

* first generate the checkout id from your server side, using your own ceradential you getted from Hyperpay support team
* create capilities of xcode "apple pay"
* create merchant id in apple store connect
* Contact hyperpay support to get the "merchant.cer" and "processing.cer" to be replaced into your apple store account

### Second Code Open UI Apple Pay Dialog :

* code dart 
```dart
                /// init request channel
                var channelRequest = HyperpayChannelRequest ( );
                channelRequest.shopperResultUrl =   "com.example.myapp.payment";  //contact hyperpay support to get merchantId
                channelRequest.merchantId =  "merchant.com.example.myapp";  //contact hyperpay support to get merchantId
                channelRequest.brandName = "APPLEPAY";  
                channelRequest.checkoutId = "**************"; //get from your server side 
                channelRequest.amount =  1;
                channelRequest.isTest = false ; //false means it's live

                await HyperPayPayment.newPayment(channelRequest : channelRequest, onComplete: (bool isSuccess) {

                  setState(() {
                    isPaymentSuccess = isSuccess;
                  });

                } );
```

### Step Three : Check Status Of Payment

* call your server side to check after completed payment, if this checkout id is completed and success charge money or not.


-----

-----


## MIT License

````
MIT License

Copyright (c) 2025 Abdallah Mahmoud <abdallah.mahmoud.dev@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

````

# Company Dafa.sa
created by developer abdallah at dafa company
