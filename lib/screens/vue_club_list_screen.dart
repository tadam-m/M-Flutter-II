import 'package:flutter/material.dart';
import 'package:techno_clubs_berlin/bloc/bloc_provider.dart';
import 'package:techno_clubs_berlin/bloc/club_list.dart';
import 'package:techno_clubs_berlin/components/club_card.dart';

import '/models/club.dart';

class VueClubListScreen extends StatelessWidget {
  const VueClubListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ClubListBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: StreamBuilder<List<Club>>(
            stream: bloc.clubList,
            builder: (context, snapshot) {
              final results = snapshot.data;
              if (results == null || results.isEmpty) {
                bloc.refresh();
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: results.map((club) => ClubCard(club)).toList(),
              );
            }),
      ),
    );
  }
}
