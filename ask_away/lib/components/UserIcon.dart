import 'package:ask_away/screens/user_profile/UserProfile.dart';
import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50,
        backgroundImage: AssetImage('assets/images/avatar.png'),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfile()),
        );
      },
    );
  }
}
