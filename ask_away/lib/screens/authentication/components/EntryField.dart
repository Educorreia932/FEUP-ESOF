import 'package:flutter/material.dart';

enum EntryFieldType {
  EMAIL,
  USERNAME,
  PASSWORD,
}

Widget EntryField(EntryFieldType entryFieldType) {
  String _title;
  bool _obscured = false;

  switch (entryFieldType) {
    case EntryFieldType.EMAIL:
      _title = "E-Mail";
      break;
    case EntryFieldType.USERNAME:
      _title = "Username";
      break;
    case EntryFieldType.PASSWORD:
      _title = "Password";
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
        TextField(
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
