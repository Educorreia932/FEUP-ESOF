import 'package:ask_away/components/cards/TalkCard.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TalksScreen extends StatefulWidget {
  @override
  State<TalksScreen> createState() => TalksScreenState();
}

class TalksScreenState extends State<TalksScreen> {
  List<Talk> talks = [
    new Talk(
        "Ultimate talk",
        "What is the answer to the ultimate talk of life, the universe and everything?",
        new DateTime.utc(2020, 9, 11, 18, 30),
        "Earth",
        new Duration(hours: 2)),
    new Talk(
        "Ultimate question",
        "What is the answer to the ultimate question of life, the universe and everything?",
        new DateTime.utc(2020, 9, 11, 18, 30),
        "Earth",
        new Duration(hours: 1, minutes: 30)),
  ];

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
                "Talks",
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: ListView(
                  children: talks
                      .map<TalkCard>((Talk talk) => TalkCard(talk))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget TalksScreenAppBar(BuildContext context) {
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
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
            Icons.calendar_today,
            size: 40,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MainScreen()),
            // );
            Navigator.of(context).push(_createCalendarRoute());
          },
        ),
      ),
    ],
  );
}

Route _createCalendarRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => TalkSchedule(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class ScheduledTalkSource extends CalendarDataSource {
  ScheduledTalkSource(List<Talk> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments.elementAt(index).date;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments
        .elementAt(index)
        .date
        .add(appointments.elementAt(index).duration);
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  @override
  String getSubject(int index) {
    return appointments.elementAt(index).title;
  }

  @override
  Color getColor(int index) {
    return Colors.green;
  }
}

class TalkSchedule extends StatefulWidget {
  @override
  TalkScheduleState createState() => new TalkScheduleState();
}

class TalkScheduleState extends State<TalkSchedule> {
  CalendarView _calendarView;
  DateTime _jumpToTime = DateTime.now();
  String _text = '';

  @override
  void initState() {
    _calendarView = CalendarView.month;
    _text = DateFormat('MMMM yyyy').format(_jumpToTime).toString();
    super.initState();
  }

  List<Talk> scheduled = [
    //TODO : change to read from user scheduled (database)
    new Talk(
        "Padoru Artificial",
        "Talk sobre emular o Padoru em software, com todos os detalhes necessários para um aprendiz desenvolver o"
            "seu próprio Padoru pessoal",
        new DateTime.utc(2020, 9, 11, 18, 30),
        "Sitio1",
        new Duration(hours: 2)),
    new Talk(
        "Nova talk",
        "Esta talk é nova fyi",
        new DateTime.utc(2020, 12, 1, 14),
        "Sitio2",
        new Duration(hours: 1, minutes: 30)),
  ];

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (_calendarView == CalendarView.month &&
        calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      _calendarView = CalendarView.day;
      _updateState(calendarTapDetails.date);
    }
  }

  void _updateState(DateTime date) {
    setState(() {
      _jumpToTime = date.add(const Duration(hours: 3, minutes: 30));
      _text = DateFormat('MMMM yyyy').format(_jumpToTime).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScheduleAppBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
        color: Color(0xFFECECEC),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Scheduled Talks",
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: SfCalendar(
                  backgroundColor: Color(0xFFECECEC),
                  initialDisplayDate: _jumpToTime,
                  //onTap: calendarTapped,
                  view: _calendarView,
                  dataSource: new ScheduledTalkSource(scheduled),
                  //getDataSource
                  monthViewSettings: MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                  showNavigationArrow: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget ScheduleAppBar(BuildContext context) {
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TalksScreen()),
          );
        },
      ),
    ),
    elevation: 0.0,
  );
}
