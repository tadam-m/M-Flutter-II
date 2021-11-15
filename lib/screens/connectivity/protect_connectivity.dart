import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'package:techno_clubs_berlin/screens/connectivity/offline.dart';

class ProtectConnectivity extends StatelessWidget {
  const ProtectConnectivity({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        context,
        connectivity,
        child,
      ) =>
          connectivity == ConnectivityResult.none ? const Offline() : child,
      builder: (context) => child,
    );
  }
}
