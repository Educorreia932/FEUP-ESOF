import 'package:ask_away/components/SimpleButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/EntryField.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            height: 200,
            padding: EdgeInsets.only(
              left: 35,
              right: 35,
            ),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    EntryField(EntryFieldType.USERNAME),
                    EntryField(EntryFieldType.PASSWORD),
                  ],
                ),
                SimpleButton("Login")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

