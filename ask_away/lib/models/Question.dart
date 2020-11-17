import 'Vote.dart';

class Question {
  int id;
  String text;
  List<Vote> votes;

  Question(String text) {
    this.text = text;
    this.votes = new List<Vote>();
  }

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

  int getPosVotes() {
    int total = 0;
    for (int i = 0; i < votes.length; i++) {
      if (votes[i].type == VoteType.up) total++;
    }
    return total;
  }

  int getNegVotes() {
    int total = 0;
    for (int i = 0; i < votes.length; i++) {
      if (votes[i].type == VoteType.up) total++;
    }
    return total;
  }
}
