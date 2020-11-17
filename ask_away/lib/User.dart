import 'Question.dart';
import 'Vote.dart';

class User {
  int id;
  String username;
  List<Question> askedQuestions;
  List<Vote> votes;

  User(int id, String username) {
    this.id = id;
    this.username = username;
  }
}