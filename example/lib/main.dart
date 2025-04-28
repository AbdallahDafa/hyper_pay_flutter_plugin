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
                child: Text("Visa"),
              ),
              onTap: () async {

                /// init request channel
                var channelRequest = HyperpayChannelRequest ( );
                channelRequest.shopperResultUrl =   "com.tuxedo.dafa.payment";  //contact hyperpay support to get merchantId
                channelRequest.merchantId =  "merchant.com.tuxedo.dafa";  //contact hyperpay support to get merchantId
                channelRequest.brandName = "VISA";
                channelRequest.checkoutId = "AA67C5F3B384BA37DED11DEDC35D74C9.prod02-vm-tx03"; //get from your server side
                channelRequest.amount =  1;
                channelRequest.isTest = false ; //false means it's live

                await HyperPayPayment.newPayment(
                    channelRequest : channelRequest,
                    onComplete: (bool isSuccess) {

                      setState(() {
                        isPaymentSuccess = isSuccess;
                      });
                    } );



                /**
                 *
                    setState(() async {
                    result = await HyperPayPayment.getPlatformVersion();
                    });

                 */



              },
            ),
            SizedBox( height: 20 ,),

            /// result
            if(result !=  "" ) Text( result ,
              style: TextStyle( color: Colors.yellow),),

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
