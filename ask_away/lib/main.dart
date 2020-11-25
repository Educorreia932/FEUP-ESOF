import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:ask_away/services/Auth.dart';
import 'package:ask_away/services/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

String appTitle = 'Ask Away';

final Future<FirebaseApp> _initialization = Firebase.initializeApp();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]); // Make application fullscreen

    return FutureBuilder(
      future: _initialization,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return AuthProvider(
            auth: Auth(),
            child: MaterialApp(
              title: 'Ask Away',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: MainScreenBuilder(),
            ),
          );
        } else if (snapshot.hasError) {
          print("Error");
          return Container();
        } else {
          print("Loading...");
          return Container();
        }
      },
    );
  }
}
