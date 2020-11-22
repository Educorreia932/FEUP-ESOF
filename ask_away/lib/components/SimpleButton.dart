import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  Text text;

  SimpleButton(String text) {
    this.text = Text(
      text,
      style: TextStyle(
        fontSize: 37,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: null,
        child: Container(
          height: 57,
          decoration: new BoxDecoration(
            color: Color(0xFFE11D1D),
            borderRadius: new BorderRadius.circular(14.0),
          ),
          child: Center(child: text),
        ),
      ),
    );
  }
}
