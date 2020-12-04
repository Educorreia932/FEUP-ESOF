import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  Text _text;
  Function _action;
  Color _backgroundColor;

  SimpleButton(String text, VoidCallback action, double fontSize, Color backgroundColor) {
    this._text = Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    );

    this._action = action;
    this._backgroundColor = backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: _action,
        child: Container(
          height: 57,
          decoration: new BoxDecoration(
            color: _backgroundColor,
            borderRadius: new BorderRadius.circular(14.0),
          ),
          child: Center(child: _text),
        ),
      ),
    );
  }
}
