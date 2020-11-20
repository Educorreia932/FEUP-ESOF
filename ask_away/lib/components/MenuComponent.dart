import 'package:ask_away/screens/MainScreen.dart';
import 'package:ask_away/screens/authentication/LoginScreen.dart';
import 'package:ask_away/screens/TalkScreen.dart';
import 'package:ask_away/screens/authentication/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/user_profile/UserProfileScreen.dart';
import '../main.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 100,
            child: DrawerHeader(
              child: Row(children: <Widget>[
                Column(children: <Widget>[
                  _UserIcon(context),
                ]),
                Container(
                  padding: new EdgeInsets.only(left: 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Mr. Padoru',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20))),
                ),
              ]),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Questions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Talks',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyTalksPage()),
              );
            },
          ),
          ListTile(
            title: Text('Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Login',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          ListTile(
            title: Text(
              'Register',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _UserIcon(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfile()),
      );
    },
    child: CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage('assets/images/avatar.jpg'),
      backgroundColor: Colors.transparent,
    ),
  );
}
