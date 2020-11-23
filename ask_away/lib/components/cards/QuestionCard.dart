import 'package:flutter/material.dart';

class QuestionCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuestionCardState();
}

class QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Educorreia932",
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
                Icon(
                  Icons.bookmark_border,
                  size: 27,
                  color: Color(0xFFFF5656),
                ),
              ],
            ),
            RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                text:
                    "What is the answer to the ultimate question of life, the universe and everything?",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF979797),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: null,
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 30,
                      ),
                    ),
                    Text(
                      "24",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: null,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: "33 minutes",
                        style: TextStyle(
                          color: Color(0xFFFF5656),
                        ),
                      ),
                      TextSpan(
                        text: " ago",
                        style: TextStyle(
                          color: Color(0xFF979797),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
