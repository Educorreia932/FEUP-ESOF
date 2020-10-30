import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'Vote.dart';

class Question {
  int id;
  String text;
  List<Vote> votes;

  Question(String text) {
    this.text = text;
    this.votes = new List<Vote>();
  }
}

class QuestionWidget extends StatelessWidget {
  Question question;
  Voting voting;

  QuestionWidget(Question question) {
    this.question = question;
    voting = new Voting(question.votes);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: new EdgeInsets.all(5),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(11)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(children: <Widget>[
          voting,
          Align(
              alignment: Alignment.centerLeft,
              child: Text(question.text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        ]),
      ),
      onTap: questionMenu,
    );
  }
}

class Voting extends StatefulWidget {
  List<Vote> votes;
  int upvoteCount, downvoteCount;

  Voting(List<Vote> votes) {
    this.votes = votes;
  }

  int getVoteCount() {
    return upvoteCount - downvoteCount;
  }

  void vote(VoteType type) {
    type == VoteType.up ? upvoteCount++ : downvoteCount++;
  }

  @override
  _VotingState createState() => new _VotingState();
}

class _VotingState extends State<Voting> {
  int _upvoteCount = 0;
  int _downvoteCount = 0;

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      Material(
        color: Colors.transparent,
        child: IconButton(
            splashRadius: 15,
            icon: Icon(Icons.keyboard_arrow_up),
            onPressed: () => setState(() => _upvoteCount++)),
      ),
      Text((_upvoteCount - _downvoteCount).toString(),
          style: TextStyle(color: Colors.black)),
      Material(
        color: Colors.transparent,
        child: IconButton(
            splashRadius: 15,
            icon: Icon(Icons.keyboard_arrow_down),
            onPressed: () => setState(() => _downvoteCount++)),
      ),
    ]);
  }
}

void questionMenu() {
  print("I was called\n");
  return;
}
