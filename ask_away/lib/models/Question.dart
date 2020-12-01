import 'AppUser.dart';
import 'Vote.dart';

class Question {
  String id;
  String text;
  int votes;
  User _author;

  Question(String text, int votes, String id) {
    this.text = text;
    this.votes = votes;
    this.id = id;
  }

  int getTotalVotes() {
    return votes;
  }

}
