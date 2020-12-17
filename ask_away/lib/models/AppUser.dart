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

    askedQuestions = [];

    Map<String, dynamic> data = value.data();

    username = data["username"];
    reputation = data["Reputation"];
    votes = data["votes"];
    scheduledTalks = data["scheduled"];

    if (scheduledTalks == null)
      scheduledTalks = [];
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
        other is User &&
            id == other.id &&
            username == other.username &&
            reputation == other.reputation &&
            votes.toString() == other.votes.toString() &&
            scheduledTalks.toString() == other.scheduledTalks.toString();

  @override
  int get hashCode => username.hashCode;

}
