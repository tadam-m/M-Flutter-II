import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_clubs_berlin/components/display_entrance.dart';
import 'package:techno_clubs_berlin/components/display_rating.dart';

import 'package:techno_clubs_berlin/models/club.dart';

class VueClubScreen extends StatelessWidget {
  const VueClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Club club = Get.arguments["club"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
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
                      Text(
                        club.location,
                        style: Theme.of(context).textTheme.bodyText1,
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
                      club.camera ? Icons.photo_camera : Icons.no_photography,
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
                    Text(
                      club.clubbingTime,
                      style: Theme.of(context).textTheme.bodyText1,
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
                    DisplayRating(club.rating),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
