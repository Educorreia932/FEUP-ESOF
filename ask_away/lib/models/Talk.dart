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
  Duration duration;

  Talk(String title, String description, DateTime date, String location, Duration duration) {
    this.title = title;
    this.description = description;
    this.date = date;
    this.location = location;
    this.duration = duration;
    this.creator = new User(0, "Mr. Padoru"); //change to receive in constructor
    //TODO user list (speakers and moderators)

    this.isExpanded = false;
  }
}
