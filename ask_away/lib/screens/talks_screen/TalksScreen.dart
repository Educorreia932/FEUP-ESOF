import 'package:ask_away/components/cards/TalkCard.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:flutter/material.dart';

class TalksScreen extends StatefulWidget {
  @override
  State<TalksScreen> createState() => TalksScreenState();
}

class TalksScreenState extends State<TalksScreen> {
  List<Talk> talks = [
    new Talk(
        "Ultimate talk",
        "What is the answer to the ultimate talk of life, the universe and everything?",
        new DateTime.utc(2020, 9, 11, 18, 30),
        "Earth"),
    new Talk(
        "Ultimate question",
        "What is the answer to the ultimate question of life, the universe and everything?",
        new DateTime.utc(2020, 9, 11, 18, 30),
        "Earth"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TalksScreenAppBar(context),
      body: Container(
        color: Color(0xFFECECEC),
        child: Column(
          children: [
            Container(
              child: Text(
                "Talks",
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: ListView(
                  children: talks.map<TalkCard>((Talk talk) => TalkCard(talk)).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget TalksScreenAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Color(0xFFECECEC),
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
    elevation: 0.0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(
          right: 20,
        ),
        child: new IconButton(
          icon: new Icon(
            Icons.sort,
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
    ],
  );
}
