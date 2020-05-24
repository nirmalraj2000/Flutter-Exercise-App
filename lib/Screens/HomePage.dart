import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterexerciseapp/Screens/Workout.dart';

class HomePage extends StatefulWidget {
  final List<int> exerciseToday;
  final int setsCount;

  final List<int> _workoutDurationSec = [];



  HomePage({this.exerciseToday, this.setsCount ,});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controllers

  bool _finished;

  // Variables
  int _exerciseIndex;

  Widget countDownState;




  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    countDownState = startButton();
    _finished = false;
    _exerciseIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
        },
        child: Container(
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
          child: Builder(builder: (context) {
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
                          "Sets : ${widget.setsCount}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 3),
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
                        // padding: EdgeInsets.all(4),
                        height: 50,
                        width: 50,
                        child: _exerciseIndex == 0
                            ? Icon(
                                Icons.play_arrow,
                                color: Colors.purpleAccent,
                              )
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: Container(
                        // padding: EdgeInsets.all(4),
                        height: 50,
                        width: 50,
                        child: _exerciseIndex == 1
                            ? Icon(
                                Icons.play_arrow,
                                color: Colors.purpleAccent,
                              )
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: Container(
                        // padding: EdgeInsets.all(4),
                        height: 50,
                        width: 50,
                        child: _exerciseIndex == 2
                            ? Icon(
                                Icons.play_arrow,
                                color: Colors.purpleAccent,
                              )
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: Container(
                        // padding: EdgeInsets.all(4),
                        height: 50,
                        width: 50,
                        child: _exerciseIndex == 3
                            ? Icon(
                                Icons.play_arrow,
                                color: Colors.purpleAccent,
                              )
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: Container(
                        // padding: EdgeInsets.all(4),
                        height: 50,
                        width: 50,
                        child: _exerciseIndex == 4
                            ? Icon(
                                Icons.play_arrow,
                                color: Colors.purpleAccent,
                              )
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
                  // decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: Colors.purpleAccent,
                  //     ),
                  //     borderRadius: BorderRadius.circular(20)),
                  child: Image(image: AssetImage("Images/1.png")),
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
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.timer,
                          size: 30,
                        ),
                        Padding(padding: EdgeInsets.only(left: 20)),
                        Text(
                          "00 : 00",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 200, right: 40),
                  child: Container(
                    child: RaisedButton(
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        setState(() {
                          _finished = !_finished;
                        });
                        startExercise();
                      },
                      color: Colors.purpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Resume",
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
          }),
        ),
      ),
    );
  }

  Widget startButton() => RaisedButton(
        onPressed: () {
          startCountDown();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.purpleAccent,
        child: Text(
          "Start",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
  Widget countDown(String text, int key) => Text(
        "$text",
        key: ValueKey(key),
        style: TextStyle(
            color: Colors.black, fontSize: 70, fontWeight: FontWeight.bold),
      );

  void startCountDown() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        countDownState = countDown("3", 2);
      });
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        countDownState = countDown("2", 3);
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        countDownState = countDown("1", 4);
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        countDownState = countDown("Go", 5);
      });
    });
  }

  void startExercise() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _exerciseIndex = 1;
      });
    });
    Future.delayed(Duration(seconds: 10), () {
      setState(() {
        _exerciseIndex = 2;
      });
    });
    Future.delayed(Duration(seconds: 15), () {
      setState(() {
        _exerciseIndex = 3;
      });
    });
    Future.delayed(Duration(seconds: 20), () {
      setState(() {
        _exerciseIndex = 4;
      });
    });
    Future.delayed(Duration(seconds: 25), () {
      setState(() {
        _exerciseIndex = 0;
      });
    });
  }

  void startWorkout(){
    Future.delayed(Duration(seconds: 10),(){});
    Future.delayed(Duration(seconds: 10),(){});
    Future.delayed(Duration(seconds: 10),(){});
    Future.delayed(Duration(seconds: 10),(){});
  }
}
