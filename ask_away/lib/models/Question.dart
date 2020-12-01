import 'AppUser.dart';
import 'Vote.dart';

class Question {
  int id;
  String text;
  int votes;
  User _author;

  Question(String text, int votes) {
    this.text = text;
    this.votes = votes;
  }

  int getTotalVotes() {
    return votes;
  }

}
