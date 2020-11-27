import 'package:ask_away/screens/talks_screen/CreateTalkScreen.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

String _currentDate = null;

String validateEmail(String value) {
  return value.isEmpty ? 'Email can\'t be empty' : null;
}

String validatePassword(String value) {
  return value.isEmpty ? 'Password can\'t be empty' : null;
}

enum EntryFieldType {
  TITLE,
  DESCRIPTION,
  LOCATION,
}

String validateText(String value) {
  return value.isEmpty ? "This field can't be empty" : null;
}

Widget EntryField(EntryFieldType entryFieldType) {
  String _title;
  bool _obscured = false;
  Function _validator;
  Function _setter;

  switch (entryFieldType) {
    case EntryFieldType.TITLE:
      _title = "Title";
      _validator = validateText;
      _setter = talkSetTitle;
      break;
    case EntryFieldType.DESCRIPTION:
      _title = "Username";
      _setter = talkSetDescription;
      break;
    case EntryFieldType.LOCATION:
      _title = "Password";
      _obscured = true;
      _validator = validatePassword;
      _setter = talkSetLocation;
      break;
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _title,
          style: TextStyle(
            fontSize: 35,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          obscureText: _obscured,
          validator: _validator,
          onSaved: (String value) {
            _setter(value);
          },
          decoration: InputDecoration(
            fillColor: Color(0xFFE5E5E5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

String initialDate() {
  String date;
  _currentDate == null ? date = DateTime.now().toString() : date = _currentDate;
  return date;
}

void setDate(String date, bool first) {
  if(first)
    _currentDate = date;
}

class TalkDatePicker extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => TalkDatePickerState();
}

class TalkDatePickerState extends State<TalkDatePicker> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
      DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMM, yyyy',
      // initialValue: DateTime.now().toString(),
      initialValue: initialDate(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Date',
      timeLabelText: "Hour",
      selectableDayPredicate: (date) {
        // Disable weekend days to select from the calendar
        if (date.weekday == 6 || date.weekday == 7) {
          return false;
        }

        return true;
      },
      onChanged: (val) => print(val),
      validator: (val) {
        print(val);
        setDate(val, true);
        setState(() {

        });
        return null;
      },
      onSaved: (val) => print(val),
      )
      ]
    );
  }
}
