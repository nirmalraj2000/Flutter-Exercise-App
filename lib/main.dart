import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'Screens/Workout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exercise App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cursorColor: Colors.blue,
        textSelectionHandleColor: Colors.blue,
      ),
      // home: AudioClass(),
      home: Workout(),
    );
  }
}

class AudioClass extends StatefulWidget {
  @override
  _AudioClassState createState() => _AudioClassState();
}

class _AudioClassState extends State<AudioClass> {
  final player = AudioPlayer();
  AudioCache audioCache;
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);

    
  }

  void initPlayer(){
    audioCache = AudioCache(fixedPlayer: advancedPlayer);

  }

  // @Deprecated("bad method")
  // void hello(){}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                // player.play();
                audioCache.loop("song1.mp3");
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.blue,
              child: Text("Start"),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: () {
                // player.stop();
                // loadAudio();
                advancedPlayer.stop();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.blue,
              child: Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}
