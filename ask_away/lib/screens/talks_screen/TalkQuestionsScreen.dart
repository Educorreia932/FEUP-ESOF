import 'package:ask_away/components/cards/question_card/QuestionCard.dart';
import 'package:ask_away/models/Question.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Talk talk;
final _scaffoldKey = GlobalKey<ScaffoldState>();

class TalkQuestionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TalkQuestionsScreenState();
}
enum SortingOptions{MostVotes, LeastVotes, NameA_Z,NameZ_A, Newest, Oldest}

class TalkQuestionsScreenState extends State<TalkQuestionsScreen> {
  List<Question> questions = [];
  bool loaded = false;
  String talkTitle = "";
  SortingOptions sorter=SortingOptions.MostVotes;

  void addQuestion(String question, String talkId) {
    if (question != "") {
      // Call the user's CollectionReference to add a new user
      FirebaseFirestore.instance
          .collection('Questions')
          .add({'text': question, 'votes': 0, 'author': currentUser}).then(
        (value) => setState(
          () {
            questions.add(new Question(question, 0, value.id, currentUser));
            FirebaseFirestore.instance.collection('Talks').doc(talkId).update(
              {
                "questions": FieldValue.arrayUnion([value.id])
              },
            );
          },
        ),
      );
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
        switch(sorter) {
          case SortingOptions.MostVotes:
              questions.sort(
                    (a, b) {
                  return b.getTotalVotes().compareTo(a.getTotalVotes());
                },);
              break;
          case SortingOptions.LeastVotes:
              questions.sort(
                    (a, b) {
                  return a.getTotalVotes().compareTo(b.getTotalVotes());
                },);
              break;

          case SortingOptions.NameA_Z:
            questions.sort(
                  (a, b) {
                return a.text.toLowerCase().compareTo(b.text.toLowerCase());
              },);
            break;
          case SortingOptions.NameZ_A:
            questions.sort(
                  (a, b) {
                return b.text.toLowerCase().compareTo(a.text.toLowerCase());
              },);
            break;
          case SortingOptions.Newest:
            questions.sort(
                  (a, b) {
                return b.id.compareTo(a.id);
              },);
            break;
          case SortingOptions.Oldest:
            questions.sort(
                  (a, b) {
                return a.id.compareTo(b.id);
              },);
            break;
          default:
            questions.sort(
                  (a, b) {
                return b.getTotalVotes().compareTo(a.getTotalVotes());
              },);
            break;
      }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String talkId = ModalRoute.of(context).settings.arguments;

    if (!loaded) {
      List<String> questionsIds;
      FirebaseFirestore.instance.collection('Talks').doc(talkId).get().then((value) {
        talk = Talk.fromData(value);
        talkTitle = value.data()["title"];
        questionsIds = List.from(value.data()['questions']);

        if (questionsIds.isNotEmpty) {
          questions = [];
          FirebaseFirestore.instance
              .collection('Questions')
              .where(FieldPath.documentId, whereIn: questionsIds)
              .get()
              .then((questionsQuery) {
            questionsQuery.docs.forEach((element) {
              questions.add(new Question(element["text"], element["votes"], element.id, element["author"]));
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
        key: _scaffoldKey,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                padding: const EdgeInsets.only(
                  left: 230.0,
                ),),

                DropdownButton(
                  hint: Text('Sort Options'),
                  value: sorter,
                  onChanged: (newValue) {
                    setState(() {
                      sorter = newValue;
                      callback("");
                    });
                  },

                  iconEnabledColor: Colors.grey[600],
                  underline: Container(
                    height:1,
                    color: Colors.grey[400],
                  ),
                  items: SortingOptions.values.map((sortValue) {
                    return DropdownMenuItem(
                           child:new Text(sortValue.toString().split('.').last,
                                textAlign: TextAlign.left,
                            ),
                            value: sortValue,
                           );
                  }).toList(),
                ),

              ],
          ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    right: 32,
                    top: 5,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: questions
                              .map<QuestionCard>((Question question) => QuestionCard(question, callback))
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
            this.talkQuestionsScreenState.addQuestion(questionController.text, talkId);
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
            Icons.people_alt_rounded,
            size: 40,
            color: Colors.black,
          ),
          onPressed: () {
            if (currentUser != talk.creator.id)
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("You must be the creator of the talk to assign roles"),
                ),
              );

            else
              Navigator.pushNamed(context, "/talk_roles", arguments: talk);
          },
        ),
      ),
    ],
  );
}
