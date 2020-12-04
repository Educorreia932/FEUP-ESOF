import 'package:ask_away/components/SimpleAppBar.dart';
import 'package:ask_away/components/SimpleButton.dart';
import 'package:ask_away/services/Auth.dart';
import 'package:ask_away/services/AuthProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'EntryField.dart';
import 'EntryField.dart';
import '../main_screen/MainScreen.dart';
import 'LoginScreen.dart';

String _email;
String _username;
String _password;

void registerSetEmail(String email) {
  _email = email;
}

void registerSetUsername(String username) {
  _username = username;
}

void registerSetPassword(String password) {
  _password = password;
}

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  Future<void> validateAndSubmit() async {
    validateAndSave();

    final BaseAuth auth = AuthProvider.of(context).auth;
    final String userId = await auth.createUserWithEmailAndPassword(_email, _password);
    FirebaseFirestore.instance.collection('Users').doc(userId).set(
      {
        'Reputation': 0,
        'scheduled': [],
        'votes': {},
        'username': _username,
      },
    );

    print('Registered user: $userId');

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreenBuilder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: SimpleAppBar(context),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                height: 450,
                padding: EdgeInsets.only(
                  left: 35,
                  right: 35,
                ),
                margin: EdgeInsets.only(
                  bottom: 70,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EntryField(EntryFieldType.EMAIL, FormType.REGISTER),
                      EntryField(EntryFieldType.USERNAME, FormType.REGISTER),
                      EntryField(EntryFieldType.PASSWORD, FormType.REGISTER),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  bottom: 40,
                ),
                child: SimpleButton(
                  "Register",
                  validateAndSubmit,
                  37,
                  Color(0xFFE11D1D),
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Color(0xFFF979797),
                      ),
                    ),
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        color: Color(0xFFFF5656),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                    ),
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
