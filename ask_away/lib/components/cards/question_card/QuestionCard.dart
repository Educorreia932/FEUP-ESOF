import 'package:ask_away/models/Question.dart';
import 'package:flutter/material.dart';

import 'components/VotingComponent.dart';

class QuestionCard extends StatefulWidget {
  Question _question;
  Function _callback;

  QuestionCard(this._question, this._callback);

  @override
  State<StatefulWidget> createState() => QuestionCardState();
}

class QuestionCardState extends State<QuestionCard> {
  void upvote()
  {
    this.widget._question.votes++;
  }
  void downvote()
  {
    this.widget._question.votes--;
  }
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
                  "Educorreia932",
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
                Icon(
                  Icons.bookmark_border,
                  size: 27,
                  color: Color(0xFFFF5656),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VotingComponent(widget._question.votes, widget._callback, this.upvote, this.downvote),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: "33 minutes",
                        style: TextStyle(
                          color: Color(0xFFFF5656),
                        ),
                      ),
                      TextSpan(
                        text: " ago",
                        style: TextStyle(
                          color: Color(0xFF979797),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


