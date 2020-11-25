import 'package:ask_away/components/cards/TalkCard.dart';
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
                  children: talks
                      .map<TalkCard>((Talk talk) => TalkCard(talk))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}