package com.dafa.hyperpay.hyper_pay.core.receiver

import android.content.BroadcastReceiver
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.util.Log
import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity
import com.oppwa.msa.model.response.CheckoutCreationResponse


class CheckoutBroadcastReceiver : BroadcastReceiver() {

    private var context: Context? = null
    private var senderComponent: ComponentName? = null

    override fun onReceive(context: Context?, oldIntent: Intent?) {
        this.context = context
        val action = oldIntent?.action
        Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - onReceive() - oldIntent: " + oldIntent);
        Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - onReceive() - oldIntent.action: " + oldIntent?.action.toString());
        Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - onReceive() - oldIntent.extras: " + oldIntent?.extras);
        if (CheckoutActivity.ACTION_ON_BEFORE_SUBMIT == action) {
            handleOnBeforeSubmit(oldIntent)
        }
    }

    private fun handleOnBeforeSubmit(oldIntent: Intent) {
        val paymentBrand = oldIntent.getStringExtra(CheckoutActivity.EXTRA_PAYMENT_BRAND)
        Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - onReceive() - paymentBrand: " + paymentBrand);
        senderComponent = oldIntent.getParcelableExtra(CheckoutActivity.EXTRA_SENDER_COMPONENT_NAME)
        Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - onReceive() - senderComponent: " + senderComponent);

        if (isPaymentBrandWithExtraParameters(paymentBrand)) {
            Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - onReceive() - type isPaymentBrandWithExtraParameters " );
            if ("AFTERPAY_PACIFIC" == paymentBrand) {
                requestCheckoutIdForAfterpay()
            }
        } else {
            Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - onReceive() - type EXTRA_CHECKOUT_ID " );
            startCheckoutActivity(oldIntent.getStringExtra(CheckoutActivity.EXTRA_CHECKOUT_ID))
        }
    }

    private fun isPaymentBrandWithExtraParameters(paymentBrand: String?): Boolean {
        return "ONEY" == paymentBrand
                || "AFTERPAY_PACIFIC" == paymentBrand
    }

    // pay attention that we are using different amount and currency for ONEY and AFTERPAY_PACIFIC
    // for the new checkoutId, it is required due to external simulators which have specific configurations
    private fun requestCheckoutIdForAfterpay() {
        Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - requestCheckoutIdForAfterpay() - call" );
//        MerchantServerApplication.requestCheckoutId(
//            MerchantServerApplication.getDefaultAuthorization(),
//            Constants.Config.AFTERPAY_AMOUNT,
//            Constants.Config.AFTERPAY_CURRENCY,
//            "PA",
//            getAfterpayExtraParameters(),
//            this::handleCheckoutId
//        )
    }

    private fun getAfterpayExtraParameters(): Map<String, String> {
        Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - getAfterpayExtraParameters() - call" );
        val parameters: MutableMap<String, String> = HashMap()
//
        parameters["testMode"] = "EXTERNAL"
//        parameters.putAll(Utils().getParametersFromFile(
//            context!!, Constants.Config.AFTERPAY_PARAMETERS_FILE))

        return parameters
    }

    private fun handleCheckoutId(response: CheckoutCreationResponse?, error: String?) {
        Log.i("abdo_hyperpay","CheckoutBroadcastReceiver - handleCheckoutId() - call" );
        if (error != null) {
            Log.i("abdo", error)
        }
        startCheckoutActivity(response!!.ndc)
    }

    private fun startCheckoutActivity(checkoutId: String?) {
        Log.i("abdo","CheckoutBroadcastReceiver - startCheckoutActivity() - checkoutId: $checkoutId" );
        Log.i("abdo","CheckoutBroadcastReceiver - startCheckoutActivity() - senderComponent: $senderComponent" );

        // this callback can be used to request a new checkout ID if selected payment brand requires
        // some specific parameters or just send back the same checkout id to continue checkout process
        val intent = Intent(CheckoutActivity.ACTION_ON_BEFORE_SUBMIT)
        intent.component = senderComponent
        intent.setPackage(senderComponent?.packageName)

        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        if (checkoutId != null) {
            intent.putExtra(CheckoutActivity.EXTRA_CHECKOUT_ID, checkoutId)
        }

        // also it can be used to cancel the checkout process by sending
        // the CheckoutActivity.EXTRA_CANCEL_CHECKOUT
        intent.putExtra(CheckoutActivity.EXTRA_TRANSACTION_ABORTED, false)

        context?.startActivity(intent)
    }
}