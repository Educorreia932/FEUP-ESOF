import 'User.dart';

class Talk {
  String id;
  String title;
  String description;

  //UserList userList; TODO
  DateTime date;
  bool isExpanded;
  User creator;
  String location;
  Duration duration;

  Talk(String id, String title, String description, DateTime date, String location, int duration) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.date = date;
    this.location = location;
    this.duration = new Duration(minutes: duration);
    this.creator = new User(0, "Mr. Padoru"); //change to receive in constructor
    //TODO user list (speakers and moderators)

    this.isExpanded = false;
  }
}
