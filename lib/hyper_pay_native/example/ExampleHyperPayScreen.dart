import 'package:flutter/material.dart';
import 'package:tuxedo/core/hyper_pay_native/controller/channel/hyperpay_channel_stream_controller.dart';
import 'package:tuxedo/core/hyper_pay_native/model/request/hyperpay_channel_request.dart';
import 'package:tuxedo/core/toast/tools_toast.dart';
import 'package:tuxedo/customWidget/button/ButtonApp.dart';
import 'package:tuxedo/customWidget/page/ScaffoldApp.dart';
import 'package:tuxedo/hyperpay_payment/constants/payment_constants.dart';

class ExampleHyperPayScreen extends StatefulWidget {
  const ExampleHyperPayScreen({super.key});

  @override
  State<ExampleHyperPayScreen> createState() => _ExampleHyperPayScreenState();
}

class _ExampleHyperPayScreenState extends State<ExampleHyperPayScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(children: [

            SizedBox( height: 100 ,),
            ButtonApp( "Pay Visa",  () async {
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
          ToolsToast.i(context,  result);
          if( result.toString() == "success" ) {
              /// check status call your server side
          } else {
            ///TODO failed payment
          }
        }
    );

    /// init request channel
    var channelRequest = HyperpayChannelRequest ( );
    channelRequest.shopperResultUrl = HyperPayPaymentConstants.shopperResultUrl;
    channelRequest.merchantId = HyperPayPaymentConstants.merchantId;
    channelRequest.brandName = "VISA";
    channelRequest.checkoutId = "37492FDAA1428216F515A6842F68E295.prod01-vm-tx16"; //get from your server side
    channelRequest.amount =  1;
    channelRequest.isTest = false ; //false means it's live
    await HyperpayChannelStreamController.sendDataToNative(channelRequest);

  }


}
