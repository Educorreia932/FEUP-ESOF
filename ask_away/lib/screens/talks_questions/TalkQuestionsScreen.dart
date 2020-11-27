import 'package:ask_away/components/cards/question_card/QuestionCard.dart';
import 'package:ask_away/models/Question.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ask_away/screens/talks_screen/TalksScreen.dart';
import 'package:flutter/material.dart';

class TalkQuestionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TalkQuestionsScreenState();
}

class TalkQuestionsScreenState extends State<TalkQuestionsScreen> {
  List<Question> questions = [];
  bool loaded = false;

  void addQuestion(String question) {
    if (question != "") {
      // Call the user's CollectionReference to add a new user
      FirebaseFirestore.instance
          .collection('Questions')
          .add({'text': question}).then((value) => setState(() {
                questions.add(new Question(question, []));
              }));
    }
  }

  void callback() {
    setState(
      () {
        questions.sort(
          (a, b) {
            return b.getTotalVotes().compareTo(a.getTotalVotes());
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      FirebaseFirestore.instance
          .collection('Questions')
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  questions.add(new Question(doc["text"], []));
                }),
                setState(() {})
              });
      loaded = true;
    }
    return GestureDetector(
        onTap: () {

          FocusScope.of(context).requestFocus(new FocusNode());
        },
      child: Scaffold(
        appBar: QuestionsScreenAppBar(context),
        body: Container(
          color: Color(0xFFECECEC),
          child: Column(
            children: [
              Container(
                child: Text(
                  "Talk #1",
                  style: TextStyle(
                    fontSize: 38,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 32,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: questions
                              .map<QuestionCard>((Question question) =>
                                  QuestionCard(question, callback))
                              .toList(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SendQuestionField(this),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SendQuestionField extends StatelessWidget {
  TextEditingController questionController = new TextEditingController();
  TalkQuestionsScreenState talkQuestionsScreenState;

  SendQuestionField(TalkQuestionsScreenState talkQuestionsScreenState){
    this.talkQuestionsScreenState = talkQuestionsScreenState;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLines: null,
            controller: questionController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Let your question be heard",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          color: Color(0xFFE11D1D),
          iconSize: 37,
          onPressed: () {
            this.talkQuestionsScreenState.addQuestion(questionController.text);
            questionController.clear();
          },
        ),
      ],
    );
  }
}

Widget QuestionsScreenAppBar(BuildContext context) {
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TalksScreen()),
          );
        },
      ),
    ),
    elevation: 0.0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(
          right: 20,
        ),
        child: new IconButton(
          icon: new Icon(
            Icons.sort,
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


