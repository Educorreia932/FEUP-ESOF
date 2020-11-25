import 'Question.dart';
import 'Vote.dart';

class User {
  String username;
  List<Question> askedQuestions;
  List<Vote> votes;

  User(this.username);
}
