import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:techno_clubs_berlin/components/club_card.dart';
import 'package:techno_clubs_berlin/models/club.dart';

Entrance _translateEntrance(String entrance) {
  switch (entrance.toLowerCase()) {
    case "easy":
      return Entrance.easy;
    case "medium":
      return Entrance.medium;
    case "hard":
    case "very hard":
      return Entrance.hard;
    default:
      throw Exception("unknown difficulty: $entrance");
  }
}

Future<List<Club>> buildTestableListView() async {
  final String responseJson =
      await rootBundle.loadString('test/test_resources/datafromclub.json');
  final data = await json.decode(responseJson);
  List<Club> listClubs = List<Club>.from(
    data['clubs'].map(
      (jsonClub) => Club(
        camera: false,
        rating: 0.0,
        reviews: [],
        clubbingTime: jsonClub["best clubbing times"],
        description: jsonClub["description"],
        entrance: _translateEntrance(jsonClub["difficulties to get in"]),
        location: jsonClub["location"],
        name: jsonClub["name"],
        price: jsonClub["price"],
      ),
    ),
    growable: false,
  );
  return listClubs;
}

List<Club> clubs = {} as List<Club>;

testListClubWidget() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });

  testWidgets('testing List View display first elements',
      (WidgetTester tester) async {
    clubs = await buildTestableListView();

    await tester.pumpWidget(MaterialApp(
        home: ListView(
      children: clubs.map((club) => ClubCard(club)).toList(),
    )));

    final firstClubFinder = find.text("Berghain");
    final secondClubFinder = find.text("Anomalie Art Club");
    final thirdClubFinder = find.text("://about blank");
    final fourClubFinder = find.text("Loophole Berlin");

    expect(firstClubFinder, findsOneWidget);
    expect(secondClubFinder, findsOneWidget);
    expect(thirdClubFinder, findsOneWidget);
    expect(fourClubFinder, findsOneWidget);
  });

  testWidgets('should scroll the list club item', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: ListView(
      children: clubs.map((club) => ClubCard(club)).toList(),
    )));

    final firstClubFinder = find.text("Berghain");
    expect(firstClubFinder, findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -3000));
    await tester.pump();

    expect(firstClubFinder, findsNothing);
    final lastClubFinder = find.text("Suicide Club");
    expect(lastClubFinder, findsOneWidget);
  });
}
