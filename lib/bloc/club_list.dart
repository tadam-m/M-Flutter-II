import 'dart:async';

import 'package:techno_clubs_berlin/API/api_manager.dart';
import 'package:techno_clubs_berlin/models/club.dart';

import 'bloc.dart';

class ClubListBloc implements Bloc {
  final ApiManager _api;

  final _controller = StreamController<List<Club>>();
  Stream<List<Club>>? _broadcastStream;
  Stream<List<Club>> get clubList {
    _broadcastStream ??= _controller.stream.asBroadcastStream();
    return _broadcastStream!;
  }

  ClubListBloc(ApiManager api) : _api = api {
    refresh();
  }

  void refresh() async {
    final clubs = await _api.getClubs();
    _controller.sink.add(clubs);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
