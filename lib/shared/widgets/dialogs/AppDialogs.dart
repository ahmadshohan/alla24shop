import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static successOrderDialog(BuildContext context) {
    return showModal(
        configuration: FadeScaleTransitionConfiguration(
            transitionDuration: Duration(milliseconds: 400),
            reverseTransitionDuration: Duration(milliseconds: 400)),
        context: context,
        builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: Text('Success order',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                )),
            content: Text(
              'Your order has been successfully added',
            )));
  }
}
