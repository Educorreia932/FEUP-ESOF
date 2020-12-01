import 'Question.dart';
import 'Vote.dart';

class User {
  String username;
  int reputation;
  List<Question> askedQuestions;
  Map<dynamic, dynamic> votes;

  User(this.username,this.reputation, this.votes);
}
