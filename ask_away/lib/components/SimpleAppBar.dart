import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:flutter/material.dart';

Widget SimpleAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: new IconButton(
        icon: new Icon(
          Icons.arrow_back,
          size: 40,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreenBuilder()),
          );
        },
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  );
}
