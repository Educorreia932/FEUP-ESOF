import 'package:flutter/material.dart';

import 'components/QuestionCard.dart';

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => new UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('User Profile'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: SweepGradient(colors: [
            Colors.blue,
            Colors.lightBlue,
            Colors.teal,
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://i.pravatar.cc/300"),
                        radius: 35,
                      ),
                      Text(
                        "John Doe",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        color: Colors.lightBlue,
                        height: 20,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ]),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 242, 242, 1.0),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Recent Questions",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 150.0,
                          child: ListView(
                            padding: const EdgeInsets.only(right: 48),
                            scrollDirection: Axis.horizontal,
                            children: [
                              QuestionCard(),
                              QuestionCard(),
                              QuestionCard()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
