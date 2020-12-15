import 'package:ask_away/services/Auth.dart';
import 'package:ask_away/services/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
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
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "More Options.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
              _launchURL();
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

  void _launchURL() async {
    const url = 'https://github.com/FEUP-ESOF-2020-21/open-cx-t1g2-escama';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


