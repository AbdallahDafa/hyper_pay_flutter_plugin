import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
// import 'package:hyper_pay_payment/hyper_pay_native/model/request/hyperpay_channel_request.dart';
import 'package:hyper_pay_payment/hyper_pay_payment.dart';
import 'package:hyper_pay_payment/hyper_pay_payment_platform_interface.dart';

// import 'package:hyper_pay/hyper_pay_native/model/request/hyperpay_channel_request.dart';
// import 'package:hyper_pay/hyper_pay_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _hyperPayPlugin = HyperPayPayment();

  bool? isPaymentSuccess = null  ;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _hyperPayPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child:  Column(children: [

            Text('Flutter exmaple/main.dart , get result Running on: $_platformVersion\n'),

            SizedBox( height: 20 ,),
            GestureDetector(
                child:  Container(
                  color: Colors.grey,
                  padding: EdgeInsets.all(10),
                  child: Text("Test Call method: fromFlutter"),
                ),
                onTap: () async {

                  await HyperPayPaymentPlatform.instance.fromFlutter();
                }),
            SizedBox( height: 20 ,),
            GestureDetector(
              child:  Container(
                color: Colors.grey,
                padding: EdgeInsets.all(10 ),
                child: Text("Visa"),
              ),
              onTap: () async {
                // visaPayment();

                /// init request channel
                var channelRequest = HyperpayChannelRequest ( );
                channelRequest.shopperResultUrl =   "com.tuxedo.dafa.payment";  //contact hyperpay support to get merchantId
                channelRequest.merchantId =  "merchant.com.tuxedo.dafa";  //contact hyperpay support to get merchantId
                channelRequest.brandName = "VISA";
                channelRequest.checkoutId = "CE3AC6C6D0CB1999E0BA2FBBF3B1EFD7.prod01-vm-tx07"; //get from your server side
                channelRequest.amount =  1;
                channelRequest.isTest = false ; //false means it's live

                await HyperPayPayment.newPayment(channelRequest : channelRequest, onComplete: (bool isSuccess) {

                  setState(() {
                    isPaymentSuccess = isSuccess;
                  });

                } );
              },
            ),
            SizedBox( height: 20 ,),

            /// status
            if( isPaymentSuccess != null && isPaymentSuccess == true )Text( "Payment success, need to check status in your server side" ,
              style: TextStyle( color: Colors.green),),
            if( isPaymentSuccess != null && isPaymentSuccess == false )Text( "Payment failed", style: TextStyle( color: Colors.red),)


          ],),
        ),
      ),
    );
  }



}
