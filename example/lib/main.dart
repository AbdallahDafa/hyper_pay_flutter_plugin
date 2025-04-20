import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:hyper_pay/hyper_pay.dart';


import 'package:hyper_pay/hyper_pay_platform_interface.dart';

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
  final _hyperPayPlugin = HyperPay();

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

                  await HyperPayPlatform.instance.fromFlutter();
                }),
            SizedBox( height: 20 ,),
            GestureDetector(
              child:  Container(
                color: Colors.grey,
                padding: EdgeInsets.all(10 ),
                child: Text("Visa"),
              ),
              onTap: (){
                visaPayment();
              },
            )



          ],),
        ),
      ),
    );
  }


  visaPayment() async {

    /// listener to result
    await HyperpayChannelStreamController.setupListenerFromNative(
        callback: ( result ) {

          if( result.toString() == "success" ) {
            /// check status call your server side
            HyperPayMessageDialog.show(context,  "Payment Result",  "check status by call your server side using same checkoutID you create");

          } else {
            ///TODO failed payment
            HyperPayMessageDialog.show(context,  "Payment Result",  "failed payment");
          }
        }
    );

    /// init request channel
    var channelRequest = HyperpayChannelRequest ( );
    channelRequest.shopperResultUrl =   "com.tuxedo.dafa.payment";  //contact hyperpay support to get merchantId
    channelRequest.merchantId =  "merchant.com.tuxedo.dafa";  //contact hyperpay support to get merchantId
    channelRequest.brandName = "VISA";
    channelRequest.checkoutId = "BB6A3DCD12AC43DAA236FA5D00BD08F9.prod01-vm-tx02"; //get from your server side
    channelRequest.amount =  1;
    channelRequest.isTest = false ; //false means it's live
    await HyperpayChannelStreamController.sendDataToNative(channelRequest);

  }



}
