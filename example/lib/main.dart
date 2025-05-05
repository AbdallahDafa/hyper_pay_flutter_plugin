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

            ///--------------------------- check connection

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

            ///--------------------------- Auto detect
            SizedBox( height: 20 ,),
            GestureDetector(
              child:  Container(
                color: Colors.grey,
                padding: EdgeInsets.all(10 ),
                child: Text("Ready Use UI Auto Detect Brand Type"),
              ),
              onTap: () async {

                await autoDetectBrandType();

              },
            ),


            ///--------------------------- single Brand visa
            ///
            SizedBox( height: 20 ,),
            GestureDetector(
              child:  Container(
                color: Colors.grey,
                padding: EdgeInsets.all(10 ),
                child: Text("Single Payment Button Visa Only"),
              ),
              onTap: () async {

                await singleBrandTypeVisa();

              },
            ),


            ///----------------------------- result

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

  singleBrandTypeVisa() async {
    /// init request channel
    var channelRequest = HyperpayChannelRequest ( );
    channelRequest.shopperResultUrl =   "com.tuxedo.dafa.payment";  //contact hyperpay support to get merchantId
    channelRequest.merchantId =  "merchant.com.tuxedo.dafa";  //contact hyperpay support to get merchantId
    channelRequest.brandName = "VISA";
    channelRequest.checkoutId = "B6C5B5F146CE4C32086E55EA69D7E8B5.prod02-vm-tx05"; //get from your server side
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


  autoDetectBrandType() async {
    /// init request channel
    var channelRequest = HyperpayChannelRequest ( );
    channelRequest.shopperResultUrl =   "com.tuxedo.dafa.payment";  //contact hyperpay support to get merchantId
    channelRequest.merchantId =  "merchant.com.tuxedo.dafa";  //contact hyperpay support to get merchantId
    channelRequest.checkoutId = "35D5DF7F78A78144EC6667CF3D047FC1.uat01-vm-tx01"; //get from your server side
    channelRequest.amount =  1;
    channelRequest.isTest = true ; //false means it's live

    await HyperPayPayment.newPayment(
        channelRequest : channelRequest,
        onComplete: (bool isSuccess) {

          setState(() {
            isPaymentSuccess = isSuccess;
          });
        } );

  }



}
