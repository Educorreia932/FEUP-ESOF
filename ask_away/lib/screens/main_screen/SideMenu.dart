import 'package:ask_away/screens/authentication/LoginScreen.dart';
import 'package:ask_away/screens/authentication/RegisterScreen.dart';
import 'package:ask_away/services/Auth.dart';
import 'package:ask_away/services/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerComponent extends StatelessWidget {
  Future<void> logout(BuildContext context) async {
    final BaseAuth auth = AuthProvider.of(context).auth;
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Logged in as\n",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                    ),
                  ),
                  TextSpan(
                    text: "Educorreia932",
                    style: TextStyle(
                      color: Color(0xFFE11D1D),
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 35,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'About',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 35,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Log Out',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 35,
              ),
            ),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }
}
