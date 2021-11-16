// 1
import 'package:flutter/widgets.dart';

import 'bloc.dart';

class MissingBlocProviderException implements Exception {
  String cause;
  MissingBlocProviderException(this.cause);
}

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key? key, required this.bloc, required this.child})
      : super(key: key);

  static T of<T extends Bloc>(BuildContext context) {
    final provider = context.findAncestorWidgetOfExactType<BlocProvider<T>>();
    if (provider == null) {
      throw MissingBlocProviderException(
          "type $T is not provided by any Bloc provider");
    }
    return provider.bloc;
  }

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 4
  @override
  Widget build(BuildContext context) => widget.child;

  // 5
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
