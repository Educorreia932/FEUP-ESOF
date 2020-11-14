import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  _userIcon(),
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
            title: Text('Talks',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
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
        ],
      ),
    );
  }
}


Widget _userIcon() {
  return InkWell(
    onTap: _userProfile,
    child: CircleAvatar(
      radius: 30,
      backgroundImage: AssetImage('assets/avatar.jpg'),
      backgroundColor: Colors.transparent,
    ),
  );
}


void _userProfile() {
  print("Profile\n");
  return;
}