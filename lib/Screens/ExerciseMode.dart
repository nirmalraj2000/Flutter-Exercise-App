import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterexerciseapp/Screens/Workout.dart';

import 'CreaterSection.dart';

class ExerciseMode extends StatefulWidget {
  @override
  _ExerciseModeState createState() => _ExerciseModeState();
}

class _ExerciseModeState extends State<ExerciseMode> {
  String _mode = "Random Mode";

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
          body: Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.info,
                            color: Colors.purpleAccent,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (BuildContext context, animation,
                                      secondaryAnimation) {
                                    return CreaterPage();
                                  },
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return CupertinoPageTransition(
                                      linearTransition: false,
                                      primaryRouteAnimation: animation,
                                      secondaryRouteAnimation:
                                          secondaryAnimation,
                                      child: child,
                                    );
                                  }),
                            );
                          }),
                    ],
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage("Images/logo.png"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          "Your Preference",
                          style: TextStyle(
                              fontSize: 30, color: Colors.purpleAccent),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 10),
                    child: ListTile(
                      title: GestureDetector(
                          onTap: () {
                            setState(() {
                              _mode = "Random Mode";
                            });
                          },
                          child: Text(
                            "Random Mode",
                            style: TextStyle(fontSize: 25),
                          )),
                      leading: Radio(
                          activeColor: Colors.purpleAccent,
                          value: "Random Mode",
                          groupValue: _mode,
                          onChanged: (selectedMode) {
                            setState(() {
                              _mode = selectedMode;
                            });
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: ListTile(
                      title: GestureDetector(
                          onTap: () {
                            setState(() {
                              _mode = "Daywise Mode";
                            });
                          },
                          child: Text(
                            "Daywise Mode",
                            style: TextStyle(fontSize: 25),
                          )),
                      leading: Radio(
                          activeColor: Colors.purpleAccent,
                          value: "Daywise Mode",
                          groupValue: _mode,
                          onChanged: (selectedMode) {
                            setState(() {
                              _mode = selectedMode;
                            });
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (BuildContext context, animation,
                                secondaryAnimation) {
                              bool mode;
                              if(_mode == "Random Mode")
                              mode = true;else mode= false;
                              return Workout(isRandomMode: mode);
                            },
                            transitionDuration: Duration(milliseconds: 500),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return CupertinoPageTransition(
                                linearTransition: false,
                                primaryRouteAnimation: animation,
                                secondaryRouteAnimation: secondaryAnimation,
                                child: child,
                              );
                            }),
                      );
                    },
                    color: Colors.purpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
