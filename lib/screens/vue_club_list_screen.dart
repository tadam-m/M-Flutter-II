import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techno_clubs_berlin/API/api_manager.dart';
import 'package:techno_clubs_berlin/components/club_card.dart';

import '/models/club.dart';

class VueClubListScreen extends StatefulWidget {
  const VueClubListScreen({Key? key}) : super(key: key);

  @override
  _VueClubListScreenState createState() => _VueClubListScreenState();
}

class _VueClubListScreenState extends State<VueClubListScreen> {
  List<Club> clubs = [];
  final ApiManager _apiProvider = ApiManager(client: http.Client());

  getClubs() async {
    _apiProvider.getClubs().then((newClubs) {
      setState(() {
        clubs = newClubs;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getClubs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: clubs.map((club) => ClubCard(club)).toList(),
        ),
      ),
    );
  }
}