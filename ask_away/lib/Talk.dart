import 'package:ask_away/Question.dart';

class Talk {
  int id;
  String title;
  String description;
  QuestionList questionList;
  //UserList userList; TODO
  DateTime date;

  Talk(String title, String description, DateTime date) {
    this.title = title;
    this.description = description;
    this.date = date;
    //TODO user list (speakers and moderators)
  }
}