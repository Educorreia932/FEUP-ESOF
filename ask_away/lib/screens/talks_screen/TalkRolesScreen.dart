import 'package:ask_away/components/cards/RoleCard.dart';
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
    return Scaffold(
      appBar: QuestionsScreenAppBar(context),
      body: Container(
        child: Column(
          children: [
            RoleCard()
          ],
        ),
      ),
    );
  }
}

