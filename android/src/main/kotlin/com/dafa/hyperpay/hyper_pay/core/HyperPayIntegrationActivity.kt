package com.dafa.hyperpay.hyper_pay.core

//import androidx.activity.enableEdgeToEdge
//import com.dafa.hyperpay.hyper_pay.hyper_pay.R
import android.os.Bundle
import android.util.Log
import android.widget.ImageView
import androidx.appcompat.app.AppCompatActivity
import com.dafa.hyperpay.hyper_pay.R
import com.dafa.hyperpay.hyper_pay.core.flutter.HyperpayFlutterChannelController
import com.dafa.hyperpay.hyper_pay.core.flutter.HyperpayFlutterRequest


class HyperPayIntegrationActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        enableEdgeToEdge()
        setContentView(R.layout.activity_hyperpay_integration)


        buttonDimissWhenClickArroundArea();
//        btnTest();

        initHyperPay();
    }

    //----------------------------------------------------------------- setup

    private fun initHyperPay() {

        /// from channel flutter get
        val request = intent.getSerializableExtra("hyperpayRequest") as? HyperpayFlutterRequest
        Log.i("abdo hyperpay", "initHyperPay() - request: $request");

//        var request = HyperpayFlutterRequest(
//            "FB202236B99B04D7214D9CC7948582F5.uat01-vm-tx02",
//            1.0 ,
//            "VISA" ,
//            false
//        );
        if (request != null) {
            HyperpayFlutterChannelController.setup(this,   request )
            // show
            HyperpayFlutterChannelController.showCheckoutUI(    );
        } else {
            Log.i("abdo hyperpay", "initHyperPay() - request is null ");
            HyperpayFlutterChannelController.fireToFlutterCompleteFailed();
        }

    }


    //----------------------------------------------------------------- draw ui

    private fun buttonDimissWhenClickArroundArea() {
        var viewDismissAllScreen  : ImageView = findViewById(R.id.viewDismissAllScreen);
        viewDismissAllScreen.setOnClickListener {

            HyperpayFlutterChannelController.fireToFlutterCompleteFailed();
        }
    }

}