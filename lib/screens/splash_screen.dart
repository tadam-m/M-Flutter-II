import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_clubs_berlin/constants/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> _playAudio() async {
    await audioPlayer.play(
      'https://zedge-ringtones.com/ringtones/f674c7deb01b7b02045328a85d03783b.mp3',
    );
    await Future<void>.delayed(const Duration(seconds: 3));
    Get.offAllNamed(loginRoute);
  }

  @override
  void initState() {
    super.initState();
    _playAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SizedBox(
                child: Text(
                  'Welcome\non\nTechno Clubs Berlin',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CircularProgressIndicator(value: null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
