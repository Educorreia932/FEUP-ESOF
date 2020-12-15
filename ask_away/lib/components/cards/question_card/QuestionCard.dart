import 'package:ask_away/models/Question.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';

import 'VotingComponent.dart';

class QuestionCard extends StatefulWidget {
  Question _question;
  Function _callback;

  QuestionCard(this._question, this._callback);

  @override
  State<StatefulWidget> createState() => QuestionCardState();
}

class QuestionCardState extends State<QuestionCard> {
  String questionUser = "";
  bool loaded = false;

  void deleteQuestion(){
    print("Deleting question: ");
    print(this.widget._question.id);
    String questionToRemove = this.widget._question.id;
    FirebaseFirestore.instance.collection('Questions').doc(questionToRemove).delete().then((value) => this.widget._callback(questionToRemove));
  }

  void acceptQuestion(){
    print("Accept question: ");
    print(this.widget._question.id);
    String questionToRemove = this.widget._question.id;
    FirebaseFirestore.instance.collection('Questions').doc(questionToRemove).update({"accepted": true}).then((value) {this.widget._callback("none"); this.widget._question.accepted = true;setState(() {
    });});
  }

  void getQuestionUser()
  {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(this.widget._question.user)
          .snapshots()
          .first
          .then((value)
          {
            questionUser = value["username"];
            setState(() {loaded=true;});
          }
      );
  }

  @override
  Widget build(BuildContext context) {
    if(!loaded) {
      getQuestionUser();
    }
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
                  questionUser,
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
                if(!this.widget._question.accepted)
                  Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            size: 28,
                            color: Color(0xFFFF5656),
                          ),
                          onPressed: () => this.acceptQuestion(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.cancel_sharp,
                            size: 28,
                            color: Color(0xFFFF5656),
                          ),
                          onPressed: () => this.deleteQuestion(),
                        )
                      ]
                  )
                else if(currentUser == this.widget._question.user)
                  IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      size: 28,
                      color: Color(0xFFFF5656),
                    ),
                    onPressed: () => this.deleteQuestion(),
                  )
                ,
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
