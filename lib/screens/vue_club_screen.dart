import 'package:flutter/material.dart';
import 'package:review/review.dart';
import 'package:techno_clubs_berlin/bloc/bloc_provider.dart';
import 'package:techno_clubs_berlin/bloc/selected_club.dart';
import 'package:techno_clubs_berlin/components/add_review_button.dart';
import 'package:techno_clubs_berlin/components/display_entrance.dart';

import 'package:techno_clubs_berlin/models/club.dart';

class VueClubScreen extends StatelessWidget {
  const VueClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedClubBloc = BlocProvider.of<SelectedClubBloc>(context);

    return StreamBuilder<Club>(
        stream: selectedClubBloc.clubData,
        builder: (context, snapshot) {
          final club = snapshot.data;

          if (club == null) selectedClubBloc.update();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: club == null
                ? const Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              club.name,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.place),
                                  Flexible(
                                    child: Text(
                                      club.location,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              club.description,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Camera',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  club.camera
                                      ? Icons.photo_camera
                                      : Icons.no_photography,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  club.camera ? "Allowed" : "Forbidden",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Price',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.euro),
                                const SizedBox(width: 10),
                                Text(
                                  club.price,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Entrance',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(width: 10),
                                DisplayEntrance(club.entrance),
                                const SizedBox(width: 10),
                                DisplayEntranceString(club.entrance),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Best Clubbing Time',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.schedule),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    club.clubbingTime,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Rating',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(width: 10),
                                StarRating(rating: club.rating?.toInt()),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Reviews",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                AddReviewButton(
                                  club: club,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            if (club.reviews.isEmpty)
                              const Text("No reviews")
                            else
                              ...club.reviews.map(
                                  (review) => ReviewDisplay(review: review)),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
