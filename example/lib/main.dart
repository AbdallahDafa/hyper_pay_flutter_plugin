
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:hyper_pay_payment/hyper_pay_payment.dart';
import 'package:hyper_pay_payment/hyper_pay_payment_platform_interface.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isPaymentSuccess = null;

  String result = "";

  String checkOutID = "D6A457453D9C36F028381B7714EB467F.uat01-vm-tx02";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(

        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:  SafeArea(
            child: Center(
              child: Column(
                children: [
                  ///--------------------------- check connection

                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      color: Colors.grey,
                      padding: EdgeInsets.all(10),
                      child: Text("Check Connection Between Dart And Native"),
                    ),
                    onTap: () async {
                      result = await HyperPayPayment.getPlatformVersion();
                      setState(() {});
                    },
                  ),

                  ///--------------------------- Auto detect
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      color: Colors.grey,
                      padding: EdgeInsets.all(10),
                      child: Text("Ready Use UI Auto Detect Brand Type"),
                    ),
                    onTap: () async {
                      await autoDetectBrandType();
                    },
                  ),

                  ///--------------------------- single Brand visa

                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      color: Colors.grey,
                      padding: EdgeInsets.all(10),
                      child: Text("Single Payment Button Visa Only"),
                    ),
                    onTap: () async {
                      // await singleBrandTypeVisaTuxedo();
                      await singleBrandTypeVisaAtera();
                    },
                  ),

                  ///--------------------------- single Brand Apple Pay

                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      color: Colors.grey,
                      padding: EdgeInsets.all(10),
                      child: Text("Single Payment Button Apple Pay"),
                    ),
                    onTap: () async {
                      await singleBrandTypeApplePay();
                    },
                  ),

                  ///----------------------------- result

                  SizedBox(
                    height: 20,
                  ),

                  /// result
                  if (result != "")
                    Text(
                      result,
                      style: TextStyle(color: Colors.blue),
                    ),

                  /// status
                  if (isPaymentSuccess != null && isPaymentSuccess == true)
                    Text(
                      "Payment success, need to check status in your server side",
                      style: TextStyle(color: Colors.green),
                    ),
                  if (isPaymentSuccess != null && isPaymentSuccess == false)
                    Text(
                      "Payment failed",
                      style: TextStyle(color: Colors.red),
                    )
                ],
              ),
            )
        ),
      ),
    );
  }

  singleBrandTypeVisaTuxedo() async {
    /// init request channel
    var channelRequest = HyperpayChannelRequest();
    channelRequest.shopperResultUrl =
        "com.tuxedo.dafa.payment"; //contact hyperpay support to get merchantId
    channelRequest.merchantId =
        "merchant.com.tuxedo.dafa"; //contact hyperpay support to get merchantId
    channelRequest.brandName = "VISA";
    channelRequest.checkoutId =
        checkOutID;
    channelRequest.amount = 1;
    channelRequest.isTest = false; //false means it's live

    await HyperPayPayment.newPayment(
        channelRequest: channelRequest,
        onComplete: (bool isSuccess) {
          setState(() {
            isPaymentSuccess = isSuccess;
          });
        });
  }


  singleBrandTypeVisaAtera() async {
    /// init request channel
    var channelRequest = HyperpayChannelRequest();
    channelRequest.shopperResultUrl =
    "com.dafa.souqEletara.payment"; //contact hyperpay support to get merchantId
    channelRequest.merchantId =
    "merchant.com.dafa.eletara"; //contact hyperpay support to get merchantId
    channelRequest.brandName = "VISA";
    channelRequest.checkoutId =
        checkOutID;
    channelRequest.amount = 1;
    channelRequest.isTest = true ; //false means it's live

    await HyperPayPayment.newPayment(
        channelRequest: channelRequest,
        onComplete: (bool isSuccess) {
          setState(() {
            isPaymentSuccess = isSuccess;
          });
        });
  }

  singleBrandTypeApplePay() async {
    /// init request channel
    var channelRequest = HyperpayChannelRequest();
    channelRequest.shopperResultUrl =
        "com.tuxedo.dafa.payment"; //contact hyperpay support to get merchantId
    channelRequest.merchantId =
        "merchant.com.tuxedo.dafa"; //contact hyperpay support to get merchantId
    channelRequest.brandName = "APPLEPAY";
    channelRequest.checkoutId =
        checkOutID;
    channelRequest.amount = 1;
    channelRequest.isTest = false; //false means it's live
    channelRequest.itemName = "Etara";

    /// message about merchant product name

    await HyperPayPayment.newPayment(
        channelRequest: channelRequest,
        onComplete: (bool isSuccess) {
          setState(() {
            isPaymentSuccess = isSuccess;
          });
        });
  }

  autoDetectBrandType() async {
    /// init request channel
    var channelRequest = HyperpayChannelRequest();
    channelRequest.shopperResultUrl =
        "com.tuxedo.dafa.payment"; //contact hyperpay support to get merchantId
    channelRequest.merchantId =
        "merchant.com.tuxedo.dafa"; //contact hyperpay support to get merchantId
    channelRequest.checkoutId =
        checkOutID;
    channelRequest.amount = 1;
    channelRequest.isTest = false; //false means it's live
    channelRequest.itemName = "Tuxedo";
    await HyperPayPayment.newPayment(
        channelRequest: channelRequest,
        onComplete: (bool isSuccess) {
          setState(() {
            isPaymentSuccess = isSuccess;
          });
        });
  }
}
