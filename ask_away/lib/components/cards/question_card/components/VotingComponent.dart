import 'package:ask_away/models/Vote.dart';
import 'package:flutter/material.dart';

class VotingComponent extends StatefulWidget {
  List<Vote> votes;
  Function callback;

  int getTotalVotes() {
    int total = 0;

    for (int i = 0; i < votes.length; i++) {
      if (votes[i].type == VoteType.up)
        total++;
      else
        total--;
    }

    return total;
  }

  VotingComponent(this.votes, this.callback);

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
              this.widget.votes.add(new Vote(VoteType.up));
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
              this.widget.votes.add(new Vote(VoteType.down));
              this.widget.callback();
            },
          ),
        ),
      ],
    );
  }
}