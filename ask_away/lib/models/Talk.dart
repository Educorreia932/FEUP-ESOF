import 'AppUser.dart';

class Talk {
  String id;
  String title;
  String description;

  DateTime date;
  bool isExpanded;
  User creator;
  String location;
  Duration duration;
  int ocupation;
  Map<String, dynamic> participants;

  Talk(this.id, this.title, this.description, this.date, this.location, int duration, this.ocupation, this.creator, Map<String, dynamic> participants) {
    this.duration = new Duration(minutes: duration);

    this.isExpanded = false;
  }

  Talk.fromData(Map<String, dynamic> data) {
    this.id = data["id"];
    this.title = data["title"];
    this.description = data["description"];
    this.date = data["date"].toDate();
    this.location = data["location"];
    this.duration = new Duration(minutes: data["duration"]);
    this.ocupation = data["ocupation"];
    this.participants = data["participants"];

    this.isExpanded = false;
  }
}
