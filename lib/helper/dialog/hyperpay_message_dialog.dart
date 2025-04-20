import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hyper_pay/helper/log/Log.dart';


typedef MessageOkButtonOnPress = Function();

class HyperPayMessageDialog {


  static show(BuildContext context, String title, String msg, {
    MessageOkButtonOnPress? okButtonOnPress
  } ) async {
    Log.i("MessageDialog - show() - title: $title /msg: $msg");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                if(okButtonOnPress != null ) okButtonOnPress();
                // Do something if needed
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}