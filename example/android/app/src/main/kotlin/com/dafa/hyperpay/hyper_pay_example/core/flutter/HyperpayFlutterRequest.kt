package com.dafa.hyperpay.hyper_pay_example.core.flutter

import java.io.Serializable


data class HyperpayFlutterRequest(
    val checkoutId: String,
    val amount: Double,
    val brandName : String ,
    val isLive : Boolean
) : Serializable