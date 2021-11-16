import 'dart:async';

import 'package:techno_clubs_berlin/bloc/bloc.dart';
import 'package:techno_clubs_berlin/models/club.dart';

class SelectedClubBloc implements Bloc {
  final _selectionController = StreamController<Club>();
  final _clubListController = StreamController<List<Club>>();

  String? _selectedClub;
  List<Club>? _clubList;

  Stream<Club>? _broadcastStream;
  Stream<Club> get clubData {
    _broadcastStream ??= _selectionController.stream.asBroadcastStream();
    return _broadcastStream!;
  }

  StreamSink<List<Club>> get clubListSink => _clubListController.sink;

  SelectedClubBloc() {
    _clubListController.stream.listen((clubList) {
      _clubList = clubList;
      update();
    });
  }

  void setSelection(String clubName) {
    _selectedClub = clubName;
    update();
  }

  void update() {
    if (_clubList == null || _selectedClub == null) return;
    final clubsMatching =
        _clubList!.where((element) => element.name == _selectedClub);
    if (clubsMatching.isNotEmpty) {
      _selectionController.sink.add(clubsMatching.first);
    }
  }

  @override
  void dispose() {
    _selectionController.close();
    _clubListController.close();
  }
}
