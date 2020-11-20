import 'package:flutter/material.dart';

final loginController = TextEditingController();
final passwordController = TextEditingController();

Widget EntryField(String title, {bool isPassword = false}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: isPassword ? passwordController : loginController,
          obscureText: isPassword,
          decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true),
        )
      ],
    ),
  );
}
