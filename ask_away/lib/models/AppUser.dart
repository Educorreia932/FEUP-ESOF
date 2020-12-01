import 'Question.dart';

class User {
  String username;
  int reputation;
  List<Question> askedQuestions;
  Map<dynamic, dynamic> votes;

  User(this.username,this.reputation, this.votes);

  User.fromData(Map<String, dynamic> data) {
    username = data["username"];
    reputation = data["Reputation"];
    votes = data["votes"];
  }
}
