import 'package:ask_away/components/cards/TalkCard.dart';
import 'package:ask_away/screens/authentication/components/EntryField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ask_away/screens/talks_screen/TalksScreen.dart';
import 'package:ask_away/models/Talk.dart';

class CreateTalkScreen extends StatefulWidget {
  @override
  State<CreateTalkScreen> createState() => CreateTalkScreenState();
}

class CreateTalkScreenState extends State<CreateTalkScreen> {
  List<Talk> talks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScheduleAppBar(context),
      body: Container(
        color: Color(0xFFECECEC),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Schedule new Talk",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addTalk(String title, String description, DateTime date, String location, int duration) {
    if (title != "" && description != "" && date != null && location != "" && duration != null) {
      // Call the user's CollectionReference to add a new user
      FirebaseFirestore.instance
          .collection('Talks')
          .add({'title': title, 'description' : description, 'date' : date, 'location' : location, 'duration':duration});
      //.then((value) => setState(() {
      //talks.add(new Talk(value.id, title, description, date, location, duration));
      //}));
    }
  }
}
