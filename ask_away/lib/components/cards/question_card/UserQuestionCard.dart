import 'package:ask_away/models/Question.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';

import 'VotingComponent.dart';

class UserQuestionCard extends StatefulWidget {
  Question _question;
  String username;

  UserQuestionCard(this._question, this.username);

  @override
  State<StatefulWidget> createState() => UserQuestionCardState();
}

class UserQuestionCardState extends State<UserQuestionCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.widget.username,
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
              ],
            ),
            RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                text: widget._question.text,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF979797),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
