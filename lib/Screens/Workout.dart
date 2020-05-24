import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

import 'HomePage.dart';

class Workout extends StatefulWidget {
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

  List<int> randomList;
  int random;
  int max;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    randomList = generateRandomNumberSet();
    continueButtonVisibility = false;
    _buttonStateWidget = emptyContainer();
    _fieldState = textField();
    _countDownState = emptyContainer();
  }

  List<int> generateRandomNumberSet() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            "Today's Workout",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
            },
            child: Container(
              height: 500,
              child: ListView.builder(
                  itemCount: randomList.length,
                  itemBuilder: (context, i) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          child: Image(
                              image: AssetImage(
                                  "Images/${randomList[i] + 1}.png")),
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
        ),
        Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30),
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
    ));
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
    // Navigating with count down

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
                  exerciseToday: randomList,
                  setsCount: int.parse(_setsController.text),
                )));
      }
    });
  }

  void goToHomePage() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(
                exerciseToday: randomList,
                setsCount: int.parse(_setsController.text),
              )));
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
