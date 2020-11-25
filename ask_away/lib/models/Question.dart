import 'AppUser.dart';
import 'Vote.dart';

class Question {
  int id;
  String text;
  List<Vote> votes;
  User _author;

  Question(String text, List<Vote> votes) {
    this.text = text;
    this.votes = votes;
  }

  int getTotalVotes() {
    int total = 0;

    for (int i = 0; i < votes.length; i++)
      if (votes[i].type == VoteType.up)
        total++;
      else
        total--;

    return total;
  }

  int getUpVotes() {
    int total = 0;

    for (int i = 0; i < votes.length; i++)
      if (votes[i].type == VoteType.up) total++;

    return total;
  }

  int getDownVotes() {
    int total = 0;
    for (int i = 0; i < votes.length; i++)
      if (votes[i].type == VoteType.up) total++;

    return total;
  }
}
