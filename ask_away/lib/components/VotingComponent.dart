import 'package:ask_away/models/Vote.dart';
import 'package:flutter/material.dart';

class Voting extends StatefulWidget {
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

  Voting(this.votes, this.callback);

  @override
  _VotingState createState() => new _VotingState();
}

class _VotingState extends State<Voting> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      Material(
        color: Colors.transparent,
        child: IconButton(
            splashRadius: 15,
            icon: Icon(Icons.keyboard_arrow_up),
            onPressed: () => setState(() {
              this.widget.votes.add(new Vote(VoteType.up));
              this.widget.callback();
            })),
      ),
      Text((this.widget.getTotalVotes()).toString(),
          style: TextStyle(color: Colors.black)),
      Material(
        color: Colors.transparent,
        child: IconButton(
            splashRadius: 15,
            icon: Icon(Icons.keyboard_arrow_down),
            onPressed: () => setState(() {
              this.widget.votes.add(new Vote(VoteType.down));
              this.widget.callback();
            })),
      ),
    ]);
  }
}