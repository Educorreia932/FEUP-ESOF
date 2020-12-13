import 'package:ask_away/components/cards/RoleCard.dart';
import 'package:ask_away/models/AppUser.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TalkRolesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TalkRolesScreenState();
}

class TalkRolesScreenState extends State<TalkRolesScreen> {
  @override
  Widget build(BuildContext context) {
    Talk talk = ModalRoute.of(context).settings.arguments;

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('Users').get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<User> users = [];

          snapshot.data.docs.forEach(
            (document) {
              List<dynamic> userScheduledTalks = document.data()["scheduled"];

              if (userScheduledTalks.contains("XWvNTQsEilhhKYhZfm25"))
                users.add(User.fromData(document));
            },
          );

          return Scaffold(
            appBar: SimpleAppBar(context),
            body: Container(
              color: Color(0xFFECECEC),
              child: ListView(
                children: users.map<RoleCard>((User user) => RoleCard(user, talk)).toList(),
              ),
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}

Widget SimpleAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    backgroundColor: Color(0xFFECECEC),
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: new IconButton(
        icon: new Icon(
          Icons.arrow_back,
          size: 40,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    elevation: 0.0,
  );
}
