import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {

}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(),
          Container(
            height: 300.0,
            color: Colors.blue,
          ),
          // Top Bar
        ],
      ),
    );
  }
}