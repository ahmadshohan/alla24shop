import 'package:alla24/colors.dart';
import 'package:flutter/material.dart';

class JRaisedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const JRaisedButton({
    Key key,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: Alla24Colors.button,
        textColor: Alla24Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ));
  }
}
