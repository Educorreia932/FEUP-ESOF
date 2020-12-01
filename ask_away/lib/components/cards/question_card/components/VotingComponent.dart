import 'package:ask_away/models/Vote.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VotingComponent extends StatefulWidget {
  int votes;
  Function callback;
  Function upvote;
  Function downvote;

  int getTotalVotes() {
    return votes;
  }

  VotingComponent(this.votes , this.callback, this.upvote, this.downvote);

  @override
  _VotingComponentState createState() => new _VotingComponentState();
}

class _VotingComponentState extends State<VotingComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.keyboard_arrow_up),
          iconSize: 30,
          onPressed: () => setState(
                () {
              this.widget.upvote();
              this.widget.callback();
            },
          ),
        ),
        Text(
          (this.widget.getTotalVotes()).toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        IconButton(
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 30,
          onPressed: () => setState(
                () {
              this.widget.downvote();
              print(this.widget.votes);
              this.widget.callback();
            },
          ),
        ),
      ],
    );
  }
}