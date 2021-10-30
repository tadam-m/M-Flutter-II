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
      'https://zedge-ringtones.com/ringtones/43c6ef2253e993fa747cc0f64560dfd1.mp3',
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
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Image(image: AssetImage('assets/icon-app.jpg')),
              ),
              SizedBox(
                child: Text(
                  'Welcome\non\nGehen Sie zum Club',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: CircularProgressIndicator(value: null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
