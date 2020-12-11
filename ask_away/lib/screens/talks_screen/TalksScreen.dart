import 'package:ask_away/components/cards/TalkCard.dart';
import 'package:ask_away/models/AppUser.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:ask_away/screens/talks_screen/CreateTalkScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TalksScreen extends StatefulWidget {
  @override
  State<TalksScreen> createState() => TalksScreenState();
}

class TalksScreenState extends State<TalksScreen> {
  bool loaded = false;
  List<Talk> talks = [];
  List<dynamic> scheduledIds = [];

  void addTalks() {
    if (!loaded) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser)
          .get()
          .then((valueUser) {
        scheduledIds = valueUser.data()["scheduled"];
        FirebaseFirestore.instance
            .collection('Talks')
            .get()
            .then((QuerySnapshot querySnapshot) {
          talks = [];
          querySnapshot.docs.forEach((doc) {
            FirebaseFirestore.instance
                .collection('Users')
                .doc(doc["creator"])
                .get()
                .then((value) {
              talks.add(new Talk(
                  doc.id,
                  doc["title"],
                  doc["description"],
                  doc["date"].toDate(),
                  doc["location"],
                  doc["duration"],
                  doc["ocupation"],
                  User.fromData(value.data())));
              setState(() {});
            });
          });
          loaded = true;
        });
      });
    }
  }

  void updateScheduled(String talkId, bool scheduled) {
    if (!scheduled) {
      FirebaseFirestore.instance.collection('Users').doc(currentUser).update({
        'scheduled': FieldValue.arrayUnion([talkId])
      }).then((value) {
        FirebaseFirestore.instance.collection('Talks').doc(talkId).update({
          'ocupation': FieldValue.increment(1)
        }).then((value1) => setState(() {
              scheduledIds.add(talkId);
              talks
                  .elementAt(
                      talks.indexWhere((element) => element.id == talkId))
                  .ocupation++;
            }));
      });
    } else {
      FirebaseFirestore.instance.collection('Users').doc(currentUser).update({
        'scheduled': FieldValue.arrayRemove([talkId])
      }).then((value) {
        FirebaseFirestore.instance.collection('Talks').doc(talkId).update({
          'ocupation': FieldValue.increment(-1)
        }).then((value1) => setState(() {
              scheduledIds.remove(talkId);
              talks
                  .elementAt(
                      talks.indexWhere((element) => element.id == talkId))
                  .ocupation--;
            }));
      });
    }
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // if(!loaded)
    // addTalk("Teste Talk", "wow isto é teste", new DateTime.utc(2020, 9, 11, 18, 30), "aqui", 70);
    addTalks();
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
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: ListView(
                  padding: const EdgeInsets.only(left: 32, right: 32, top: 10),
                  children: talks.map<TalkCard>((Talk talk) {
                    bool scheduled = false;
                    if (scheduledIds.contains(talk.id)) {
                      scheduled = true;
                    }
                    return TalkCard(talk, updateScheduled, scheduled);
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "/talk_creation");
          },
          icon: Icon(Icons.add),
          label: Text('New Talk')),
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
      var begin = Offset(1.0, 0.0);
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

Route _createTalksRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => TalksScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0);
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
  bool loaded = false;
  User user;

  @override
  void initState() {
    _calendarView = CalendarView.month;
    _text = DateFormat('MMMM yyyy').format(_jumpToTime).toString();
    getScheduled();
    super.initState();
  }

  List<Talk> scheduled = [];

  void getScheduled() {
    if (!loaded) {
      scheduled = [];
      loaded = true;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser)
          .get()
          .then((value) {
        user = User.fromData(value.data());

        if (user.scheduledTalks.length > 0) {
          for (int i = 0; i < user.scheduledTalks.length; ++i) {
            FirebaseFirestore.instance
                .collection("Talks")
                .doc(user.scheduledTalks[i])
                .get()
                .then((value) {
              scheduled.add(new Talk(
                  value.id,
                  value.data()["title"],
                  value.data()["description"],
                  value.data()["date"].toDate(),
                  value.data()["location"],
                  value.data()["duration"],
                  value.data()["ocupation"],
                  user));
              setState(() {});
            });
          }
        } else
          setState(() {});
      });
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void updateScheduled(dynamic talkId, bool scheduled) {
    FirebaseFirestore.instance.collection('Users').doc(currentUser).update({
      'scheduled': FieldValue.arrayRemove([talkId])
    }).then((value) {
      loaded = false;
      getScheduled();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScheduleAppBar(context),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
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
            Container(child: Builder(
              builder: (context) {
                if (_selectedIndex == 0) {
                  return Expanded(
                      child: SfCalendar(
                    allowedViews: [CalendarView.day, CalendarView.month],
                    backgroundColor: Color(0xFFECECEC),
                    initialDisplayDate: _jumpToTime,
                    view: _calendarView,
                    dataSource: new ScheduledTalkSource(scheduled),
                    //getDataSource
                    monthViewSettings: MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment),
                    showNavigationArrow: true,
                    showDatePickerButton: true,
                  ));
                } else {
                  return Expanded(
                    child: ListView(
                      padding:
                          const EdgeInsets.only(left: 17, right: 17, top: 10),
                      children: scheduled.map<TalkCard>((Talk talk) {
                        for (String t in user.scheduledTalks) {
                          if (t == talk.id) {
                            return TalkCard(talk, updateScheduled, true);
                          }
                        }
                        return null;
                      }).toList(),
                    ),
                  );
                }
              },
            ))
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
        },
      ),
    ),
    elevation: 0.0,
  );
}
