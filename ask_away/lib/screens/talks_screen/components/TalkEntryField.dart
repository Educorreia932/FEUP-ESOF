import 'package:ask_away/screens/talks_screen/CreateTalkScreen.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

String _currentDate;

// String validateEmail(String value) {
//   return value.isEmpty ? 'Email can\'t be empty' : null;
// }
//
// String validatePassword(String value) {
//   return value.isEmpty ? 'Password can\'t be empty' : null;
// }

enum TalkEntryFieldType { TITLE, DESCRIPTION, LOCATION, STARTDATE, ENDDATE }

String validateText(String value) {
  return value.isEmpty ? "This field can't be empty" : null;
}

Widget TalkEntryField(TalkEntryFieldType entryFieldType) {

  String _title;
  bool _obscured = false;
  Function _validator;
  Function _setter;

  switch (entryFieldType) {
    case TalkEntryFieldType.TITLE:
      _title = "Title";
      _validator = validateText;
      _setter = talkSetTitle;
      break;
    case TalkEntryFieldType.DESCRIPTION:
      _title = "Description";
      _validator = validateText;
      _setter = talkSetDescription;
      break;
    case TalkEntryFieldType.LOCATION:
      _title = "Location";
      _validator = validateText;
      _setter = talkSetLocation;
      break;
    case TalkEntryFieldType.STARTDATE:
      _title = "Start Date";
      _setter = talkSetStartDate;
      break;
    case TalkEntryFieldType.ENDDATE:
      _title = "End Date";
      _setter = talkSetEndDate;
      break;
  }
  if (entryFieldType == TalkEntryFieldType.STARTDATE
      || entryFieldType == TalkEntryFieldType.ENDDATE)
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _title,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              TalkDatePicker(_setter)
            ]));
  else
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _title,
            style: TextStyle(
              fontSize: 20,
            ),
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
                  width: 0.001,
                  style: BorderStyle.none,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF979797),
                )
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
  if (first) _currentDate = date;
}

class TalkDatePicker extends StatefulWidget {
  Function _setter;

  TalkDatePicker(this._setter);

  @override
  State<StatefulWidget> createState() => TalkDatePickerState();
}

class TalkDatePickerState extends State<TalkDatePicker> {
  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
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
      onChanged: (val)
      {
        setDate(val, true);
        setState(() {});
        },
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) {
        //print("wowowowow"); print(val);
        this.widget._setter(val);
      }
    );
  }
}
