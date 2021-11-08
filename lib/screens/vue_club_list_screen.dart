import 'package:flutter/material.dart';
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

  getClubs() async {
    ApiManager().getClubs().then((newClubs) {
      setState(() {
        clubs = newClubs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Wrap(
          children: clubs.map((club) => ClubCard(club)).toList(),
        ),
      ),
    );
  }
}
