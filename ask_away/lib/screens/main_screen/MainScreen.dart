import 'package:ask_away/components/SimpleButton.dart';
import 'package:ask_away/components/UserIcon.dart';
import 'package:ask_away/screens/BuildWaitingScreen.dart';
import 'package:ask_away/screens/authentication/LoginScreen.dart';
import 'package:ask_away/services/Auth.dart';
import 'package:ask_away/services/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../talks_screen/TalksScreen.dart';
import 'SideMenu.dart';

String currentUser;

class MainScreenBuilder extends StatelessWidget {
  MainScreenBuilder({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth;

    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          currentUser = snapshot.data;

          final bool isLoggedIn = currentUser != null;

          return MainScreen(isLoggedIn);
        }

        return BuildWaitingScreen();
      },
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MainScreen extends StatelessWidget {
  bool _isLoggedIn;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  MainScreen(this._isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: DrawerComponent(),
      appBar: MainScreenAppBar(_drawerKey, _isLoggedIn, context),
      body: Container(
        color: Color(0xFFE5E5E5),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15),
                child: Text(
                  "Ask Away",
                  style: TextStyle(
                    fontSize: 55,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 15),
                child: Text(
                  "Every great answer starts with a great question.",
                  style: TextStyle(
                    color: Color(0xFF9A9A9A),
                    fontSize: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  bottom: 70,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                    Builder(
                      builder: (context) => SimpleButton(
                        "Find talk",
                        () {
                          if (currentUser != null) {
                            Navigator.pushNamed(context, '/talks');
                          }

                          else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "You have to be logged in to access talks!"),
                            backgroundColor: Colors.red,
                            ));
                          }
                        },
                        37,
                        Color(0xFFE11D1D),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

MainScreenAppBar(GlobalKey<ScaffoldState> _drawerKey, bool _isLoggedIn, BuildContext context) {
  return AppBar(
    toolbarHeight: 100,
    leading: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: new IconButton(
        icon: new Icon(
          Icons.menu,
          size: 40,
          color: Colors.black,
        ),
        onPressed: () => {_drawerKey.currentState.openDrawer()},
      ),
    ),
    backgroundColor: Color(0xFFE5E5E5),
    elevation: 0.0,
    actions: [
      Padding(
        padding: const EdgeInsets.only(
          top: 20,
          right: 10,
        ),
        child: _isLoggedIn
            ? UserIcon()
            : InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.black, fontSize: 35),
                ),
              ),
      ),
    ],
  );
}
