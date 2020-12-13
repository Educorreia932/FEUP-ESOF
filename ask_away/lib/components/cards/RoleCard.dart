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
  State<StatefulWidget> createState() => RoleCardState();
}

class RoleCardState extends State<RoleCard> {
  String role;

  void changeRole(User user, String role, Talk talk) {
    FirebaseFirestore.instance
        .collection("Talks")
        .doc("XWvNTQsEilhhKYhZfm25")
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text("Atendee"),
                    activeColor: Colors.red,
                    value: "atendee",
                    groupValue: role,
                    onChanged: (String value) {
                      setState(() {
                        role = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Moderator"),
                    activeColor: Colors.red,
                    value: "moderator",
                    groupValue: role,
                    onChanged: (String value) {
                      setState(() {
                        role = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Speaker"),
                    activeColor: Colors.red,
                    value: "speaker",
                    groupValue: role,
                    onChanged: (String value) {
                      setState(() {
                        role = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
