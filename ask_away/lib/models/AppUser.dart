import 'package:cloud_firestore/cloud_firestore.dart';

import 'Question.dart';

class User {
  String id;
  String username;
  int reputation;
  List<Question> askedQuestions;
  Map<dynamic, dynamic> votes;
  List<dynamic> scheduledTalks;

  User(this.username, this.reputation, this.votes);

  User.fromData(DocumentSnapshot value) {
    id = value.id;

    Map<String, dynamic> data = value.data();

    username = data["username"];
    reputation = data["Reputation"];
    votes = data["votes"];
    scheduledTalks = data["scheduled"];

    if (scheduledTalks == null)
      scheduledTalks = [];
  }
}
