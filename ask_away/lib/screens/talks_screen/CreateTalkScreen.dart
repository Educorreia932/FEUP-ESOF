import 'package:ask_away/components/SimpleButton.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ask_away/screens/talks_screen/TalksScreen.dart';
import 'package:ask_away/models/Talk.dart';

import 'components/TalkEntryField.dart';

String _title;
String _description;
String _location;
DateTime _startdate;
DateTime _enddate;
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

void talkSetStartDate(String date) {
  _startdate = DateTime.parse(date);
}

void talkSetEndDate(String date) {
  _enddate = DateTime.parse(date);
}

class CreateTalkScreenState extends State<CreateTalkScreen> {
  List<Talk> talks = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      if (_startdate.isBefore(_enddate)) {
        _duration = _enddate.difference(_startdate).inMinutes;
        return true;
      }
      //else Scaffold.of(context).showSnackBar(SnackBar(content: Text('End Date must be after Start Date')));
    }

    return false;
  }

  bool validateAndSubmit() {
    if (validateAndSave()) {
      return addTalk(_title, _description, _startdate, _location, _duration);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScheduleAppBar(context),
      body: Container(
          color: Color(0xFFECECEC),
          //child: ScrollConfiguration(
          // behavior: MyBehavior(),
          child: Form(
            key: formKey,
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
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: TalkEntryField(TalkEntryFieldType.TITLE),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: TalkEntryField(TalkEntryFieldType.DESCRIPTION),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: TalkEntryField(TalkEntryFieldType.LOCATION),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: TalkEntryField(TalkEntryFieldType.STARTDATE),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: TalkEntryField(TalkEntryFieldType.ENDDATE),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  bottom: 40,
                  top: 40,
                ),
                child: Builder(
                  builder: (context1) {
                    return SimpleButton(
                      "Submit talk",
                          () {
                        if (validateAndSubmit()) {
                          Scaffold.of(context1)
                              .showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Talk submitted successfuly")));
                        } else {
                          Scaffold.of(context1)
                              .showSnackBar(SnackBar(backgroundColor: Colors.red,
                                content: Text("Invalid talk info")));
                        }
                      },
                      37,
                      Color(0xFFE11D1D),
                    );
                  },
                )
              ),
            ]),
          )),
    );
  }

  bool addTalk(String title, String description, DateTime date, String location,
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
        'duration': duration,
        'creator': currentUser,
        'ocupation': 0,
      });
      return true;
    }
    return false;
  }
}
