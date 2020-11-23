import 'package:ask_away/components/cards/QuestionCard.dart';
import 'package:ask_away/screens/talks_screen/TalksScreen.dart';
import 'package:flutter/material.dart';

class TalkQuestionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TalkQuestionsScreenState();
}

class TalkQuestionsScreenState extends State<TalkQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          QuestionCard(),
                          SizedBox(
                            height: 20,
                          ),
                          QuestionCard(),
                          SizedBox(
                            height: 20,
                          ),
                          QuestionCard(),
                          SizedBox(
                            height: 20,
                          ),
                          QuestionCard(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Row(
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
                          iconSize: 30,
                          color: Color(0xFFE11D1D),
                          onPressed: null,
                        ),
                      ],
                    ),
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
