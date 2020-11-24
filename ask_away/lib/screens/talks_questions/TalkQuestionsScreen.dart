import 'package:ask_away/components/cards/question_card/QuestionCard.dart';
import 'package:ask_away/models/Question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ask_away/models/Vote.dart';
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
    if (question != "")
      setState(
        () {
          questions.add(new Question(question, []));
        },
      );
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
          questions.add(new Question(doc["text"],[]));
        }
        ),
        setState(() {})
      });
      loaded = true;
    }
    return Scaffold(
      appBar: TalksScreenAppBar(context),
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
                            .map<QuestionCard>(
                                (Question question) => QuestionCard(question, callback))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SendQuestionField(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendQuestionField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            maxLines: null,
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
          onPressed: null,
        ),
      ],
    );
  }
}
