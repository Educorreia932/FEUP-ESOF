import 'package:ask_away/components/UserIcon.dart';
import 'package:ask_away/models/AppUser.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main_screen/MainScreen.dart';
import 'package:ask_away/models/Question.dart';
import 'package:ask_away/components/cards/question_card/UserQuestionCard.dart';


class UserProfile extends StatefulWidget {
  @override
  UserProfileState createState() => new UserProfileState();
}


class UserProfileState extends State<UserProfile> {
  User user;
  bool loaded = false;
  List<Question> questions = [];
  int totalRep = 0;

  void getUserQuestions() {
    FirebaseFirestore.instance
        .collection('Questions')
        .where("author", isEqualTo: currentUser)
        .get()
        .then((questionsQuery) {
        questionsQuery.docs.forEach((element) {
        totalRep += element["votes"];
        questions.add(new Question(
            element["text"], element["votes"], element.id, element["author"],
            element["accepted"]));
          });
        setState(() {});

    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser)
          .snapshots()
          .first
          .then((value) =>
        {
          user = new User(
              value.data()["username"], value.data()["Reputation"],
              value.data()["votes"]),
          getUserQuestions(),
          setState(() {})
        }
      );

      loaded = true;

    }


    return Scaffold(
      appBar: UserProfileAppBar(context),
      body: Column(
        children: [
          Container(
            color: Color(0xFFECECEC),
            child: Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      UserIcon(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.50,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(

                                text: user != null ? user.username : "",

                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.06,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.50,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: "Asking questions",
                                style: TextStyle(
                                  color: Color(0xFFC8C8C8),
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.045,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reputation",
                            style: TextStyle(
                              color: Color(0xFFE11D1D),
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            user != null ? totalRep.toString() : "",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFECECEC),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  SectionHeader("Asked Questions", questions.length),
                  Expanded(
                  child: ListView(
                  scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: questions
                        .map<UserQuestionCard>((Question question) => UserQuestionCard(question, user.username))
                        .toList(),
                  ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget UserProfileAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreenBuilder()),
          );
        },
      ),
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(
          right: 20,
        ),
        child: new IconButton(
          icon: new Icon(
            Icons.bookmark,
            size: 40,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreenBuilder()),
            );
          },
        ),
      ),
    ],
  );
}

class SectionHeader extends StatelessWidget {
  String _title;
  int _value;

  SectionHeader(String title, int value) {
    _title = title;
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          _title,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        SizedBox(width: 15),
        Text(
          _value.toString(),
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFFE11D1D),
          ),
        ),
      ],
    );
  }
}


