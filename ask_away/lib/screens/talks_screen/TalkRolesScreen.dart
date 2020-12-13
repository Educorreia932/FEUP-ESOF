import 'package:ask_away/components/cards/RoleCard.dart';
import 'package:ask_away/models/AppUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TalkQuestionsScreen.dart';

class TalkRolesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TalkRolesScreenState();
}

class TalkRolesScreenState extends State<TalkRolesScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('Users').get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<User> users = [];

          snapshot.data.docs.forEach(
            (document) {
              List<dynamic> userScheduledTalks = document.data()["scheduled"];

              if (userScheduledTalks.contains("XWvNTQsEilhhKYhZfm25")) users.add(User.fromData(document.data()));
            },
          );

          return Scaffold(
            appBar: QuestionsScreenAppBar(context),
            body: Container(
              color: Color(0xFFECECEC),
              child: ListView(
                children: users.map<RoleCard>((User user) => RoleCard(user)).toList(),
              ),
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
