import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Ask Away'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void createQuestion(){
  return;
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(children: [
          Container(
            height: 520,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              children: <Widget>[
                Container(
                    margin: new EdgeInsets.only(top: 5),
                    padding: new EdgeInsets.symmetric(vertical: 20,horizontal: 8),
                    color: Colors.blue,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('This is the first question',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)))),
                Container(
                    margin: new EdgeInsets.only(top: 5),
                    padding: new EdgeInsets.symmetric(vertical: 20,horizontal: 8),
                    color: Colors.red,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Second question looks very padoru in red',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)))),
              ],
            ),
          ),
        ]),
      floatingActionButton: FloatingActionButton(
        onPressed: createQuestion,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
    ),);
  }
}
