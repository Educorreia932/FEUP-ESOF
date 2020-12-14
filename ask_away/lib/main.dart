import 'package:ask_away/screens/BuildWaitingScreen.dart';
import 'package:ask_away/screens/authentication/LoginScreen.dart';
import 'package:ask_away/screens/authentication/RegisterScreen.dart';
import 'package:ask_away/screens/main_screen/MainScreen.dart';
import 'package:ask_away/screens/talks_screen/TalkQuestionsScreen.dart';
import 'package:ask_away/screens/talks_screen/CreateTalkScreen.dart';
import 'package:ask_away/screens/talks_screen/TalkRolesScreen.dart';
import 'package:ask_away/screens/talks_screen/TalksScreen.dart';
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
          loadCensoredWords();
          return AuthProvider(
            auth: Auth(),
            child: MaterialApp(
              title: 'Ask Away',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              initialRoute: "/",
              routes: {
                '/': (context) => MainScreenBuilder(key : Key("mainScreen")),
                '/login': (context) => LoginScreen(key : Key("login")),
                '/register': (context) => RegisterScreen(),
                '/talks': (context) => TalksScreen(),
                '/talk_questions': (context) => TalkQuestionsScreen(),
                '/talk_creation': (context) => CreateTalkScreen(),
                '/talk_roles': (context) => TalkRolesScreen(),
              },
            ),
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
