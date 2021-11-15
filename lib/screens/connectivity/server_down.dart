import 'package:flutter/material.dart';

class ServerDown extends StatelessWidget {
  const ServerDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oops, the server is unreachable !"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off),
              Text(
                'We could not connect to the server',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                'Press back to retry',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
