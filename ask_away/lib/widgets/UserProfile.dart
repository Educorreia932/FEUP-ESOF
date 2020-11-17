import 'package:ask_away/widgets/TopBar.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(),
          Container(),
          TopBar()
        ],
      )
    );
  }
}
