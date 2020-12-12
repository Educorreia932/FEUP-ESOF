import 'package:ask_away/components/cards/RoleCard.dart';
import 'package:ask_away/models/AppUser.dart';
import 'package:ask_away/models/Talk.dart';
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
    List<User> users = [];

    FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((value) {
          value.docs.forEach((document) {
            print(document.data());
          });
        });

    return Scaffold(
      appBar: QuestionsScreenAppBar(context),
      body: Container(
        child: Column(
          children: users.map<RoleCard>((User user) => RoleCard(user)).toList(),
        ),
      ),
    );
  }
}

