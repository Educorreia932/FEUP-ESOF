import 'dart:async' show Future;
import 'dart:convert';
import 'dart:io';
import 'package:ask_away/components/cards/question_card/QuestionCard.dart';
import 'package:ask_away/components/cards/question_card/components/VotingComponent.dart';
import 'package:ask_away/models/AppUser.dart';
import 'package:ask_away/models/Question.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ask_away/screens/talks_screen/TalksScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;


List<String> censoredWords;



Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/censoredWords.txt');
}

void loadCensoredWords(){
  loadAsset().then((value) {LineSplitter ls = new LineSplitter(); censoredWords = ls.convert(value);});
}


class TalkQuestionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TalkQuestionsScreenState();
}

class TalkQuestionsScreenState extends State<TalkQuestionsScreen> {
  List<Question> questions = [];
  bool loaded = false;
  String talkTitle = "";




  void voteForQuestion(Question question){
    DocumentReference userRef = FirebaseFirestore.instance.collection('Users').doc(currentUser);
    String questionID = question.id;
    User user;
    FirebaseFirestore.instance.runTransaction(
          (transaction) {
        return transaction.get(userRef).then(
              (value) {
            user = User.fromData(value.data());
            DocumentReference docRef = FirebaseFirestore.instance.collection("Questions").doc(questionID);

            // User didn't have a vote in this question
            if (!user.votes.containsKey(questionID)) {
              docRef.update({"votes": FieldValue.increment(1)});
              question.votes += 1;

              user.votes[questionID] = 1;
            }

            // User already had a vote of the same type
            else if (user.votes[questionID] == 1) {
              docRef.update({"votes": FieldValue.increment(-1)});
              question.votes -= 1;

              user.votes.remove(questionID);
            }

            // User already had a vote of the opposite type
            else {
              docRef.update({"votes": FieldValue.increment(2 * 1)});
              question.votes += 2 * 1;

              user.votes[questionID] = 1;
            }

            userRef.update({"votes": user.votes});
            callback("none");
          },
        );
      },
    );

  }
  bool verifyQuestionWords(String question){
    List<String> questionLines = question.split("\n");
    List<String> questionWords = [];
    for(int i =0;i <questionLines.length;i++){
      List<String> l1 = questionLines[i].split(" ");
      questionWords.addAll(l1);
    }

    for (int i=0; i < questionWords.length;i++)
      if(censoredWords.contains(questionWords[i].toLowerCase()))
        return false;

    return true;
  }

  bool verifyEqualQuestions(String question,BuildContext context){

    for (int i=0; i < questions.length;i++)
      if(compareQuestions(questions[i].text,question)){
        Scaffold.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 8),
          content: Text(
              "There is already an identical question in this talk! Do you wish to upvote it? "),
          backgroundColor: Colors.grey[400],
          action: SnackBarAction(
            label: "Vote",
            textColor: Colors.red,
            onPressed: (){voteForQuestion(questions[i]);},
          ),
        ));
        return false;
      }

    return true;
  }

  bool compareQuestions(String question1, String question2){
    List<String> question1Lines = question1.split("\n");
    List<String> question1Words = [];
    for(int i =0;i <question1Lines.length;i++){
      List<String> l1 = question1Lines[i].split(" ");
      question1Words.addAll(l1);
    }
    while(question1Words.remove(""));
    List<String> question2Lines = question2.split("\n");
    List<String> question2Words = [];
    for(int i =0;i <question2Lines.length;i++){
      List<String> l1 = question2Lines[i].split(" ");
      question2Words.addAll(l1);
    }
    while(question2Words.remove(""));
    if(question1Words.length!=question2Words.length)
      return false;

    for(int i=0; i< question2Words.length;i++){
      if(question2Words[i]!=question1Words[i])
        return false;
    }
    return true;
  }

  void addQuestion(String question, String talkId,BuildContext context) {

    if(!verifyQuestionWords(question)){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
            "Invalid words are present in the question submitted, "
                "please rewrite your question!"),
        backgroundColor: Color(0xFFE11D1D),
      ));
      return;
    }

    if(!verifyEqualQuestions(question,context))
      return;



    if (question != "") {
      // Call the user's CollectionReference to add a new user
      FirebaseFirestore.instance.collection('Questions').add({
        'text': question,
        'votes': 0,
        'author': currentUser
      }).then((value) => setState(() {
            questions.add(new Question(question, 0, value.id, currentUser));
            FirebaseFirestore.instance.collection('Talks').doc(talkId)
            .update({
              "questions": FieldValue.arrayUnion([value.id])
            });
          }));
    }
  }

  void callback(String id) {
    if (id != "none") {
      for (Question q in questions) {
        if (q.id == id) {
          questions.remove(q);
          break;
        }
      }
    }
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
    String talkId = ModalRoute.of(context).settings.arguments;

    if (!loaded) {
      List<String> questionsIds;
      FirebaseFirestore.instance
          .collection('Talks')
          .doc(talkId)
          .get()
          .then((talk) {
        talkTitle = talk.data()["title"];
        questionsIds = List.from(talk.data()['questions']);

        if(questionsIds.isNotEmpty) {
          questions = [];
          FirebaseFirestore.instance
              .collection('Questions')
              .where(FieldPath.documentId, whereIn: questionsIds)
              .get()
              .then((questionsQuery) {
            questionsQuery.docs.forEach((element) {
              questions.add(new Question(element["text"], element["votes"],
                  element.id, element["author"]));
            });
            this.callback("none");
          });
        }
        this.callback("none");
        loaded = true;
      });
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
                  talkTitle,
                  textAlign: TextAlign.center,
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
                      SendQuestionField(this, talkId),
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
  String talkId;

  SendQuestionField(TalkQuestionsScreenState talkQuestionsScreenState, String talkId) {
    this.talkQuestionsScreenState = talkQuestionsScreenState;
    this.talkId = talkId;
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
            this.talkQuestionsScreenState.addQuestion(questionController.text, talkId,context);
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
          },
        ),
      ),
    ],
  );
}
