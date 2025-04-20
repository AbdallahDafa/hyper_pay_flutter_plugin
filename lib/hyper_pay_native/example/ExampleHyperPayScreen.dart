import 'package:flutter/material.dart';
import 'package:hyper_pay/helper/dialog/hyperpay_message_dialog.dart';

import 'package:hyper_pay/hyper_pay_native/controller/channel/hyperpay_channel_stream_controller.dart';
import 'package:hyper_pay/hyper_pay_native/model/request/hyperpay_channel_request.dart';


class ExampleHyperPayScreen extends StatefulWidget {
  const ExampleHyperPayScreen({super.key});

  @override
  State<ExampleHyperPayScreen> createState() => _ExampleHyperPayScreenState();
}

class _ExampleHyperPayScreenState extends State<ExampleHyperPayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(children: [

            SizedBox( height: 100 ,),
            GestureDetector(
                child:  Text("Pay Visa"),
                    onTap: () async {
              await visaPayment();
            })

          ],)
          ,
        )

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
    channelRequest.checkoutId = "C9AEE314FC899D90B5D27C837EDC5BE3.prod01-vm-tx12"; //get from your server side
    channelRequest.amount =  1;
    channelRequest.isTest = false ; //false means it's live
    await HyperpayChannelStreamController.sendDataToNative(channelRequest);

  }


}
