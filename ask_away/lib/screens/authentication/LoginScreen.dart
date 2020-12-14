import 'package:ask_away/components/SimpleAppBar.dart';
import 'package:ask_away/components/SimpleButton.dart';
import 'package:ask_away/screens/authentication/RegisterScreen.dart';
import 'package:ask_away/services/Auth.dart';
import 'package:ask_away/services/AuthProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../main_screen/MainScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart'as auth;
import 'EntryField.dart';




final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn();



String _email;
String _password;

void loginSetEmail(String email) {
  _email = email;
}

void loginSetPassword(String password) {
  _password = password;
}

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  Future<void> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount;
    try {
       googleSignInAccount = await _googleSignIn.signIn();
    } catch (error) {
      print(error);


      return;
    }
    print(googleSignInAccount);
    GoogleSignInAuthentication googleSignInAuthentication;
    try {
       googleSignInAuthentication = await googleSignInAccount.authentication;
    } catch (error) {
      print(error);


      return;
    }


     auth.AuthCredential credential = auth.GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

     auth.UserCredential authResult = await _auth.signInWithCredential(credential);

    print("anonymous assert");
     auth.FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);


    print("final assert");
    final auth.FirebaseUser currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');
    Navigator.pop(context);
  }

  void signOutGoogle() async{
    await _googleSignIn.signOut();

    print("User Sign Out");
  }



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
    final String userId = await auth.signInWithEmailAndPassword(_email, _password);

    print('User logged in: $userId');

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ScrollConfiguration(
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
                height: 520,
                padding: EdgeInsets.only(
                  left: 35,
                  right: 35,
                ),
                margin: EdgeInsets.only(
                  bottom: 30,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EntryField(EntryFieldType.EMAIL, FormType.LOGIN),
                      EntryField(EntryFieldType.PASSWORD, FormType.LOGIN),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  bottom: 10,
                ),
                child: SimpleButton(
                  "Login",
                  validateAndSubmit,
                  37,
                  Color(0xFFE11D1D),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  bottom: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: signInWithGoogle,
                    child: Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        color: Colors.white70,
                        border: Border.all(
                          width: 1,
                          color: Colors.grey[700],),
                        borderRadius: new BorderRadius.circular(14.0),
                      ),
                      child: Row(children: [
                        Padding(padding: EdgeInsets.only(left: 45),),
                        Image(
                          image: AssetImage('assets/images/google_icon.png'),
                        ),
                        new Text('Sign In with Google',
                        style: new TextStyle(
                          fontSize: 20.0,
                          /*foreground: Paint()..shader = LinearGradient(colors: [
                            Colors.red,
                            Colors.deepOrange,
                            Colors.orange,
                            Colors.amber,
                            Colors.amber,
                            Colors.lime,
                            Colors.lightGreen,
                            Colors.green,
                            Colors.teal,
                            Colors.cyan,
                            Colors.lightBlue,
                            Colors.blue,
                            Colors.indigo,
                            Colors.blue[900],

                          ]).createShader(Rect.fromLTWH(160, 0, 90.0, 2000.0)),*/
                          color:Colors.grey[700],
                        ),
                      ),
                        ],
                      ),
                    ),
                  ),
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
                      text: "Don’t have an account? ",
                      style: TextStyle(
                        color: Color(0xFFF979797),
                      ),
                    ),
                    TextSpan(
                      text: "Register",
                      style: TextStyle(
                        color: Color(0xFFFF5656),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/register');
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
