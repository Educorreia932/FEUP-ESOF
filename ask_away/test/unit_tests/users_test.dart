import 'package:ask_away/models/AppUser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


void main() {
  final instance = MockFirestoreInstance();

  setUp(() async {

  });

  test("Insert and read user data from database", () async {
    User user;
    String username = "Escama";
    int reputation = 21;
    List<String> scheduled = ["id1", "id2", "id3"];
    Map<String, int> votes = {"q1" : -1, "q2" : 1, "q3" : 1};

    await instance.collection('Users').doc("USER_TEST").set({
      'username' : username,
      'Reputation' : reputation,
      'scheduled' : scheduled,
      'votes' : votes,
    });

    final snapshot = await instance.collection('Users').doc("USER_TEST").get();

    user = User.fromData(snapshot);

    expect(user.username, equals(username));
    expect(user.reputation, equals(reputation));
    expect(user.scheduledTalks, equals(scheduled));
    expect(user.votes, equals(votes));
  });
}