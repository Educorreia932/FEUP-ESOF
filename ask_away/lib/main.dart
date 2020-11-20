import 'package:ask_away/screens/MainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'components/MenuComponent.dart';
import 'components/QuestionComponent.dart';

String appTitle = 'Ask Away';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]); // Make application fullscreen

    return FutureBuilder(
      future: _initialization,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            title: 'Ask Away',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: MainScreen(),
          );
        }

        else if (snapshot.hasError) {
          print("Error");
          return Container();
        }

        else {
          print("Loading...");
          return Container();
        }
      },
    );
  }
}

// class MyHomePageState extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   QuestionList qList = new QuestionList();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.blue[50],
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: new GestureDetector(
//             onTap: () {
//               FocusScope.of(context).requestFocus(new FocusNode());
//             },
//             child: qList),
//         drawer: MyDrawer());
//   }
// }
