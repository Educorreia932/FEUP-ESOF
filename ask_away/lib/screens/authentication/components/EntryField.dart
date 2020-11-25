import 'package:flutter/material.dart';

enum EntryFieldType {
  EMAIL,
  USERNAME,
  PASSWORD,
}

final emailController = TextEditingController();
final usernameController = TextEditingController();
final passwordController = TextEditingController();

Widget EntryField(EntryFieldType entryFieldType) {
  String _title;
  bool _obscured = false;
  TextEditingController _controller;

  switch (entryFieldType) {
    case EntryFieldType.EMAIL:
      _title = "E-Mail";
      _controller = emailController;
      break;
    case EntryFieldType.USERNAME:
      _title = "Username";
      _controller = usernameController;
      break;
    case EntryFieldType.PASSWORD:
      _title = "Password";
      _controller = passwordController;
      _obscured = true;
      break;
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _title,
          style: TextStyle(
            fontSize: 35,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _controller,
          obscureText: _obscured,
          decoration: InputDecoration(
            fillColor: Color(0xFFE5E5E5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
