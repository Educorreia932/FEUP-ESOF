import 'package:ask_away/models/Talk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date format

class TalksScreen extends StatefulWidget {
  @override
  State<TalksScreen> createState() => TalksScreenState();
}

class TalksScreenState extends State<TalksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFECECEC),
        child: Column(
          children: [
            Container(
              child: Text("Talk #1"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: ListView(
                  children: [
                    TalkCard(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                text: TextSpan(
                    style: TextStyle(
                      color: Color(0xFF979797),
                      fontSize: 17,
                    ),
                    text:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque porta pulvinar molestie. Donec et quam purus. Fusce sed ornare nulla, et imperdiet nunc. "),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.person),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
