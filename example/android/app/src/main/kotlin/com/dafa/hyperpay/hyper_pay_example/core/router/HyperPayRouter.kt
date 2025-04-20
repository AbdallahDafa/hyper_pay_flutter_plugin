package com.dafa.hyperpay.hyper_pay_example.core.router

import android.content.Context
import android.content.Intent
import com.dafa.hyperpay.hyper_pay_example.core.HyperPayIntegrationActivity
import com.dafa.hyperpay.hyper_pay_example.core.flutter.HyperpayFlutterRequest

object HyperPayRouter {


    fun openHyperPayDialog(context : Context, request: HyperpayFlutterRequest ) {
        val intent = Intent(context, HyperPayIntegrationActivity::class.java)
        intent.putExtra("hyperpayRequest", request)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)
    }
}