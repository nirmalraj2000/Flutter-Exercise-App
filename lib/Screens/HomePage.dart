import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  final List<int> exerciseToday;
  final int setsCount;

  final List<int> _workoutDurationSec = [
    25 + 1,
    25 + 1,
    25 + 1,
    25 + 1,
    25 + 1
  ];

  final List<int> musicIndex;

  HomePage({this.exerciseToday, this.setsCount, this.musicIndex});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _finished;

  int _exerciseIndex;
  bool isLowDuration;
  final int breakDurationSeconds = 5 + 1;

  AssetImage imageState;

  String seconds;
  String minutes;
  int counter;
  bool isBreakTime;
  Timer _timer;
  bool isStartButtonClicked;
  String _startButtonText;
  bool isEndOfCycle;
  bool isStartedWorkout;
  AudioPlayer advancedPlayer = AudioPlayer();
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
    _finished = false;
    _exerciseIndex = 0;
    imageState = AssetImage("Images/${widget.exerciseToday[0] + 1}.png");
    seconds = "00";
    minutes = "00";
    counter = 0;
    isLowDuration = false;
    isBreakTime = false;
    isStartButtonClicked = false;
    _startButtonText = "Start";
    isEndOfCycle = false;
    isStartedWorkout = false;
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                title: Text(
                  "Close",
                ),
                content: Text("Do you want to exit ?"),
                actions: <Widget>[
                  RaisedButton(
                    color: Colors.purpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  RaisedButton(
                    color: Colors.purpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      if (_timer != null) _timer.cancel();
                      advancedPlayer.stop();
                      exit(0);
                    },
                    child: Text("Quit"),
                  )
                ],
              );
            });
      },
      child: SafeArea(
              child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "Images/background.png",
                ),
              ),
            ),
            child: exercisePage(),
          ),
        ),
      ),
    );
  }

  Widget exercisePage() => Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Sets : ${counter.toString()} / ${widget.setsCount}",
                      style: TextStyle(
                        fontSize: 20,
                        color: _finished ? Colors.green : Colors.black,
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _finished ? Colors.green : Colors.black,
                            width: 3),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                _finished
                    ? Padding(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Icon(
                          Icons.done,
                          size: 40,
                          color: Colors.green,
                        ),
                      )
                    : Container(),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 10),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: _exerciseIndex == 0 &&
                            isBreakTime == false &&
                            isStartedWorkout
                        ? Icon(
                            Icons.play_arrow,
                            color: Colors.purpleAccent,
                          )
                        : _exerciseIndex > 0
                            ? Icon(Icons.done, color: Colors.green)
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: _exerciseIndex == 1 && isBreakTime == false
                        ? Icon(
                            Icons.play_arrow,
                            color: Colors.purpleAccent,
                          )
                        : _exerciseIndex > 1
                            ? Icon(Icons.done, color: Colors.green)
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: _exerciseIndex == 2 && isBreakTime == false
                        ? Icon(
                            Icons.play_arrow,
                            color: Colors.purpleAccent,
                          )
                        : _exerciseIndex > 2
                            ? Icon(Icons.done, color: Colors.green)
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: _exerciseIndex == 3 && isBreakTime == false
                        ? Icon(
                            Icons.play_arrow,
                            color: Colors.purpleAccent,
                          )
                        : _exerciseIndex > 3
                            ? Icon(Icons.done, color: Colors.green)
                            : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5,
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: _exerciseIndex == 4 &&
                                _finished == false &&
                                isBreakTime == false ||
                            (isEndOfCycle && !_finished)
                        ? Icon(
                            Icons.play_arrow,
                            color: Colors.purpleAccent,
                          )
                        : _finished
                            ? Icon(Icons.done, color: Colors.green)
                            : null,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 5, left: 10),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _exerciseIndex == 0
                                ? Colors.purpleAccent
                                : Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                          "Images/${widget.exerciseToday[0] + 1}.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _exerciseIndex == 1
                                ? Colors.purpleAccent
                                : Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                          "Images/${widget.exerciseToday[1] + 1}.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _exerciseIndex == 2
                                ? Colors.purpleAccent
                                : Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                          "Images/${widget.exerciseToday[2] + 1}.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _exerciseIndex == 3
                                ? Colors.purpleAccent
                                : Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                          "Images/${widget.exerciseToday[3] + 1}.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _exerciseIndex == 4
                                ? Colors.purpleAccent
                                : Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                          "Images/${widget.exerciseToday[4] + 1}.png"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 300,
              width: 300,
              child: Image(
                image: imageState,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Container(
                width: 165,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: isLowDuration ? Colors.red : Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      size: 30,
                      color: isLowDuration ? Colors.red : Colors.black,
                    ),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    Text(
                      "$minutes : $seconds",
                      style: TextStyle(
                          fontSize: 30,
                          color: isLowDuration ? Colors.red : Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 200, right: 40,bottom: 20),
              child: Container(
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  onPressed: () {
                    if (isStartButtonClicked) {
                      _timer.cancel();
                      // initstate body boilerplate code
                      _finished = false;
                      _exerciseIndex = 0;
                      imageState = AssetImage(
                          "Images/${widget.exerciseToday[0] + 1}.png");
                      seconds = "00";
                      minutes = "00";
                      counter = 0;
                      isLowDuration = false;
                      isBreakTime = false;
                      isStartButtonClicked = false;
                      isEndOfCycle = false;
                      isStartedWorkout = false;
                      setState(() {
                        isStartButtonClicked = !isStartButtonClicked;
                      });
                      advancedPlayer.stop();
                    } else {
                      _finished = false;
                      _exerciseIndex = 0;
                      imageState = AssetImage(
                          "Images/${widget.exerciseToday[0] + 1}.png");
                      seconds = "00";
                      minutes = "00";
                      counter = 0;
                      isLowDuration = false;
                      isBreakTime = false;
                      isStartButtonClicked = false;
                      isEndOfCycle = false;
                      isStartedWorkout = true;
                      startExercise();
                    }
                    setState(() {
                      isStartButtonClicked = !isStartButtonClicked;
                    });
                  },
                  color: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    isStartButtonClicked ? "Stop" : _startButtonText,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      });

  // logical section here
  int returnSeconds(int duration) {
    return duration % 60;
  }

  int returnMinutes(int duration) {
    int value = duration ~/ 60;
    return value;
  }

  void startExercise({int index = 1}) {
    int duration;
    if (isBreakTime) {
      duration = breakDurationSeconds;

      index = index - 1;
      setState(() {
        imageState = AssetImage("Images/break.png");
      });
    } else {
      duration = widget._workoutDurationSec[index == 6 ? 4 : index - 1];
    }

    // Single Timer for all the cycles

    if (!isBreakTime && index != 6) {
      audioCache.play("song${widget.musicIndex[index - 1].toString()}.mp3");
    }
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      if (duration < 1 || index == 6) {
        if (!isBreakTime) advancedPlayer.stop();
        timer.cancel();
        if (((index == 5 || index == 6) &&
            counter == widget.setsCount - 1 &&
            isBreakTime)) {
        } else {
          setState(() {
            imageState = AssetImage(
                "Images/${widget.exerciseToday[index == 5 || index == 6 ? index == 5 && (counter != widget.setsCount - 1) ? 0 : 4 : index] + 1}.png");
            _exerciseIndex = index == 5 || index == 6
                ? index == 5 && (counter != widget.setsCount - 1) ? 0 : 4
                : index;
          });
        }
        if (index <= 5 &&
            !(index == 5 && counter == widget.setsCount - 1 && !isBreakTime)) {
          // after one exercise
          isBreakTime = !isBreakTime;

          startExercise(index: index + 1);
        } else {
          // after single cycle completion
          isEndOfCycle = true;
          isBreakTime ? counter = counter : counter = counter + 1;
          if (counter < widget.setsCount) {
            setState(() {
              _exerciseIndex = 0;
              imageState =
                  AssetImage("Images/${widget.exerciseToday[0] + 1}.png");
            });
            isEndOfCycle = false;
            startExercise(index: 1);
          } else {
            // completed the exercise
            isLowDuration = false;
            _finished = true;
            _startButtonText = "Retake";
            isStartButtonClicked = !isStartButtonClicked;
          }
        }
      } else {
        duration = duration - 1;
        if (duration <= 10)
          isLowDuration = true;
        else
          isLowDuration = false;

        int durationSeconds = returnSeconds(duration);
        int durationMinutes = returnMinutes(duration);
        setState(() {
          seconds = durationSeconds < 10
              ? "0" + durationSeconds.toString()
              : durationSeconds.toString();
          minutes = durationMinutes < 10
              ? "0" + durationMinutes.toString()
              : durationMinutes.toString();
        });
      }
    });
  }
}
