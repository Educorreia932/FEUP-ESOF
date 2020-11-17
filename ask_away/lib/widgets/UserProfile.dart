import 'package:ask_away/widgets/TopBar.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => new UserProfileState();
}

class UserProfileState extends State<UserProfile> {
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
          Align(
            child: Column(
              children: <Widget>[
                CircularProfileAvatar(
                  "https://i.pravatar.cc/300",
                  borderWidth: 4.0,
                ),
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          TopBar(),
        ],
      ),
    );
  }
}
