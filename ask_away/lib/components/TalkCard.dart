import 'package:ask_away/components/SimpleButton.dart';
import 'package:ask_away/screens/talks_screen/TalksScreen.dart';
import 'package:flutter/material.dart';

class TalkCard extends StatefulWidget {
  @override
  State<TalkCard> createState() => TalkCardState();
}

class TalkCardState extends State<TalkCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  "Talk #1",
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
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                text: TextSpan(
                    style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 16,
                    ),
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque porta pulvinar molestie. Donec et quam purus. Fusce sed ornare nulla, et imperdiet nunc. "),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xFFE11D1D),
                      ),
                      Text(
                        "Educorreia932",
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
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 5,
                        ),
                        child: Icon(
                          Icons.calendar_today,
                          color: Color(0xFFE11D1D),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "6 hours",
                              style: TextStyle(
                                color: Color(0xFFFF5656),
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: " left",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SimpleButton(
              "Enter Talk",
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TalksScreen(),
                  ),
                );
              },
              20,
              Color(0xFFC4C4C4)
            )
          ],
        ),
      ),
    );
  }
}
