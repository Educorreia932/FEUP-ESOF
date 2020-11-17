import 'package:ask_away/Question.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format

import 'User.dart';

class Talk {
  int id;
  String title;
  String description;
  QuestionList questionList;

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
    this.creator = new User(0, "Mr. Padoru"); //change to receive in constructor
    //TODO user list (speakers and moderators)

    this.isExpanded = false;
  }
}

class TalkList extends StatefulWidget {
  @override
  TalkListState createState() => new TalkListState();
}

class TalkListState extends State<TalkList> {
  final DateFormat formatterDate = DateFormat('dd/MM/yyyy     HH:mm');

  List<Talk> talks = [
    new Talk("Demencia Artificial", "Talk sobre emular o Padoru em software, com todos os detalhes necessários para um aprendiz desenvolver o"
            "seu próprio Padoru pessoal",
        new DateTime.utc(2020, 9, 11, 18, 30), "Sitio1"),
    new Talk("Nova talk", "Esta talk é nova fyi",
        new DateTime.utc(2020, 12, 1, 14), "Sitio2")
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [_buildTalkPanel()],
    );
  }

  Widget _userNdate(Talk talk) {
    return Container(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.only(bottom: 5.0, left: 5.0, top: 5.0),
        child: Column(
          children: [
            Row(
              children: [
                IconTheme(
                  data: new IconThemeData(
                    color: Colors.black,
                  ),
                  child: Icon(Icons.person),
                ),
                Text(
                  "  " + talk.creator.username,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              children: [
                IconTheme(
                    data: new IconThemeData(
                      color: Colors.blue,
                    ),
                    child: Icon(Icons.date_range),
                ),
                Text(
                  "  " + formatterDate.format(talk.date),
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildTalkPanel() {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.all(5.0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          talks[index].isExpanded = !isExpanded;
        });
      },
      children: talks.map<ExpansionPanel>((Talk talk) {
        return ExpansionPanel(
          canTapOnHeader: true,
          // ignore: missing_return
          headerBuilder: (BuildContext context, bool isExpanded) {
            if (isExpanded) {
              return ListTile(
                  title: Text(talk.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)));
            } else {
              return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin:
                            EdgeInsets.only(bottom: 10.0, left: 5.0, top: 5.0),
                        child: Text(
                          talk.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                      ),
                      _userNdate(talk),
                    ],
                  ));
            }
          },
          body: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
                      child: Text(talk.description,
                          style: TextStyle(fontSize: 17.0))
                  ),
                  _userNdate(talk),
                ],
              )),
          isExpanded: talk.isExpanded,
        );
      }).toList(),
    );
  }
}
