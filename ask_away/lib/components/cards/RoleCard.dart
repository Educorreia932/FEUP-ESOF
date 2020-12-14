import 'package:ask_away/models/AppUser.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoleCard extends StatefulWidget {
  User user;
  Talk talk;

  RoleCard(this.user, this.talk);

  @override
  State<StatefulWidget> createState() => RoleCardState(this.user, this.talk);
}

class RoleCardState extends State<RoleCard> {
  String role;

  RoleCardState(User user, Talk talk) {
    role = talk.getUserRole(user);
  }

  void removePreviousRole() {
    String userID = widget.user.id;

    for (String userRole in widget.talk.participants.keys) {
      List<dynamic> users = widget.talk.participants[userRole];

      if (users.contains(userID))
        users.removeWhere((id) => id == userID);
    }
  }

  void changeRole(String role) {
    if (!widget.talk.participants.containsKey(role))
      widget.talk.participants[role] = List();

    removePreviousRole();
    widget.talk.participants[role].add(widget.user.id);

    FirebaseFirestore.instance
        .collection("Talks")
        .doc(widget.talk.id)
        .update({"participants": widget.talk.participants});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 15,
              ),
              child: Text(
                widget.user.username,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  roleOption("Attendee", "atendees"),
                  roleOption("Moderator", "moderators"),
                  roleOption("Speaker", "speakers")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget roleOption(String title, String roleValue) {
    return RadioListTile(
      title: Text(title),
      activeColor: Colors.red,
      value: roleValue,
      groupValue: role,
      onChanged: (String value) {
        changeRole(value);
        setState(
          () {
            role = value;
          },
        );
      },
    );
  }
}
