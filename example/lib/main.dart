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

  bool? isPaymentSuccess = null  ;

  String result = "";

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
            SizedBox( height: 20 ,),
            GestureDetector(
              child:  Container(
                color: Colors.grey,
                padding: EdgeInsets.all(10 ),
                child: Text("Check Connection Between Dart And Native"),
              ),
              onTap: () async {


                result = await HyperPayPayment.getPlatformVersion();
                setState(()   {});

              },
            ),

            SizedBox( height: 20 ,),
            GestureDetector(
              child:  Container(
                color: Colors.grey,
                padding: EdgeInsets.all(10 ),
                child: Text("Visa"),
              ),
              onTap: () async {


                  // result = await HyperPayPayment.getPlatformVersion();
                  // setState(()   {});

                await visaPayment();

              },
            ),
            SizedBox( height: 20 ,),

            /// result
            if(result !=  "" ) Text( result ,
              style: TextStyle( color: Colors.blue),),

            /// status
            if( isPaymentSuccess != null && isPaymentSuccess == true )Text( "Payment success, need to check status in your server side" ,
              style: TextStyle( color: Colors.green),),
            if( isPaymentSuccess != null && isPaymentSuccess == false )Text( "Payment failed", style: TextStyle( color: Colors.red),)


          ],),
        ),
      ),
    );
  }

  visaPayment() async {
    /// init request channel
    var channelRequest = HyperpayChannelRequest ( );
    channelRequest.shopperResultUrl =   "com.tuxedo.dafa.payment";  //contact hyperpay support to get merchantId
    channelRequest.merchantId =  "merchant.com.tuxedo.dafa";  //contact hyperpay support to get merchantId
    channelRequest.brandName = "VISA";
    channelRequest.checkoutId = "50797B004CC64A2003A2EFC442205E34.prod02-vm-tx11"; //get from your server side
    channelRequest.amount =  1;
    channelRequest.isTest = false ; //false means it's live

    await HyperPayPayment.newPayment(
        channelRequest : channelRequest,
        onComplete: (bool isSuccess) {

          setState(() {
            isPaymentSuccess = isSuccess;
          });
        } );

  }



}
