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

    for (String userRole in participants.keys) {
      print(userRole);
    }

    this.isExpanded = false;
  }
}
