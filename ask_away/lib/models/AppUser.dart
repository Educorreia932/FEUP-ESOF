import 'Question.dart';
import 'Vote.dart';

class User {
  String username;
  int reputation;
  List<Question> askedQuestions;
  List<Vote> votes;

  User(this.username,this.reputation);
}
