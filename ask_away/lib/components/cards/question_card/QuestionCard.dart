import 'package:ask_away/models/Question.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:ask_away/models/AppUser.dart';

import 'components/VotingComponent.dart';



class QuestionCard extends StatefulWidget {
  Question _question;
  Function _callback;


  QuestionCard(this._question, this._callback);

  @override
  State<StatefulWidget> createState() => QuestionCardState();
}



class QuestionCardState extends State<QuestionCard> {

  void deleteQuestion(){
    print("Deleting question: ");
    print(this.widget._question.id);
    String questionToRemove = this.widget._question.id;
    FirebaseFirestore.instance.collection('Questions').doc(questionToRemove).delete().then((value) => this.widget._callback(questionToRemove));
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
                if(currentUser == this.widget._question.user)
                  IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      size: 28,
                      color: Color(0xFFFF5656),
                    ),
                    onPressed: () => this.deleteQuestion(),
                  )
                ,
                IconButton(
                    icon: Icon(
                      Icons.bookmark_border,
                      size: 27,
                      color: Color(0xFFFF5656),
                    )
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
                VotingComponent(widget._question.votes, widget._callback, widget._question),
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
