import 'dart:async';
import 'dart:io';
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
import 'package:flutter/src/foundation/diagnostics.dart';

String appTitle = 'Ask Away';
Stopwatch stopwatch = new Stopwatch()..start();

Future<FirebaseApp> _initialization;

Future<FirebaseApp> initialize()async{


  Stopwatch stopwatch2 = new Stopwatch()..start();
  Future<FirebaseApp> initialization= Firebase.initializeApp();
  int delay=5*1000-stopwatch2.elapsed.inMilliseconds;
  if(delay<0)
    delay=0;


  return Future.delayed(Duration(milliseconds: delay),()=>_initialization=initialization);
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadCensoredWords();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]); // Make application fullscreen
    return FutureBuilder(
      future:  initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        
        if (snapshot.hasData ) {

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

          return MaterialApp(
              home: new Scaffold(
                body: new InkWell(

                 child: new Stack(
                   fit: StackFit.expand,
                   children: <Widget>[
                      new Container(
                        decoration: new BoxDecoration(
                            color: Colors.black12,
                        ),
                      ),
                     new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                              new Expanded(
                                flex: 2,
                                child: new Container(
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[

                                        new Text("Ask Away",
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 80.0
                                            ),
                                        ),
                                        new Padding(
                                          padding: const EdgeInsets.only(top: 30.0),
                                        ),
                                        new CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          child: Hero(
                                            tag: "splashscreenImage",
                                            child: new Container(
                                              child: new Image.asset("./assets/images/logo.png"),
                                            ),
                                          ),
                                          radius: 100,
                                        ),
                                       ],
                                    )
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                       padding: const EdgeInsets.only(top: 20.0),
                                      ),
                                      Row (
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left: 75.0),
                                          ),
                                          new Text("Loading",
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 40.0
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20.0),
                                          ),
                                          SizedBox(
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.black) ,
                                            ),
                                            width: 50,
                                            height: 50,
                                          ),
                                        ]
                                      ),
                                    ],
                                ),
                              ),
                            ],
                          ),
                     ],
                    ),
                   ),
                ),
              );
        }
      },
    );
  }
}

