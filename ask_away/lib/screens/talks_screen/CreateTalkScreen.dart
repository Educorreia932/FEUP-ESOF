import 'package:ask_away/components/cards/TalkCard.dart';
import 'package:ask_away/screens/authentication/components/EntryField.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ask_away/screens/talks_screen/TalksScreen.dart';
import 'package:ask_away/models/Talk.dart';

import 'components/TalkEntryField.dart';

String _title;
String _description;
String _location;
DateTime _date;
int _duration;

class CreateTalkScreen extends StatefulWidget {
  @override
  State<CreateTalkScreen> createState() => CreateTalkScreenState();
}

void talkSetTitle(String title) {
  _title = title;
}

void talkSetDescription(String description) {
  _description = description;
}

void talkSetLocation(String location) {
  _location = location;
}

void talkSetDate(DateTime date) {
  _date = date;
}

class CreateTalkScreenState extends State<CreateTalkScreen> {
  List<Talk> talks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScheduleAppBar(context),
      body: Container(
        color: Color(0xFFECECEC),
        //child: ScrollConfiguration(
         // behavior: MyBehavior(),
          child: ListView(children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "Schedule new Talk",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
           Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/15, right: MediaQuery.of(context).size.width/15),
                child: TalkDatePicker(),
           ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/15, right: MediaQuery.of(context).size.width/15),
              child: TalkDatePicker(),
            ),
          ]
        ),
      ),
    );
  }

  void addTalk(String title, String description, DateTime date, String location,
      int duration) {
    if (title != "" &&
        description != "" &&
        date != null &&
        location != "" &&
        duration != null) {
      // Call the user's CollectionReference to add a new user
      FirebaseFirestore.instance.collection('Talks').add({
        'title': title,
        'description': description,
        'date': date,
        'location': location,
        'duration': duration
      });
      //.then((value) => setState(() {
      //talks.add(new Talk(value.id, title, description, date, location, duration));
      //}));
    }
  }
}
