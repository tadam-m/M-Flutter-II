import 'package:flutter/material.dart';
import 'package:techno_clubs_berlin/components/club_card.dart';

import '/models/club.dart';

class VueClubListScreen extends StatelessWidget {
  const VueClubListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Wrap(
          children: List<Widget>.generate(
            10,
            (i) => ClubCard(
              Club.random(),
            ),
          ),
        ),
      ),
    );
  }
}
