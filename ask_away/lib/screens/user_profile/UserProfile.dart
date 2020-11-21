import 'package:ask_away/components/UserIcon.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => new UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserProfileAppBar(context),
      body: Column(
        children: [
          Container(
            color: Color(0xFFECECEC),
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      UserIcon(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Eduardo Correia",
                            style: TextStyle(
                              fontSize: 35,
                            ),
                          ),
                          Text(
                            "Asking questions",
                            style: TextStyle(
                              color: Color(0xFFC8C8C8),
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reputation",
                            style: TextStyle(
                              color: Color(0xFFE11D1D),
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            "159",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFECECEC),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  SectionHeader("Asked Questions", 5),
                  Column(
                    children: [
                      QuestionCard(),
                      SizedBox(
                        height: 10,
                      ),
                      QuestionCard(),
                    ],
                  ),
                  SectionHeader("Answers", 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget UserProfileAppBar(BuildContext context) {
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
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        },
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(
          right: 20,
        ),
        child: new IconButton(
          icon: new Icon(
            Icons.bookmark,
            size: 40,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
        ),
      ),
    ],
  );
}

class SectionHeader extends StatelessWidget {
  String _title;
  int _value;

  SectionHeader(String title, int value) {
    _title = title;
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          _title,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        SizedBox(width: 15),
        Text(
          _value.toString(),
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFFE11D1D),
          ),
        ),
      ],
    );
  }
}

class QuestionCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuestionCardState();
}

class QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Educorreia932",
              style: TextStyle(
                fontSize: 21,
              ),
            ),
            RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                text:
                    "What is the answer to the ultimate question of life, the universe and everything?",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFF979797),
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: null,
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    size: 30,
                  ),
                ),
                Text(
                  "24",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: null,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 30,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
