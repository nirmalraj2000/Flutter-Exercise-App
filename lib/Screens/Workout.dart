import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

import 'HomePage.dart';

class Workout extends StatefulWidget {
  final bool isRandomMode;

  Workout({@required this.isRandomMode = false});

  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool continueButtonVisibility;
  TextEditingController _setsController = TextEditingController();

  Widget _buttonStateWidget;
  Widget _countDownState;
  Widget _fieldState;

  List<int> workoutList;
  List<int> musicIndex;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    musicIndex = [1, 2, 3, 4, 5];
    workoutList = widget.isRandomMode
        ? generateRandomNumberSet(isInitial: true)
        : dayWiseWorkout();
    continueButtonVisibility = false;
    _buttonStateWidget = emptyContainer();
    _fieldState = textField();
    _countDownState = emptyContainer();
  }

  List<int> generateRandomNumberSet({bool isInitial = false}) {
    if (!isInitial) musicIndex.shuffle();
    List<int> randomList = [];

    while (true) {
      int random = Random().nextInt(13);
      if (randomList.length != 0 && randomList.contains(random)) {
        continue;
      }
      randomList.add(random);
      if (randomList.length == 5) break;
    }

    return randomList;
  }

  List<int> dayWiseWorkout() {
    int day = DateTime.now().weekday;
    switch (day) {
      case 1:
        return [0, 1, 2, 3, 4];
        break;
      case 2:
        return [5, 6, 7, 8, 9];
        break;
      case 3:
        return [10, 11, 12, 13, 0];
        break;
      case 4:
        return [1, 2, 3, 4, 5];
        break;
      case 5:
        return [6, 7, 8, 9, 10];
        break;
      case 6:
        return [11, 12, 13, 0, 1];
        break;
      case 7:
        return [2, 3, 4, 5, 6];
        break;
      default:
    }
  }

  _moveToLastScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _moveToLastScreen();
      },
      child: SafeArea(
        child: Scaffold(
            body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Today's Workout",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  widget.isRandomMode
                      ? IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              workoutList = generateRandomNumberSet();
                            });
                          },
                        )
                      : Container(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 500,
                child: ListView.builder(
                    itemCount: workoutList.length,
                    itemBuilder: (context, i) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 110,
                            width: 110,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image(
                                    image: AssetImage(
                                        "Images/${workoutList[i] + 1}.png")),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Text(
                              "${i + 1}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 15),
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      width: 150,
                      height: 50,
                      child: Form(
                        key: _formKey,
                        child: AnimatedSwitcher(
                          duration: Duration(seconds: 250),
                          child: _fieldState,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: _countDownState,
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      child: _buttonStateWidget,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget textField() => TextFormField(
        controller: _setsController,
        onChanged: (value) {
          if (value == null || value == "") {
            setState(() {
              continueButtonVisibility = false;
              _buttonStateWidget = emptyContainer();
            });
          } else {
            setState(() {
              continueButtonVisibility = true;
              _buttonStateWidget = containerButton(context);
            });
          }
        },
        validator: (value) {
          if (value == null)
            return "Enter Some Value";
          else if (int.parse(value) is int) {
            print("null");
            return null;
          } else
            return "Enter a Valid count";
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          hintText: "Your Sets",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );

  Widget countDown(String text, int key) => Text(
        "$text",
        key: ValueKey(key),
        style: TextStyle(
            color: Colors.black, fontSize: 70, fontWeight: FontWeight.bold),
      );

  void startCountDown() {
    // Navigating with count down optional

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _countDownState = countDown("3", 2);
      });
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _countDownState = countDown("2", 3);
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _countDownState = countDown("1", 4);
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _countDownState = countDown("Go", 5);
      });
    });
    Future.delayed(Duration(seconds: 5), () {
      if (_formKey.currentState.validate()) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(
                  exerciseToday: workoutList,
                  setsCount: int.parse(_setsController.text),
                  musicIndex: musicIndex,
                )));
      }
    });
  }

  void goToHomePage() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushReplacement(

        PageRouteBuilder(
            pageBuilder: (BuildContext context, animation, secondaryAnimation) {
              return HomePage(
                exerciseToday: workoutList,
                setsCount: int.parse(_setsController.text),
                musicIndex: musicIndex,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return CupertinoPageTransition(
                linearTransition: false,
                primaryRouteAnimation: animation,
                secondaryRouteAnimation: secondaryAnimation,
                child: child,
              );
            }),
      );
    }
  }

  Widget containerButton(BuildContext context) => Container(
        key: ValueKey(1),
        width: 130,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              _buttonStateWidget = emptyContainer();
            });

            // startCountDown();
            goToHomePage();
          },
          child: Text(
            "Go",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.blue,
        ),
      );

  Widget emptyContainer() => Container(
        key: ValueKey(2),
      );
}
