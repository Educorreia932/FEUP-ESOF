import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question #1",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [Text("Jane Doe"), Text("1d ago")],
          ),
          RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
                style: TextStyle(color: Colors.black),
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vitae quam eros. Cras interdum lacus sed erat pulvinar placerat. Mauris laoreet purus at neque semper, nec bibendum lacus consectetur."),
          ),
          Row(
            children: [
              Icon(Icons.keyboard_arrow_up),
              Text("10"),
              Icon(Icons.keyboard_arrow_down),
              Icon(Icons.comment),
              Text("8"),
              Icon(Icons.remove_red_eye),
              Text("50"),
            ],
          )
        ],
      ),
    );
  }
}
