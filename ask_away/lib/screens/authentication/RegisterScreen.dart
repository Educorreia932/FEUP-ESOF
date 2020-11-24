import 'package:ask_away/components/SimpleAppBar.dart';
import 'package:ask_away/components/SimpleButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/EntryField.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context),
      body: Column(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EntryField(EntryFieldType.EMAIL),
                EntryField(EntryFieldType.USERNAME),
                EntryField(EntryFieldType.PASSWORD),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
              bottom: 40,
            ),
            child: SimpleButton("Register", register, 37, Color(0xFFE11D1D)),
          ),
          RichText(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> register() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: "barry.allen@example.com", password: "SuperSecretPassword!");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
