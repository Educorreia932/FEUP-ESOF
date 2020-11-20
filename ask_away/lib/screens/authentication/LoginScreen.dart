import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/EntryField.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  Widget _LoginForm() {
    return Column(
      children: <Widget>[
        EntryField("Email"),
        EntryField("Password", isPassword: true),
      ],
    );
  }

  Widget _SubmitButton() {
    return InkWell(
      onTap: _Login,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xfffbb448),
                  Color(0xfff7892b),
                ])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  void _Login() {
    final login = loginController.text;
    final password = passwordController.text;

    print("Login: $login , Senha: $password ");

    FirebaseFirestore.instance
        .collection('Users')
        .where(
          "login",
          isEqualTo: login,
        )
        .where(
          "password",
          isEqualTo: password,
        )
        .get().then((value) => print(value.size));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Column(
          children: [
            _LoginForm(),
            _SubmitButton(),
          ],
        ),
      ),
    );
  }
}
