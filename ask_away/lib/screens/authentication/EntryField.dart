import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'RegisterScreen.dart';

String validateEmail(String value) {
  return value.isEmpty ? 'Email can\'t be empty' : null;
}

String validatePassword(String value) {
  return value.isEmpty ? 'Password can\'t be empty' : null;
}

enum FormType {
  LOGIN,
  REGISTER
}

enum EntryFieldType {
  EMAIL,
  USERNAME,
  PASSWORD,
}

Widget EntryField(EntryFieldType entryFieldType, FormType formType) {
  String _title;
  bool _obscured = false;
  Function _validator;
  Function _setter;

  switch (entryFieldType) {
    case EntryFieldType.EMAIL:
      _title = "E-Mail";
      _validator = validateEmail;
      _setter = formType == FormType.LOGIN? loginSetEmail : registerSetEmail;
      break;
    case EntryFieldType.USERNAME:
      _title = "Username";
      _setter = registerSetUsername;
      break;
    case EntryFieldType.PASSWORD:
      _title = "Password";
      _obscured = true;
      _validator = validatePassword;
      _setter = formType == FormType.LOGIN? loginSetPassword : registerSetPassword;
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
          key: _title == "E-Mail" ? Key("emailfield") : _title == "Password" ? Key("passfield") : Key("userfield"),
          obscureText: _obscured,
          validator: _validator,
          onSaved: (String value) {
            _setter(value);
          },
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
