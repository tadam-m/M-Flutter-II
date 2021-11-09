import 'package:flutter/material.dart';

import 'package:techno_clubs_berlin/models/club.dart';

class DisplayEntrance extends StatelessWidget {
  final Entrance entrance;

  const DisplayEntrance(this.entrance, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<Entrance, Icon> map = {
      Entrance.easy: const Icon(Icons.shield_outlined),
      Entrance.medium: const Icon(Icons.security),
      Entrance.hard: const Icon(Icons.shield),
    };

    return map[entrance]!;
  }
}

class DisplayEntranceString extends StatelessWidget {
  final Entrance entrance;

  const DisplayEntranceString(this.entrance, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      entrance.toString().split('.').last,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
