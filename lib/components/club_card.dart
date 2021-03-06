import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:review/review.dart';

import 'package:techno_clubs_berlin/bloc/bloc_provider.dart';
import 'package:techno_clubs_berlin/bloc/selected_club.dart';
import 'package:techno_clubs_berlin/components/display_entrance.dart';
import 'package:techno_clubs_berlin/models/club.dart';
import 'package:techno_clubs_berlin/screens/vue_club_screen.dart';

class ClubCard extends StatelessWidget {
  final Club club;

  const ClubCard(this.club, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedClubBloc = BlocProvider.of<SelectedClubBloc>(context);

    return OpenContainer(
        closedColor: Colors.transparent,
        closedBuilder: (BuildContext context, openContainer) {
          return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    club.name,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(
                        club.camera ? Icons.photo_camera : Icons.no_photography,
                      ),
                      const SizedBox(width: 10),
                      DisplayEntrance(club.entrance),
                      const SizedBox(width: 10),
                      StarRating(rating: club.rating?.toInt()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        openBuilder: (BuildContext context, closeContainer) {
          selectedClubBloc.setSelection(club.name);
          return const VueClubScreen();
        });
  }
}
