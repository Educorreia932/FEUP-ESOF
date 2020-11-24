import 'User.dart';

class Talk {
  int id;
  String title;
  String description;

  //UserList userList; TODO
  DateTime date;
  bool isExpanded;
  User creator;
  String location;

  Talk(String title, String description, DateTime date, String location) {
    this.title = title;
    this.description = description;
    this.date = date;
    this.location = location;
    this.creator = new User("Mr. Padoru"); //change to receive in constructor
    //TODO user list (speakers and moderators)

    this.isExpanded = false;
  }
}
