import 'package:ask_away/Menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ask_away/Question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, AsyncSnapshot snapshot) {

        if (snapshot.hasData) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MyHomePage(title: 'Ask Away'),
          );
        }
        else if (snapshot.hasError) {
          print("error");
          return Container();
        }
        else {
          print("loading");
          return Container();
        }
      },
    );

  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void createQuestion() {
  return;
}

class MyHomePageState extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  QuestionList qList = new QuestionList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: qList
      ),
      drawer: MyDrawer()
    );
  }
}
