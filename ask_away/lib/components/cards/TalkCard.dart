import 'package:ask_away/components/SimpleButton.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:ask_away/screens/talks_screen/TalkQuestionsScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TalkCard extends StatefulWidget {
  Talk talk;
  Function(String, bool) callback;
  bool scheduled;

  TalkCard(this.talk, this.callback, this.scheduled);

  @override
  State<TalkCard> createState() => TalkCardState();

  void callCallback(String id) {
    callback(id, scheduled);
    scheduled = !scheduled;
  }
}

class TalkCardState extends State<TalkCard> {
  bool displayText = false;
  Icon arrow = Icon(Icons.keyboard_arrow_down);

  final DateFormat formatterDate = DateFormat('dd/MM/yyyy');
  final DateFormat durationFormat = DateFormat('hh:mm');

  void updateContainer() {
    this.setState(() {
      displayText = !displayText;
      if (displayText) {
        arrow = Icon(Icons.keyboard_arrow_up);
      } else
        arrow = Icon(Icons.keyboard_arrow_down);
    });
  }

  Widget savedButton() {
    if (this.widget.scheduled) {
      return Icon(
        Icons.bookmark_rounded,
        size: 30,
        color: Color(0xFFFF5656),
      );
    } else
      return Icon(
        Icons.bookmark_border,
        size: 30,
        color: Color(0xFFFF5656),
      );
  }

  @override
  Widget build(BuildContext context) {
    DateTime endTime = widget.talk.date.add(widget.talk.duration);

    return Column(
      children: [
        Container(
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
                    IconButton(icon: arrow, onPressed: updateContainer),
                    Flexible(
                      child: Text(
                        this.widget.talk.title,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                        icon: savedButton(),
                        onPressed: () {
                          this.widget.callCallback(this.widget.talk.id);
                        }),
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
                              widget.talk.creator.username,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(widget.talk.ocupation.toString()),
                            Icon(
                              Icons.person,
                              color: Color(0xFFE11D1D),
                            ),
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
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.045),
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
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045),
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
                  Navigator.pushNamed(context, '/talk_questions',
                      arguments: widget.talk.id);
                }, 20, Colors.blue),
              ],
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
