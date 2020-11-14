import 'package:ask_away/Question.dart';
import 'package:flutter/material.dart';

class Talk {
  int id;
  String title;
  String description;
  QuestionList questionList;
  //UserList userList; TODO
  DateTime date;
  bool isExpanded;

  Talk(String title, String description, DateTime date) {
    this.title = title;
    this.description = description;
    this.date = date;
    this.isExpanded = false;
    //TODO user list (speakers and moderators)
  }
}

class TalkList extends StatefulWidget {
  @override
  TalkListState createState() => new TalkListState();
}

class TalkListState extends State<TalkList> {
  List<Talk> talks = [
    new Talk("Demencia Artificial", "Talk sobre emular o Padoru em software", new DateTime.utc(2020,9,11,18,30)),
    new Talk("Nova talk", "Esta talk é nova fyi", new DateTime.utc(2020, 12, 1, 14))
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:[ _buildTalkPanel()],
    );
  }

  Widget _buildTalkPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          talks[index].isExpanded = !isExpanded;
        });
      },
      children: talks.map<ExpansionPanel>((Talk talk) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(talk.title),
              );
            },
            body: ListTile(
              title: Text(talk.description),
            ),
          isExpanded: talk.isExpanded,
        );
      }).toList(),
    );
  }
}