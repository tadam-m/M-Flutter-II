import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:techno_clubs_berlin/API/api_manager.dart';
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
  final file = File('test/test_resources/datafromclub.json');
  String data = await file.readAsString();
  final jsonData = json.decode(data);
  List<Club> listClubs = List<Club>.from(
    jsonData['clubs'].map(
      (jsonClub) => Club(
        camera: false,
        reviews: jsonClub["reviews"],
        clubbingTime: jsonClub["best clubbing times"],
        description: jsonClub["description"],
        entrance: _translateEntrance(jsonClub["difficulties to get in"]),
        location: jsonClub["location"],
        name: jsonClub["name"],
        price: jsonClub["price"],
        rating: jsonClub["rate"].toDouble(),
      ),
    ),
    growable: false,
  );
  return listClubs;
}

class MockAPI extends ApiManager {
  MockAPI() : super(client: http.Client());

  @override
  Future<List<Club>> getClubs() async {
    final clubs = await buildTestableListView();
    return Future.value(clubs);
  }
}

void listClubUnitTest() {
  group('Test Get Clubs Request', () {
    test('Return List of all clubs if the getClubs method successfully',
        () async {
      final api = MockAPI();
      List<Club> clubs = await api.getClubs();

      expect(clubs, isInstanceOf<List<Club>>());
      expect(clubs.length, 20);
    });
  });
}
