import 'dart:developer';

import 'package:ask_away/models/AppUser.dart';
import 'package:ask_away/models/Talk.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


void main() {
  final instance = MockFirestoreInstance();

  setUp(() async {

  });

  test("Insert and read talk data from database", () async {
    Talk talk;

    String title = "Test talk";
    String description = "This is a description";
    DateTime date = DateTime.now();
    String location = "Talk location";
    int duration = 142;
    int ocupation = 23;
    Map<String, List<String>> participants = {'atendees': ["atendee1", "atendee2"], 'moderators':["moderator1"], 'speakers':["speaker1"]};
    String creator = "talkCreator";

    await instance.collection('Talks').doc("TALK_TEST").set({
      'title' : title,
      'description' : description,
      'date' : date,
      'location' : location,
      'duration' : duration,
      'ocupation' : ocupation,
      'participants' : participants,
      'creator' : creator,
    });

    User creatorObj;
    String username = "Escama";
    int reputation = 21;
    List<String> scheduled = [];
    Map<String, int> votes = {};

    await instance.collection('Users').doc(creator).set({
      'username' : username,
      'Reputation' : reputation,
      'scheduled' : scheduled,
      'votes' : votes,
    });

    final snapshot = await instance.collection('Talks').doc("TALK_TEST").get();
    final snapshot_creator = await instance.collection('Users').doc(creator).get();
    
    talk = await Talk.fromData(snapshot, instance);

    creatorObj = User.fromData(snapshot_creator);

    expect(talk.title, equals(title));
    expect(talk.description, equals(description));
    expect(talk.date, equals(date));
    expect(talk.location, equals(location));
    expect(talk.duration.inMinutes, equals(duration));
    expect(talk.ocupation, equals(ocupation));
    expect(talk.participants, equals(participants));
    expect(talk.creator, equals(creatorObj));
  });
}