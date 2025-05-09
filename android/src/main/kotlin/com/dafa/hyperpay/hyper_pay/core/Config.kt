package com.dafa.hyperpay.hyper_pay.core

import com.oppwa.mobile.connect.provider.Connect




// the configuration values to change across the app
object Config {

    var  CHECKOUT_ID = "" //example: "5C6FF379D6F36C4DC498FFDC8E5EC79E.prod01-vm-tx17"
    var mode : Connect.ProviderMode =  Connect.ProviderMode.LIVE;
    var PAYMENT_BUTTON_BRAND = "" //example "VISA" in type single brand method

    // the payment brands for Ready-to-Use UI and Payment Button
    /**
     * case auto detect
     * //linkedSetOf("VISA", "MASTER", "MADA", "GOOGLEPAY")
     *
     * case single brand
     * //linkedSetOf("VISA" )
     */
    var PAYMENT_BRANDS =  linkedSetOf<String>()


}