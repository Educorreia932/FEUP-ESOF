import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Stream<String> get  onAuthStateChanged;
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<String> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((User user) => user?.uid);
  }

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User user = userCredential.user;

    return user?.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User user = userCredential.user;

    return user?.uid;
  }

  @override
  Future<String> currentUser() async {
    final User user = FirebaseAuth.instance.currentUser;

    return user?.uid;
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}