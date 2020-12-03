import 'AppUser.dart';

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

  Talk(String id, String title, String description, DateTime date, String location, int duration, User creator) {
    this.id = id;
    this.title = title;
    this.description = description;
    this.date = date;
    this.location = location;
    this.duration = new Duration(minutes: duration);
    this.creator = creator;
    //TODO user list (moderators)

    this.isExpanded = false;
  }
}
