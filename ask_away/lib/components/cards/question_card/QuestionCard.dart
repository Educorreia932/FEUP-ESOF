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
  void upvote()
  {
    User user;
    String questionID = this.widget._question.id;
    DocumentReference userRef = FirebaseFirestore.instance.collection('Users')
        .doc(currentUser);
    FirebaseFirestore.instance.runTransaction((transaction)  {
      return
      userRef.get()
          .then((value) {
        user = new User(value.data()["username"], value.data()["Reputation"],
            value.data()["votes"]);
        DocumentReference docRef = FirebaseFirestore.instance.collection(
            "Questions").doc(questionID);

        print("Antes");
        print(user.votes);

        if (!user.votes.containsKey(questionID)) {
          docRef.update({"votes": FieldValue.increment(1)});
          this.widget._question.votes++;

          user.votes[questionID] = 1;
          userRef.update(
              {"votes": user.votes}
          );
        }
        else {
          if (user.votes[questionID] == 1) {
            docRef.update({"votes": FieldValue.increment(-1)});
            this.widget._question.votes--;

            user.votes.remove(questionID);
            userRef.update(
                {"votes": user.votes}
            );
          }
          else {
            docRef.update({"votes": FieldValue.increment(2)});
            this.widget._question.votes += 2;

            user.votes[questionID] = 1;
            userRef.update(
                {"votes": user.votes}
            );
          }
        }
        print("Depois");
        print(user.votes);
        this.widget._callback();
      });
      // Get document reference
    });
  }
  void downvote()
  {
    User user;
    String questionID = this.widget._question.id;
    DocumentReference userRef = FirebaseFirestore.instance.collection('Users')
        .doc(currentUser);
    FirebaseFirestore.instance.runTransaction((transaction)  {
      return
        userRef.get()
            .then((value) {
          user = new User(value.data()["username"], value.data()["Reputation"],
              value.data()["votes"]);
          DocumentReference docRef = FirebaseFirestore.instance.collection(
              "Questions").doc(questionID);

          print("Antes");
          print(user.votes);

          if (!user.votes.containsKey(questionID)) {
            docRef.update({"votes": FieldValue.increment(-1)});
            this.widget._question.votes--;

            user.votes[questionID] = -1;
            userRef.update(
                {"votes": user.votes}
            );
          }
          else {
            if (user.votes[questionID] == -1) {
              docRef.update({"votes": FieldValue.increment(1)});
              this.widget._question.votes++;

              user.votes.remove(questionID);
              userRef.update(
                  {"votes": user.votes}
              );
            }
            else {
              docRef.update({"votes": FieldValue.increment(-2)});
              this.widget._question.votes -= 2;

              user.votes[questionID] = -1;
              userRef.update(
                  {"votes": user.votes}
              );
            }
          }
          print("Depois");
          print(user.votes);
          this.widget._callback();
        });
      // Get document reference
    });
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


