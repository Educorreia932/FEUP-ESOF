import 'package:ask_away/components/SimpleButton.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:ask_away/screens/talks_questions/TalkQuestionsScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TalkCard extends StatefulWidget {
  Talk talk;

  @override
  State<TalkCard> createState() => TalkCardState();

  TalkCard(this.talk);
}

class TalkCardState extends State<TalkCard> {
  bool displayText = false;
  final DateFormat formatterDate = DateFormat('dd/MM/yyyy');
  final DateFormat durationFormat = DateFormat('hh:mm');

  @override
  Widget build(BuildContext context) {
    DateTime endTime = widget.talk.date.add(widget.talk.duration);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            this.setState(() {
              displayText = !displayText;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        this.widget.talk.title,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Icon(
                        Icons.bookmark_border,
                        size: 30,
                        color: Color(0xFFFF5656),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    height: displayText ? 100 : 0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        text: TextSpan(
                            style: TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 16,
                            ),
                            text: this.widget.talk.description),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Color(0xFFE11D1D),
                              ),
                              Text(
                                this.widget.talk.creator.username,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today),
                              Text(
                                formatterDate.format(widget.talk.date),
                                style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.timelapse),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        durationFormat.format(widget.talk.date) +
                                            ' - ' +
                                            durationFormat.format(endTime),
                                    style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.045),
                                  ),
                                ]),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SimpleButton("Enter Talk", () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TalkQuestionsScreen(),
                      ),
                    );
                  }, 20, Colors.blue),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
