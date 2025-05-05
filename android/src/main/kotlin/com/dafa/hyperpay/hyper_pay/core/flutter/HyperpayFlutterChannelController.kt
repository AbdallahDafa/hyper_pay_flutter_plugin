package com.dafa.hyperpay.hyper_pay.core.flutter

// flutter import class EventChannelSavedEvent
import android.content.ComponentName
import android.util.Log
import androidx.activity.result.ActivityResultLauncher
import androidx.appcompat.app.AppCompatActivity
import com.dafa.hyperpay.hyper_pay.HyperPayPlugin
//import com.dafa.hyperpay.hyper_pay.HyperPayMainActivity

import com.dafa.hyperpay.hyper_pay.core.Config
import com.dafa.hyperpay.hyper_pay.core.receiver.CheckoutBroadcastReceiver
import com.oppwa.mobile.connect.checkout.meta.CheckoutActivityResult
import com.oppwa.mobile.connect.checkout.meta.CheckoutActivityResultContract
import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings
import com.oppwa.mobile.connect.checkout.meta.CheckoutSkipCVVMode
import com.oppwa.mobile.connect.provider.Connect

object HyperpayFlutterChannelController {


    lateinit var request : HyperpayFlutterRequest;
    lateinit var  activityCompat : AppCompatActivity;
    lateinit var  checkoutLauncher : ActivityResultLauncher<CheckoutSettings> ;


    //---------------------------------------------------------------------- public method

    fun setup(
        activityCompat : AppCompatActivity,
        request: HyperpayFlutterRequest,
    ) {
        this.request = request;
        this.activityCompat = activityCompat;

        if( request.brandName == "auto") {
            setConfigByRequestInfoTypeAutoDetectBrandMethod();
        } else  {
            setConfigByRequestInfoTypeSingleBrandMethod();

        }

        setterActivityResult();
    }



    fun fireToFlutterCompleteFailed(){
        Log.i( "abdo hyperpay", "fireToFlutterCompleteFailed()")
        activityCompat.finish();
        /// TO-DO call channel flutter
        HyperPayPlugin.eventSink?.success("failed")
    }


    fun fireToFlutterCompleteSuccessWhileNeedCheckStatus(){
        Log.i( "abdo hyperpay", "fireToFlutterCompleteSuccessWhileNeedCheckStatus()")
        activityCompat.finish();
        /// TO-DO call channel flutter
        HyperPayPlugin.eventSink?.success("success")
    }


    fun showCheckoutUI() {
//        if( request.brandName == "auto") {
//            request.brandName = null;
//        }
        val checkoutSettings = getCreateCheckoutSettings();
        checkoutLauncher.launch( checkoutSettings );
    }


    //----------------------------------------------------------------------  choose type brand


    private fun setConfigByRequestInfoTypeSingleBrandMethod() {
        Config.CHECKOUT_ID = request.checkoutId ;
        Config.PAYMENT_BUTTON_BRAND = request.brandName;
        Config.PAYMENT_BRANDS =  linkedSetOf( request.brandName ) ;
        if(request.isLive ) {
            Config.mode =     Connect.ProviderMode.LIVE;
        } else {
            Config.mode =     Connect.ProviderMode.TEST;
        }
    }

    private fun setConfigByRequestInfoTypeAutoDetectBrandMethod(){
        Config.CHECKOUT_ID = request.checkoutId ;
        Config.PAYMENT_BUTTON_BRAND =  "";
        Config.PAYMENT_BRANDS =  linkedSetOf(   ) ;
        if(request.isLive ) {
            Config.mode =     Connect.ProviderMode.LIVE;
        } else {
            Config.mode =     Connect.ProviderMode.TEST;
        }
    }


    //----------------------------------------------------------------------  setter

    private fun setterActivityResult() {
        checkoutLauncher   =     activityCompat.registerForActivityResult(
            CheckoutActivityResultContract()
        ) {
                result: CheckoutActivityResult -> HyperpayFlutterChannelController.handleCheckoutActivityResult(result)
        }
    }

    private fun getCreateCheckoutSettings(  ): CheckoutSettings {
        var checkoutSettings =  CheckoutSettings(
            Config.CHECKOUT_ID,
            Config.PAYMENT_BRANDS,
            Config.mode)
            .setSkipCVVMode(CheckoutSkipCVVMode.FOR_STORED_CARDS)
//            .setGooglePayPaymentDataRequestJson(getGooglePayPaymentDataRequestJson())

            // set broadcast receiver name
            .setComponentName(
                ComponentName(
                    activityCompat.packageName, CheckoutBroadcastReceiver::class.java.name)
            )
        checkoutSettings.isTotalAmountRequired = true  //show price with button

        if( request.brandName != "auto") {
            checkoutSettings.setPaymentButtonBrand( Config.PAYMENT_BUTTON_BRAND )
        }

        Log.i("abdo", "setupHyperpayFromDocs() - checkoutSettings:  " +  checkoutSettings  );
        Log.i("abdo","getCreateCheckoutSettings() - checkoutId: " + Config.CHECKOUT_ID);
        Log.i("abdo","getCreateCheckoutSettings() - setComponentName.ComponentName: " + activityCompat.packageName);
        return  checkoutSettings;
    }



    private fun handleCheckoutActivityResult(result: CheckoutActivityResult) {
        Log.i("abdo", "handleCheckoutActivityResult() - describeContents: ${result.describeContents()}")
        Log.i("abdo", "handleCheckoutActivityResult() - isErrored: ${result.isErrored }")
        Log.i("abdo", "handleCheckoutActivityResult() - isCanceled: ${result.isCanceled }")
        Log.i("abdo", "handleCheckoutActivityResult() - paymentError: ${result.paymentError}")
        Log.i("abdo", "handleCheckoutActivityResult() - transaction: ${result.transaction}")
        Log.i("abdo", "handleCheckoutActivityResult() - transaction.describeContents: ${result.transaction?.describeContents()}")
        Log.i("abdo", "handleCheckoutActivityResult() - transaction.paymentParams.shopperResultUrl: ${result.transaction?.paymentParams?.shopperResultUrl}")
        Log.i("abdo", "handleCheckoutActivityResult() - transaction.paymentParams.paymentBrand: ${result.transaction?.paymentParams?.paymentBrand}")
        Log.i("abdo", "handleCheckoutActivityResult() - transaction.paymentParams.checkoutId: ${result.transaction?.paymentParams?.checkoutId}")
        Log.i("abdo", "handleCheckoutActivityResult() - transaction.transactionType: ${result.transaction?.transactionType}")
        Log.i("abdo", "handleCheckoutActivityResult() - transaction.redirectUrl: ${result.transaction?.redirectUrl}")

        /// case user click "Back button"
        if( result.isCanceled ) return fireToFlutterCompleteFailed();

        // case found error in  request or checkout id is null
        if( result.isErrored ) return fireToFlutterCompleteFailed();
        if( result.transaction == null ) return fireToFlutterCompleteFailed();
        var isMissedCheckoutID = result.transaction?.paymentParams?.checkoutId == null  ;
        if( isMissedCheckoutID ) return fireToFlutterCompleteFailed();

        /// now it's good, to check by server, api check status
        fireToFlutterCompleteSuccessWhileNeedCheckStatus();
    }


}


