import 'package:alla24/colors.dart';
import 'package:flutter/material.dart';

class JOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const JOutlineButton(
      {Key key, this.onPressed, this.text, this.color = Alla24Colors.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: OutlineButton(
          onPressed: onPressed,
          borderSide: BorderSide(color: color),
          textColor: color,
          highlightedBorderColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          )),
    );
  }
}
